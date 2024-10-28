use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::Raw::Traits;
use GLib::Raw::Subs;
use GLib::Raw::Object;

use GLib::Object::TypeModule;
use GIO::ListStore;
use Pango::Cairo::FontMap;
use Pango::FontMap;
use GTK::Expression:ver<4>;
use GTK::Button::Spin:ver<4>;
use GTK::Button::Check:ver<4>;


use GLib::Roles::Implementor;

class StringHolder is repr<CStruct> {
  HAS GObject $.parent;

  has Str $.title       is gattribute;
  has Str $.icon        is gattribute;
  has Str $.description is gattribute;

  method finalize is g-vfunc {
    my $Parent = GLib::Object.new($.parent);
    $Parent.finalize;
  }

  method get_type {
    state $n = GLib::Object::TypeModule.register-static(::?CLASS);
    $n;
  }

}

class StringPair is repr<CStruct> {
  HAS GObject $.parent;

  has Str $.id     is gattribute is rw;
  has Str $.string is gattribute is rw;

  method finalize is g-vfunc {
    my $Parent = GLib::Object.new($.parent);
    $Parent.finalize;
  }

  method get_type {
    state $n = GLib::Object::TypeModule.register-static(::?CLASS);
    $n;
  }

}

our subset StringHolderAncestry is export of Mu
  where StringHolder | GObject;

class String::Holder {
  also does GLib::Roles::Object;

  has StringHolder $!sh is implementor handles<
    title
    icon
    description
    get_type
  >;

  submethod BUILD ( :$string-holder ) {
    self.setStringHolder($string-holder) if $string-holder;
  }

  method setStringHolder (StringHolderAncestry $_) {
    my $to-parent;

    $!sh = do {
      when StringHolder {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(StringHolder, $_);
      }
    }
    self!setObject($to-parent);
  }

  method StringHolder { $!sh }

  proto method new (|)
  { * }

  multi method new (
    StringHolderAncestry  $string-holder,
                         :$ref             = True
  ) {
    return Nil unless $string-holder;

    my $o = self.bless( :$string-holder );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $title, Str() $icon, Str() $description) {
    my $string-holder = self.new-object-ptr( self.get_type );

    my $o = $string-holder ?? self.bless( :$string-holder ) !! Nil;
    return Nil unless $o;

    $o.title       = $title;
    $o.icon        = $icon,
    $o.description = $description;
    $o;
  }
}

our subset StringPairAncestry is export of Mu
  where StringPair | GObject;

class String::Pair {
  also does GLib::Roles::Object;

  has StringPair $!sp is implementor handles<
    id
    string
    get_type
  >;

  submethod BUILD ( :$string-pair ) {
    self.setStringPair($string-pair) if $string-pair;
  }

  method setStringPair (StringPairAncestry $_) {
    my $to-parent;

    $!sp = do {
      when StringPair {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(StringPair, $_);
      }
    }
    self!setObject($to-parent);
  }

  method StringPair { $!sp }

  proto method new (|)
  { * }

  multi method new (StringPairAncestry $string-pair, :$ref = True) {
    return Nil unless $string-pair;

    my $o = self.bless( :$string-pair );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $id, Str() $string) {
    my $string-pair = self.new-object-ptr( self.get_type );

    my $o = $string-pair ?? self.bless( :$string-pair ) !! Nil;
    return Nil unless $o;

    $o.id     = $id;
    $o.string = $string;
    $o;
  }
}

INIT {
  my ($, $) = (StringHolder, StringPair)».get_type;
}

use GLib::MainContext;
use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::DropDown:ver<4>;
use GTK::Label:ver<4>;

sub strings-setup-item-single-line ($factory, $item) {
  my $box   = GTK::Box.new-hbox(10);
  my $image = GTK::Image.new;
  my $title = GTK::Label.new( xalign => 0 );
  $box.append($_) for $image, $title;
  $item.child = $box;
}

sub strings-setup-item-full ($factory, $item) {
  my $image = GTK::Image.new;
  my ($title, $desc) = GTK::Label.new( xalign => 0 ) xx 2;
  $desc.add-css-class('dim-label');

  my ($box, $box2) = ( GTK::Box.new-hbox(10), GTK::Box.new-vbox(2) );
   $box.append($_) for $image, $box2;
  $box2.append($_) for $title, $desc;

  $item<title image desc> = ($title, $image, $desc);
  $item.child  = $box;
}

sub strings-bind-item ($factory, $item) {
  my $holder = $item.get-item;

  my ($title, $image, $desc) = $item<title image desc>;

  $title = $holder.title;
  if $image {
    $image.set-from-icon-name($holder.icon);
    $image.visible = $holder.icon.so;
  }
  if $desc {
    $desc.label   = $holder.description;
    $desc.visible = $holder.description.so;
  }
}

sub strings-factory-new ($full) {
  my $factory = GTK::List::Item::Factory::Signal.new();
  $factory.Setup.tap( -> *@a {
    my $r = $full ?? &strings-setup-item-full !!
                     &strings-setup-item-single-line;
    $r( |@a );
  });
  $factory;
}

sub strings-model-new ($titles, $icons, $descriptions) {
  my $store = GIO::ListStore.new( String::Holder.get_type );
  for $titles.keys {
    my $holder = String::Holder.new(
      $titles[$_],
      $icons        ?? $icons[$_]        !! Nil,
      $descriptions ?? $descriptions[$_] !! Nil
    );
    $store.append($holder);
    #$holder.unref;
  }
  $store;
}

sub drop-down-new-from-strings ($titles, $icons?, $descriptions?) {
  return Nil unless $titles;
  return Nil unless $icons        && $icons.elems        == $titles.elems;
  return Nil unless $descriptions && $descriptions.elems == $titles.elems;

  my $model   = strings-model-new($titles, $icons, $descriptions);
  my $factory = strings-factory-new(False);

  my $list-factory;
  $list-factory = strings-factory-new(True) if $icons && $descriptions;

  my $dd = GTK::DropDown.new( :$model, :$factory,  :$list-factory );

  # .unref for $model, $factory;
  # $list-factory.unref if $list-factory;

  $dd;
}

sub MAIN {
  my $app = GTK::Application.new(
    title => 'org.genex.dropdown.stringholder'
  );

  $app.Activate.tap( -> *@a {
    my @times = « '1 minute' '2 minutes' '5 minutes' '20 minutes' »;

    my @many-times = «
      '1 minute'   '2 minutes'  '5 minutes'  '10 minutes' '15 minutes'
      '20 minutes' '25 minutes' '30 minutes' '35 minutes' '40 minutes'
      '45 minutes' '50 minute'  '55 minutes'
      '1 hour'     '2 hours'    '3 hours'    '5 hours'    '6 hours'
      '7 hour'     '8 hours'    '9 hours'    '10 hours'   '11 hours'
      '12 hours'
    »;

    my @device-titles = « 'Headphones' 'Digital Output' 'Analog Output' »;
    my @device-icons  = «
      'audio-headphones-symbolic'
      'audio-card-symbolic'
      'audio-card-symbolic'
    »;
    my @device-descs  = «
      'Built-in Audio'
      'Digital Built-in audio',
      'Thinkpad Tunderbolt 3 Dock USB Audio'
    »;

    $app.window.setAttributes({ title => 'hello world', resizable => True });
    $app.window.Close-Request.tap( -> *@a {
      $app.quit;
      @a.tail.r = 1;
    });

    my $box = GTK::Box.new-vbox(10).setAttributes( margins => 10 );
    $app.window.child = $box;

    my $expression = GTK::Expression::Closure::C.new(
      G_TYPE_STRING,
      sub ($o) {
        Pango::Font::Family.name( cast( PangoFontFamily, $o ) ).clone;
      }
    );

    my $model  = Pango::Cairo::FontMap.get-default;
    my $button = GTK::DropDown.new.setAttributes(
      model    => $model,
      selected => False,

      :$expression
    );

    my $spin = GTK::Button::Spin.new-with-range(-1, $model.elems, 1);
    $spin.halign = GTK_ALIGN_START;

    my $check = GTK::Button::Check.new-with-label('Enable search');

    $button.bind('selected',      $spin,  'value',  :create, :dual);
    $button.bind('enable-search', $check, 'active', :create, :dual);

    my $mt2-expression = GTK::Expression::Closure::C.new(
      G_TYPE_STRING,
      sub ($o) {
        String::Hoder.new( cast(StringHolder, $o) ).title;
      }
    );

    my $t-button   = drop-down-new-from-strings( @times );
    my $mt-button  = drop-down-new-from-strings( @many-times );
    my $mt-button2 = drop-down-new-from-strings( @many-times ).setAttributes(
      enable-search => True,
      expression    => $mt2-expression
    );
    my $dt-button  = drop-down-new-from-strings(
      @device-titles,
      @device-icons,
      @device-descs
    );

    my $store = GIO::ListStore.new(String::Pair.get_type);
    $store.append($_) for (
      <1 One>, <2 Two>, «2.5 'Two ½'», <3 Three>
    ).map({ String::Pair.new( |$_ ) });
    my $b-factory = GTK::List::Item::Factory::Signal.new;
    $b-factory.Setup.tap( -> @a { });
    my $b-button = GTK::DropDown.new(
      model   => $store,
      factory => $b-factory
    );
    $b-button.notify('selected').tap( -> *@a {
      my $selected = $b-button.selected;
      my $pair     = String::Pair.new( $store.get-item($selected, :raw) );
      say "Selected: { $pair.id }";
    });

    my $factory = GTK::List::Item::Factory::Signal.new;
    $factory.Setup.tap( -> *@a {
      GTK::List::Item.new( @a[1] ).child =
        GTK::Label.new( halign => GTK_ALIGN_START );
    });
    $factory.Bind.tap(-> *@a {
      my $item = GTK::List::Item.new( @a[1] );
      my $label = GTK::Label.new( $item.child );

      $label.text = String::Pair.new( $item.item( :raw ) ).string;
    });

    my $hbox      = GTK::Box.new-hbox( css-classes => 'linked' );
    my $entry     = GTK::Entry.new;
    my $b-button2 = GTK::DropDown.new( model => $store, :$factory );
    $hbox.append($entry, $b-button2);

    $box.append($_) for $button,     $spin,      $check,
                        $t-button,   $mt-button, $mt-button2,
                        $b-button,   $hbox;
  });

  $app.run;
}

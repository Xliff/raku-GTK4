use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Button::Check:ver<4>;

use GTK::Widget:ver<4>;

our subset GtkCheckButtonAncestry is export of Mu
  where GtkCheckButton | GtkWidgetAncestry;

class GTK::Button::Check:ver<4> is GTK::Widget:ver<4> {
  has GtkCheckButton $!gtk-cb is implementor;

  submethod BUILD ( :$gtk-check-button ) {
    self.setGtkCheckButton($gtk-check-button) if $gtk-check-button
  }

  method setGtkCheckButton (GtkCheckButtonAncestry $_) {
    my $to-parent;

    $!gtk-cb = do {
      when GtkCheckButton {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCheckButton, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Structs::GtkCheckButton
    is also<GtkCheckButton>
  { $!gtk-cb }

  multi method new (GtkCheckButtonAncestry $gtk-check-button, :$ref = True) {
    return unless $gtk-check-button;

    my $o = self.bless( :$gtk-check-button );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-check-button = gtk_check_button_new();

    $gtk-check-button ?? self.bless( :$gtk-check-button ) !! Nil;
  }

  method new_with_label (Str() $label) is also<new-with-label> {
    my $gtk-check-button = gtk_check_button_new_with_label($label);

    $gtk-check-button ?? self.bless( :$gtk-check-button ) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $gtk-check-button = gtk_check_button_new_with_mnemonic($label);

    $gtk-check-button ?? self.bless( :$gtk-check-button ) !! Nil;
  }

  proto method new-group (|)
  { * }

  multi method new-group (*@labels) {
    samewith(@labels);
  }
  multi method new-group (@labels) {
    my @group;
    my $first = ::?CLASS.new_with_label(@labels.head);
    @group.push: $first;

    for @labels.skip(1) {
      @group.push: ::?CLASS.new_with_label($_);
      @group.tail.group = $first;
    };

    @group;
  }

  # Type: boolean
  method active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: GTKCheckButton
  method group is rw  is g-property {
    my $gv = GLib::Value.new( self.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkCheckButton() $val is copy {
        $gv.object = $val;
        self.prop_set('group', $gv);
      }
    );
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: boolean
  method inconsistent is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('inconsistent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('inconsistent', $gv);
      }
    );
  }

  # Type: boolean
  method use-underline is rw  is g-property is also<use_underline> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-underline', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-underline', $gv);
      }
    );
  }

  # Type: GTKWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-cb, 'activate');
  }

  method Toggled {
    self.connect($!gtk-cb, 'toggled');
  }

  method get_active is also<get-active> {
    so gtk_check_button_get_active($!gtk-cb);
  }

  method get_child (
    :$raw            = False,
    :quick(:$fast)   = False,
    :slow( :$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_check_button_get_child($!gtk-cb),
      $raw,
      $proper
    );
  }

  method get_inconsistent is also<get-inconsistent> {
    so gtk_check_button_get_inconsistent($!gtk-cb);
  }

  method get_label is also<get-label> {
    gtk_check_button_get_label($!gtk-cb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_check_button_get_type, $n, $t );
  }

  method get_use_underline is also<get-use-underline> {
    so gtk_check_button_get_use_underline($!gtk-cb);
  }

  method set_active (Int() $setting) is also<set-active> {
    my gboolean $s = $setting.so.Int;

    gtk_check_button_set_active($!gtk-cb, $s);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_check_button_set_child($!gtk-cb, $child);
  }

  method set_group (GtkCheckButton() $group) is also<set-group> {
    gtk_check_button_set_group($!gtk-cb, $group);
  }

  method set_inconsistent (Int() $inconsistent) is also<set-inconsistent> {
    my gboolean $i = $inconsistent.so.Int;

    gtk_check_button_set_inconsistent($!gtk-cb, $i);
  }

  method set_label (Str() $label) is also<set-label> {
    gtk_check_button_set_label($!gtk-cb, $label);
  }

  method set_use_underline (Int() $setting) is also<set-use-underline> {
    my gboolean $s = $setting.so.Int;

    gtk_check_button_set_use_underline($!gtk-cb, $s);
  }

}


BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Button::Check;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    my $existing = .slurp;
    %widgets = try from-json($existing) if $existing.chars;
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Button::Check;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

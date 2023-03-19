use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Button:ver<4>;

use GTK::Widget;

our subset GtkButtonAncestry is export of Mu
  where GtkButton | GtkWidgetAncestry;

class GTK::Button:ver<4> is GTK::Widget:ver<4> {
  has GtkButton $!gtk-b is implementor;

  submethod BUILD ( :$gtk-button ) {
    self.setGtkButton($gtk-button) if $gtk-button
  }

  method setGtkButton (GtkButtonAncestry $_) {
    my $to-parent;

    $!gtk-b = do {
      when GtkButton {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkButton, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkButton
    is also<GtkButton>
  { $!gtk-b }

  multi method new (GtkButtonAncestry $gtk-button, :$ref = True) {
    return unless $gtk-button;

    my $o = self.bless( :$gtk-button );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-button = do {
      given %a<label> {
        when .defined {
          my $l = %a<label>:delete;

          when $l.contains('_') {
            return ::?CLASS.new_with_mnemonic($l, |%a);
          }

          default {
            return ::?CLASS.new_with_label($l, |%a);
          }
        }

        default {
          gtk_button_new()
        }
      }
    }

    my $o = $gtk-button ?? self.bless( :$gtk-button ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_from_icon_name (Str() $icon_name, *%a)
    is also<new-from-icon-name>
  {
    my $gtk-button = gtk_button_new_from_icon_name($icon_name);

    my $o = $gtk-button ?? self.bless( :$gtk-button ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_label (Str() $label, *%a) is also<new-with-label> {
    my $gtk-button = gtk_button_new_with_label($label);

    my $o = $gtk-button ?? self.bless( :$gtk-button ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_mnemonic (Str() $label, *%a) is also<new-with-mnemonic> {
    my $gtk-button = gtk_button_new_with_mnemonic($label);

    my $o = $gtk-button ?? self.bless( :$gtk-button ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  proto method new_buttons (|)
    is also<new-buttons>
  { * }

  multi method new_buttons ( *@labels, :m(:$mnemonic) ) {
    samewith(@labels, :$mnemonic);
  }
  multi method new_buttons ( @labels, :m(:$mnemonic) ) {
    do for @labels {
      $mnemonic ?? ::?CLASS.new_with_mnemonic($_)
                !! ::?CLASS.new_with_label($_);
    }
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

  # Type: boolean
  method has-frame is rw  is g-property is also<has_frame> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-frame', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-frame', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: GTKWidget
  method child (
    :$raw                   = False,
    :quick(:$fast)          = False,
    :slow(:$proper)         = $fast.not
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
        #self.setBuildableChild(0, $val);
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-b, 'activate');
  }

  method Clicked {
    self.connect($!gtk-b, 'clicked');
  }

  # cw: Backwards compatibility
  method add (GtkWidget() $child)
    is also<
      add-child
      add_child
    >
  {
    self.child = $child;
  }

  method get_child (
    :$raw                   = False,
    :quick(:$fast)          = False,
    :slow(:$proper)         = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_button_get_child($!gtk-b),
      $raw,
      $proper
    )
  }

  method get_has_frame is also<get-has-frame> {
    so gtk_button_get_has_frame($!gtk-b);
  }

  method get_icon_name is also<get-icon-name> {
    gtk_button_get_icon_name($!gtk-b);
  }

  method get_label is also<get-label> {
    gtk_button_get_label($!gtk-b);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_button_get_type, $n, $t );
  }

  method get_use_underline is also<get-use-underline> {
    so gtk_button_get_use_underline($!gtk-b);
  }

  method unsetChild {
    self.set_child(GtkWidget);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    #self.setBuildableChild(0, $child)
    gtk_button_set_child($!gtk-b, $child);
  }

  method set_has_frame (Int() $has_frame) is also<set-has-frame> {
    my gboolean $h = $has_frame.so.Int;

    gtk_button_set_has_frame($!gtk-b, $h);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gtk_button_set_icon_name($!gtk-b, $icon_name);
  }

  method set_label (Str() $label) is also<set-label> {
    gtk_button_set_label($!gtk-b, $label);
  }

  method set_use_underline (Int() $use_underline)
    is also<set-use-underline>
  {
    my gboolean $u = $use_underline.so.Int;

    gtk_button_set_use_underline($!gtk-b, $u);
  }

}

BEGIN {
  writeTypeToManifest( GTK::Button );
}

INIT {
  my \O = GTK::Button;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

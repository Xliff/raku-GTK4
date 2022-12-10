use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Window::Controls:ver<4>;

use GTK::Widget:ver<4>;

our subset GtkWindowControlsAncestry is export of Mu
  where GtkWindowControls | GtkWidgetAncestry;

class GTK::Window::Controls:ver<4> is GTK::Widget:ver<4> {
  has GtkWindowControls $!gtk-wc is implementor;

  submethod BUILD ( :$gtk-window-controls ) {
    self.setGtkWindowControls($gtk-window-controls)
      if $gtk-window-controls
  }

  method setGtkWindowControls (GtkWindowControlsAncestry $_) {
    my $to-parent;

    $!gtk-wc = do {
      when GtkWindowControls {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkWindowControls, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkWindowControls
    is also<GtkWindowControls>
  { $!gtk-wc }

  multi method new (
    $gtk-window-controls where * ~~ GtkWindowControlsAncestry,

    :$ref = True
  ) {
    return unless $gtk-window-controls;

    my $o = self.bless( :$gtk-window-controls );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $side) {
    my GtkPackType $s = $side;

    my $gtk-window-controls = gtk_window_controls_new($s);

    $gtk-window-controls ?? self.bless( :$gtk-window-controls ) !! Nil;
  }

  # Type: string
  method decoration-layout is rw  is g-property is also<decoration_layout> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('decoration-layout', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('decoration-layout', $gv);
      }
    );
  }

  # Type: boolean
  method empty is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('empty', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'empty does not allow writing'
      }
    );
  }

  # Type: GtkPackType
  method side ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkPackType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('side', $gv);
        my $s = $gv.GtkPackType;
        return $s unless $enum;
        GtkPackTypeEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPackType) = $val;
        self.prop_set('side', $gv);
      }
    );
  }

  method get_decoration_layout is also<get-decoration-layout> {
    gtk_window_controls_get_decoration_layout($!gtk-wc);
  }

  method get_empty is also<get-empty> {
    so gtk_window_controls_get_empty($!gtk-wc);
  }

  method get_side ( :$enum = True ) is also<get-side> {
    my $s = gtk_window_controls_get_side($!gtk-wc);
    return $s unless $enum;
    GtkPackTypeEnum($s);
  }

  method set_decoration_layout (Str() $layout)
    is also<set-decoration-layout>
  {
    gtk_window_controls_set_decoration_layout($!gtk-wc, $layout);
  }

  method set_side (Int() $side) is also<set-side> {
    my GtkPackType $s = $side;

    gtk_window_controls_set_side($!gtk-wc, $s);
  }

}

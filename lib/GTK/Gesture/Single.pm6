use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Gesture::Single:ver<4>;

use GDK::Events:ver<4>;
use GTK::Gesture:ver<4>;

use GLib::Roles::Implementor;

our subset GtkGestureSingleAncestry is export of Mu
  where GtkGestureSingle | GtkGestureAncestry;

class GTK::Gesture::Single:ver<4> is GTK::Gesture:ver<4> {
  has GtkGestureSingle $!gtk-gs is implementor;

  submethod BUILD ( :$gtk-single-gesture ) {
    self.setGtkGestureSingle($gtk-single-gesture) if $gtk-single-gesture
  }

  method setGtkGestureSingle (GtkGestureSingleAncestry $_) {
    my $to-parent;

    $!gtk-gs = do {
      when GtkGestureSingle {
        $to-parent = cast(GtkGesture, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGestureSingle, $_);
      }
    }
    self.setGtkGesture($to-parent);
  }

  method GTK::Raw::Definitions::GtkGestureSingle
    is also<GtkGestureSingle>
  { $!gtk-gs }

  multi method new (
     $gtk-single-gesture where * ~~ GtkGestureSingleAncestry,

    :$ref = True
  ) {
    return unless $gtk-single-gesture;

    my $o = self.bless( :$gtk-single-gesture );
    $o.ref if $ref;
    $o;
  }

  # Type: uint
  method button is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('button', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('button', $gv);
      }
    );
  }

  # Type: boolean
  method exclusive is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('exclusive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('exclusive', $gv);
      }
    );
  }

  # Type: boolean
  method touch-only is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('touch-only', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('touch-only', $gv);
      }
    );
  }

  method get_button is also<get-button> {
    gtk_gesture_single_get_button($!gtk-gs);
  }

  method get_current_button is also<get-current-button> {
    gtk_gesture_single_get_current_button($!gtk-gs);
  }

  method get_current_sequence (:$raw = False )
    is also<get-current-sequence>
  {
    propReturnObject(
      gtk_gesture_single_get_current_sequence($!gtk-gs),
      $raw,
      |GDK::Event::Sequence.getTypePair
    );
  }

  method get_exclusive is also<get-exclusive> {
    so gtk_gesture_single_get_exclusive($!gtk-gs);
  }

  method get_touch_only is also<get-touch-only> {
    so gtk_gesture_single_get_touch_only($!gtk-gs);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_gesture_single_get_type, $n, $t );
  }

  method set_button (Int() $button) is also<set-button> {
    my guint $b = $button;

    gtk_gesture_single_set_button($!gtk-gs, $b);
  }

  method set_exclusive (Int() $exclusive) is also<set-exclusive> {
    my gboolean $e = $exclusive.so.Int;

    gtk_gesture_single_set_exclusive($!gtk-gs, $e);
  }

  method set_touch_only (Int() $touch_only) is also<set-touch-only> {
    my gboolean $t = $touch_only.so.Int;

    gtk_gesture_single_set_touch_only($!gtk-gs, $t);
  }

}

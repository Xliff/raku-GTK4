use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::ScrolledWindow:ver<4>;

use GTK::Adjustment:ver<4>;
use GTK::Window:ver<4>;

use GLib::Roles::Implementor;

our subset GtkScrolledWindowAncestry is export of Mu
  where GtkScrolledWindow | GtkWindowAncestry;

class GTK::ScrolledWindow:ver<4> is GTK::Window:ver<4> {
  has GtkScrolledWindow $!gtk-sw is implementor;

  submethod BUILD ( :$gtk-scrolled-window ) {
    self.setGtkScrolledWindow($gtk-scrolled-window) if $gtk-scrolled-window;
  }

  method setGtkScrolledWindow (GtkScrolledWindowAncestry $_) {
    my $to-parent;

    $!gtk-sw = do {
      when GtkScrolledWindow {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkScrolledWindow, $_);
      }
    }

    self.setGtkWindow($to-parent);
  }

  method GTK::Raw::Definitions::GtkScrolledWindow
    is also<GtkScrolledWindow>
  { $!gtk-sw }

  multi method new (
    GtkScrolledWindowAncestry  $gtk-scrolled-window,
                              :$ref                  = True
  ) {
    return unless $gtk-scrolled-window;

    my $o = self.bless( :$gtk-scrolled-window );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-scrolled-window = gtk_scrolled_window_new();

    my $o = $gtk-scrolled-window ?? self.bless( :$gtk-scrolled-window )
                                 !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GTKAdjustment
  method adjustment ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Adjustment.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('adjustment', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Adjustment.getTypePair
        )
      },
      STORE => -> $, GObject() $val is copy {
        $gv.object = $val;
        self.prop_set('adjustment', $gv);
      }
    );
  }

  method child is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_child    },
      STORE => -> $, \v { self.set_child(v) }
  }

  method hadjustment is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_hadjustment    },
      STORE => -> $, \v { self.set_hadjustment(v) }
  }

  method has_frame
    is also<has-frame>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_has_frame    },
      STORE => -> $, \v { self.set_has_frame(v) }
  }

  method kinetic_scrolling
    is also<kinetic-scrolling>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_kinetic_scrolling    },
      STORE => -> $, \v { self.set_kinetic_scrolling(v) }
  }

  method max_content_height
    is also<max-content-height>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_max_content_height    },
      STORE => -> $, \v { self.set_max_content_height(v) }
  }

  method max_content_width
    is also<max-content-width>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_max_content_width    },
      STORE => -> $, \v { self.set_max_content_width(v) }
  }

  method min_content_height
    is also<min-content-height>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_min_content_height    },
      STORE => -> $, \v { self.set_min_content_height(v) }
  }

  method min_content_width
    is also<min-content-width>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_min_content_width    },
      STORE => -> $, \v { self.set_min_content_width(v) }
  }

  method overlay_scrolling
    is also<overlay-scrolling>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_overlay_scrolling    },
      STORE => -> $, \v { self.set_overlay_scrolling(v) }
  }

  method placement is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_placement    },
      STORE => -> $, \v { self.set_placement(v) }
  }

  method policy is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_policy    },
      STORE => -> $, \v { self.set_policy(v) }
  }

  method hscrollbar-policy is also<hscrollbar_policy> is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_policy[0]    },
      STORE => -> $, \v { self.set_policy( v, self.get_policy[1] ) }
  }

  method vscrollbar-policy is also<vscrollbar_policy> is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_policy[1]    },
      STORE => -> $, \v { self.set_policy( self.get_policy[0], v ) }
  }

  method propagate_natural_height
    is also<propagate-natural-height>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_propagate_natural_height    },
      STORE => -> $, \v { self.set_propagate_natural_height(v) }
  }

  method propagate_natural_width
    is also<propagate-natural-width>
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_propagate_natural_width    },
      STORE => -> $, \v { self.set_propagate_natural_width(v) }
  }

  method vadjustment is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_vadjustment    },
      STORE => -> $, \v { self.set_vadjustment(v) }
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    gtk_scrolled_window_get_child($!gtk-sw);
  }

  method get_hadjustment (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-hadjustment>
  {
    returnProperWidget(
      gtk_scrolled_window_get_hadjustment($!gtk-sw),
      $raw,
      $proper
    );
  }

  method get_has_frame is also<get-has-frame> {
    so gtk_scrolled_window_get_has_frame($!gtk-sw);
  }

  method get_hscrollbar ( :$raw = False ) is also<get-hscrollbar> {
    propReturnObject(
      gtk_scrolled_window_get_hscrollbar($!gtk-sw),
      $raw,
      |GTK::ScrollBar.getTypePair
     )
  }

  method get_kinetic_scrolling is also<get-kinetic-scrolling> {
    so gtk_scrolled_window_get_kinetic_scrolling($!gtk-sw);
  }

  method get_max_content_height is also<get-max-content-height> {
    gtk_scrolled_window_get_max_content_height($!gtk-sw);
  }

  method get_max_content_width is also<get-max-content-width> {
    gtk_scrolled_window_get_max_content_width($!gtk-sw);
  }

  method get_min_content_height is also<get-min-content-height> {
    gtk_scrolled_window_get_min_content_height($!gtk-sw);
  }

  method get_min_content_width is also<get-min-content-width> {
    gtk_scrolled_window_get_min_content_width($!gtk-sw);
  }

  method get_overlay_scrolling is also<get-overlay-scrolling> {
    so gtk_scrolled_window_get_overlay_scrolling($!gtk-sw);
  }

  method get_placement is also<get-placement> {
    gtk_scrolled_window_get_placement($!gtk-sw);
  }

  proto method get_policy (|)
  { * }

  multi method get_policy {
    samewith($, $);
  }
  multi method get_policy (
    $hscrollbar_policy is rw,
    $vscrollbar_policy is rw
  )
    is also<get-policy>
  {
    my GtkPolicyType ($hp, $vp) = 0 xx 2;

    gtk_scrolled_window_get_policy($!gtk-sw, $hp, $vp);
    ($hscrollbar_policy, $vscrollbar_policy) = ($hp, $vp);
  }

  method get_propagate_natural_height is also<get-propagate-natural-height> {
    gtk_scrolled_window_get_propagate_natural_height($!gtk-sw);
  }

  method get_propagate_natural_width is also<get-propagate-natural-width> {
    gtk_scrolled_window_get_propagate_natural_width($!gtk-sw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_scrolled_window_get_type, $n, $t );
  }

  method get_vadjustment ( :$raw = False ) is also<get-vadjustment> {
    propReturnObject(
      gtk_scrolled_window_get_vadjustment($!gtk-sw),
      $raw,
      |GTK::Adjustment.getTypePair
    );
  }

  method get_vscrollbar (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
   )
    is also<get-vscrollbar>
  {
     returnProperWidget(
        gtk_scrolled_window_get_vscrollbar($!gtk-sw),
        $raw,
        $proper
      );
  }

  method min-content-size is also<min_content_size> is rw {
    Proxy.new:
      FETCH => -> $ {
        ( $.get-min-cointent-width, $.get-min-content-height )
      },

      STORE => -> $, \v {
        my $v = takeIntOrArray(v, &?ROUTINE.name);
        self.set_min_content_width($v.head);
        self.set_min_content_height($v.tail);
      }
  }

  method max-content-size is also<max_content_size> is rw {
    Proxy.new:
      FETCH => -> $ {
        ( $.get-max-cointent-width, $.get-max-content-height )
      },

      STORE => -> $, \v {
        my $v = takeIntOrArray(v, &?ROUTINE.name);
        self.set_max_content_width($v.head);
        self.set_max_content_height($v.tail);
      }
  }

  method set_child (GtkWidget() $child)
    is also<
      set-child
      add_child
      add-child
    >
  {
    gtk_scrolled_window_set_child($!gtk-sw, $child);
  }

  method set_hadjustment (Int() $hadjustment) is also<set-hadjustment> {
    my GtkAdjustment $h = $hadjustment;

    gtk_scrolled_window_set_hadjustment($!gtk-sw, $h);
  }

  method set_has_frame (Int() $has_frame) is also<set-has-frame> {
    my gboolean $h = $has_frame;

    gtk_scrolled_window_set_has_frame($!gtk-sw, $h);
  }

  method set_kinetic_scrolling (Int() $kinetic_scrolling)
    is also<set-kinetic-scrolling>
  {
    my gboolean $k = $kinetic_scrolling;

    gtk_scrolled_window_set_kinetic_scrolling($!gtk-sw, $k);
  }

  method set_max_content_height (Int() $height)
    is also<set-max-content-height>
  {
    my gint $h = $height;

    gtk_scrolled_window_set_max_content_height($!gtk-sw, $h);
  }

  method set_max_content_width (Int() $width) is also<set-max-content-width> {
    my gint $w = $width;

    gtk_scrolled_window_set_max_content_width($!gtk-sw, $w);
  }

  method set_min_content_height (Int() $height)
    is also<set-min-content-height>
  {
    my gint $h = $height;

    gtk_scrolled_window_set_min_content_height($!gtk-sw, $h);
  }

  method set_min_content_width (Int() $width) is also<set-min-content-width> {
    my gint $w = $width;

    gtk_scrolled_window_set_min_content_width($!gtk-sw, $w);
  }

  method set_overlay_scrolling (Int() $overlay_scrolling)
    is also<set-overlay-scrolling>
  {
    my gboolean $o = $overlay_scrolling;

    gtk_scrolled_window_set_overlay_scrolling($!gtk-sw, $overlay_scrolling);
  }

  method set_placement (Int() $window_placement) is also<set-placement> {
    my GtkCornerType $w = $window_placement;

    gtk_scrolled_window_set_placement($!gtk-sw, $w);
  }

  method set_policy (Int() $hscrollbar_policy, Int() $vscrollbar_policy)
    is also<set-policy>
  {
    my GtkPolicyType ($h, $v) = ($hscrollbar_policy, $vscrollbar_policy);

    gtk_scrolled_window_set_policy($!gtk-sw, $h, $v);
  }

  method set_propagate_natural_height (Int() $propagate)
    is also<set-propagate-natural-height>
  {
    my gboolean $p = $propagate;

    gtk_scrolled_window_set_propagate_natural_height($!gtk-sw, $p);
  }

  method set_propagate_natural_width (Int() $propagate)
    is also<set-propagate-natural-width>
  {
    my gboolean $p = $propagate;

    gtk_scrolled_window_set_propagate_natural_width($!gtk-sw, $propagate);
  }

  method set_vadjustment (Int() $vadjustment) is also<set-vadjustment> {
    my GtkAdjustment $v = $vadjustment;

    gtk_scrolled_window_set_vadjustment($!gtk-sw, $v);
  }

  method unset_placement is also<unset-placement> {
    gtk_scrolled_window_unset_placement($!gtk-sw);
  }

}

BEGIN {
  writeTypeToManifest(GTK::ScrolledWindow, $?FILE);
}

INIT {
  my \O = GTK::ScrolledWindow;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

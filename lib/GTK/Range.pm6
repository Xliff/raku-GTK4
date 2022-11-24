use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Range:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;

our subset GtkRangeAncestry is export of Mu
  where GtkRange | GtkOrientable | GtkWidgetAncestry;

class GTK::Range:ver<4> is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkRange $!gtk-r is implementor;

  submethod BUILD ( :$gtk-range ) {
    self.setGtkRange($gtk-range) if $gtk-range
  }

  method setGtkRange (GtkRangeAncestry $_) {
    my $to-parent;

    $!gtk-r = do {
      when GtkRange {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkOrientable {
        $!gtk-o    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkRange, $_);
     }

      default {
        $to-parent = $_;
        cast(GtkRange, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkOrientable;
  }

  method GTK::Raw::Definitions::GtkRange
    is also<GtkRange>
  { $!gtk-r }

  multi method new (GtkRangeAncestry $gtk-range, :$ref = True) {
    return unless $gtk-range;cast(GtkRange, $_);

    my $o = self.bless( :$gtk-range );
    $o.ref if $ref;
    $o;
  }

  # Type: GTKAdjustment
  method adjustment is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('adjustment', $gv);
        cast(GtkAdjustment, $gv.pointer);
      },
      STORE => -> $, GtkAdjustment() $val is copy {
        $gv.pointer = $val;
        self.prop_set('adjustment', $gv);
      }
    );
  }

  # Type: boolean
  method inverted is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('inverted', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('inverted', $gv);
      }
    );
  }

  # Type: boolean
  method show-fill-level is rw  is g-property is also<show_fill_level> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-fill-level', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-fill-level', $gv);
      }
    );
  }

  # Type: boolean
  method restrict-to-fill-level
    is rw
    is g-property
    is also<restrict_to_fill_level>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('restrict-to-fill-level', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('restrict-to-fill-level', $gv);
      }
    );
  }

  # Type: double
  method fill-level is rw  is g-property is also<fill_level> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fill-level', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('fill-level', $gv);
      }
    );
  }

  # Type: int
  method round-digits is rw  is g-property is also<round_digits> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('round-digits', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('round-digits', $gv);
      }
    );
  }

  method Adjust-Bounds {
    self.connect-gdouble($!gtk-r, 'adjust-bounds');
  }

  method Change-Value {
    self.connect-change-value($!gtk-r);
  }

  method Move-Slider {
    self.connect-move-slider($!gtk-r);
  }

  method Value-Changed {
    self.connect($!gtk-r, 'value-changed');
  }

  method get_adjustment is also<get-adjustment> {
    gtk_range_get_adjustment($!gtk-r);
  }

  method get_fill_level is also<get-fill-level> {
    gtk_range_get_fill_level($!gtk-r);
  }

  method get_flippable is also<get-flippable> {
    so gtk_range_get_flippable($!gtk-r);
  }

  method get_inverted is also<get-inverted> {
    so gtk_range_get_inverted($!gtk-r);
  }

  proto method get_range_rect (|)
    is also<get-range-rect>
  { * }

  multi method get_range_rect {
    samewith( GdkRectangle.new );
  }
  multi method get_range_rect (GdkRectangle() $range_rect)  {
    gtk_range_get_range_rect($!gtk-r, $range_rect);
  }

  method get_restrict_to_fill_level is also<get-restrict-to-fill-level> {
    so gtk_range_get_restrict_to_fill_level($!gtk-r);
  }

  method get_round_digits is also<get-round-digits> {
    gtk_range_get_round_digits($!gtk-r);
  }

  method get_show_fill_level is also<get-show-fill-level> {
    so gtk_range_get_show_fill_level($!gtk-r);
  }

  proto method get_slider_range (|)
  { * }

  multi method get_slider_range {
    samewith($, $);
  }
  multi method get_slider_range ($slider_start is rw, $slider_end is rw)
    is also<get-slider-range>
  {
    my gint ($s, $e) = 0 xx 2;

    gtk_range_get_slider_range($!gtk-r, $s, $e);
    ($slider_start, $slider_end) = ($s, $e);
  }

  method get_slider_size_fixed is also<get-slider-size-fixed> {
    gtk_range_get_slider_size_fixed($!gtk-r);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_range_get_type, $n, $t );
  }

  method get_value is also<get-value> {
    gtk_range_get_value($!gtk-r);
  }

  method set_adjustment (GtkAdjustment() $adjustment)
    is also<set-adjustment>
  {
    gtk_range_set_adjustment($!gtk-r, $adjustment);
  }

  method set_fill_level (Num() $fill_level) is also<set-fill-level> {
    my gdouble $f = $fill_level;

    gtk_range_set_fill_level($!gtk-r, $f);
  }

  method set_flippable (Int() $flippable) is also<set-flippable> {
    my gboolean $f = $flippable.so.Int;

    gtk_range_set_flippable($!gtk-r, $f);
  }

  method set_increments (Num() $step, Num() $page)
    is also<set-increments>
  {
    my gdouble ($s, $p) = ($step, $page);

    gtk_range_set_increments($!gtk-r, $s, $p);
  }

  method set_inverted (Int() $setting) is also<set-inverted> {
    my gboolean $s = $setting.so.Int;

    gtk_range_set_inverted($!gtk-r, $s);
  }

  method set_range (Num() $min, Num() $max)
    is also<set-range>
  {
    my gdouble ($mn, $mx) = ($min, $max);

    gtk_range_set_range($!gtk-r, $min, $max);
  }

  method set_restrict_to_fill_level (Int() $restrict_to_fill_level)
    is also<set-restrict-to-fill-level>
  {
    my gboolean $r = $restrict_to_fill_level.so.Int;

    gtk_range_set_restrict_to_fill_level($!gtk-r, $r);
  }

  method set_round_digits (Int() $round_digits) is also<set-round-digits> {
    my gint $r = $round_digits;

    gtk_range_set_round_digits($!gtk-r, $r);
  }

  method set_show_fill_level (Int() $show_fill_level)
    is also<set-show-fill-level>
  {
    my gboolean $s = $show_fill_level.so.Int;

    gtk_range_set_show_fill_level($!gtk-r, $s);
  }

  method set_slider_size_fixed (Int() $size_fixed)
    is also<set-slider-size-fixed>
  {
    my gboolean $s = $size_fixed.so.Int;

    gtk_range_set_slider_size_fixed($!gtk-r, $s);
  }

  method set_value (gdouble  $value) is also<set-value> {
    gtk_range_set_value($!gtk-r, $value);
  }

}

INIT {
  my \O = GTK::Range;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

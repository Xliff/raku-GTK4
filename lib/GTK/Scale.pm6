use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Scale:ver<4>;

use GTK::Range:ver<4>;

our subset GtkScaleAncestry is export of Mu
  where GtkScale | GtkRangeAncestry;

class GTK::Scale:ver<4> is GTK::Range {
  has GtkScale $!gtk-s is implementor;

  submethod BUILD ( :$gtk-scale ) {
    self.setGtkScale($gtk-scale) if $gtk-scale
  }

  method setGtkScale (GtkScaleAncestry $_) {
    my $to-parent;

    $!gtk-s = do {
      when GtkScale {
        $to-parent = cast(GtkRange, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkScale, $_);
      }
    }
    self.setGtkRange($to-parent);
  }

  method GTK::Raw::Definitions::GtkScale
    is also<GtkScale>
  { $!gtk-s }

  multi method new (GtkScaleAncestry $gtk-scale, :$ref = True) {
    return unless $gtk-scale;

    my $o = self.bless( :$gtk-scale );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int()           $orientation,
    GtkAdjustment() $adjustment   = GtkAdjustment
  ) {
    my GtkOrientation $o = $orientation;

    my $gtk-scale = gtk_scale_new($o, $adjustment);

    $gtk-scale ?? self.bless( :$gtk-scale ) !! Nil;
  }

  method new_percent_range (
    :h(:$horizontal) = True,
    :v(:$veritcal)   = $horizontal.not
  ) {
    ::?CLASS.new_with_range(0, 100, :$horizontal, :$veritcal);
  }

  proto method new_with_range (|)
  { * }

  multi method new_with_range (
    Num()     $min,
    Num()     $max,
    Num()     $step        = 1,
          :h(:$horizontal) = True,
          :v(:$veritcal)   = $horizontal.not
  ) {
    samewith(
      $veritcal ?? GTK_ORIENTATION_VERTICAL !! GTK_ORIENTATION_HORIZONTAL,
      $min,
      $max,
      $step
    );
  }
  multi method new_with_range (
    Int()  $orientation,
    Num()  $min,
    Num()  $max,
    Num()  $step,
  )
    is also<new-with-range>
  {
    my GtkOrientation  $o            =  $orientation;
    my gdouble        ($mn, $mx, $s) = ($min, $max, $step);

    my $gtk-scale = gtk_scale_new_with_range($o, $mn, $mx, $s);

    $gtk-scale ?? self.bless( :$gtk-scale ) !! Nil;
  }

  method new-h-scale (GtkAdjustment() $adjustment = GtkAdjustment)
    is static
    is also<
      new_h_scale
      new_hscale
      new-hscale
    >
  {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, $adjustment);
  }

  method new-v-scale (GtkAdjustment() $adjustment = GtkAdjustment)
    is static
    is also<
      new_v_scale
      new_vscale
      new-vscale
    >
  {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, $adjustment);
  }

  # Type: int
  method digits is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('digits', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('digits', $gv);
      }
    );
  }

  # Type: boolean
  method draw-value is rw  is g-property is also<draw_value> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('draw-value', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('draw-value', $gv);
      }
    );
  }

  # Type: boolean
  method has-origin is rw  is g-property is also<has_origin> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-origin', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-origin', $gv);
      }
    );
  }

  # Type: GTKPositionType
  method value-pos ( :$enum = True ) is rw  is g-property is also<value_pos> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkPositionType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value-pos', $gv);
        my $pt = $gv.valueFromEnum(GtkPositionType);
        return $pt unless $enum;
        GtkPositionTypeEnum($pt)
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPositionType) = $val;
        self.prop_set('value-pos', $gv);
      }
    );
  }

  method add_mark (Num() $value, Int() $position, Str() $markup)
    is also<add-mark>
  {
    my gdouble         $v = $value;
    my GtkPositionType $p = $position;

    gtk_scale_add_mark($!gtk-s, $value, $position, $markup);
  }

  method clear_marks is also<clear-marks> {
    gtk_scale_clear_marks($!gtk-s);
  }

  method get_digits is also<get-digits> {
    gtk_scale_get_digits($!gtk-s);
  }

  method get_draw_value is also<get-draw-value> {
    so gtk_scale_get_draw_value($!gtk-s);
  }

  method get_has_origin is also<get-has-origin> {
    so gtk_scale_get_has_origin($!gtk-s);
  }

  method get_layout ( :$raw =  False ) is also<get-layout> {
    propReturnObject(
      gtk_scale_get_layout($!gtk-s),
      $raw,
      |Pango::Layout.getTypePair
    );
  }

  proto method get_layout_offsets (|)
    is also<get-layout-offsets>
  { * }

  multi method get_layout_offsets {
    samewith($, $);
  }
  multi method get_layout_offsets ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;

    gtk_scale_get_layout_offsets($!gtk-s, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_scale_get_type, $n, $t );
  }

  method get_value_pos is also<get-value-pos> {
    gtk_scale_get_value_pos($!gtk-s);
  }

  method set_digits (Int() $digits) is also<set-digits> {
    my gint $d = $digits;

    gtk_scale_set_digits($!gtk-s, $d);
  }

  method set_draw_value (Int() $draw_value) is also<set-draw-value> {
    my gboolean $d = $draw_value.so.Int;

    gtk_scale_set_draw_value($!gtk-s, $d);
  }

  method set_format_value_func (
             &func,
    gpointer $user_data      = gpointer,
             &destroy_notify = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-format-value-func>
  {
    gtk_scale_set_format_value_func(
      $!gtk-s,
      &func,
      $user_data,
      &destroy_notify
    );
  }

  method set_has_origin (Int() $has_origin) is also<set-has-origin> {
    my gboolean $h = $has_origin.so.Int;

    gtk_scale_set_has_origin($!gtk-s, $h);
  }

  method set_value_pos (Int() $pos) is also<set-value-pos> {
    my GtkPositionType $p = $pos;

    gtk_scale_set_value_pos($!gtk-s, $p);
  }

}

INIT {
  my \O = GTK::Scale;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

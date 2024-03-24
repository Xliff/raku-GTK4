use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Button::Spin:ver<4>;

use GTK::Adjustment:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Editable:ver<4>;
use GTK::Roles::Signals::SpinButton:ver<4>;
use GTK::Roles::Constraint::Target:ver<4>;
use GTK::Roles::Editable:ver<4>;
use GTK::Roles::Orientable:ver<4>;

our subset GtkSpinButtonAncestry is export of Mu
  where GtkSpinButton      | GtkConstraintTarget | GtkEditable | GtkOrientable |
        GtkWidgetAncestry;

class GTK::Button::Spin:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Signals::SpinButton;
  also does GTK::Roles::Constraint::Target;
  also does GTK::Roles::Editable;
  also does GTK::Roles::Orientable;

  has GtkSpinButton $!gtk-sb is implementor;

  has $.a;

  submethod BUILD ( :$gtk-spin-button, :adjustment(:$!a) ) {
    self.setGtkSpinButton($gtk-spin-button) if $gtk-spin-button
  }

  method setGtkSpinButton (GtkSpinButtonAncestry $_) {
    my $to-parent;

    $!gtk-sb = do {
      when GtkSpinButton {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkConstraintTarget {
        $!gtk-ct   = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkSpinButton, $_);
      }

      when GtkEditable {
        $!gtk-e    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkSpinButton, $_);
      }

      when GtkOrientable {
        $!gtk-o    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkSpinButton, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSpinButton, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkConstraintTarget;
    self.roleInit-GtkEditable;
    self.roleInit-GtkOrientable;
  }

  method GTK::Raw::Definitions::GtkSpinButton
    is also<GtkSpinButton>
  { $!gtk-sb }

  multi method new (
    $gtk-spin-button where * ~~ GtkSpinButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-spin-button;

    my $o = self.bless( :$gtk-spin-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Range()  $range,
            :c(:climb-rate(:$climb_rate)) = ($range.max - $range.min) / 20,
            :s(:$step)                    = $climb_rate,
            :p(:$page)                    = $climb_rate * 4,
            :d(:$digits)                  = 0,
            :h(:$horizontal)              = True,
            :v(:$vertical)                = $horizontal.not;
  ) {
    my $a = GTK::Adjustment.new($range, :$step, :$page);
    my $o = samewith($a, $climb_rate, $digits);
    $o.orientation = $vertical ?? GTK_ORIENTATION_VERTICAL
                               !! GTK_ORIENTATION_HORIZONTAL;
    $o;
  }
  multi method new (
    GtkAdjustment() $adjustment,
    Num()           $climb_rate,
    Int()           $digits,
                    :h(:$horizontal) = True,
                    :v(:$vertical)   = $horizontal.not
  ) {
    my gdouble $c = $climb_rate;
    my gint    $d = $digits;

    say "A: { GTK::Adjustment.new($adjustment).gist }";

    my $gtk-spin-button = gtk_spin_button_new($adjustment, $c, $d);

    my $o = $gtk-spin-button ?? self.bless( :$gtk-spin-button, :$adjustment )
                             !! Nil;
    $o.configure($adjustment, $climb_rate, $digits);
    $o.orientation = $vertical ?? GTK_ORIENTATION_VERTICAL
                               !! GTK_ORIENTATION_HORIZONTAL;
    $o;
  }
  multi method new (*%a) {
    my $gtk-spin-button = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    my $o = $gtk-spin-button ?? self.bless( :$gtk-spin-button ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }
  multi method new (|c) {
    die "Invalid arguments { |c.gist }";
  }

  method new_with_range (
    Num()  $min,
    Num()  $max,
    Num()  $step,
          :h(:$horizontal) = True,
          :v(:$vertical)   = $horizontal.not
  )
    is also<new-with-range>
  {
    my ($n, $x, $s) = ($min, $max, $step);

    my $gtk-spin-button = gtk_spin_button_new_with_range($n, $x, $s);

    my $o = $gtk-spin-button ?? self.bless( :$gtk-spin-button ) !! Nil;
    $o.orientation = $vertical ?? GTK_ORIENTATION_VERTICAL
                               !! GTK_ORIENTATION_HORIZONTAL;
    $o;
  }

  # Type: GtkAdjustment
  method adjustment ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Adjustment.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('adjustment', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Adjustment.getTypePair
        );
      },
      STORE => -> $, GtkAdjustment() $val is copy {
        $gv.object = $val;
        self.prop_set('adjustment', $gv);
      }
    );
  }

  # Type: double
  method climb-rate is rw  is g-property is also<climb_rate> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('climb-rate', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('climb-rate', $gv);
      }
    );
  }

  # Type: uint
  method digits is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('digits', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('digits', $gv);
      }
    );
  }

  # Type: boolean
  method numeric is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('numeric', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('numeric', $gv);
      }
    );
  }

  # Type: boolean
  method snap-to-ticks is rw  is g-property is also<snap_to_ticks> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('snap-to-ticks', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('snap-to-ticks', $gv);
      }
    );
  }

  # Type: GtkSpinButtonUpdatePolicy
  method update-policy ( :$enum = True )
    is rw
    is g-property
    is also<update_policy>
 {
    my $gv = GLib::Value.new-enum(GtkSpinButtonUpdatePolicy);
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('update-policy', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GtkSpinButtonUpdatePolicyEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSpinButtonUpdatePolicy) = $val;
        self.prop_set('update-policy', $gv);
      }
    );
  }

  # Type: double
  method value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('value', $gv);
      }
    );
  }

  # Type: boolean
  method wrap is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('wrap', $gv);
      }
    );
  }

  method Change-Value is also<Change_Value> {
    self.connect-change-value2($!gtk-sb);
  }

  method Input {
    self.connect-input($!gtk-sb);
  }

  method Output {
    self.connect-ruint($!gtk-sb, 'output');
  }

  method Value-Changed is also<Value_Changed> {
    self.connect($!gtk-sb, 'value-changed');
  }

  method Wrapped {
    self.connect($!gtk-sb, 'wrapped');
  }

  method configure (
    GtkAdjustment() $adjustment,
    Num()           $climb_rate,
    Int()           $digits
  ) {
    my gdouble  $c = $climb_rate;
    my guint    $d = $digits    ;

    gtk_spin_button_configure($!gtk-sb, $adjustment, $c, $d);
  }

  method get_adjustment ( :$raw = False ) is also<get-adjustment> {
    propReturnObject(
      gtk_spin_button_get_adjustment($!gtk-sb),
      $raw,
      |GTK::Adjustment.getTypePair
    );
  }

  method get_climb_rate is also<get-climb-rate> {
    gtk_spin_button_get_climb_rate($!gtk-sb);
  }

  method get_digits is also<get-digits> {
    gtk_spin_button_get_digits($!gtk-sb);
  }

  proto method get_increments (|)
    is also<get-increments>
  { * }

  multi method get_increments {
    samewith($, $);
  }
  multi method get_increments ($step is rw, $page is rw) {
    my gdouble ($s, $p) = 0e0 xx 2;

    gtk_spin_button_get_increments($!gtk-sb, $s, $p);
    ($step, $page) = ($s, $p);
  }

  method get_numeric is also<get-numeric> {
    so gtk_spin_button_get_numeric($!gtk-sb);
  }

  proto method get_range (|)
    is also<get-range>
  { * }

  multi method get_range {
    samewith($, $);
  }
  multi method get_range ($min is rw, $max is rw) {
    my gdouble ($n, $x) = ($min, $max);

    gtk_spin_button_get_range($!gtk-sb, $n, $x);
    ($min, $max) = ($n, $x);
  }

  method get_snap_to_ticks is also<get-snap-to-ticks> {
    so gtk_spin_button_get_snap_to_ticks($!gtk-sb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_spin_button_get_type, $n, $t );
  }

  method get_update_policy ( :$enum = False ) is also<get-update-policy> {
    my $p = gtk_spin_button_get_update_policy($!gtk-sb);
    return $p unless $enum;
    GtkSpinButtonUpdatePolicyEnum($p);
  }

  method get_value is also<get-value> {
    gtk_spin_button_get_value($!gtk-sb);
  }

  method get_value_as_int is also<get-value-as-int> {
    gtk_spin_button_get_value_as_int($!gtk-sb);
  }

  method get_wrap is also<get-wrap> {
    so gtk_spin_button_get_wrap($!gtk-sb);
  }

  method set_adjustment (GtkAdjustment() $adjustment) is also<set-adjustment> {
    gtk_spin_button_set_adjustment($!gtk-sb, $adjustment);
  }

  method set_climb_rate (Num() $climb_rate) is also<set-climb-rate> {
    my gdouble $c = $climb_rate;

    gtk_spin_button_set_climb_rate($!gtk-sb, $c);
  }

  method set_digits (Int() $digits) is also<set-digits> {
    my guint $d = $digits;

    gtk_spin_button_set_digits($!gtk-sb, $d);
  }

  method set_increments (Num() $step, Num() $page) is also<set-increments> {
    my gdouble ($s, $p) = ($step, $page);

    gtk_spin_button_set_increments($!gtk-sb, $s, $p);
  }

  method set_numeric (Int() $numeric) is also<set-numeric> {
    my gboolean $n = $numeric.so.Int;

    gtk_spin_button_set_numeric($!gtk-sb, $n);
  }

  method set_range (Num() $min, Num() $max) is also<set-range> {
    my gdouble ($n, $x) = ($min, $max);

    gtk_spin_button_set_range($!gtk-sb, $n, $x);
  }

  method set_snap_to_ticks (Int() $snap_to_ticks) is also<set-snap-to-ticks> {
    my gboolean $s = $snap_to_ticks.so.Int;

    gtk_spin_button_set_snap_to_ticks($!gtk-sb, $s);
  }

  method set_update_policy (Int() $policy) is also<set-update-policy> {
    my GtkSpinButtonUpdatePolicy $p = $policy;

    gtk_spin_button_set_update_policy($!gtk-sb, $p);
  }

  method set_value (Num() $value) is also<set-value> {
    my gdouble $v = $value;

    gtk_spin_button_set_value($!gtk-sb, $v);
  }

  method set_wrap (Int() $wrap) is also<set-wrap> {
    my gboolean $w = $wrap.so.Int;

    gtk_spin_button_set_wrap($!gtk-sb, $w);
  }

  method spin (Int() $direction, Num() $increment) {
    my GtkSpinType $d = $direction;
    my gdouble     $i = $increment;

    gtk_spin_button_spin($!gtk-sb, $d, $i);
  }

  method update {
    gtk_spin_button_update($!gtk-sb);
  }

}

# BEGIN {
#   writeTypeToManifest(GTK::Button::Spin);
# }

INIT {
  my \O = GTK::Button::Spin;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

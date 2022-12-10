use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Button::Scale:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
#use GTK::Roles::AccessibleRange;
use GTK::Roles::Orientable;

our subset GtkScaleButtonAncestry is export of Mu
  where GtkScaleButton | GtkWidgetAncestry;

class GTK::Button::Scale:ver<4> is GTK::Widget:ver<4> {
  # also does GTK::Roles::AccessibleRange;
  also does GTK::Roles::Orientable;

  has GtkScaleButton $!gtk-sb is implementor;

  submethod BUILD ( :$gtk-scale-button ) {
    self.setGtkScaleButton($gtk-scale-button) if $gtk-scale-button
  }

  method setGtkScaleButton (GtkScaleButtonAncestry $_) {
    my $to-parent;

    $!gtk-sb = do {
      when GtkScaleButton {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkScaleButton, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkScaleButton
    is also<GtkScaleButton>
  { $!gtk-sb }

  multi method new (
    $gtk-scale-button where * ~~ GtkScaleButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-scale-button;

    my $o = self.bless( :$gtk-scale-button );
    $o.ref if $ref;
    $o;
  }

  multi method new (Num() $min, Num() $max, Num() $step, @icons) {
    samewith(  $min, $max, $step, ArrayToCArray(Str, @icons, :null)  )
  }
  multi method new (
    Num()       $min,
    Num()       $max,
    Num()       $step,
    CArray[Str] $icons
  ) {
    my gdouble ($n, $x, $s) = ($min, $max, $step);

    my $gtk-scale-button    = gtk_scale_button_new($n, $x, $s, $icons);

    $gtk-scale-button ?? self.bless( :$gtk-scale-button ) !! Nil;
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

  # Type: GtkStrv
  method icons ( :$array = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icons', $gv);
        my $o = cast(CArray[Str], $gv.boxed);
        return $o unless $array;
        CArrayToArray($o);
      },
      STORE => -> $,  $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('icons', $gv);
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

  method Popdown {
    self.connect($!gtk-sb, 'popdown');
  }

  method Popup {
    self.connect($!gtk-sb, 'popup');
  }

  method Volume-Changed is also<Volume_Changed> {
    self.connect-double($!gtk-sb, 'value-changed');
  }

  method get_adjustment ( :$raw = False ) is also<get-adjustment> {
    propReturnObject(
      gtk_scale_button_get_adjustment($!gtk-sb),
      $raw,
      |GTK::Adjustment.getTypePair
    );
  }

  method get_minus_button (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-minus-button>
  {
    returnProperWidget(
      gtk_scale_button_get_minus_button($!gtk-sb),
      $raw,
      $proper
    );
  }

  method get_plus_button (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-plus-button>
  {
    returnProperWidget(
      gtk_scale_button_get_plus_button($!gtk-sb),
      $raw,
      $proper
    );
  }

  method get_popup (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-popup>
  {
    returnProperWidget(
      gtk_scale_button_get_popup($!gtk-sb),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_scale_button_get_type, $n, $t );
  }

  method get_value is also<get-value> {
    gtk_scale_button_get_value($!gtk-sb);
  }

  method set_adjustment (GtkAdjustment() $adjustment)
    is also<set-adjustment>
  {
    gtk_scale_button_set_adjustment($!gtk-sb, $adjustment);
  }

  proto method set_icons (|)
    is also<set-icons>
  { * }

  multi method set_icons (@icons) {
    samewith(  ArrayToCArray(Str, @icons, :null)  );
  }
  multi method set_icons (CArray[Str] $icons) {
    gtk_scale_button_set_icons($!gtk-sb, $icons);
  }

  method set_value (Num() $value) is also<set-value> {
    my gdouble $v = $value;

    gtk_scale_button_set_value($!gtk-sb, $v);
  }

}

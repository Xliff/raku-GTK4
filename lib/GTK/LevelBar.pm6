use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::LevelBar:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;

our subset GtkLevelBarAncestry is export of Mu
  where GtkLevelBar | GtkOrientable | GtkWidgetAncestry;

class GTK::LevelBar:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;

  has GtkLevelBar $!gtk-lb is implementor;

  submethod BUILD ( :$gtk-level-bar ) {
    self.setGtkLevelBar($gtk-level-bar) if $gtk-level-bar;
  }

  method setGtkLevelBar (GtkLevelBarAncestry $_) {
    my $to-parent;

    $!gtk-lb = do {
      when GtkLevelBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkOrientable {
        $!gtk-o    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkLevelBar, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkLevelBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkOrientable;
  }

  method GTK::Raw::Definitions::GtkLevelBar
  { $!gtk-lb }

  multi method new (
    $gtk-level-bar where * ~~ GtkLevelBarAncestry,

    :$ref = True
  ) {
    return unless $gtk-level-bar;

    my $o = self.bless( :$gtk-level-bar );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-level-bar = gtk_level_bar_new();

    $gtk-level-bar ?? self.bless( :$gtk-level-bar ) !! Nil;
  }

  method new_for_interval (Num() $min, Num() $max) {
    my gdouble ($n, $x) = ($min, $max);

    my $gtk-level-bar = gtk_level_bar_new_for_interval($n, $x);

    $gtk-level-bar ?? self.bless( :$gtk-level-bar ) !! Nil;
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

  # Type: double
  method max-value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('max-value', $gv);
      }
    );
  }

  # Type: double
  method min-value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('min-value', $gv);
      }
    );
  }

  # Type: GtkLevelBarMode
  method mode ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkLevelBarMode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkLevelBarModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkLevelBarMode) = $val;
        self.prop_set('mode', $gv);
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

  method Offset-Changed {
    self.connect-string($!gtk-lb, 'offset-changed');
  }

  method add_offset_value (Str() $name, Num() $value) {
    my gdouble $v = $value;

    gtk_level_bar_add_offset_value($!gtk-lb, $name, $v);
  }

  method get_inverted {
    so gtk_level_bar_get_inverted($!gtk-lb);
  }

  method get_max_value {
    gtk_level_bar_get_max_value($!gtk-lb);
  }

  method get_min_value {
    gtk_level_bar_get_min_value($!gtk-lb);
  }

  method get_mode ( :$enum = True ) {
    my $m = gtk_level_bar_get_mode($!gtk-lb);
    return $m unless $enum;
    GtkLevelBarModeEnum($m);
  }

  proto method get_offset_value (|)
  { * }

  multi method get_offset_value (Str() $name) {
    samewith($name, $);
  }
  multi method get_offset_value (
    Str() $name,
          $value is rw
  ) {
    my gdouble $v = 0e0;

    gtk_level_bar_get_offset_value($!gtk-lb, $name, $v);
    $value = $v;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_level_bar_get_type, $n, $t );
  }

  method get_value {
    gtk_level_bar_get_value($!gtk-lb);
  }

  method remove_offset_value (Str() $name) {
    gtk_level_bar_remove_offset_value($!gtk-lb, $name);
  }

  method set_inverted (Int() $inverted) {
    my gboolean $i = $inverted.so.Int;

    gtk_level_bar_set_inverted($!gtk-lb, $i);
  }

  method set_max_value (Num() $value) {
    my gdouble $v = $value;

    gtk_level_bar_set_max_value($!gtk-lb, $v);
  }

  method set_min_value (Num() $value) {
    my gdouble $v = $value;

    gtk_level_bar_set_min_value($!gtk-lb, $v);
  }

  method set_mode (Int() $mode) {
    my GtkLevelBarMode $m = $mode;

    gtk_level_bar_set_mode($!gtk-lb, $m);
  }

  method set_value (Num() $value) {
    my gdouble $v = $value;

    gtk_level_bar_set_value($!gtk-lb, $v);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::LevelBar;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::LevelBar;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

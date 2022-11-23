use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::ProgressBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkProgressBarAncestry is export of Mu
  where GtkProgressBar | GtkWidgetAncestry;

class GTK::ProgressBar:ver<4> is GTK::Widget:ver<4> {
  has GtkProgressBar $!gtk-pb is implementor;

  submethod BUILD ( :$gtk-progress-bar ) {
    self.setGtkProgressBar($gtk-progress-bar) if $gtk-progress-bar
  }

  method setGtkProgressBar (GtkProgressBarAncestry $_) {
    my $to-parent;

    $!gtk-pb = do {
      when GtkProgressBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkProgressBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkProgressBar
    is also<GtkProgressBar>
  { $!gtk-pb }

  multi method new (GtkProgressBarAncestry $gtk-progress-bar, :$ref = True) {
    return unless $gtk-progress-bar;

    my $o = self.bless( :$gtk-progress-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-progress-bar = gtk_progress_bar_new();

    $gtk-progress-bar ?? self.bless( :$gtk-progress-bar ) !! Nil;
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
  method fraction is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fraction', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('fraction', $gv);
      }
    );
  }

  # Type: double
  method pulse-step is rw  is g-property is also<pulse_step> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pulse-step', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('pulse-step', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: boolean
  method show-text is rw  is g-property is also<show_text> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-text', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-text', $gv);
      }
    );
  }

  # Type: GTKEllipsizeMode
  method ellipsize ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(PangoEllipsizeMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ellipsize', $gv);
        my $e = $gv.valueFromEnum(PangoEllipsizeMode);
        return $e unless $enum;
        PangoEllipsizeModeEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoEllipsizeMode) = $val;
        self.prop_set('ellipsize', $gv);
      }
    );
  }

  method get_ellipsize ( :$enum = True ) is also<get-ellipsize> {
    my $e = gtk_progress_bar_get_ellipsize($!gtk-pb);
    return $e unless $enum;
    PangoEllipsizeModeEnum($e);
  }

  method get_fraction is also<get-fraction> {
    gtk_progress_bar_get_fraction($!gtk-pb);
  }

  method get_inverted is also<get-inverted> {
    so gtk_progress_bar_get_inverted($!gtk-pb);
  }

  method get_pulse_step is also<get-pulse-step> {
    gtk_progress_bar_get_pulse_step($!gtk-pb);
  }

  method get_show_text is also<get-show-text> {
    so gtk_progress_bar_get_show_text($!gtk-pb);
  }

  method get_text is also<get-text> {
    gtk_progress_bar_get_text($!gtk-pb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_progress_bar_get_type, $n, $t );
  }

  method pulse {
    gtk_progress_bar_pulse($!gtk-pb);
  }

  method set_ellipsize (Int() $mode) is also<set-ellipsize> {
    my PangoEllipsizeMode $m = $mode;

    gtk_progress_bar_set_ellipsize($!gtk-pb, $m);
  }

  method set_fraction (Num() $fraction) is also<set-fraction> {
    my gdouble $f = $fraction;

    gtk_progress_bar_set_fraction($!gtk-pb, $f);
  }

  method set_inverted (Int() $inverted) is also<set-inverted> {
    my gboolean $i= $inverted.so.Int;

    gtk_progress_bar_set_inverted($!gtk-pb, $i);
  }

  method set_pulse_step (Num() $fraction) is also<set-pulse-step> {
    my gdouble $f = $fraction;

    gtk_progress_bar_set_pulse_step($!gtk-pb, $f);
  }

  method set_show_text (Int() $show_text) is also<set-show-text> {
    my gboolean $s= $show_text.so.Int;

    gtk_progress_bar_set_show_text($!gtk-pb, $s);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_progress_bar_set_text($!gtk-pb, $text);
  }

}

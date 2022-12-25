use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Overlay:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkOverlayAncestry is export of Mu
  where GtkOverlay | GtkWidgetAncestry;

class GTK::Overlay is GTK::Widget {
  has GtkOverlay $!gtk-o is implementor;

  submethod BUILD ( :$gtk-overlay ) {
    self.setGtkOverlay($gtk-overlay) if $gtk-overlay
  }

  method setGtkOverlay (GtkOverlayAncestry $_) {
    my $to-parent;

    $!gtk-o = do {
      when GtkOverlay {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkOverlay, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkOverlay
    is also<GtkOverlay>
  { $!gtk-o }

  multi method new (
    $gtk-overlay where * ~~ GtkOverlayAncestry,

    :$ref = True
  ) {
    return unless $gtk-overlay;

    my $o = self.bless( :$gtk-overlay );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-overlay = gtk_overlay_new();

    $gtk-overlay ?? self.bless( :$gtk-overlay ) !! Nil;
  }

  method add_overlay (GtkWidget()  $widget) is also<add-overlay> {
    gtk_overlay_add_overlay($!gtk-o, $widget);
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget($gv.object, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_overlay_get_child($!gtk-o),
      $raw,
      $proper
    );
  }

  method get_clip_overlay (GtkWidget() $widget) is also<get-clip-overlay> {
    so gtk_overlay_get_clip_overlay($!gtk-o, $widget);
  }

  method get_measure_overlay (GtkWidget() $widget)
    is also<get-measure-overlay>
  {
    so gtk_overlay_get_measure_overlay($!gtk-o, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_overlay_get_type, $n, $t );
  }

  method remove_overlay (GtkWidget() $widget) is also<remove-overlay> {
    gtk_overlay_remove_overlay($!gtk-o, $widget);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_overlay_set_child($!gtk-o, $child);
  }

  method set_clip_overlay (GtkWidget() $widget, Int() $clip_overlay)
    is also<set-clip-overlay>
  {
    my gboolean  $c = $clip_overlay.so.Int;

    gtk_overlay_set_clip_overlay($!gtk-o, $widget, $clip_overlay);
  }

  method set_measure_overlay (GtkWidget() $widget, Int() $measure)
    is also<set-measure-overlay>
  {
    my gboolean $m = $measure.so.Int;

    gtk_overlay_set_measure_overlay($!gtk-o, $widget, $m);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Overlay;
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
  my \O = GTK::Overlay;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

use v6.c;

use NativeCall;

use GTK::Raw::Types;

use GTK::LayoutManager:ver<4>;

# cw: Not quite sure what to do with this one...

class GTK::OverlayLayout is GTK::LayoutManager:ver<4> {
  has GtkOverlayLayout $!gtkol is implementor;

  method new ( *%a ) {
    my $gtk-overlay-layout = gtk_overlay_layout_new();

    my $o = $gtk-overlay-layout ?? self.bless( :$gtk-overlay-layout ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }
}

class GTK::OverlayLayout::Child {
  has GtkOverlayLayoutChild $!gtkol-c is implementor;

  method get_clip_overlay {
    so gtk_overlay_layout_child_get_clip_overlay($!gtkol-c);
  }

  method get_measure {
    so gtk_overlay_layout_child_get_measure($!gtkol-c);
  }

  method set_clip_overlay (Int() $clip_overlay) {
    my gboolean $c = $clip_overlay.so.Int;

    gtk_overlay_layout_child_set_clip_overlay($!gtkol-c, $c);
  }

  method set_measure (Int() $measure) {
    my gboolean $m = $measure.so.Int;

    gtk_overlay_layout_child_set_measure($!gtkol-c, $m);
  }

}


### /usr/src/gtk4/gtk/gtkoverlaylayout.h

sub gtk_overlay_layout_child_get_clip_overlay (GtkOverlayLayoutChild $child)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_layout_child_get_measure (GtkOverlayLayoutChild $child)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_layout_child_set_clip_overlay (
  GtkOverlayLayoutChild $child,
  gboolean              $clip_overlay
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_layout_child_set_measure (
  GtkOverlayLayoutChild $child,
  gboolean              $measure
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_layout_new
  returns GtkOverlayLayout
  is      native(gtk4)
  is      export
{ * }

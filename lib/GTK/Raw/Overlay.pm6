use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Overlay:ver<4>;

### /usr/src/gtk4/gtk/gtkoverlay.h

sub gtk_overlay_add_overlay (
  GtkOverlay $overlay,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_get_child (GtkOverlay $overlay)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_get_clip_overlay (
  GtkOverlay $overlay,
  GtkWidget  $widget
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_get_measure_overlay (
  GtkOverlay $overlay,
  GtkWidget  $widget
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_remove_overlay (
  GtkOverlay $overlay,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_set_child (
  GtkOverlay $overlay,
  GtkWidget  $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_set_clip_overlay (
  GtkOverlay $overlay,
  GtkWidget  $widget,
  gboolean   $clip_overlay
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_overlay_set_measure_overlay (
  GtkOverlay $overlay,
  GtkWidget  $widget,
  gboolean   $measure
)
  is      native(gtk4)
  is      export
{ * }

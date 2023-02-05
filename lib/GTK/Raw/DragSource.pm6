use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::DragSource:ver<4>;

### /usr/src/gtk4/gtk/gtkdragsource.h

sub gtk_drag_source_drag_cancel (GtkDragSource $source)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_get_actions (GtkDragSource $source)
  returns GdkDragAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_get_content (GtkDragSource $source)
  returns GdkContentProvider
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_get_drag (GtkDragSource $source)
  returns GdkDrag
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_check_threshold (
  GtkWidget $widget,
  gint      $start_x,
  gint      $start_y,
  gint      $current_x,
  gint      $current_y
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_new
  returns GtkDragSource
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_set_actions (
  GtkDragSource $source,
  GdkDragAction $actions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_set_content (
  GtkDragSource      $source,
  GdkContentProvider $content
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_source_set_icon (
  GtkDragSource $source,
  GdkPaintable  $paintable,
  gint          $hot_x,
  gint          $hot_y
)
  is      native(gtk4)
  is      export
{ * }

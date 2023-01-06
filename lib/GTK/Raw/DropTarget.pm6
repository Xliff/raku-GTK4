use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::DropTarget:ver<4>;

### /usr/src/gtk4/gtk/gtkdroptarget.h

sub gtk_drop_target_get_actions (GtkDropTarget $self)
  returns GdkDragAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_current_drop (GtkDropTarget $self)
  returns GdkDrop
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_drop (GtkDropTarget $self)
  returns GdkDrop
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_formats (GtkDropTarget $self)
  returns GdkContentFormats
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_gtypes (
  GtkDropTarget $self,
  gsize         $n_types
)
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_preload (GtkDropTarget $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_get_value (GtkDropTarget $self)
  returns GValue
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_new (
  GType         $type,
  GdkDragAction $actions
)
  returns GtkDropTarget
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_reject (GtkDropTarget $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_set_actions (
  GtkDropTarget $self,
  GdkDragAction $actions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_set_gtypes (
  GtkDropTarget $self,
  GType         $types,
  gsize         $n_types
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_set_preload (
  GtkDropTarget $self,
  gboolean      $preload
)
  is      native(gtk4)
  is      export
{ * }

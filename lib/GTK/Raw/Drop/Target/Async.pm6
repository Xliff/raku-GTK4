use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Drop::Target::Async:ver<4>;

### /usr/src/gtk4/gtk/gtkdroptargetasync.h

sub gtk_drop_target_async_get_actions (GtkDropTargetAsync $self)
  returns GdkDragAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_async_get_formats (GtkDropTargetAsync $self)
  returns GdkContentFormats
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_async_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_async_new (
  GdkContentFormats $formats,
  GdkDragAction     $actions
)
  returns GtkDropTargetAsync
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_async_reject_drop (
  GtkDropTargetAsync $self,
  GdkDrop            $drop
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_async_set_actions (
  GtkDropTargetAsync $self,
  GdkDragAction      $actions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_target_async_set_formats (
  GtkDropTargetAsync $self,
  GdkContentFormats  $formats
)
  is      native(gtk4)
  is      export
{ * }

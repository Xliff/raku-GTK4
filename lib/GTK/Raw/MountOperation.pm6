use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::MountOperation;

### /usr/src/gtk4/gtk/gtkmountoperation.h

sub gtk_mount_operation_get_display (GtkMountOperation $op)
  returns GdkDisplay
  is      native(gtk4)
  is      export
{ * }

sub gtk_mount_operation_get_parent (GtkMountOperation $op)
  returns GtkWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_mount_operation_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_mount_operation_is_showing (GtkMountOperation $op)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_mount_operation_new (GtkWindow $parent)
  returns GtkMountOperation
  is      native(gtk4)
  is      export
{ * }

sub gtk_mount_operation_set_display (
  GtkMountOperation $op,
  GdkDisplay        $display
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_mount_operation_set_parent (
  GtkMountOperation $op,
  GtkWindow         $parent
)
  is      native(gtk4)
  is      export
{ * }

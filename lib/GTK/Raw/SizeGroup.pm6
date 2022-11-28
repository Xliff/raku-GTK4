use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::SizeGroup:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtksizegroup.h

sub gtk_size_group_add_widget (
  GtkSizeGroup $size_group,
  GtkWidget    $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_size_group_get_mode (GtkSizeGroup $size_group)
  returns GtkSizeGroupMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_size_group_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_size_group_get_widgets (GtkSizeGroup $size_group)
  returns GSList
  is      native(gtk4)
  is      export
{ * }

sub gtk_size_group_new (GtkSizeGroupMode $mode)
  returns GtkSizeGroup
  is      native(gtk4)
  is      export
{ * }

sub gtk_size_group_remove_widget (
  GtkSizeGroup $size_group,
  GtkWidget    $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_size_group_set_mode (
  GtkSizeGroup     $size_group,
  GtkSizeGroupMode $mode
)
  is      native(gtk4)
  is      export
{ * }

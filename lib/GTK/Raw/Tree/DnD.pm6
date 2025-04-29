use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtktreednd.h

sub gtk_tree_drag_dest_drag_data_received (
  GtkTreeDragDest $drag_dest,
  GtkTreePath     $dest,
  GValue          $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_drag_dest_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_drag_dest_row_drop_possible (
  GtkTreeDragDest $drag_dest,
  GtkTreePath     $dest_path,
  GValue          $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_create_row_drag_content (
  GtkTreeModel $tree_model,
  GtkTreePath  $path
)
  returns GdkContentProvider
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_get_row_drag_data (
  GValue               $value,
  CArray[GtkTreeModel] $tree_model,
  CArray[GtkTreePath]  $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_data_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_drag_source_drag_data_delete (
  GtkTreeDragSource $drag_source,
  GtkTreePath       $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_drag_source_drag_data_get (
  GtkTreeDragSource $drag_source,
  GtkTreePath       $path
)
  returns GdkContentProvider
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_drag_source_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_drag_source_row_draggable (
  GtkTreeDragSource $drag_source,
  GtkTreePath       $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

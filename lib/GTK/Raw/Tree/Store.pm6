use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Tree::Store:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtktreestore.h

sub gtk_tree_store_append (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_clear (GtkTreeStore $tree_store)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_insert (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent,
  gint         $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_insert_after (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent,
  GtkTreeIter  $sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_insert_before (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent,
  GtkTreeIter  $sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_insert_with_values (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent,
  gint         $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_insert_with_valuesv (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent,
  gint         $position,
  CArray[gint] $columns,
  gpointer     $values,
  gint         $n_values
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_is_ancestor (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $descendant
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_iter_depth (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_iter_is_valid (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_move_after (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_move_before (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_new (gint $n_columns, Str)
  returns GtkTreeStore
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_newv (
  gint          $n_columns,
  CArray[GType] $types
)
  returns GtkTreeStore
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_prepend (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_remove (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_reorder (
  GtkTreeStore $tree_store,
  GtkTreeIter  $parent,
  gint         $new_order is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_set (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_set_column_types (
  GtkTreeStore $tree_store,
  gint         $n_columns,
  GType        $types
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_set_value (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  gint         $column,
  GValue       $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_set_valuesv (
  GtkTreeStore $tree_store,
  GtkTreeIter  $iter,
  CArray[gint] $columns,
  gpointer     $values,
  gint         $n_values
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_store_swap (
  GtkTreeStore $tree_store,
  GtkTreeIter  $a,
  GtkTreeIter  $b
)
  is      native(gtk4)
  is      export
{ * }

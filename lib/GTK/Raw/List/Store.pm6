use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::List::Store:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkliststore.h

sub gtk_list_store_append (
  GtkListStore $list_store,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_clear (GtkListStore $list_store)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_insert (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  gint         $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_insert_after (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_insert_before (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  GtkTreeIter  $sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_insert_with_values (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  gint         $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_insert_with_valuesv (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  gint         $position,
  gint         $columns      is rw,
  GValue       $values,
  gint         $n_values
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_iter_is_valid (
  GtkListStore $list_store,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_move_after (
  GtkListStore $store,
  GtkTreeIter  $iter,
  GtkTreeIter  $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_move_before (
  GtkListStore $store,
  GtkTreeIter  $iter,
  GtkTreeIter  $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_new (gint $n_columns, Str)
  returns GtkListStore
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_newv (
  gint          $n_columns,
  CArray[GType] $types
)
  returns GtkListStore
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_prepend (
  GtkListStore $list_store,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_remove (
  GtkListStore $list_store,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_reorder (
  GtkListStore $store,
  gint         $new_order is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_set (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  Str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_set_column_types (
  GtkListStore $list_store,
  gint         $n_columns,
  GType        $types
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_set_value (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  gint         $column,
  GValue       $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_set_valuesv (
  GtkListStore $list_store,
  GtkTreeIter  $iter,
  CArray[gint] $columns,
  gpointer     $values,        #= @[GValue]
  gint         $n_values
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_store_swap (
  GtkListStore $store,
  GtkTreeIter  $a,
  GtkTreeIter  $b
)
  is      native(gtk4)
  is      export
{ * }

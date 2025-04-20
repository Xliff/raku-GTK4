use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtktreesortable.h

sub gtk_tree_sortable_get_sort_column_id (
  GtkTreeSortable $sortable,
  gint            $sort_column_id is rw,
  GtkSortType     $order          is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_sortable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_sortable_has_default_sort_func (GtkTreeSortable $sortable)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_sortable_set_default_sort_func (
  GtkTreeSortable $sortable,
                  &sort_func (
                    GtkTreeModel,
                    GtkTreeIter,
                    GtkTreeIter,
                    gpointer --> gint
                  ),
  gpointer        $user_data,
                  &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_sortable_set_sort_column_id (
  GtkTreeSortable $sortable,
  gint            $sort_column_id,
  GtkSortType     $order
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_sortable_set_sort_func (
  GtkTreeSortable $sortable,
  gint            $sort_column_id,
                  &sort_func (
                    GtkTreeModel,
                    GtkTreeIter,
                    GtkTreeIter,
                    gpointer --> gint
                  ),
  gpointer        $user_data,
                  &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_sortable_sort_column_changed (GtkTreeSortable $sortable)
  is      native(gtk4)
  is      export
{ * }

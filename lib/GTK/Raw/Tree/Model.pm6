use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Tree::Model:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtktreemodel.h

sub gtk_tree_model_foreach (
  GtkTreeModel            $model,
                          &func (
                            GtkTreeModel,
                            GtkTreePath,
                            GtkTreeIter,
                            gpointer
                            --> gboolean
                          ),
  gpointer                $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  GType        $type,
  gpointer     $val,
  gint         $terminator
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_column_type (
  GtkTreeModel $tree_model,
  gint         $index
)
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_flags (GtkTreeModel $tree_model)
  returns GtkTreeModelFlags
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_iter (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  GtkTreePath  $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_iter_first (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_iter_from_string (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  Str          $path_string
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_n_columns (GtkTreeModel $tree_model)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_path (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_string_from_iter (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_valist (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  va_list      $var_args
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_get_value (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  gint         $column,
  GValue       $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_children (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_has_child (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_n_children (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_next (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_nth_child (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  GtkTreeIter  $parent,
  gint         $n
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_parent (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter,
  GtkTreeIter  $child
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_iter_previous (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_ref_node (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_row_changed (
  GtkTreeModel $tree_model,
  GtkTreePath  $path,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_row_deleted (
  GtkTreeModel $tree_model,
  GtkTreePath  $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_row_has_child_toggled (
  GtkTreeModel $tree_model,
  GtkTreePath  $path,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_row_inserted (
  GtkTreeModel $tree_model,
  GtkTreePath  $path,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_rows_reordered (
  GtkTreeModel $tree_model,
  GtkTreePath  $path,
  GtkTreeIter  $iter,
  gint         $new_order is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_rows_reordered_with_length (
  GtkTreeModel $tree_model,
  GtkTreePath  $path,
  GtkTreeIter  $iter,
  gint         $new_order is rw,
  gint         $length
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_model_unref_node (
  GtkTreeModel $tree_model,
  GtkTreeIter  $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_iter_copy (GtkTreeIter $iter)
  returns GtkTreeIter
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_iter_free (GtkTreeIter $iter)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_iter_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_append_index (
  GtkTreePath $path,
  gint        $index_
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_compare (
  GtkTreePath $a,
  GtkTreePath $b
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_copy (GtkTreePath $path)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_down (GtkTreePath $path)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_free (GtkTreePath $path)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_get_depth (GtkTreePath $path)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_get_indices (GtkTreePath $path)
  returns CArray[gint]
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_get_indices_with_depth (
  GtkTreePath $path,
  gint        $depth is rw
)
  returns CArray[gint]
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_is_ancestor (
  GtkTreePath $path,
  GtkTreePath $descendant
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_is_descendant (
  GtkTreePath $path,
  GtkTreePath $ancestor
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_new
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_new_first
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_new_from_indices (gint $first_index)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_new_from_indicesv (
  gint  $indices is rw,
  gsize $length
)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_new_from_string (Str $path)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_next (GtkTreePath $path)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_prepend_index (
  GtkTreePath $path,
  gint        $index_
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_prev (GtkTreePath $path)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_to_string (GtkTreePath $path)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_path_up (GtkTreePath $path)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_copy (GtkTreeRowReference $reference)
  returns GtkTreeRowReference
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_deleted (
  GObject     $proxy,
  GtkTreePath $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_free (GtkTreeRowReference $reference)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_get_model (GtkTreeRowReference $reference)
  returns GtkTreeModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_get_path (GtkTreeRowReference $reference)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_inserted (
  GObject     $proxy,
  GtkTreePath $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_new (
  GtkTreeModel $model,
  GtkTreePath  $path
)
  returns GtkTreeRowReference
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_new_proxy (
  GObject      $proxy,
  GtkTreeModel $model,
  GtkTreePath  $path
)
  returns GtkTreeRowReference
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_reordered (
  GObject     $proxy,
  GtkTreePath $path,
  GtkTreeIter $iter,
  gint        $new_order is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_row_reference_valid (GtkTreeRowReference $reference)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

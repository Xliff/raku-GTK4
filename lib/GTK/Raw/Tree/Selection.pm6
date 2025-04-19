use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Tree::Expander;

### /usr/src/gtk4/gtk/deprecated/gtktreeselection.h

sub gtk_tree_selection_count_selected_rows (GtkTreeSelection $selection)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_get_mode (GtkTreeSelection $selection)
  returns GtkSelectionMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_get_select_function (GtkTreeSelection $selection)
  returns gpointer
  is      native(gtk4)
  is      export
{ * } #= --> &(GtkTreeSelection, GtkTreeModel, GtkTreePath, gboolean, gpointer --> gboolean)

sub gtk_tree_selection_get_selected (
  GtkTreeSelection     $selection,
  CArray[GtkTreeModel] $model,
  GtkTreeIter          $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_get_selected_rows (
  GtkTreeSelection     $selection,
  CArray[GtkTreeModel] $model
)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_get_tree_view (GtkTreeSelection $selection)
  returns GtkTreeView
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_get_user_data (GtkTreeSelection $selection)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_iter_is_selected (
  GtkTreeSelection $selection,
  GtkTreeIter      $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_path_is_selected (
  GtkTreeSelection $selection,
  GtkTreePath      $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_select_all (GtkTreeSelection $selection)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_select_iter (
  GtkTreeSelection $selection,
  GtkTreeIter      $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_select_path (
  GtkTreeSelection $selection,
  GtkTreePath      $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_select_range (
  GtkTreeSelection $selection,
  GtkTreePath      $start_path,
  GtkTreePath      $end_path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_selected_foreach (
  GtkTreeSelection $selection,
                   &func (GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer),
  gpointer         $data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_set_mode (
  GtkTreeSelection $selection,
  GtkSelectionMode $type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_set_select_function (
  GtkTreeSelection     $selection,
  gpointer             $func, #= &(GtkTreeSelection, GtkTreeModel, GtkTreePath, gboolean, gpointer --> gboolean)
  gpointer             $data,
  GDestroyNotify       $destroy
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_unselect_all (GtkTreeSelection $selection)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_unselect_iter (
  GtkTreeSelection $selection,
  GtkTreeIter      $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_unselect_path (
  GtkTreeSelection $selection,
  GtkTreePath      $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_selection_unselect_range (
  GtkTreeSelection $selection,
  GtkTreePath      $start_path,
  GtkTreePath      $end_path
)
  is      native(gtk4)
  is      export
{ * }

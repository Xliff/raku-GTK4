use v6.c;

use NativeCall;

use GLib::Raw::Types:ver<4>;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Tree::View;

### /usr/src/gtk4/gtk/deprecated/gtktreeview.h

sub gtk_tree_view_append_column (
  GtkTreeView       $tree_view,
  GtkTreeViewColumn $column
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_collapse_all (GtkTreeView $tree_view)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_collapse_row (
  GtkTreeView $tree_view,
  GtkTreePath $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_columns_autosize (GtkTreeView $tree_view)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_convert_bin_window_to_tree_coords (
  GtkTreeView $tree_view,
  gint        $bx,
  gint        $by,
  gint        $tx is rw,
  gint        $ty is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_convert_bin_window_to_widget_coords (
  GtkTreeView $tree_view,
  gint        $bx,
  gint        $by,
  gint        $wx is rw,
  gint        $wy is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_convert_tree_to_bin_window_coords (
  GtkTreeView $tree_view,
  gint        $tx,
  gint        $ty,
  gint        $bx is rw,
  gint        $by is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_convert_tree_to_widget_coords (
  GtkTreeView $tree_view,
  gint        $tx,
  gint        $ty,
  gint        $wx is rw,
  gint        $wy is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_convert_widget_to_bin_window_coords (
  GtkTreeView $tree_view,
  gint        $wx,
  gint        $wy,
  gint        $bx is rw,
  gint        $by is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_convert_widget_to_tree_coords (
  GtkTreeView $tree_view,
  gint        $wx,
  gint        $wy,
  gint        $tx is rw,
  gint        $ty is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_create_row_drag_icon (
  GtkTreeView $tree_view,
  GtkTreePath $path
)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_enable_model_drag_dest (
  GtkTreeView       $tree_view,
  GdkContentFormats $formats,
  GdkDragAction     $actions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_enable_model_drag_source (
  GtkTreeView       $tree_view,
  GdkModifierType   $start_button_mask,
  GdkContentFormats $formats,
  GdkDragAction     $actions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_expand_all (GtkTreeView $tree_view)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_expand_row (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  gboolean    $open_all
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_expand_to_path (
  GtkTreeView $tree_view,
  GtkTreePath $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_activate_on_single_click (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_background_area (
  GtkTreeView       $tree_view,
  GtkTreePath       $path,
  GtkTreeViewColumn $column,
  GdkRectangle      $rect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_cell_area (
  GtkTreeView       $tree_view,
  GtkTreePath       $path,
  GtkTreeViewColumn $column,
  GdkRectangle      $rect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_column (
  GtkTreeView $tree_view,
  gint        $n
)
  returns GtkTreeViewColumn
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_columns (GtkTreeView $tree_view)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_cursor (
  GtkTreeView               $tree_view,
  CArray[GtkTreePath]       $path,
  CArray[GtkTreeViewColumn] $focus_column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_dest_row_at_pos (
  GtkTreeView             $tree_view,
  gint                    $drag_x,
  gint                    $drag_y,
  CArray[GtkTreePath]     $path,
  GtkTreeViewDropPosition $pos
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_drag_dest_row (
  GtkTreeView             $tree_view,
  CArray[GtkTreePath]     $path,
  GtkTreeViewDropPosition $pos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_enable_search (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_enable_tree_lines (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_expander_column (GtkTreeView $tree_view)
  returns GtkTreeViewColumn
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_fixed_height_mode (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_grid_lines (GtkTreeView $tree_view)
  returns GtkTreeViewGridLines
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_headers_clickable (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_headers_visible (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_hover_expand (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_hover_selection (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_level_indentation (GtkTreeView $tree_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_model (GtkTreeView $tree_view)
  returns GtkTreeModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_n_columns (GtkTreeView $tree_view)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_path_at_pos (
  GtkTreeView               $tree_view,
  gint                      $x,
  gint                      $y,
  CArray[GtkTreePath]       $path,
  CArray[GtkTreeViewColumn] $column,
  gint                      $cell_x is rw,
  gint                      $cell_y is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_reorderable (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_row_separator_func (GtkTreeView $tree_view)
  returns gpointer
  is      native(gtk4)
  is      export
{ * } #=

sub gtk_tree_view_get_rubber_banding (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_search_column (GtkTreeView $tree_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_search_entry (GtkTreeView $tree_view)
  returns GtkEditable
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_search_equal_func (GtkTreeView $tree_view)
  returns gpointer
  is      native(gtk4)
  is      export
{ * } #= GtkTreeViewSearchEqualFunc

sub gtk_tree_view_get_selection (GtkTreeView $tree_view)
  returns GtkTreeSelection
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_show_expanders (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_tooltip_column (GtkTreeView $tree_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_tooltip_context (
  GtkTreeView          $tree_view,
  gint                 $x,
  gint                 $y,
  gboolean             $keyboard_tip,
  CArray[GtkTreeModel] $model,
  CArray[GtkTreePath]  $path,
  GtkTreeIter          $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_visible_range (
  GtkTreeView         $tree_view,
  CArray[GtkTreePath] $start_path,
  CArray[GtkTreePath] $end_path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_get_visible_rect (
  GtkTreeView  $tree_view,
  GdkRectangle $visible_rect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_insert_column (
  GtkTreeView       $tree_view,
  GtkTreeViewColumn $column,
  gint              $position
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_insert_column_with_attributes (
  GtkTreeView     $tree_view,
  gint            $position,
  Str             $title,
  GtkCellRenderer $cell
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_insert_column_with_data_func (
  GtkTreeView     $tree_view,
  gint            $position,
  Str             $title,
  GtkCellRenderer $cell,
                  &func (
                    GtkTreeViewColumn,
                    GtkCellRenderer,
                    GtkTreeModel,
                    GtkTreeIter,
                    gpointer,
                    gpointer,
                    gpointer
                  )
)
  returns gint
  is      native(gtk4)
  is      export
{ * }
#= 7 param on &func - &(gpointer)

sub gtk_tree_view_is_blank_at_pos (
  GtkTreeView               $tree_view,
  gint                      $x,
  gint                      $y,
  CArray[GtkTreePath]       $path,
  CArray[GtkTreeViewColumn] $column,
  gint                      $cell_x is rw,
  gint                      $cell_y is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_is_rubber_banding_active (GtkTreeView $tree_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_map_expanded_rows (
  GtkTreeView $tree_view,
              &func (GtkTreeView, GtkTreePath, gpointer),
  gpointer    $data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_move_column_after (
  GtkTreeView       $tree_view,
  GtkTreeViewColumn $column,
  GtkTreeViewColumn $base_column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_new_with_model (GtkTreeModel $model)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_remove_column (
  GtkTreeView       $tree_view,
  GtkTreeViewColumn $column
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_row_activated (
  GtkTreeView       $tree_view,
  GtkTreePath       $path,
  GtkTreeViewColumn $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_row_expanded (
  GtkTreeView $tree_view,
  GtkTreePath $path
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_scroll_to_cell (
  GtkTreeView       $tree_view,
  GtkTreePath       $path,
  GtkTreeViewColumn $column,
  gboolean          $use_align,
  gfloat            $row_align,
  gfloat            $col_align
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_scroll_to_point (
  GtkTreeView $tree_view,
  gint        $tree_x,
  gint        $tree_y
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_activate_on_single_click (
  GtkTreeView $tree_view,
  gboolean    $single
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_column_drag_function (
  GtkTreeView $tree_view,
              &func (
                GtkTreeView,
                GtkTreeViewColumn,
                GtkTreeViewColumn,
                GtkTreeViewColumn,
                gpointer --> gboolean
              ),
  gpointer    $user_data,
              &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_cursor (
  GtkTreeView       $tree_view,
  GtkTreePath       $path,
  GtkTreeViewColumn $focus_column,
  gboolean          $start_editing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_cursor_on_cell (
  GtkTreeView       $tree_view,
  GtkTreePath       $path,
  GtkTreeViewColumn $focus_column,
  GtkCellRenderer   $focus_cell,
  gboolean          $start_editing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_drag_dest_row (
  GtkTreeView             $tree_view,
  GtkTreePath             $path,
  GtkTreeViewDropPosition $pos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_enable_search (
  GtkTreeView $tree_view,
  gboolean    $enable_search
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_enable_tree_lines (
  GtkTreeView $tree_view,
  gboolean    $enabled
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_expander_column (
  GtkTreeView       $tree_view,
  GtkTreeViewColumn $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_fixed_height_mode (
  GtkTreeView $tree_view,
  gboolean    $enable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_grid_lines (
  GtkTreeView          $tree_view,
  GtkTreeViewGridLines $grid_lines
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_headers_clickable (
  GtkTreeView $tree_view,
  gboolean    $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_headers_visible (
  GtkTreeView $tree_view,
  gboolean    $headers_visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_hover_expand (
  GtkTreeView $tree_view,
  gboolean    $expand
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_hover_selection (
  GtkTreeView $tree_view,
  gboolean    $hover
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_level_indentation (
  GtkTreeView $tree_view,
  gint        $indentation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_model (
  GtkTreeView  $tree_view,
  GtkTreeModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_reorderable (
  GtkTreeView $tree_view,
  gboolean    $reorderable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_row_separator_func (
  GtkTreeView    $tree_view,
                 &func (GtkTreeModel, GtkTreeIter, gpointer --> gboolean ),
  gpointer       $data,
                 &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_rubber_banding (
  GtkTreeView $tree_view,
  gboolean    $enable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_search_column (
  GtkTreeView $tree_view,
  gint        $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_search_entry (
  GtkTreeView $tree_view,
  GtkEditable $entry
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_search_equal_func (
  GtkTreeView $tree_view,
              &func (
                GtkTreeModel,
                gint,
                Str,
                GtkTreeIter,
                gpointer --> gboolean
              ),
  gpointer    $search_user_data,
              &notify (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_show_expanders (
  GtkTreeView $tree_view,
  gboolean    $enabled
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_tooltip_cell (
  GtkTreeView       $tree_view,
  GtkTooltip        $tooltip,
  GtkTreePath       $path,
  GtkTreeViewColumn $column,
  GtkCellRenderer   $cell
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_tooltip_column (
  GtkTreeView $tree_view,
  gint        $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_set_tooltip_row (
  GtkTreeView $tree_view,
  GtkTooltip  $tooltip,
  GtkTreePath $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_unset_rows_drag_dest (GtkTreeView $tree_view)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_view_unset_rows_drag_source (GtkTreeView $tree_view)
  is      native(gtk4)
  is      export
{ * }

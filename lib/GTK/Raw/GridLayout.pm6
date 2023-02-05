use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::GridLayout:ver<4>;

### /usr/src/gtk4/gtk/gtkgridlayout.h

sub gtk_grid_layout_child_get_column (GtkGridLayoutChild $child)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_get_column_span (GtkGridLayoutChild $child)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_get_row (GtkGridLayoutChild $child)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_get_row_span (GtkGridLayoutChild $child)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_set_column (
  GtkGridLayoutChild $child,
  gint               $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_set_column_span (
  GtkGridLayoutChild $child,
  gint               $span
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_set_row (
  GtkGridLayoutChild $child,
  gint               $row
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_child_set_row_span (
  GtkGridLayoutChild $child,
  gint               $span
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_get_baseline_row (GtkGridLayout $grid)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_get_column_homogeneous (GtkGridLayout $grid)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_get_column_spacing (GtkGridLayout $grid)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_get_row_baseline_position (
  GtkGridLayout $grid,
  gint          $row
)
  returns GtkBaselinePosition
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_get_row_homogeneous (GtkGridLayout $grid)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_get_row_spacing (GtkGridLayout $grid)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_new
  returns GtkGridLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_set_baseline_row (
  GtkGridLayout $grid,
  gint          $row
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_set_column_homogeneous (
  GtkGridLayout $grid,
  gboolean      $homogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_set_column_spacing (
  GtkGridLayout $grid,
  guint         $spacing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_set_row_baseline_position (
  GtkGridLayout       $grid,
  gint                $row,
  GtkBaselinePosition $pos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_set_row_homogeneous (
  GtkGridLayout $grid,
  gboolean      $homogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_layout_set_row_spacing (
  GtkGridLayout $grid,
  guint         $spacing
)
  is      native(gtk4)
  is      export
{ * }

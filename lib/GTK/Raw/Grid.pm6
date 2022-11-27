use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Grid;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkgrid.h

sub gtk_grid_attach (
  GtkGrid   $grid,
  GtkWidget $child,
  gint      $column,
  gint      $row,
  gint      $width,
  gint      $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_attach_next_to (
  GtkGrid         $grid,
  GtkWidget       $child,
  GtkWidget       $sibling,
  GtkPositionType $side,
  gint            $width,
  gint            $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_baseline_row (GtkGrid $grid)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_child_at (
  GtkGrid $grid,
  gint    $column,
  gint    $row
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_column_homogeneous (GtkGrid $grid)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_column_spacing (GtkGrid $grid)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_row_baseline_position (
  GtkGrid $grid,
  gint    $row
)
  returns GtkBaselinePosition
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_row_homogeneous (GtkGrid $grid)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_row_spacing (GtkGrid $grid)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_insert_column (
  GtkGrid $grid,
  gint    $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_insert_next_to (
  GtkGrid         $grid,
  GtkWidget       $sibling,
  GtkPositionType $side
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_insert_row (
  GtkGrid $grid,
  gint    $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_new
  returns GtkGrid
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_query_child (
  GtkGrid   $grid,
  GtkWidget $child,
  gint      $column is rw,
  gint      $row    is rw,
  gint      $width  is rw,
  gint      $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_remove (
  GtkGrid   $grid,
  GtkWidget $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_remove_column (
  GtkGrid $grid,
  gint    $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_remove_row (
  GtkGrid $grid,
  gint    $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_set_baseline_row (
  GtkGrid $grid,
  gint    $row
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_set_column_homogeneous (
  GtkGrid  $grid,
  gboolean $homogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_set_column_spacing (
  GtkGrid $grid,
  guint   $spacing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_set_row_baseline_position (
  GtkGrid             $grid,
  gint                $row,
  GtkBaselinePosition $pos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_set_row_homogeneous (
  GtkGrid  $grid,
  gboolean $homogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_set_row_spacing (
  GtkGrid $grid,
  guint   $spacing
)
  is      native(gtk4)
  is      export
{ * }

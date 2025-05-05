use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Cell::Area::Context:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcellareacontext.h

sub gtk_cell_area_context_allocate (
  GtkCellAreaContext $context,
  gint               $width,
  gint               $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_allocation (
  GtkCellAreaContext $context,
  gint               $width is rw,
  gint               $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_area (GtkCellAreaContext $context)
  returns GtkCellArea
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_preferred_height (
  GtkCellAreaContext $context,
  gint               $minimum_height is rw,
  gint               $natural_height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_preferred_height_for_width (
  GtkCellAreaContext $context,
  gint               $width,
  gint               $minimum_height is rw,
  gint               $natural_height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_preferred_width (
  GtkCellAreaContext $context,
  gint               $minimum_width is rw,
  gint               $natural_width is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_preferred_width_for_height (
  GtkCellAreaContext $context,
  gint               $height,
  gint               $minimum_width is rw,
  gint               $natural_width is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_push_preferred_height (
  GtkCellAreaContext $context,
  gint               $minimum_height,
  gint               $natural_height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_push_preferred_width (
  GtkCellAreaContext $context,
  gint               $minimum_width,
  gint               $natural_width
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_context_reset (GtkCellAreaContext $context)
  is      native(gtk4)
  is      export
{ * }

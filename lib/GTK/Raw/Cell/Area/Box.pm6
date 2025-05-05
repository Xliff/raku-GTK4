use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Cell::Area::Box:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcellareabox.h

sub gtk_cell_area_box_get_spacing (GtkCellAreaBox $box)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_box_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_box_new
  returns GtkCellArea
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_box_pack_end (
  GtkCellAreaBox  $box,
  GtkCellRenderer $renderer,
  gboolean        $expand,
  gboolean        $align,
  gboolean        $fixed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_box_pack_start (
  GtkCellAreaBox  $box,
  GtkCellRenderer $renderer,
  gboolean        $expand,
  gboolean        $align,
  gboolean        $fixed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_area_box_set_spacing (
  GtkCellAreaBox $box,
  gint           $spacing
)
  is      native(gtk4)
  is      export
{ * }

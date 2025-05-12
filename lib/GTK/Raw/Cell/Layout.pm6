use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Cell::Editable:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcelllayout.h

sub gtk_cell_layout_add_attribute (
  GtkCellLayout   $cell_layout,
  GtkCellRenderer $cell,
  Str             $attribute,
  gint            $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_clear (GtkCellLayout $cell_layout)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_clear_attributes (
  GtkCellLayout   $cell_layout,
  GtkCellRenderer $cell
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_get_area (GtkCellLayout $cell_layout)
  returns GtkCellArea
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_get_cells (GtkCellLayout $cell_layout)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_pack_end (
  GtkCellLayout   $cell_layout,
  GtkCellRenderer $cell,
  gboolean        $expand
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_pack_start (
  GtkCellLayout   $cell_layout,
  GtkCellRenderer $cell,
  gboolean        $expand
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_reorder (
  GtkCellLayout   $cell_layout,
  GtkCellRenderer $cell,
  gint            $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_set_attributes (
  GtkCellLayout   $cell_layout,
  GtkCellRenderer $cell
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_layout_set_cell_data_func (
  GtkCellLayout $cell_layout,
                &func (
                  GtkCellLayout,
                  GtkCellRenderer,
                  GtkTreeModel,
                  GtkTreeIter,
                  gpointer
                ),
  gpointer      $func_data,
                &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

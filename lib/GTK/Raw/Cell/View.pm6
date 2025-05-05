use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Cell::View:ver<4>;

### /usr/src/gtk4/gtk/gtkcellview.h

sub gtk_cell_view_get_displayed_row (GtkCellView $cell_view)
  returns GtkTreePath
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_get_draw_sensitive (GtkCellView $cell_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_get_fit_model (GtkCellView $cell_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_get_model (GtkCellView $cell_view)
  returns GtkTreeModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_new_with_context (
  GtkCellArea        $area,
  GtkCellAreaContext $context
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_new_with_markup (Str $markup)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_new_with_text (Str $text)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_new_with_texture (GdkTexture $texture)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_set_displayed_row (
  GtkCellView $cell_view,
  GtkTreePath $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_set_draw_sensitive (
  GtkCellView $cell_view,
  gboolean    $draw_sensitive
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_set_fit_model (
  GtkCellView $cell_view,
  gboolean    $fit_model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_view_set_model (
  GtkCellView  $cell_view,
  GtkTreeModel $model
)
  is      native(gtk4)
  is      export
{ * }

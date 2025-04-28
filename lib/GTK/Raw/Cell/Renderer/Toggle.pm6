use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Cell::Renderer::Toggle:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcellrenderertoggle.h

sub gtk_cell_renderer_toggle_get_activatable (GtkCellRendererToggle $toggle)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_get_active (GtkCellRendererToggle $toggle)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_get_radio (GtkCellRendererToggle $toggle)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_new
  returns GtkCellRenderer
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_set_activatable (
  GtkCellRendererToggle $toggle,
  gboolean              $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_set_active (
  GtkCellRendererToggle $toggle,
  gboolean              $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_toggle_set_radio (
  GtkCellRendererToggle $toggle,
  gboolean              $radio
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Cell::Renderer:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcellrenderer.h

sub gtk_cell_renderer_activate (
  GtkCellRenderer      $cell,
  GdkEvent             $event,
  GtkWidget            $widget,
  Str                  $path,
  GdkRectangle         $background_area,
  GdkRectangle         $cell_area,
  GtkCellRendererState $flags
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_aligned_area (
  GtkCellRenderer      $cell,
  GtkWidget            $widget,
  GtkCellRendererState $flags,
  GdkRectangle         $cell_area,
  GdkRectangle         $aligned_area
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_alignment (
  GtkCellRenderer $cell,
  gfloat          $xalign is rw,
  gfloat          $yalign is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_fixed_size (
  GtkCellRenderer $cell,
  gint            $width is rw,
  gint            $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_is_expanded (GtkCellRenderer $cell)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_is_expander (GtkCellRenderer $cell)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_padding (
  GtkCellRenderer $cell,
  gint            $xpad is rw,
  gint            $ypad is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_preferred_height (
  GtkCellRenderer $cell,
  GtkWidget       $widget,
  gint            $minimum_size is rw,
  gint            $natural_size is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_preferred_height_for_width (
  GtkCellRenderer $cell,
  GtkWidget       $widget,
  gint            $width,
  gint            $minimum_height is rw,
  gint            $natural_height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_preferred_size (
  GtkCellRenderer $cell,
  GtkWidget       $widget,
  GtkRequisition  $minimum_size,
  GtkRequisition  $natural_size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_preferred_width (
  GtkCellRenderer $cell,
  GtkWidget       $widget,
  gint            $minimum_size is rw,
  gint            $natural_size is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_preferred_width_for_height (
  GtkCellRenderer $cell,
  GtkWidget       $widget,
  gint            $height,
  gint            $minimum_width is rw,
  gint            $natural_width is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_request_mode (GtkCellRenderer $cell)
  returns GtkSizeRequestMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_sensitive (GtkCellRenderer $cell)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_state (
  GtkCellRenderer      $cell,
  GtkWidget            $widget,
  GtkCellRendererState $cell_state
)
  returns GtkStateFlags
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_get_visible (GtkCellRenderer $cell)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_is_activatable (GtkCellRenderer $cell)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_alignment (
  GtkCellRenderer $cell,
  gfloat          $xalign,
  gfloat          $yalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_fixed_size (
  GtkCellRenderer $cell,
  gint            $width,
  gint            $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_is_expanded (
  GtkCellRenderer $cell,
  gboolean        $is_expanded
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_is_expander (
  GtkCellRenderer $cell,
  gboolean        $is_expander
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_padding (
  GtkCellRenderer $cell,
  gint            $xpad,
  gint            $ypad
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_sensitive (
  GtkCellRenderer $cell,
  gboolean        $sensitive
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_set_visible (
  GtkCellRenderer $cell,
  gboolean        $visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_snapshot (
  GtkCellRenderer      $cell,
  GtkSnapshot          $snapshot,
  GtkWidget            $widget,
  GdkRectangle         $background_area,
  GdkRectangle         $cell_area,
  GtkCellRendererState $flags
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_start_editing (
  GtkCellRenderer      $cell,
  GdkEvent             $event,
  GtkWidget            $widget,
  Str                  $path,
  GdkRectangle         $background_area,
  GdkRectangle         $cell_area,
  GtkCellRendererState $flags
)
  returns GtkCellEditable
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_stop_editing (
  GtkCellRenderer $cell,
  gboolean        $canceled
)
  is      native(gtk4)
  is      export
{ * }

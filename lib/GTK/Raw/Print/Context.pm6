use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Print::Context:ver<4>;

### /usr/src/gtk4/gtk/gtkprintcontext.h

sub gtk_print_context_create_pango_context (GtkPrintContext $context)
  returns PangoContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_create_pango_layout (GtkPrintContext $context)
  returns PangoLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_cairo_context (GtkPrintContext $context)
  returns cairo_t
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_dpi_x (GtkPrintContext $context)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_dpi_y (GtkPrintContext $context)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_hard_margins (
  GtkPrintContext $context,
  gdouble         $top is rw,
  gdouble         $bottom is rw,
  gdouble         $left is rw,
  gdouble         $right is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_height (GtkPrintContext $context)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_page_setup (GtkPrintContext $context)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_pango_fontmap (GtkPrintContext $context)
  returns PangoFontMap
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_get_width (GtkPrintContext $context)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_context_set_cairo_context (
  GtkPrintContext $context,
  cairo_t         $cr,
  gdouble         $dpi_x,
  gdouble         $dpi_y
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Printer:ver<4>;

### /usr/src/gtk4/gtk/gtkprinter.h

sub gtk_printer_accepts_pdf (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_accepts_ps (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_compare (
  GtkPrinter $a,
  GtkPrinter $b
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_backend (GtkPrinter $printer)
  returns GtkPrintBackend
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_capabilities (GtkPrinter $printer)
  returns GtkPrintCapabilities
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_default_page_size (GtkPrinter $printer)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_description (GtkPrinter $printer)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_hard_margins (
  GtkPrinter $printer,
  gdouble    $top2     is rw,
  gdouble    $bottom   is rw,
  gdouble    $left     is rw,
  gdouble    $right    is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_hard_margins_for_paper_size (
  GtkPrinter   $printer,
  GtkPaperSize $paper_size,
  gdouble      $top         is rw,
  gdouble      $bottom      is rw,
  gdouble      $left        is rw,
  gdouble      $right       is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_icon_name (GtkPrinter $printer)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_job_count (GtkPrinter $printer)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_location (GtkPrinter $printer)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_name (GtkPrinter $printer)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_state_message (GtkPrinter $printer)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_enumerate_printers (
           &func (GtkPrinter, gpointer --> gboolean),
  gpointer $data,
           &destroy (gpointer),
  gboolean $wait
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_capabilities_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_has_details (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_is_accepting_jobs (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_is_active (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_is_default (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_is_paused (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_is_virtual (GtkPrinter $printer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_list_papers (GtkPrinter $printer)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_new (
  Str             $name,
  GtkPrintBackend $backend,
  gboolean        $virtual_
)
  returns GtkPrinter
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_request_details (GtkPrinter $printer)
  is      native(gtk4)
  is      export
{ * }

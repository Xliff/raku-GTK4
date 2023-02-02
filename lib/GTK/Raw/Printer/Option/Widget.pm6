use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Printer::Option::Widget:ver<4>;

### /usr/src/gtk4/gtk/gtkprinteroptionwidget.h

sub gtk_printer_option_widget_get_external_label (
  GtkPrinterOptionWidget $setting
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_widget_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_widget_get_value (GtkPrinterOptionWidget $setting)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_widget_has_external_label (
  GtkPrinterOptionWidget $setting
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_widget_new (GtkPrinterOption $source)
  returns GtkPrinterOptionWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_widget_set_source (
  GtkPrinterOptionWidget $setting,
  GtkPrinterOption       $source
)
  is      native(gtk4)
  is      export
{ * }

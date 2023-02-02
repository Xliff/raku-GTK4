use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Printer::Option:ver<4>;

### /usr/src/gtk4/gtk/gtkprinteroption.h

sub gtk_printer_option_allocate_choices (
  GtkPrinterOption $option,
  gint             $num
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_choices_from_array (
  GtkPrinterOption $option,
  gint             $num_choices,
  CArray[Str]      $choices,
  CArray[Str]      $choices_display
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_clear_has_conflict (GtkPrinterOption $option)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_get_activates_default (GtkPrinterOption $option)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_has_choice (
  GtkPrinterOption $option,
  Str              $choice
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_new (
  Str                  $name,
  Str                  $display_text,
  GtkPrinterOptionType $type
)
  returns GtkPrinterOption
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set (
  GtkPrinterOption $option,
  Str              $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_activates_default (
  GtkPrinterOption $option,
  gboolean         $activates
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_boolean (
  GtkPrinterOption $option,
  gboolean         $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_has_conflict (
  GtkPrinterOption $option,
  gboolean         $has_conflict
)
  is      native(gtk4)
  is      export
{ * }

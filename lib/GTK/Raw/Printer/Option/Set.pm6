use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Printer::Option::Set:ver<4>;

### /usr/src/gtk4/gtk/gtkprinteroptionset.h

sub gtk_printer_option_set_add (
  GtkPrinterOptionSet $set,
  GtkPrinterOption    $option
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_clear_conflicts (GtkPrinterOptionSet $set)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_foreach (
  GtkPrinterOptionSet $set,
                      &func (GtkPrinterOption, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_foreach_in_group (
  GtkPrinterOptionSet $set,
  Str                 $group,
                      &func (GtkPrinterOption, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_get_groups (GtkPrinterOptionSet $set)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_lookup (
  GtkPrinterOptionSet $set,
  Str                 $name
)
  returns GtkPrinterOption
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_new
  returns GtkPrinterOptionSet
  is      native(gtk4)
  is      export
{ * }

sub gtk_printer_option_set_remove (
  GtkPrinterOptionSet $set,
  GtkPrinterOption    $option
)
  is      native(gtk4)
  is      export
{ * }

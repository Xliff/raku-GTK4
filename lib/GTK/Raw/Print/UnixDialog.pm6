use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Print::UnixDialog;

### /usr/src/gtk4/gtk/gtkprintunixdialog.h

sub gtk_print_unix_dialog_add_custom_tab (
  GtkPrintUnixDialog $dialog,
  GtkWidget          $child,
  GtkWidget          $tab_label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_current_page (GtkPrintUnixDialog $dialog)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_embed_page_setup (GtkPrintUnixDialog $dialog)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_has_selection (GtkPrintUnixDialog $dialog)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_manual_capabilities (GtkPrintUnixDialog $dialog)
  returns GtkPrintCapabilities
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_page_setup (GtkPrintUnixDialog $dialog)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_page_setup_set (GtkPrintUnixDialog $dialog)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_selected_printer (GtkPrintUnixDialog $dialog)
  returns GtkPrinter
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_settings (GtkPrintUnixDialog $dialog)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_support_selection (GtkPrintUnixDialog $dialog)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_new (
  Str       $title,
  GtkWindow $parent
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_current_page (
  GtkPrintUnixDialog $dialog,
  gint               $current_page
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_embed_page_setup (
  GtkPrintUnixDialog $dialog,
  gboolean           $embed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_has_selection (
  GtkPrintUnixDialog $dialog,
  gboolean           $has_selection
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_manual_capabilities (
  GtkPrintUnixDialog   $dialog,
  GtkPrintCapabilities $capabilities
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_page_setup (
  GtkPrintUnixDialog $dialog,
  GtkPageSetup       $page_setup
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_settings (
  GtkPrintUnixDialog $dialog,
  GtkPrintSettings   $settings
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_unix_dialog_set_support_selection (
  GtkPrintUnixDialog $dialog,
  gboolean           $support_selection
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GTK::Raw::Structs;

unit package GTK::Raw::Page::Setup::UnixDialog;

### /usr/src/gtk4/gtk/gtkpagesetupunixdialog.h

sub gtk_page_setup_unix_dialog_get_page_setup (GtkPageSetupUnixDialog $dialog)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_unix_dialog_get_print_settings (GtkPageSetupUnixDialog $dialog)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_unix_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_unix_dialog_new (
  Str       $title,
  GtkWindow $parent
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_unix_dialog_set_page_setup (
  GtkPageSetupUnixDialog $dialog,
  GtkPageSetup           $page_setup
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_unix_dialog_set_print_settings (
  GtkPageSetupUnixDialog $dialog,
  GtkPrintSettings       $print_settings
)
  is      native(gtk4)
  is      export
{ * }

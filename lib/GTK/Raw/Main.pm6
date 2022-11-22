use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Main:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkmain.h

sub gtk_disable_setlocale
  is      native(gtk4)
  is      export
{ * }

sub gtk_get_default_language
  returns PangoLanguage
  is      native(gtk4)
  is      export
{ * }

sub gtk_get_locale_direction
  returns GtkTextDirection
  is      native(gtk4)
  is      export
{ * }

sub gtk_init
  is      native(gtk4)
  is      export
{ * }

sub gtk_init_abi_check (
  gint   $num_checks,
  size_t $sizeof_GtkWindow,
  size_t $sizeof_GtkBox
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_init_check
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_init_check_abi_check (
  gint   $num_checks,
  size_t $sizeof_GtkWindow,
  size_t $sizeof_GtkBox
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_is_initialized
  returns uint32
  is      native(gtk4)
  is      export
{ * }

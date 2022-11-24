use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::CssProvider:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkcssprovider.h

sub gtk_css_provider_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_load_from_data (
  GtkCssProvider $css_provider,
  CArray[uint8]  $data,
  gssize         $length
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_load_from_file (
  GtkCssProvider $css_provider,
  GFile          $file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_load_from_path (
  GtkCssProvider $css_provider,
  Str            $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_load_from_resource (
  GtkCssProvider $css_provider,
  Str            $resource_path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_load_named (
  GtkCssProvider $provider,
  Str            $name,
  Str            $variant
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_new
  returns GtkCssProvider
  is      native(gtk4)
  is      export
{ * }

sub gtk_css_provider_to_string (GtkCssProvider $provider)
  returns Str
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Button::Link;

### /usr/src/gtk4/gtk/gtklinkbutton.h

sub gtk_link_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_link_button_get_uri (GtkLinkButton $link_button)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_link_button_get_visited (GtkLinkButton $link_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_link_button_new (Str $uri)
  returns GtkLinkButtons
  is      native(gtk4)
  is      export
{ * }

sub gtk_link_button_new_with_label (
  Str $uri,
  Str $label
)
  returns GtkLinkButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_link_button_set_uri (
  GtkLinkButton $link_button,
  Str           $uri
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_link_button_set_visited (
  GtkLinkButton $link_button,
  gboolean      $visited
)
  is      native(gtk4)
  is      export
{ * }

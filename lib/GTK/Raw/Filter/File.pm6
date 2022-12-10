use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>

unit package GTK::Raw::Filter::File:ver<4>;

### /usr/src/gtk4/gtk/gtkfilefilter.h

sub gtk_file_filter_add_mime_type (
  GtkFileFilter $filter,
  Str           $mime_type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_add_pattern (
  GtkFileFilter $filter,
  Str           $pattern
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_add_pixbuf_formats (GtkFileFilter $filter)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_add_suffix (
  GtkFileFilter $filter,
  Str           $suffix
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_get_attributes (GtkFileFilter $filter)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_get_name (GtkFileFilter $filter)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_new
  returns GtkFileFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_new_from_gvariant (GVariant $variant)
  returns GtkFileFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_set_name (
  GtkFileFilter $filter,
  Str           $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_filter_to_gvariant (GtkFileFilter $filter)
  returns GVariant
  is      native(gtk4)
  is      export
{ * }

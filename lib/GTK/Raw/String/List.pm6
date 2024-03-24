use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::String::List:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkstringlist.h

sub gtk_string_list_append (
  GtkStringList $self,
  Str           $string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_list_get_string (
  GtkStringList $self,
  guint         $position
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_object_get_string (GtkStringObject $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_object_new (Str $string)
  returns GtkStringObject
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_list_new (CArray[Str] $strings)
  returns GtkStringList
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_list_remove (
  GtkStringList $self,
  guint         $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_list_splice (
  GtkStringList $self,
  guint         $position,
  guint         $n_removals,
  CArray[Str]   $additions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_list_take (
  GtkStringList $self,
  Str           $string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_list_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_object_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

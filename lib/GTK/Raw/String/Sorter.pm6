use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::String::Sorter:ver<4>;

### /usr/src/gtk4/gtk/gtkstringsorter.h

sub gtk_string_sorter_get_collation (GtkStringSorter $self)
  returns GtkCollation
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_sorter_get_expression (GtkStringSorter $self)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_sorter_get_ignore_case (GtkStringSorter $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_sorter_new (GtkExpression $expression)
  returns GtkStringSorter
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_sorter_set_collation (
  GtkStringSorter $self,
  GtkCollation    $collation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_sorter_set_expression (
  GtkStringSorter $self,
  GtkExpression   $expression
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_sorter_set_ignore_case (
  GtkStringSorter $self,
  gboolean        $ignore_case
)
  is      native(gtk4)
  is      export
{ * }

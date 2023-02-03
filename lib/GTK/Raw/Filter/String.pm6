use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Filter::String:ver<4>;

### /usr/src/gtk4/gtk/gtkstringfilter.h

sub gtk_string_filter_get_expression (GtkStringFilter $self)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_get_ignore_case (GtkStringFilter $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_get_match_mode (GtkStringFilter $self)
  returns GtkStringFilterMatchMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_get_search (GtkStringFilter $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_new (GtkExpression $expression)
  returns GtkStringFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_set_expression (
  GtkStringFilter $self,
  GtkExpression   $expression
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_set_ignore_case (
  GtkStringFilter $self,
  gboolean        $ignore_case
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_set_match_mode (
  GtkStringFilter          $self,
  GtkStringFilterMatchMode $mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_string_filter_set_search (
  GtkStringFilter $self,
  Str             $search
)
  is      native(gtk4)
  is      export
{ * }

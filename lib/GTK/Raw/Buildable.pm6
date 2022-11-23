use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Buildable:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkbuildable.h

sub gtk_buildable_get_buildable_id (GtkBuildable $buildable)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_buildable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_buildable_parse_context_get_element (GtkBuildableParseContext $context)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_buildable_parse_context_get_element_stack (
  GtkBuildableParseContext $context
)
  returns GPtrArray
  is      native(gtk4)
  is      export
{ * }

sub gtk_buildable_parse_context_get_position (
  GtkBuildableParseContext $context,
  gint                     $line_number is rw,
  gint                     $char_number is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_buildable_parse_context_pop (GtkBuildableParseContext $context)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_buildable_parse_context_push (
  GtkBuildableParseContext $context,
  GtkBuildableParser       $parser,
  gpointer                 $user_data
)
  is      native(gtk4)
  is      export
{ * }

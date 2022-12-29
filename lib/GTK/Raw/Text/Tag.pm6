use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

# cw: Making exception due to length of class implementation compunit.
unit package GTK::Raw::Text::Tag:ver<4>;

### /usr/src/gtk4/gtk/gtktexttag.h

sub gtk_text_tag_changed (
  GtkTextTag $tag,
  gboolean   $size_changed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_get_priority (GtkTextTag $tag)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_new (Str $name)
  returns GtkTextTag
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_set_priority (
  GtkTextTag $tag,
  gint       $priority
)
  is      native(gtk4)
  is      export
{ * }

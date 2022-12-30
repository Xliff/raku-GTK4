use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Text::Mark:ver<4>;

### /usr/src/gtk4/gtk/gtktextmark.h

sub gtk_text_mark_get_buffer (GtkTextMark $mark)
  returns GtkTextBuffer
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_get_deleted (GtkTextMark $mark)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_get_left_gravity (GtkTextMark $mark)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_get_name (GtkTextMark $mark)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_get_visible (GtkTextMark $mark)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_new (
  Str      $name,
  gboolean $left_gravity
)
  returns GtkTextMark
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_mark_set_visible (
  GtkTextMark $mark,
  gboolean    $setting
)
  is      native(gtk4)
  is      export
{ * }

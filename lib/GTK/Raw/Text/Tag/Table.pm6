use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Text::Tag::Table:ver<4>;

### /usr/src/gtk4/gtk/gtktexttagtable.h

sub gtk_text_tag_table_add (
  GtkTextTagTable $table,
  GtkTextTag      $tag
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_table_foreach (
  GtkTextTagTable        $table,
                         &func (GtkTextTag, gpointer),
  gpointer               $data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_table_get_size (GtkTextTagTable $table)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_table_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_table_lookup (
  GtkTextTagTable $table,
  Str             $name
)
  returns GtkTextTag
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_table_new
  returns GtkTextTagTable
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_tag_table_remove (
  GtkTextTagTable $table,
  GtkTextTag      $tag
)
  is      native(gtk4)
  is      export
{ * }

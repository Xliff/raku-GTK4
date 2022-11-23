use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Entry::Buffer:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkentrybuffer.h

sub gtk_entry_buffer_delete_text (
  GtkEntryBuffer $buffer,
  guint          $position,
  gint           $n_chars
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_emit_deleted_text (
  GtkEntryBuffer $buffer,
  guint          $position,
  guint          $n_chars
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_emit_inserted_text (
  GtkEntryBuffer $buffer,
  guint          $position,
  Str            $chars,
  guint          $n_chars
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_get_bytes (GtkEntryBuffer $buffer)
  returns gsize
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_get_length (GtkEntryBuffer $buffer)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_get_max_length (GtkEntryBuffer $buffer)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_get_text (GtkEntryBuffer $buffer)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_insert_text (
  GtkEntryBuffer $buffer,
  guint          $position,
  Str            $chars,
  gint           $n_chars
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_new (
  Str  $initial_chars,
  gint $n_initial_chars
)
  returns GtkEntryBuffer
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_set_max_length (
  GtkEntryBuffer $buffer,
  gint           $max_length
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_buffer_set_text (
  GtkEntryBuffer $buffer,
  Str            $chars,
  gint           $n_chars
)
  is      native(gtk4)
  is      export
{ * }

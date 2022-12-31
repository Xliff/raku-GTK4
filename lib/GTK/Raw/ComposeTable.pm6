use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::ComposeTable:ver<4>;

### /usr/src/gtk4/gtk/gtkcomposetable.h

sub gtk_check_algorithmically (
  guint   $compose_buffer is rw,
  gint    $n_compose,
  GString $output
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_check (
  GtkComposeTable $table,
  guint           $compose_buffer is rw,
  gint            $n_compose,
  gboolean        $compose_finish,
  gboolean        $compose_match,
  GString         $output
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_data_hash (
  guint16 $data is rw,
  gint    $max_seq_len,
  gint    $n_seqs
)
  returns guint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_foreach (
  GtkComposeTable            $table,
  GtkComposeSequenceCallback $callback,
  gpointer                   $data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_get_prefix (
  GtkComposeTable $table,
  guint           $compose_buffer is rw,
  gint            $n_compose,
  gint            $prefix is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_get_x11_compose_file_dir
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_new_with_data (
  guint16 $data is rw,
  gint    $max_seq_len,
  gint    $n_seqs
)
  returns GtkComposeTable
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_new_with_file (Str $compose_file)
  returns GtkComposeTable
  is      native(gtk4)
  is      export
{ * }

sub gtk_compose_table_parse (
  Str      $compose_file,
  gboolean $found_include
)
  returns GtkComposeTable
  is      native(gtk4)
  is      export
{ * }

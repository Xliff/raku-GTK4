use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Editable:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkeditable.h

sub gtk_editable_delegate_get_property (
  GObject    $object,
  guint      $prop_id,
  GValue     $value,
  GParamSpec $pspec
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_delegate_set_property (
  GObject    $object,
  guint      $prop_id,
  GValue     $value,
  GParamSpec $pspec
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_delete_selection (GtkEditable $editable)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_delete_text (
  GtkEditable $editable,
  gint        $start_pos,
  gint        $end_pos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_finish_delegate (GtkEditable $editable)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_alignment (GtkEditable $editable)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_chars (
  GtkEditable $editable,
  gint        $start_pos,
  gint        $end_pos
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_delegate (GtkEditable $editable)
  returns GtkEditable
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_editable (GtkEditable $editable)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_enable_undo (GtkEditable $editable)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_max_width_chars (GtkEditable $editable)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_position (GtkEditable $editable)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_selection_bounds (
  GtkEditable $editable,
  gint        $start_pos is rw,
  gint        $end_pos   is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_text (GtkEditable $editable)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_get_width_chars (GtkEditable $editable)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_init_delegate (GtkEditable $editable)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_insert_text (
  GtkEditable $editable,
  Str         $text,
  gint        $length,
  gint        $position   is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_select_region (
  GtkEditable $editable,
  gint        $start_pos,
  gint        $end_pos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_alignment (
  GtkEditable $editable,
  gfloat      $xalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_editable (
  GtkEditable $editable,
  gboolean    $is_editable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_enable_undo (
  GtkEditable $editable,
  gboolean    $enable_undo
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_max_width_chars (
  GtkEditable $editable,
  gint        $n_chars
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_position (
  GtkEditable $editable,
  gint        $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_text (
  GtkEditable $editable,
  Str         $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_editable_set_width_chars (
  GtkEditable $editable,
  gint        $n_chars
)
  is      native(gtk4)
  is      export
{ * }

# sub gtk_editable_install_properties (
#   GObjectClass $object_class,
#   guint        $first_prop
# )
#   returns guint
#   is      native(gtk4)
#   is      export
# { * }

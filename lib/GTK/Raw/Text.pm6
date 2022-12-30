use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Graphene::Raw::Definitions;
use Pango::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

### /usr/src/gtk4/gtk/gtktext.h

sub gtk_text_compute_cursor_extents (
  GtkText         $self,
  gsize           $position,
  graphene_rect_t $strong,
  graphene_rect_t $weak
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_activates_default (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_attributes (GtkText $self)
  returns PangoAttrList
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_buffer (GtkText $self)
  returns GtkEntryBuffer
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_enable_emoji_completion (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_extra_menu (GtkText $self)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_input_hints (GtkText $self)
  returns GtkInputHints
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_input_purpose (GtkText $self)
  returns GtkInputPurpose
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_invisible_char (GtkText $self)
  returns gunichar
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_max_length (GtkText $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_overwrite_mode (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_placeholder_text (GtkText $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_propagate_text_width (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_tabs (GtkText $self)
  returns PangoTabArray
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_text_length (GtkText $self)
  returns guint16
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_truncate_multiline (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_get_visibility (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_grab_focus_without_selecting (GtkText $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_new_with_buffer (GtkEntryBuffer $buffer)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_activates_default (
  GtkText  $self,
  gboolean $activates
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_attributes (
  GtkText       $self,
  PangoAttrList $attrs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_buffer (
  GtkText        $self,
  GtkEntryBuffer $buffer
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_enable_emoji_completion (
  GtkText  $self,
  gboolean $enable_emoji_completion
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_extra_menu (
  GtkText    $self,
  GMenuModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_input_hints (
  GtkText       $self,
  GtkInputHints $hints
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_input_purpose (
  GtkText         $self,
  GtkInputPurpose $purpose
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_invisible_char (
  GtkText  $self,
  gunichar $ch
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_max_length (
  GtkText $self,
  gint    $length
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_overwrite_mode (
  GtkText  $self,
  gboolean $overwrite
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_placeholder_text (
  GtkText $self,
  Str     $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_propagate_text_width (
  GtkText  $self,
  gboolean $propagate_text_width
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_tabs (
  GtkText       $self,
  PangoTabArray $tabs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_truncate_multiline (
  GtkText  $self,
  gboolean $truncate_multiline
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_set_visibility (
  GtkText  $self,
  gboolean $visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_unset_invisible_char (GtkText $self)
  is      native(gtk4)
  is      export
{ * }

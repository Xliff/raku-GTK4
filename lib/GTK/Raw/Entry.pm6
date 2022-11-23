use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Pango::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Entry:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkentry.h

sub gtk_entry_get_activates_default (GtkEntry $entry)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_alignment (GtkEntry $entry)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_attributes (GtkEntry $entry)
  returns PangoAttrList
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_buffer (GtkEntry $entry)
  returns GtkEntryBuffer
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_completion (GtkEntry $entry)
  returns GtkEntryCompletion
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_current_icon_drag_source (GtkEntry $entry)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_extra_menu (GtkEntry $entry)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_has_frame (GtkEntry $entry)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_activatable (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_area (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  GdkRectangle         $icon_area
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_at_pos (
  GtkEntry $entry,
  gint     $x,
  gint     $y
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_gicon (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns GIcon
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_name (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_paintable (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_sensitive (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_storage_type (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns GtkImageType
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_tooltip_markup (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_icon_tooltip_text (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_input_hints (GtkEntry $entry)
  returns GtkInputHints
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_input_purpose (GtkEntry $entry)
  returns GtkInputPurpose
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_invisible_char (GtkEntry $entry)
  returns gunichar
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_max_length (GtkEntry $entry)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_overwrite_mode (GtkEntry $entry)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_placeholder_text (GtkEntry $entry)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_progress_fraction (GtkEntry $entry)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_progress_pulse_step (GtkEntry $entry)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_tabs (GtkEntry $entry)
  returns PangoTabArray
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_text_length (GtkEntry $entry)
  returns guint16
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_get_visibility (GtkEntry $entry)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_grab_focus_without_selecting (GtkEntry $entry)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_new
  returns GtkEntry
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_new_with_buffer (GtkEntryBuffer $buffer)
  returns GtkEntry
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_progress_pulse (GtkEntry $entry)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_reset_im_context (GtkEntry $entry)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_activates_default (
  GtkEntry $entry,
  gboolean $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_alignment (
  GtkEntry $entry,
  gfloat   $xalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_attributes (
  GtkEntry      $entry,
  PangoAttrList $attrs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_buffer (
  GtkEntry       $entry,
  GtkEntryBuffer $buffer
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_completion (
  GtkEntry           $entry,
  GtkEntryCompletion $completion
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_extra_menu (
  GtkEntry   $entry,
  GMenuModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_has_frame (
  GtkEntry $entry,
  gboolean $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_activatable (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  gboolean             $activatable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_drag_source (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  GdkContentProvider   $provider,
  GdkDragAction        $actions
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_from_gicon (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  GIcon                $icon
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_from_icon_name (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  Str                  $icon_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_from_paintable (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  GdkPaintable         $paintable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_sensitive (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  gboolean             $sensitive
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_tooltip_markup (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  Str                  $tooltip
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_icon_tooltip_text (
  GtkEntry             $entry,
  GtkEntryIconPosition $icon_pos,
  Str                  $tooltip
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_input_hints (
  GtkEntry      $entry,
  GtkInputHints $hints
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_input_purpose (
  GtkEntry        $entry,
  GtkInputPurpose $purpose
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_invisible_char (
  GtkEntry $entry,
  gunichar $ch
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_max_length (
  GtkEntry $entry,
  gint     $max
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_overwrite_mode (
  GtkEntry $entry,
  gboolean $overwrite
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_placeholder_text (
  GtkEntry $entry,
  Str      $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_progress_fraction (
  GtkEntry $entry,
  gdouble  $fraction
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_progress_pulse_step (
  GtkEntry $entry,
  gdouble  $fraction
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_tabs (
  GtkEntry      $entry,
  PangoTabArray $tabs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_set_visibility (
  GtkEntry $entry,
  gboolean $visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_entry_unset_invisible_char (GtkEntry $entry)
  is      native(gtk4)
  is      export
{ * }

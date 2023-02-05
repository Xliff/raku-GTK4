use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Pango::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Text::View:ver<4>;

### /usr/src/gtk4/gtk/gtktextview.h

sub gtk_text_view_add_child_at_anchor (
  GtkTextView        $text_view,
  GtkWidget          $child,
  GtkTextChildAnchor $anchor
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_add_overlay (
  GtkTextView $text_view,
  GtkWidget   $child,
  gint        $xpos,
  gint        $ypos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_backward_display_line (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_backward_display_line_start (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_buffer_to_window_coords (
  GtkTextView       $text_view,
  GtkTextWindowType $win,
  gint              $buffer_x,
  gint              $buffer_y,
  gint              $window_x is rw,
  gint              $window_y is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_forward_display_line (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_forward_display_line_end (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_accepts_tab (GtkTextView $text_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_bottom_margin (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_buffer (GtkTextView $text_view)
  returns GtkTextBuffer
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_cursor_locations (
  GtkTextView  $text_view,
  GtkTextIter  $iter,
  GdkRectangle $strong,
  GdkRectangle $weak
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_cursor_visible (GtkTextView $text_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_editable (GtkTextView $text_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_extra_menu (GtkTextView $text_view)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_gutter (
  GtkTextView       $text_view,
  GtkTextWindowType $win
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_indent (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_input_hints (GtkTextView $text_view)
  returns GtkInputHints
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_input_purpose (GtkTextView $text_view)
  returns GtkInputPurpose
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_iter_at_location (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint        $x,
  gint        $y
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_iter_at_position (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint        $trailing is rw,
  gint        $x,
  gint        $y
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_iter_location (
  GtkTextView  $text_view,
  GtkTextIter  $iter,
  GdkRectangle $location
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_justification (GtkTextView $text_view)
  returns GtkJustification
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_left_margin (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_line_at_y (
  GtkTextView $text_view,
  GtkTextIter $target_iter,
  gint        $y,
  gint        $line_top is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_line_yrange (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint        $y is rw,
  gint        $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_ltr_context (GtkTextView $text_view)
  returns PangoContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_monospace (GtkTextView $text_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_overwrite (GtkTextView $text_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_pixels_above_lines (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_pixels_below_lines (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_pixels_inside_wrap (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_right_margin (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_rtl_context (GtkTextView $text_view)
  returns PangoContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_tabs (GtkTextView $text_view)
  returns PangoTabArray
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_top_margin (GtkTextView $text_view)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_visible_rect (
  GtkTextView  $text_view,
  GdkRectangle $visible_rect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_get_wrap_mode (GtkTextView $text_view)
  returns GtkWrapMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_im_context_filter_keypress (
  GtkTextView $text_view,
  GdkEvent    $event
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_move_mark_onscreen (
  GtkTextView $text_view,
  GtkTextMark $mark
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_move_overlay (
  GtkTextView $text_view,
  GtkWidget   $child,
  gint        $xpos,
  gint        $ypos
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_move_visually (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint        $count
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_new_with_buffer (GtkTextBuffer $buffer)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_place_cursor_onscreen (GtkTextView $text_view)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_remove (
  GtkTextView $text_view,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_reset_cursor_blink (GtkTextView $text_view)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_reset_im_context (GtkTextView $text_view)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_scroll_mark_onscreen (
  GtkTextView $text_view,
  GtkTextMark $mark
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_scroll_to_iter (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gdouble     $within_margin,
  gboolean    $use_align,
  gdouble     $xalign,
  gdouble     $yalign
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_scroll_to_mark (
  GtkTextView $text_view,
  GtkTextMark $mark,
  gdouble     $within_margin,
  gboolean    $use_align,
  gdouble     $xalign,
  gdouble     $yalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_accepts_tab (
  GtkTextView $text_view,
  gboolean    $accepts_tab
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_bottom_margin (
  GtkTextView $text_view,
  gint        $bottom_margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_buffer (
  GtkTextView   $text_view,
  GtkTextBuffer $buffer
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_cursor_visible (
  GtkTextView $text_view,
  gboolean    $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_editable (
  GtkTextView $text_view,
  gboolean    $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_extra_menu (
  GtkTextView $text_view,
  GMenuModel  $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_gutter (
  GtkTextView       $text_view,
  GtkTextWindowType $win,
  GtkWidget         $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_indent (
  GtkTextView $text_view,
  gint        $indent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_input_hints (
  GtkTextView   $text_view,
  GtkInputHints $hints
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_input_purpose (
  GtkTextView     $text_view,
  GtkInputPurpose $purpose
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_justification (
  GtkTextView      $text_view,
  GtkJustification $justification
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_left_margin (
  GtkTextView $text_view,
  gint        $left_margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_monospace (
  GtkTextView $text_view,
  gboolean    $monospace
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_overwrite (
  GtkTextView $text_view,
  gboolean    $overwrite
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_pixels_above_lines (
  GtkTextView $text_view,
  gint        $pixels_above_lines
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_pixels_below_lines (
  GtkTextView $text_view,
  gint        $pixels_below_lines
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_pixels_inside_wrap (
  GtkTextView $text_view,
  gint        $pixels_inside_wrap
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_right_margin (
  GtkTextView $text_view,
  gint        $right_margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_tabs (
  GtkTextView   $text_view,
  PangoTabArray $tabs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_top_margin (
  GtkTextView $text_view,
  gint        $top_margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_set_wrap_mode (
  GtkTextView $text_view,
  GtkWrapMode $wrap_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_starts_display_line (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_view_window_to_buffer_coords (
  GtkTextView       $text_view,
  GtkTextWindowType $win,
  gint              $window_x,
  gint              $window_y,
  gint              $buffer_x is rw,
  gint              $buffer_y is rw
)
  is      native(gtk4)
  is      export
{ * }

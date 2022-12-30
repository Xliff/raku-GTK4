use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Text::Buffer:ver<4>;

### /usr/src/gtk4/gtk/gtktextbuffer.h

sub gtk_text_buffer_add_mark (
  GtkTextBuffer $buffer,
  GtkTextMark   $mark,
  GtkTextIter   $where
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_add_selection_clipboard (
  GtkTextBuffer $buffer,
  GdkClipboard  $clipboard
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_apply_tag (
  GtkTextBuffer $buffer,
  GtkTextTag    $tag,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_apply_tag_by_name (
  GtkTextBuffer $buffer,
  Str           $name,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_backspace (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  gboolean      $interactive,
  gboolean      $default_editable
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_begin_irreversible_action (GtkTextBuffer $buffer)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_begin_user_action (GtkTextBuffer $buffer)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_copy_clipboard (
  GtkTextBuffer $buffer,
  GdkClipboard  $clipboard
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_create_child_anchor (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter
)
  returns GtkTextChildAnchor
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_create_mark (
  GtkTextBuffer $buffer,
  Str           $mark_name,
  GtkTextIter   $where,
  gboolean      $left_gravity
)
  returns GtkTextMark
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_create_tag (
  GtkTextBuffer $buffer,
  Str           $tag_name,
  Str           $first_property_name
)
  returns GtkTextTag
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_cut_clipboard (
  GtkTextBuffer $buffer,
  GdkClipboard  $clipboard,
  gboolean      $default_editable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_delete (
  GtkTextBuffer $buffer,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_delete_interactive (
  GtkTextBuffer $buffer,
  GtkTextIter   $start_iter,
  GtkTextIter   $end_iter,
  gboolean      $default_editable
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_delete_mark (
  GtkTextBuffer $buffer,
  GtkTextMark   $mark
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_delete_mark_by_name (
  GtkTextBuffer $buffer,
  Str           $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_delete_selection (
  GtkTextBuffer $buffer,
  gboolean      $interactive,
  gboolean      $default_editable
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_end_irreversible_action (GtkTextBuffer $buffer)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_end_user_action (GtkTextBuffer $buffer)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_bounds (
  GtkTextBuffer $buffer,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_can_redo (GtkTextBuffer $buffer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_can_undo (GtkTextBuffer $buffer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_char_count (GtkTextBuffer $buffer)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_enable_undo (GtkTextBuffer $buffer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_end_iter (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_has_selection (GtkTextBuffer $buffer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_insert (GtkTextBuffer $buffer)
  returns GtkTextMark
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_iter_at_child_anchor (
  GtkTextBuffer      $buffer,
  GtkTextIter        $iter,
  GtkTextChildAnchor $anchor
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_iter_at_line (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  gint          $line_number
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_iter_at_line_index (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  gint          $line_number,
  gint          $byte_index
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_iter_at_line_offset (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  gint          $line_number,
  gint          $char_offset
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_iter_at_mark (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  GtkTextMark   $mark
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_iter_at_offset (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  gint          $char_offset
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_line_count (GtkTextBuffer $buffer)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_mark (
  GtkTextBuffer $buffer,
  Str           $name
)
  returns GtkTextMark
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_max_undo_levels (GtkTextBuffer $buffer)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_modified (GtkTextBuffer $buffer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_selection_bound (GtkTextBuffer $buffer)
  returns GtkTextMark
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_selection_bounds (
  GtkTextBuffer $buffer,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_selection_content (GtkTextBuffer $buffer)
  returns GdkContentProvider
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_slice (
  GtkTextBuffer $buffer,
  GtkTextIter   $start,
  GtkTextIter   $end,
  gboolean      $include_hidden_chars
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_start_iter (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_tag_table (GtkTextBuffer $buffer)
  returns GtkTextTagTable
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_text (
  GtkTextBuffer $buffer,
  GtkTextIter   $start,
  GtkTextIter   $end,
  gboolean      $include_hidden_chars
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  Str           $text,
  gint          $len
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_at_cursor (
  GtkTextBuffer $buffer,
  Str           $text,
  gint          $len
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_child_anchor (
  GtkTextBuffer      $buffer,
  GtkTextIter        $iter,
  GtkTextChildAnchor $anchor
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_interactive (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  Str           $text,
  gint          $len,
  gboolean      $default_editable
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_interactive_at_cursor (
  GtkTextBuffer $buffer,
  Str           $text,
  gint          $len,
  gboolean      $default_editable
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_markup (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  Str           $markup,
  gint          $len
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_paintable (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  GdkPaintable  $paintable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_range (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_range_interactive (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  GtkTextIter   $start,
  GtkTextIter   $end,
  gboolean      $default_editable
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_with_tags (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  Str           $text,
  gint          $len,
  GtkTextTag    $first_tag
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_insert_with_tags_by_name (
  GtkTextBuffer $buffer,
  GtkTextIter   $iter,
  Str           $text,
  gint          $len,
  Str           $first_tag_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_move_mark (
  GtkTextBuffer $buffer,
  GtkTextMark   $mark,
  GtkTextIter   $where
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_move_mark_by_name (
  GtkTextBuffer $buffer,
  Str           $name,
  GtkTextIter   $where
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_new (GtkTextTagTable $table)
  returns GtkTextBuffer
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_paste_clipboard (
  GtkTextBuffer $buffer,
  GdkClipboard  $clipboard,
  GtkTextIter   $override_location,
  gboolean      $default_editable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_place_cursor (
  GtkTextBuffer $buffer,
  GtkTextIter   $where
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_redo (GtkTextBuffer $buffer)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_remove_all_tags (
  GtkTextBuffer $buffer,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_remove_selection_clipboard (
  GtkTextBuffer $buffer,
  GdkClipboard  $clipboard
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_remove_tag (
  GtkTextBuffer $buffer,
  GtkTextTag    $tag,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_remove_tag_by_name (
  GtkTextBuffer $buffer,
  Str           $name,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_select_range (
  GtkTextBuffer $buffer,
  GtkTextIter   $ins,
  GtkTextIter   $bound
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_set_enable_undo (
  GtkTextBuffer $buffer,
  gboolean      $enable_undo
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_set_max_undo_levels (
  GtkTextBuffer $buffer,
  guint         $max_undo_levels
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_set_modified (
  GtkTextBuffer $buffer,
  gboolean      $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_set_text (
  GtkTextBuffer $buffer,
  Str           $text,
  gint          $len
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_buffer_undo (GtkTextBuffer $buffer)
  is      native(gtk4)
  is      export
{ * }

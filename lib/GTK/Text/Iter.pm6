use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text::Iter:ver<4>;

use GLib::GSList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTextIterAncestry is export of Mu
  where GtkTextIter | GObject;

class GTK::Text::Iter:ver<4> {
  also does GLib::Roles::Object;

  has GtkTextIter $!gtk-ti is implementor;

  submethod BUILD ( :$gtk-text-iter ) {
    self.setGtkTextIter($gtk-text-iter) if $gtk-text-iter
  }

  method setGtkTextIter (GtkTextIterAncestry $_) {
    my $to-parent;

    $!gtk-ti = do {
      when GtkTextIter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTextIter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Structs::GtkTextIter
    is also<GtkTextIter>
  { $!gtk-ti }

  multi method new (
     $gtk-text-iter where * ~~ GtkTextIterAncestry,

    :$ref = True
  ) {
    return unless $gtk-text-iter;

    my $o = self.bless( :$gtk-text-iter );
    $o.ref if $ref;
    $o;
  }

  method assign (GtkTextIter() $other) {
    gtk_text_iter_assign($!gtk-ti, $other);
  }

  method backward_char is also<backward-char> {
    gtk_text_iter_backward_char($!gtk-ti);
  }

  method backward_chars (Int() $count) is also<backward-chars> {
    my gint $c = $count;

    gtk_text_iter_backward_chars($!gtk-ti, $c);
  }

  method backward_cursor_position is also<backward-cursor-position> {
    gtk_text_iter_backward_cursor_position($!gtk-ti);
  }

  method backward_cursor_positions (Int() $count)
    is also<backward-cursor-positions>
  {
    my gint $c = $count;

    gtk_text_iter_backward_cursor_positions($!gtk-ti, $c);
  }

  proto method backward_find_char (|)
    is also<backward-find-char>
  { * }

  multi method backward_find_char (
                   &pred,
    gpointer       $user_data = gpointer,
    GtkTextIter() :$limit     = GtkTextIter
  ) {
    samewith(&pred, $user_data, $limit);
  }
  multi method backward_find_char (
                  &pred,
    gpointer      $user_data = gpointer,
    GtkTextIter() $limit     = GtkTextIter
  ) {
    gtk_text_iter_backward_find_char($!gtk-ti, &pred, $user_data, $limit);
  }

  method backward_line is also<backward-line> {
    gtk_text_iter_backward_line($!gtk-ti);
  }

  method backward_lines (Int() $count) is also<backward-lines> {
    my gint $c = $count;

    gtk_text_iter_backward_lines($!gtk-ti, $c);
  }

  proto method backward_search (|)
    is also<backward-search>
  { * }

  multi method backward_search (
    Str()         $str,
    Int()         :f(:$flags)                = 0,
    GtkTextIter() :s(:start(:$match_start))  = GtkTextIter,
    GtkTextIter() :e(:end(:$match_end))      = GtkTextIter,
    GtkTextIter() :l(:$limit)                = GtkTextIter
  ) {
    samewith($str, $flags, $match_start, $match_end, $limit);
  }
  multi method backward_search (
    Str()         $str,
    Int()         $flags,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    GtkTextIter() $limit         = GtkTextIter
  ) {
    my GtkTextSearchFlags $f = $flags;

    gtk_text_iter_backward_search(
      $!gtk-ti,
      $str,
      $flags,
      $match_start,
      $match_end,
      $limit
    );
  }

  method backward_sentence_start is also<backward-sentence-start> {
    gtk_text_iter_backward_sentence_start($!gtk-ti);
  }

  method backward_sentence_starts (Int() $count)
    is also<backward-sentence-starts>
  {
    my gint $c = $count;

    gtk_text_iter_backward_sentence_starts($!gtk-ti, $c);
  }

  method backward_to_tag_toggle (GtkTextTag() $tag)
    is also<backward-to-tag-toggle>
  {
    gtk_text_iter_backward_to_tag_toggle($!gtk-ti, $tag);
  }

  method backward_visible_cursor_position
    is also<backward-visible-cursor-position>
  {
    gtk_text_iter_backward_visible_cursor_position($!gtk-ti);
  }

  method backward_visible_cursor_positions (Int() $count)
    is also<backward-visible-cursor-positions>
  {
    my gint $c = $count;

    gtk_text_iter_backward_visible_cursor_positions($!gtk-ti, $c);
  }

  method backward_visible_line is also<backward-visible-line> {
    gtk_text_iter_backward_visible_line($!gtk-ti);
  }

  method backward_visible_lines (Int() $count)
    is also<backward-visible-lines>
  {
    my gint $c = $count;

    gtk_text_iter_backward_visible_lines($!gtk-ti, $c);
  }

  method backward_visible_word_start is also<backward-visible-word-start> {
    gtk_text_iter_backward_visible_word_start($!gtk-ti);
  }

  method backward_visible_word_starts (Int() $count)
    is also<backward-visible-word-starts>
  {
    my gint $c = $count;

    gtk_text_iter_backward_visible_word_starts($!gtk-ti, $c);
  }

  method backward_word_start is also<backward-word-start> {
    gtk_text_iter_backward_word_start($!gtk-ti);
  }

  method backward_word_starts (Int() $count) is also<backward-word-starts> {
    my gint $c = $count;

    gtk_text_iter_backward_word_starts($!gtk-ti, $c);
  }

  method can_insert (Int() $default_editability) is also<can-insert> {
    my gboolean $d = $default_editability.so.Int;

    so gtk_text_iter_can_insert($!gtk-ti, $d);
  }

  method compare (GtkTextIter() $rhs) {
    gtk_text_iter_compare($!gtk-ti, $rhs);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_text_iter_copy($!gtk-ti),
      $raw,
      |self.getTypePair
    );
  }

  method editable (Int() $default_setting) {
    my gboolean $d = $default_setting.so.Int;

    gtk_text_iter_editable($!gtk-ti, $d);
  }

  method ends_line is also<ends-line> {
    gtk_text_iter_ends_line($!gtk-ti);
  }

  method ends_sentence is also<ends-sentence> {
    gtk_text_iter_ends_sentence($!gtk-ti);
  }

  method ends_tag (GtkTextTag() $tag) is also<ends-tag> {
    gtk_text_iter_ends_tag($!gtk-ti, $tag);
  }

  method ends_word is also<ends-word> {
    gtk_text_iter_ends_word($!gtk-ti);
  }

  method equal (GtkTextIter() $rhs) {
    gtk_text_iter_equal($!gtk-ti, $rhs);
  }

  method forward_char is also<forward-char> {
    gtk_text_iter_forward_char($!gtk-ti);
  }

  method forward_chars (Int() $count) is also<forward-chars> {
    my gint $c = $count;

    gtk_text_iter_forward_chars($!gtk-ti, $c);
  }

  method forward_cursor_position is also<forward-cursor-position> {
    gtk_text_iter_forward_cursor_position($!gtk-ti);
  }

  method forward_cursor_positions (Int() $count)
    is also<forward-cursor-positions>
  {
    my gint $c = $count;

    gtk_text_iter_forward_cursor_positions($!gtk-ti, $c);
  }

  proto method forward_find_char (|)
    is also<forward-find-char>
  { * }

  multi method forward_find_char (
                   &pred,
    gpointer       $user_data = gpointer,
    GtkTextIter() :$limit     = GtkTextIter
  ) {
    samewith(&pred, $user_data, $limit);
  }
  multi method forward_find_char (
                  &pred,
    gpointer      $user_data = gpointer,
    GtkTextIter() $limit     = GtkTextIter
  ) {
    gtk_text_iter_forward_find_char($!gtk-ti, &pred, $user_data, $limit);
  }

  method forward_line is also<forward-line> {
    gtk_text_iter_forward_line($!gtk-ti);
  }

  method forward_lines (Int() $count) is also<forward-lines> {
    my gint $c = $count;

    gtk_text_iter_forward_lines($!gtk-ti, $c);
  }

  proto method forward_search (|)
    is also<forward-search>
  { * }

  multi method forward_search (
    Str()         $str,
    Int()         :f(:$flags)                = 0,
    GtkTextIter() :s(:start(:$match_start))  = GtkTextIter,
    GtkTextIter() :e(:end(:$match_end))      = GtkTextIter,
    GtkTextIter() :l(:$limit)                = GtkTextIter
  ) {
    samewith($str, $flags, $match_start, $match_end, $limit);
  }
  multi method forward_search (
    Str()         $str,
    Int()         $flags,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end  ,
    GtkTextIter() $limit        = GtkTextIter
  ) {
    my GtkTextSearchFlags $f = $flags;

    so gtk_text_iter_forward_search(
      $!gtk-ti,
      $str,
      $f,
      $match_start,
      $match_end,
      $limit
    );
  }

  method forward_sentence_end is also<forward-sentence-end> {
    gtk_text_iter_forward_sentence_end($!gtk-ti);
  }

  method forward_sentence_ends (Int() $count) is also<forward-sentence-ends> {
    my gint $c = $count;

    gtk_text_iter_forward_sentence_ends($!gtk-ti, $c);
  }

  method forward_to_end is also<forward-to-end> {
    gtk_text_iter_forward_to_end($!gtk-ti);
  }

  method forward_to_line_end is also<forward-to-line-end> {
    gtk_text_iter_forward_to_line_end($!gtk-ti);
  }

  method forward_to_tag_toggle (GtkTextTag() $tag)
    is also<forward-to-tag-toggle>
  {
    gtk_text_iter_forward_to_tag_toggle($!gtk-ti, $tag);
  }

  method forward_visible_cursor_position
    is also<forward-visible-cursor-position>
  {
    gtk_text_iter_forward_visible_cursor_position($!gtk-ti);
  }

  method forward_visible_cursor_positions (Int() $count)
    is also<forward-visible-cursor-positions>
  {
    my gint $c = $count;

    gtk_text_iter_forward_visible_cursor_positions($!gtk-ti, $c);
  }

  method forward_visible_line is also<forward-visible-line> {
    gtk_text_iter_forward_visible_line($!gtk-ti);
  }

  method forward_visible_lines (Int() $count) is also<forward-visible-lines> {
    my gint $c = $count;

    gtk_text_iter_forward_visible_lines($!gtk-ti, $c);
  }

  method forward_visible_word_end is also<forward-visible-word-end> {
    gtk_text_iter_forward_visible_word_end($!gtk-ti);
  }

  method forward_visible_word_ends (Int() $count)
    is also<forward-visible-word-ends>
  {
    my gint $c = $count;

    gtk_text_iter_forward_visible_word_ends($!gtk-ti, $c);
  }

  method forward_word_end is also<forward-word-end> {
    gtk_text_iter_forward_word_end($!gtk-ti);
  }

  method forward_word_ends (Int() $count) is also<forward-word-ends> {
    my gint $c = $count;

    gtk_text_iter_forward_word_ends($!gtk-ti, $c);
  }

  method free {
    gtk_text_iter_free($!gtk-ti);
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_text_iter_get_buffer($!gtk-ti),
      $raw,
      |::('GTK::Text::Buffer').getTypePair
    );
  }

  method get_bytes_in_line is also<get-bytes-in-line> {
    gtk_text_iter_get_bytes_in_line($!gtk-ti);
  }

  method get_char is also<get-char> {
    gtk_text_iter_get_char($!gtk-ti);
  }

  method get_chars_in_line is also<get-chars-in-line> {
    gtk_text_iter_get_chars_in_line($!gtk-ti);
  }

  method get_child_anchor ( :$raw = False ) is also<get-child-anchor> {
    propReturnObject(
      gtk_text_iter_get_child_anchor($!gtk-ti),
      $raw,
      |GTK::Text::Child::Anchor.getTypePair
    );
  }

  method get_language ( :$raw = False ) is also<get-language> {
    propReturnObject(
      gtk_text_iter_get_language($!gtk-ti),
      $raw,
      |Pango::Language.getTypePair
    );
  }

  method get_line is also<get-line> {
    gtk_text_iter_get_line($!gtk-ti);
  }

  method get_line_index is also<get-line-index> {
    gtk_text_iter_get_line_index($!gtk-ti);
  }

  method get_line_offset is also<get-line-offset> {
    gtk_text_iter_get_line_offset($!gtk-ti);
  }

  method get_marks ( :$raw = False, :$glist = False ) is also<get-marks> {
    returnGSList(
      gtk_text_iter_get_marks($!gtk-ti),
      $raw,
      $glist,
      |GTK::Text::Mark.getTypePair
    );
  }

  method get_offset is also<get-offset> {
    gtk_text_iter_get_offset($!gtk-ti);
  }

  method get_paintable ( :$raw = False ) is also<get-paintable> {
    propReturnObject(
      gtk_text_iter_get_paintable($!gtk-ti),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method get_slice (GtkTextIter() $end) is also<get-slice> {
    gtk_text_iter_get_slice($!gtk-ti, $end);
  }

  method get_tags ( :$raw = False, :$glist = False ) is also<get-tags> {
    returnGSList(
      gtk_text_iter_get_tags($!gtk-ti),
      $raw,
      $glist,
      |GTK::Text::Tag.getTypePair
    );
  }

  method get_text (GtkTextIter() $end) is also<get-text> {
    gtk_text_iter_get_text($!gtk-ti, $end);
  }

  method get_toggled_tags (Int() $toggled_on) is also<get-toggled-tags> {
    my gboolean $t = $toggled_on.so.Int;

    gtk_text_iter_get_toggled_tags($!gtk-ti, $t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_iter_get_type, $n, $t );
  }

  method get_visible_line_index is also<get-visible-line-index> {
    gtk_text_iter_get_visible_line_index($!gtk-ti);
  }

  method get_visible_line_offset is also<get-visible-line-offset> {
    gtk_text_iter_get_visible_line_offset($!gtk-ti);
  }

  method get_visible_slice (GtkTextIter() $end) is also<get-visible-slice> {
    gtk_text_iter_get_visible_slice($!gtk-ti, $end);
  }

  method get_visible_text (GtkTextIter() $end) is also<get-visible-text> {
    gtk_text_iter_get_visible_text($!gtk-ti, $end);
  }

  method has_tag (GtkTextTag() $tag) is also<has-tag> {
    so gtk_text_iter_has_tag($!gtk-ti, $tag);
  }

  method in_range (GtkTextIter() $start, GtkTextIter() $end)
    is also<in-range>
  {
    so gtk_text_iter_in_range($!gtk-ti, $start, $end);
  }

  method inside_sentence is also<inside-sentence> {
    so gtk_text_iter_inside_sentence($!gtk-ti);
  }

  method inside_word is also<inside-word> {
    so gtk_text_iter_inside_word($!gtk-ti);
  }

  method is_cursor_position is also<is-cursor-position> {
    so gtk_text_iter_is_cursor_position($!gtk-ti);
  }

  method is_end is also<is-end> {
    so gtk_text_iter_is_end($!gtk-ti);
  }

  method is_start is also<is-start> {
    so gtk_text_iter_is_start($!gtk-ti);
  }

  method order (GtkTextIter() $second) {
    gtk_text_iter_order($!gtk-ti, $second);
  }

  method set_line (Int() $line_number) is also<set-line> {
    my gint $l = $line_number;

    gtk_text_iter_set_line($!gtk-ti, $l);
  }

  method set_line_index (Int() $byte_on_line) is also<set-line-index> {
    my gint $b = $byte_on_line;

    gtk_text_iter_set_line_index($!gtk-ti, $b);
  }

  method set_line_offset (Int() $char_on_line) is also<set-line-offset> {
    my gint $c = $char_on_line;

    gtk_text_iter_set_line_offset($!gtk-ti, $c);
  }

  method set_offset (Int() $char_offset) is also<set-offset> {
    my gint $c = $char_offset;

    gtk_text_iter_set_offset($!gtk-ti, $c);
  }

  method set_visible_line_index (Int() $byte_on_line)
    is also<set-visible-line-index>
  {
    my gint $b = $byte_on_line;

    gtk_text_iter_set_visible_line_index($!gtk-ti, $b);
  }

  method set_visible_line_offset (Int() $char_on_line)
    is also<set-visible-line-offset>
  {
    my gint $c = $char_on_line;

    gtk_text_iter_set_visible_line_offset($!gtk-ti, $c);
  }

  method starts_line is also<starts-line> {
    gtk_text_iter_starts_line($!gtk-ti);
  }

  method starts_sentence is also<starts-sentence> {
    gtk_text_iter_starts_sentence($!gtk-ti);
  }

  method starts_tag (GtkTextTag() $tag) is also<starts-tag> {
    gtk_text_iter_starts_tag($!gtk-ti, $tag);
  }

  method starts_word is also<starts-word> {
    gtk_text_iter_starts_word($!gtk-ti);
  }

  method toggles_tag (GtkTextTag() $tag) is also<toggles-tag> {
    gtk_text_iter_toggles_tag($!gtk-ti, $tag);
  }

}

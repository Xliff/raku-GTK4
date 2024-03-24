use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text::Buffer:ver<4>;

use GLib::Value;
use GTK::Text::Iter:ver<4>;
use GTK::Text::Tag:ver<4>;
use GTK::Text::Tag::Table:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTextBufferAncestry is export of Mu
  where GtkTextBuffer | GObject;

class GTK::Text::Buffer:ver<4> {
  also does GLib::Roles::Object;

  has GtkTextBuffer $!gtk-tb is implementor;

  submethod BUILD ( :$gtk-text-buffer ) {
    self.setGtkTextBuffer($gtk-text-buffer) if $gtk-text-buffer;
  }

  method setGtkTextBuffer (GtkTextBufferAncestry $_) {
    my $to-parent;

    $!gtk-tb = do {
      when GtkTextBuffer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTextBuffer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Structs::GtkTextBuffer
    is also<GtkTextBuffer>
  { $!gtk-tb }

  multi method new (
     $gtk-text-buffer where * ~~ GtkTextBufferAncestry,

    :$ref = True
  ) {
    return unless $gtk-text-buffer;

    my $o = self.bless( :$gtk-text-buffer );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkTextTagTable $table) {
    my $gtk-text-buffer = gtk_text_buffer_new($table);

    $gtk-text-buffer ?? self.bless( :$gtk-text-buffer ) !! Nil;
  }
  multi method new (Str $text) {
    my $o = samewith(GtkTextTagTable);

    return Nil unless $o;
    $o.text = $text;
    $o;
  }
  multi method new ($_ is copy) {
    when .can('Str')             { $_ .= Str            ; proceed }
    when .can('GtkTextTagTable') { $_ .= GtkTextTagTable; proceed }
    when GtkTextTagTable | Str   { samewith($_) }

    default {
      X::GLib::InvalidArgument.new(
        message => "Argument to .new must be Str or GtkTextTagTable {
                    ''}compatible"
      ).throw;
    }
  }

  # Type: boolean
  method can-redo is rw  is g-property is also<can_redo> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-redo', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'can-redo does not allow writing'
      }
    );
  }

  # Type: boolean
  method can-undo is rw  is g-property is also<can_undo> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-undo', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'can-undo does not allow writing'
      }
    );
  }

  # Type: int
  method cursor-position is rw  is g-property is also<cursor_position> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cursor-position', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'cursor-position does not allow writing'
      }
    );
  }

  # Type: boolean
  method enable-undo is rw  is g-property is also<enable_undo> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-undo', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-undo', $gv);
      }
    );
  }

  # Type: boolean
  method has-selection is rw  is g-property is also<has_selection> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-selection', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-selection does not allow writing'
      }
    );
  }

  # Type: GtkTextTagTable
  method tag-table ( :$raw = False ) is rw  is g-property is also<tag_table> {
    my $gv = GLib::Value.new( GTK::Text::Tag::Table.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tag-table', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Text::Tag::Table.getTypePair
        );
      },
      STORE => -> $, GtkTextTagTable() $val is copy {
        $gv.object = $val;
        self.prop_set('tag-table', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  method add_mark (GtkTextMark() $mark, GtkTextIter() $where) \
    is also<add-mark>
  {
    gtk_text_buffer_add_mark($!gtk-tb, $mark, $where);
  }

  method add_selection_clipboard (GdkClipboard() $clipboard)
    is also<add-selection-clipboard>
  {
    gtk_text_buffer_add_selection_clipboard($!gtk-tb, $clipboard);
  }

  multi method applyTagAtIndexes (
    Str   $name,
    Int() $start,
    Int() $end
  ) {
    my $tag = self.tag-table.lookup($name);

    X::GLib::InvalidArgument.new(
      message => "No Text Tag with the name '$name' was found during {
                  '' }application attempt!"
    ).throw unless $tag;

    samewith($tag, $start, $end, :tag);
  }
  multi method applyTagAtIndexes (
    GtkTextTag()  $t,
    Int()         $start,
    Int()         $end,
                 :$tag is required
  ) {
    my $s = self.get_iter_at_offset($start);
    my $e = self.get_iter_at_offset($end);

    for [$start, $s], [$end, $e] {
      X::GLib::InvalidArgument.new(
        message => "An Invalid offset of '{ .head }' was given while {
                    '' }attempting to apply a text tag!"
      ).throw unless .tail.get-char;
    }

    self.apply_tag($t, $s, $e);
  }


  proto method apply_tag (|)
    is also<apply-tag>
  { * }

  multi method apply_tag (GtkTextTag() $tag) {
    samewith($tag, |self.bounds);
  }
  multi method apply_tag (
    GtkTextTag()    $tag,
    GtkTextIter()   $start,
    GtkTextIter()   $end
  ) {
    gtk_text_buffer_apply_tag($!gtk-tb, $tag, $start, $end);
  }

  method apply_tag_by_name (
    Str()         $name,
    GtkTextIter() $start,
    GtkTextIter() $end
  )
    is also<apply-tag-by-name>
  {
    gtk_text_buffer_apply_tag_by_name($!gtk-tb, $name, $start, $end);
  }

  method backspace (
    GtkTextIter() $iter,
    Int()         $interactive,
    Int()         $default_editable
  ) {
    my gboolean ($i, $d) = ($interactive, $default_editable)».so.Int;

    gtk_text_buffer_backspace($!gtk-tb, $iter, $i, $d);
  }

  method begin_irreversible_action is also<begin-irreversible-action> {
    gtk_text_buffer_begin_irreversible_action($!gtk-tb);
  }

  method begin_user_action is also<begin-user-action> {
    gtk_text_buffer_begin_user_action($!gtk-tb);
  }

  method copy_clipboard (GdkClipboard() $clipboard) is also<copy-clipboard> {
    gtk_text_buffer_copy_clipboard($!gtk-tb, $clipboard);
  }

  method create_child_anchor (GtkTextIter() $iter)
    is also<create-child-anchor>
  {
    gtk_text_buffer_create_child_anchor($!gtk-tb, $iter);
  }

  method create_mark (
    Str()         $mark_name,
    GtkTextIter() $where,
    Int()         $left_gravity
  )
    is also<create-mark>
  {
    my gboolean $l = $left_gravity.so.Int;

    gtk_text_buffer_create_mark($!gtk-tb, $mark_name, $where, $l);
  }

  method create_tag (Str() $tag_name, :$raw = False)
    is also<create-tag>
  {
    propReturnObject(
      gtk_text_buffer_create_tag($!gtk-tb, $tag_name, Str),
      $raw,
      |GTK::Text::Tag.getTypePair
    );
  }

  method cut_clipboard (GdkClipboard() $clipboard, Int() $default_editable)
    is also<cut-clipboard>
  {
    my gboolean $d = $default_editable.so.Int;

    gtk_text_buffer_cut_clipboard($!gtk-tb, $clipboard, $d);
  }

  method delete (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_text_buffer_delete($!gtk-tb, $start, $end);
  }

  method delete_interactive (
    GtkTextIter() $start_iter,
    GtkTextIter() $end_iter,
    Int()         $default_editable
  )
    is also<delete-interactive>
  {
    my gboolean $d = $default_editable.so.Int;

    gtk_text_buffer_delete_interactive($!gtk-tb, $start_iter, $end_iter, $d);
  }

  method delete_mark (GtkTextMark() $mark) is also<delete-mark> {
    gtk_text_buffer_delete_mark($!gtk-tb, $mark);
  }

  method delete_mark_by_name (Str() $name) is also<delete-mark-by-name> {
    gtk_text_buffer_delete_mark_by_name($!gtk-tb, $name);
  }

  method delete_selection (
    Int() $interactive,
    Int() $default_editable
  )
    is also<delete-selection>
  {
    my gboolean ($i, $d) = ($interactive, $default_editable)».so.Int;

    gtk_text_buffer_delete_selection($!gtk-tb, $i, $d);
  }

  method end_irreversible_action is also<end-irreversible-action> {
    gtk_text_buffer_end_irreversible_action($!gtk-tb);
  }

  method end_user_action is also<end-user-action> {
    gtk_text_buffer_end_user_action($!gtk-tb);
  }

  proto method get_bounds (|)
    is also<
      get-bounds
      bounds
    >
  { * }

  multi method get_bounds (:$raw = False) {
    samewith(GtkTextIter.new, GtkTextIter.new, :$raw);
  }
  multi method get_bounds (
    GtkTextIter()  $start,
    GtkTextIter()  $end,
                  :$raw    = False
  ) {
    gtk_text_buffer_get_bounds($!gtk-tb, $start, $end);

    (
      propReturnObject($start, $raw, |GTK::Text::Iter.getTypePair),
      propReturnObject($end,   $raw, |GTK::Text::Iter.getTypePair)
    );
  }

  method get_can_redo is also<get-can-redo> {
    so gtk_text_buffer_get_can_redo($!gtk-tb);
  }

  method get_can_undo is also<get-can-undo> {
    so gtk_text_buffer_get_can_undo($!gtk-tb);
  }

  method get_char_count is also<get-char-count> {
    gtk_text_buffer_get_char_count($!gtk-tb);
  }

  method get_enable_undo is also<get-enable-undo> {
    so gtk_text_buffer_get_enable_undo($!gtk-tb);
  }

  method get_end_iter (GtkTextIter() $iter) is also<get-end-iter> {
    gtk_text_buffer_get_end_iter($!gtk-tb, $iter);
  }

  method get_has_selection is also<get-has-selection> {
    so gtk_text_buffer_get_has_selection($!gtk-tb);
  }

  method get_insert is also<get-insert> {
    gtk_text_buffer_get_insert($!gtk-tb);
  }

  proto method get_iter_at_child_anchor (|)
    is also<get-iter-at-child-anchor>
  { * }

  multi method get_iter_at_child_anchor (Int() $anchor, :$raw = False) {
    samewith(GtkTextIter.new, $anchor, :$raw);
  }
  multi method get_iter_at_child_anchor (
    GtkTextIter()  $iter,
    Int()          $anchor,
                  :$raw     = False
  ) {
    my GtkTextChildAnchor $a = $anchor;

    gtk_text_buffer_get_iter_at_child_anchor($!gtk-tb, $iter, $a);
    propReturnObject($iter, $raw, |GTK::Text::Iter);
  }

  proto method get_iter_at_line (|)
    is also<get-iter-at-line>
  { * }

  multi method get_iter_at_line (Int() $line_number, :$raw = False) {
    samewith(GtkTextIter.new, $line_number, :$raw);
  }
  multi method get_iter_at_line (
    GtkTextIter()  $iter,
    Int()          $line_number,
                  :$raw = False
  ) {
    my gint $l = $line_number;

    gtk_text_buffer_get_iter_at_line($!gtk-tb, $iter, $l);
    propReturnObject($iter, $raw, |GTK::Text::Iter);
  }

  proto method get_iter_at_line_index (|)
  { * }

  multi method get_iter_at_line_index (
    Int()  $line_number,
    Int()  $byte_index,
          :$raw          = False
  ) {
    samewith(GtkTextIter.new, $line_number, $byte_index, :$raw);
  }
  multi method get_iter_at_line_index (
    GtkTextIter()  $iter,
    Int()          $line_number,
    Int()          $byte_index,
                  :$raw          = False
  )
    is also<get-iter-at-line-index>
  {
    my gint ($l, $b) = ($line_number, $byte_index);

    gtk_text_buffer_get_iter_at_line_index($!gtk-tb, $iter, $l, $b);
    propReturnObject($iter, $raw, |GTK::Text::Iter.getTypePair);
  }

  proto method get_iter_at_line_offset (|)
  { * }

  multi method get_iter_at_line_offset (
    Int()  $line_number,
    Int()  $char_offset,
          :$raw          = False
  ) {
    samewith(GtkTextIter, $line_number, $char_offset);
  }
  multi method get_iter_at_line_offset (
    GtkTextIter()  $iter,
    Int()          $line_number,
    Int()          $char_offset,
                  :$raw          = False
  )
    is also<get-iter-at-line-offset>
  {
    my gint ($l, $c) = ($line_number, $char_offset);

    gtk_text_buffer_get_iter_at_line_offset($!gtk-tb, $iter, $l, $c);
    propReturnObject($iter, $raw, |GTK::Text::Iter.getTypePair);
  }

  proto method get_iter_at_mark (|)
    is also<get-iter-at-mark>
  { * }

  multi method get_iter_at_mark (GtkTextMark() $mark, :$raw = False) {
    samewith(GtkTextIter.new, $mark, :$raw);
  }
  multi method get_iter_at_mark (
    GtkTextIter()  $iter,
    GtkTextMark()  $mark,
                  :$raw   = False
  ) {
    gtk_text_buffer_get_iter_at_mark($!gtk-tb, $iter, $mark);
    propReturnObject($iter, $raw, |GTK::Text::Iter.getTypePair);
  }

  proto method get_iter_at_offset (|)
    is also<get-iter-at-offset>
  { * }

  multi method get_iter_at_offset (Int() $char_offset, :$raw = False) {
    samewith(GtkTextIter.new, $char_offset, :$raw);
  }
  multi method get_iter_at_offset (
    GtkTextIter()  $iter,
    Int()          $char_offset,
                  :$raw          = False
  ) {
    my gint $c = $char_offset;

    gtk_text_buffer_get_iter_at_offset($!gtk-tb, $iter, $c);

    propReturnObject($iter, $raw, |GTK::Text::Iter.getTypePair);
  }

  method get_line_count is also<get-line-count> {
    gtk_text_buffer_get_line_count($!gtk-tb);
  }

  method get_mark (Str $name, :$raw = False)
    is also<get-mark>
  {
    propReturnObject(
      gtk_text_buffer_get_mark($!gtk-tb, $name),
      $raw,
      |GTK::Text::Mark.getTypePair
    )
  }

  method get_max_undo_levels is also<get-max-undo-levels> {
    gtk_text_buffer_get_max_undo_levels($!gtk-tb);
  }

  method get_modified is also<get-modified> {
    so gtk_text_buffer_get_modified($!gtk-tb);
  }

  method get_selection_bound is also<get-selection-bound> {
    gtk_text_buffer_get_selection_bound($!gtk-tb);
  }

  proto method get_selection_bounds (|)
    is also<get-selection-bounds>
  { * }

  multi method get_selection_bounds {
    samewith(GtkTextIter.new, GtkTextIter.new);
  }
  multi method get_selection_bounds (
    GtkTextIter()  $start,
    GtkTextIter()  $end,
                  :$raw    = False
  ) {
    gtk_text_buffer_get_selection_bounds($!gtk-tb, $start, $end);

    (
      propReturnObject($start, $raw, |GTK::Text::Iter.getTypePair),
      propReturnObject(  $end, $raw, |GTK::Text::Iter.getTypePair)
    )
  }

  method get_selection_content is also<get-selection-content> {
    gtk_text_buffer_get_selection_content($!gtk-tb);
  }

  method get_slice (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int()         $include_hidden_chars
  )
    is also<get-slice>
  {
    my gboolean $i = $include_hidden_chars.so.Int;

    gtk_text_buffer_get_slice($!gtk-tb, $start, $end, $i);
  }

  method get_start_iter (GtkTextIter() $iter)
    is also<get-start-iter>
  {
    gtk_text_buffer_get_start_iter($!gtk-tb, $iter);
  }

  method get_tag_table ( :$raw = False ) is also<get-tag-table> {
    propReturnObject(
      gtk_text_buffer_get_tag_table($!gtk-tb),
      $raw,
      |GTK::Text::Tag::Table.getTypePair
    );
  }

  method get_text (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int()         $include_hidden_chars
  )
    is also<get-text>
  {
    my gboolean $i = $include_hidden_chars.so.Int;

    gtk_text_buffer_get_text($!gtk-tb, $start, $end, $i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_buffer_get_type, $n, $t );
  }

  method insert (
    GtkTextIter() $iter,
    Str()         $text,
    Int()         $len
  ) {
    my gint $l = $len;

    gtk_text_buffer_insert($!gtk-tb, $iter, $text, $l);
  }

  method insert_at_cursor (Str() $text, Int() $len)
    is also<insert-at-cursor>
  {
    my gint $l = $len;

    gtk_text_buffer_insert_at_cursor($!gtk-tb, $text, $l);
  }

  method insert_child_anchor (GtkTextIter() $iter, Int() $anchor)
    is also<insert-child-anchor>
  {
    my GtkTextChildAnchor $a = $anchor;

    gtk_text_buffer_insert_child_anchor($!gtk-tb, $iter, $a);
  }

  method insert_interactive (
    GtkTextIter() $iter,
    Str()         $text,
    Int()         $len,
    Int()         $default_editable
  )
    is also<insert-interactive>
  {
    my gint     $l = $len;
    my gboolean $d = $default_editable.so.Int;

    gtk_text_buffer_insert_interactive($!gtk-tb, $iter, $text, $l, $d);
  }

  method insert_interactive_at_cursor (
    Str() $text,
    Int() $len,
    Int() $default_editable
  )
    is also<insert-interactive-at-cursor>
  {
    my gint     $l = $len;
    my gboolean $d = $default_editable.so.Int;

    gtk_text_buffer_insert_interactive_at_cursor($!gtk-tb, $text, $l, $d);
  }

  method insert_markup (
    GtkTextIter() $iter,
    Str()         $markup,
    Int()         $len
  )
    is also<insert-markup>
  {
    my gint $l = $len;

    gtk_text_buffer_insert_markup($!gtk-tb, $iter, $markup, $l);
  }

  method insert_paintable (
    GtkTextIter()   $iter,
    GdkPaintable()  $paintable
  )
    is also<insert-paintable>
  {
    gtk_text_buffer_insert_paintable($!gtk-tb, $iter, $paintable);
  }

  method insert_range (
    GtkTextIter()   $iter,
    GtkTextIter()   $start,
    GtkTextIter()   $end
  )
    is also<insert-range>
  {
    gtk_text_buffer_insert_range($!gtk-tb, $iter, $start, $end);
  }

  method insert_range_interactive (
    GtkTextIter()  $iter,
    GtkTextIter()  $start,
    GtkTextIter()  $end,
    Int()          $default_editable
  )
    is also<insert-range-interactive>
  {
    my gboolean $d = $default_editable.so.Int;

    gtk_text_buffer_insert_range_interactive(
      $!gtk-tb,
      $iter,
      $start,
      $end,
      $d
    );
  }

  method insert_with_tags (
    GtkTextIter() $iter,
    Str()         $text,
    Int()         $len,
    GtkTextTag()  $first_tag
  )
    is also<insert-with-tags>
  {
    my gint $l = $len;

    gtk_text_buffer_insert_with_tags($!gtk-tb, $iter, $text, $l, $first_tag);
  }

  method insert_with_tags_by_name (
    GtkTextIter() $iter,
    Str()         $text,
    Int()         $len,
    Str()         $first_tag_name
  )
    is also<insert-with-tags-by-name>
  {
    my gint $l = $len;

    gtk_text_buffer_insert_with_tags_by_name(
      $!gtk-tb,
      $iter,
      $text,
      $l,
      $first_tag_name
    );
  }

  method move_mark (GtkTextMark() $mark, GtkTextIter() $where)
    is also<move-mark>
  {
    gtk_text_buffer_move_mark($!gtk-tb, $mark, $where);
  }

  method move_mark_by_name (Str() $name, GtkTextIter() $where)
    is also<move-mark-by-name>
  {
    gtk_text_buffer_move_mark_by_name($!gtk-tb, $name, $where);
  }

  method paste_clipboard (
    GdkClipboard() $clipboard,
    GtkTextIter()  $override_location,
    Int()          $default_editable
  )
    is also<paste-clipboard>
  {
    my gboolean $d = $default_editable.so.Int;

    gtk_text_buffer_paste_clipboard(
      $!gtk-tb,
      $clipboard,
      $override_location,
      $d
    );
  }

  method place_cursor (GtkTextIter() $where)
    is also<place-cursor>
  {
    gtk_text_buffer_place_cursor($!gtk-tb, $where);
  }

  method redo {
    gtk_text_buffer_redo($!gtk-tb);
  }

  method remove_all_tags (GtkTextIter() $start, GtkTextIter() $end)
    is also<remove-all-tags>
  {
    gtk_text_buffer_remove_all_tags($!gtk-tb, $start, $end);
  }

  method remove_selection_clipboard (GdkClipboard() $clipboard)
    is also<remove-selection-clipboard>
  {
    gtk_text_buffer_remove_selection_clipboard($!gtk-tb, $clipboard);
  }

  method remove_tag (
    GtkTextTag()    $tag,
    GtkTextIter()   $start,
    GtkTextIter()   $end
  )
    is also<remove-tag>
  {
    gtk_text_buffer_remove_tag($!gtk-tb, $tag, $start, $end);
  }

  method remove_tag_by_name (
    Str()           $name,
    GtkTextIter()   $start,
    GtkTextIter()   $end
  )
    is also<remove-tag-by-name>
  {
    gtk_text_buffer_remove_tag_by_name($!gtk-tb, $name, $start, $end);
  }

  method select_range (
    GtkTextIter() $ins,
    GtkTextIter() $bound
  )
    is also<select-range>
  {
    gtk_text_buffer_select_range($!gtk-tb, $ins, $bound);
  }

  method set_enable_undo (Int() $enable_undo)
    is also<set-enable-undo>
  {
    my gboolean $e = $enable_undo.so.Int;

    gtk_text_buffer_set_enable_undo($!gtk-tb, $e);
  }

  method set_max_undo_levels (Int() $max_undo_levels)
    is also<set-max-undo-levels>
  {
    my guint $m = $max_undo_levels;

    gtk_text_buffer_set_max_undo_levels($!gtk-tb, $max_undo_levels);
  }

  method set_modified (Int() $setting)
    is also<set-modified>
  {
    my gboolean $s = $setting.so.Int;

    gtk_text_buffer_set_modified($!gtk-tb, $s);
  }

  method set_text (Str() $text, Int() $len)
    is also<set-text>
  {
    my gint $l = $len;

    gtk_text_buffer_set_text($!gtk-tb, $text, $l);
  }

  method undo {
    gtk_text_buffer_undo($!gtk-tb);
  }

}

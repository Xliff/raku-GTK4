use v6.c;

 use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text::View:ver<4>;

use GTK::Text::Buffer:ver<4>;
use GTK::Text::Iter:ver<4>;
use GTK::Text::Mark:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Scrollable:ver<4>;
use GTK::Roles::Signals::Generic:ver<4>;
use GTK::Roles::Signals::Text::View:ver<4>;

our subset GtkTextViewAncestry is export of Mu
  where GtkTextView | GtkScrollable | GtkWidgetAncestry;

class GTK::Text::View:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Scrollable;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::TextView;

  has GtkTextView $!gtk-tv is implementor;

  submethod BUILD ( :$gtk-text-view ) {
    self.setGtkTextView($gtk-text-view) if $gtk-text-view
  }

  method setGtkTextView (GtkTextViewAncestry $_) {
    my $to-parent;

    $!gtk-tv = do {
      when GtkTextView {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkScrollable {
        $!gtk-scroll = $_;
        $to-parent   = cast(GtkWidget, $_);
        cast(GtkTextView, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkTextView, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkScrollable;
  }

  method GTK::Raw::Definitions::GtkTextView
    is also<GtkTextView>
  { $!gtk-tv }

  multi method new (
     $gtk-text-view where * ~~ GtkTextViewAncestry,

    :$ref = True
  ) {
    return unless $gtk-text-view;

    my $o = self.bless( :$gtk-text-view );
    $o.ref if $ref;
    $o;
  }
  multi method new ( Str() :$text is required ) {
    ::?CLASS.new_with_buffer( GTK::Text::Buffer.new($text) );
  }
  multi method new ( GtkTextBuffer() :$buffer is required ) {
    ::?CLASS.new_with_buffer($buffer);
  }
  multi method new (*%named where *.elems == 0) {
    my $gtk-text-view = gtk_text_view_new();

    $gtk-text-view ?? self.bless( :$gtk-text-view ) !! Nil;
  }

  method new_with_buffer (GtkTextBuffer() $buffer) is also<new-with-buffer> {
    my $gtk-text-view = gtk_text_view_new_with_buffer($buffer);

    $gtk-text-view ?? self.bless( :$gtk-text-view ) !! Nil;
  }


  # Type: boolean
  method accepts-tab is rw  is g-property is also<accepts_tab> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accepts-tab', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accepts-tab', $gv);
      }
    );
  }

  # Type: int
  method bottom-margin is rw  is g-property is also<bottom_margin> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bottom-margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('bottom-margin', $gv);
      }
    );
  }

  # Type: GtkTextBuffer
  method buffer ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Text::Buffer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('buffer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Text::Buffer.getTypePair
        );
      },
      STORE => -> $, GtkTextBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: boolean
  method cursor-visible is rw  is g-property is also<cursor_visible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cursor-visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('cursor-visible', $gv);
      }
    );
  }

  # Type: boolean
  method editable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('editable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable', $gv);
      }
    );
  }

  # Type: GMenuModel
  method extra-menu ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('extra-menu', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        );
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('extra-menu', $gv);
      }
    );
  }

  # Type: string
  method im-module is rw  is g-property is also<im_module> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('im-module', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('im-module', $gv);
      }
    );
  }

  # Type: int
  method indent is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indent', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('indent', $gv);
      }
    );
  }

  # Type: GtkInputHints
  method input-hints ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkInputHints );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-hints', $gv);
        my $i = $gv.enum;
        return $i unless $enum;
        GtkInputHintsEnum($i);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputHints) = $val;
        self.prop_set('input-hints', $gv);
      }
    );
  }

  # Type: GtkInputPurpose
  method input-purpose ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkInputPurpose );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-purpose', $gv);
        my $i = $gv.enum;
        GtkInputPurposeEnum($i);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputPurpose) = $val;
        self.prop_set('input-purpose', $gv);
      }
    );
  }

  # Type: PangoJustification
  method justification ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkJustification );
    Proxy.new(
      FETCH => sub ($) {
        my $j = self.prop_get('justification', $gv);
        return $j unless $enum;
        GtkJustificationEnum($gv.enum);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkJustification) = $val;
        self.prop_set('justification', $gv);
      }
    );
  }

  # Type: int
  method left-margin is rw  is g-property is also<left_margin> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('left-margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('left-margin', $gv);
      }
    );
  }

  # Type: boolean
  method monospace is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('monospace', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('monospace', $gv);
      }
    );
  }

  # Type: boolean
  method overwrite is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overwrite', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('overwrite', $gv);
      }
    );
  }

  # Type: int
  method pixels-above-lines
    is rw
    is g-property
    is also<pixels_above_lines>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixels-above-lines', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-above-lines', $gv);
      }
    );
  }

  # Type: int
  method pixels-below-lines
    is rw
    is g-property
    is also<pixels_below_lines>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixels-below-lines', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-below-lines', $gv);
      }
    );
  }

  # Type: int
  method pixels-inside-wrap is rw  is g-property is also<pixels_inside_wrap> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixels-inside-wrap', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-inside-wrap', $gv);
      }
    );
  }

  # Type: int
  method right-margin is rw  is g-property is also<right_margin> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('right-margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('right-margin', $gv);
      }
    );
  }

  # Type: PangoTabArray
  method tabs ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::Tabs.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tabs', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |Pango::Tabs.getTypePair
        )
      },
      STORE => -> $, PangoTabArray() $val is copy {
        $gv.pointer = $val;
        self.prop_set('tabs', $gv);
      }
    );
  }

  # Type: int
  method top-margin is rw  is g-property is also<top_margin> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('top-margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('top-margin', $gv);
      }
    );
  }

  # Type: PangoWrapMode
  method wrap-mode ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( PangoWrapMode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-mode', $gv);
        my $w = $gv.enum;
        return $w unless $enum;
        PangoWrapModeEnum($w);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkWrapMode) = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  # Convenience function
  method text is rw {
    self.buffer.text
  }

  method Backspace {
    self.connect($!gtk-tv, 'backspace');
  }

  method Copy-Clipboard {
    self.connect($!gtk-tv, 'copy-clipboard');
  }

  method Cut-Clipboard {
    self.connect($!gtk-tv, 'cut-clipboard');
  }

  method Delete-From-Cursor {
    self.connect-enumP-int($!gtk-tv, 'delete-from-cursor');
  }

  method Extend-Selection {
    self.conenct-extend-selection($!gtk-tv);
  }

  method Insert-At-Cursor {
    self.connect-string($!gtk-tv, 'insert-at-cursor');
  }

  method Insert-Emoji {
    self.connect($!gtk-tv, 'insert-emoji');
  }

  method Move-Cursor {
    self.connect-move-cursor($!gtk-tv, 'move-cursor');
  }

  method Move-Viewport {
    self.connect-enumP-int($!gtk-tv, 'move-viewport');
  }

  method Paste-Clipboard {
    self.connect($!gtk-tv, 'paste-clipboard');
  }

  method Preedit-Changed {
    self.connect($!gtk-tv, 'preedit-changed');
  }

  method Select-All {
    self.connect-uint($!gtk-tv, 'select-all');
  }

  method Set-Anchor {
    self.connect($!gtk-tv, 'set-anchor');
  }

  method Toggle-Cursor {
    self.connect($!gtk-tv, 'toggle-cursor');
  }

  method Toggle-Overwrite {
    self.connect($!gtk-tv, 'toggle-overwrite');
  }

  method add_child_at_anchor (GtkWidget() $child, GtkTextChildAnchor $anchor)
    is also<add-child-at-anchor>
  {
    my GtkTextChildAnchor $a = $anchor;

    gtk_text_view_add_child_at_anchor($!gtk-tv, $child, $a);
  }

  method add_overlay (GtkWidget() $child, Int() $xpos, Int() $ypos)
    is also<add-overlay>
  {
    my gint ($x, $y) = ($xpos, $ypos);

    gtk_text_view_add_overlay($!gtk-tv, $child, $x, $y);
  }

  method backward_display_line (GtkTextIter() $iter)
    is also<backward-display-line>
  {
    gtk_text_view_backward_display_line($!gtk-tv, $iter);
  }

  method backward_display_line_start (GtkTextIter() $iter)
    is also<backward-display-line-start>
  {
    gtk_text_view_backward_display_line_start($!gtk-tv, $iter);
  }

  proto method buffer_to_window_coords (|)
    is also<buffer-to-window-coords>
  { * }

  multi method buffer_to_window_coords (
    Int() $win,
    Int() $buffer_x,
    Int() $buffer_y
  ) {
    samewith($win, $buffer_x, $buffer_y, $, $);
  }
  multi method buffer_to_window_coords (
    Int() $win,
    Int() $buffer_x,
    Int() $buffer_y,
          $window_x   is rw,
          $window_y   is rw
  ) {
    my GtkTextWindowType  $w                  = $win;
    my gint              ($bx, $by, $wx, $wy) = ($buffer_x, $buffer_y, 0, 0);

    gtk_text_view_buffer_to_window_coords($!gtk-tv, $w, $bx, $by, $wx, $wy);
    ($window_x, $window_y) = ($wx, $wy);
  }

  method forward_display_line (GtkTextIter() $iter)
    is also<forward-display-line>
  {
    gtk_text_view_forward_display_line($!gtk-tv, $iter);
  }

  method forward_display_line_end (GtkTextIter() $iter)
    is also<forward-display-line-end>
  {
    gtk_text_view_forward_display_line_end($!gtk-tv, $iter);
  }

  method get_accepts_tab is also<get-accepts-tab> {
    so gtk_text_view_get_accepts_tab($!gtk-tv);
  }

  method get_bottom_margin is also<get-bottom-margin> {
    gtk_text_view_get_bottom_margin($!gtk-tv);
  }

  method get_buffer is also<get-buffer> {
    gtk_text_view_get_buffer($!gtk-tv);
  }

  proto method get_cursor_locations (|)
    is also<get-cursor-locations>
  { * }

  multi method get_cursor_locations (GtkTextIter() $iter, :$raw = False) {
    samewith($iter, GdkRectangle.new, GdkRectangle.new, :$raw);
  }
  multi method get_cursor_locations (
    GtkTextIter()   $iter,
    GdkRectangle()  $strong,
    GdkRectangle()  $weak,
                   :$raw     = False
  ) {
    gtk_text_view_get_cursor_locations($!gtk-tv, $iter, $strong, $weak);

    (
      propReturnObject($strong, $raw, |GDK::Rectangle.getTypePair),
      propReturnObject($weak,   $raw, |GDK::Rectangle.getTypePair)
    );
  }

  method get_cursor_visible is also<get-cursor-visible> {
    so gtk_text_view_get_cursor_visible($!gtk-tv);
  }

  method get_editable is also<get-editable> {
    so gtk_text_view_get_editable($!gtk-tv);
  }

  method get_extra_menu (:$raw = False ) is also<get-extra-menu> {
    propReturnObject(
      gtk_text_view_get_extra_menu($!gtk-tv),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_gutter (Int() $win) is also<get-gutter> {
    my GtkTextWindowType $w = $win;

    gtk_text_view_get_gutter($!gtk-tv, $w);
  }

  method get_indent is also<get-indent> {
    gtk_text_view_get_indent($!gtk-tv);
  }

  method get_input_hints ( :$enum = True ) is also<get-input-hints> {
    my $i = gtk_text_view_get_input_hints($!gtk-tv);
    return $i unless $enum;
    GtkInputHintsEnum($i);
  }

  method get_input_purpose ( :$enum = True ) is also<get-input-purpose> {
    my $i = gtk_text_view_get_input_purpose($!gtk-tv);
    return $i unless $enum;
    GtkInputPurposeEnum($i);
  }

  proto method get_iter_at_location (|)
    is also<get-iter-at-location>
  { * }

  multi method get_iter_at_location (Int() $x, Int() $y, :$raw = False) {
    return-with-all(
      samewith(GtkTextIter.new, $x, $y, :all, :$raw)
    );
  }
  multi method get_iter_at_location (
    GtkTextIter()  $iter,
    Int()          $x,
    Int()          $y,
                  :$all   = False,
                  :$raw   = False
  ) {
    my gint ($xx, $yy) = ($x, $y);

    my $rv = gtk_text_view_get_iter_at_location($!gtk-tv, $iter, $xx, $yy);

    $all.not
      ?? $rv
      !! ( $rv, propReturnObject($iter, $raw, GTK::Text::Iter.getTypePair) )
  }

  proto method get_iter_at_position (|)
    is also<get-iter-at-position>
  { * }

  multi method get_iter_at_position (Int() $x, Int() $y, :$raw = False) {
    return-with-all(
      samewith(GtkTextIter.new, $, $x, $y, :all, :$raw)
    );
  }
  multi method get_iter_at_position (
    GtkTextIter()  $iter,
                   $trailing is rw,
    Int()          $x,
    Int()          $y,
                  :$all             = False,
                  :$raw             = False
  ) {
    my gint ($xx, $yy, $t) = ($x, $y, $trailing);

    my $rv = gtk_text_view_get_iter_at_position(
      $!gtk-tv,
      $iter,
      $t,
      $xx,
      $yy
    );
    $trailing = $t;

    $all.not
      ?? $rv
      !! (
            $rv,
            propReturnObject($iter, $raw, GTK::Text::Iter.getTypePair),
            $trailing
         );
  }

  proto method get_iter_location (|)
    is also<get-iter-location>
  { * }

  multi method get_iter_location (GtkTextIter() $iter, :$raw = False) {
    samewith($iter, GdkRectangle.new, :$raw);
  }
  multi method get_iter_location (
    GtkTextIter()   $iter,
    GdkRectangle()  $location,
                   :$raw       = False
  ) {
    gtk_text_view_get_iter_location($!gtk-tv, $iter, $location);
    propReturnObject($location, $raw, |GDK::Rectangle.getTypePair);
  }

  method get_justification ( :$enum = True ) is also<get-justification> {
    my $j = gtk_text_view_get_justification($!gtk-tv);
    return $j unless $enum;
    GtkJustificationEnum($j);
  }

  method get_left_margin is also<get-left-margin> {
    gtk_text_view_get_left_margin($!gtk-tv);
  }

  proto method get_line_at_y (|)
    is also<get-line-at-y>
  { * }

  multi method get_line_at_y (GtkTextIter() $target_iter, Int() $y) {
    samewith($target_iter, $y, $);
  }
  multi method get_line_at_y (
    GtkTextIter() $target_iter,
    Int()         $y,
                  $line_top     is rw,
  ) {
    my gint ($yy, $lt) = ($y, 0);

    gtk_text_view_get_line_at_y($!gtk-tv, $target_iter, $y, $lt);
    $line_top = $lt;
  }

  proto method get_line_yrange (|)
    is also<get-line-yrange>
  { * }

  multi method get_line_yrange (GtkTextIter() $iter) {
    samewith($, $);
  }
  multi method get_line_yrange (
    GtkTextIter() $iter,
                  $y      is rw,
                  $height is rw
  ) {
    my gint ($yy, $h) = 0 xx 2;

    gtk_text_view_get_line_yrange($!gtk-tv, $iter, $yy, $h);
    ($y, $height) = ($yy, $h);
  }

  method get_ltr_context ( :$raw = False ) is also<get-ltr-context> {
    propReturnObject(
      gtk_text_view_get_ltr_context($!gtk-tv),
      $raw,
      |Pango::Context.getTypePair
    );
  }

  method get_monospace is also<get-monospace> {
    so gtk_text_view_get_monospace($!gtk-tv);
  }

  method get_overwrite is also<get-overwrite> {
    so gtk_text_view_get_overwrite($!gtk-tv);
  }

  method get_pixels_above_lines is also<get-pixels-above-lines> {
    gtk_text_view_get_pixels_above_lines($!gtk-tv);
  }

  method get_pixels_below_lines is also<get-pixels-below-lines> {
    gtk_text_view_get_pixels_below_lines($!gtk-tv);
  }

  method get_pixels_inside_wrap is also<get-pixels-inside-wrap> {
    gtk_text_view_get_pixels_inside_wrap($!gtk-tv);
  }

  method get_right_margin is also<get-right-margin> {
    gtk_text_view_get_right_margin($!gtk-tv);
  }

  method get_rtl_context ( :$raw = False ) is also<get-rtl-context> {
    propReturnObject(
      gtk_text_view_get_rtl_context($!gtk-tv),
      $raw,
      |Pango::Context.getTypePair
    );
  }

  method get_tabs ( :$raw = False ) is also<get-tabs> {
    propReturnObject(
      gtk_text_view_get_tabs($!gtk-tv),
      $raw,
      |Pango::Tabs.getTypePair
    );
  }

  method get_top_margin is also<get-top-margin> {
    gtk_text_view_get_top_margin($!gtk-tv);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_view_get_type, $n, $t );
  }

  proto method get_visible_rect (|)
    is also<get-visible-rect>
  { * }

  multi method get_visible_rect ( :$raw = False ) {
    samewith(GdkRectangle.new, :$raw)
  }
  multi method get_visible_rect (
    GdkRectangle()  $visible_rect,
                   :$raw           = False
  ) {
    gtk_text_view_get_visible_rect($!gtk-tv, $visible_rect);
    propReturnObject($visible_rect, $raw, |GDK::Rectangle.getTypePair);
  }

  method get_wrap_mode ( :$enum = True ) is also<get-wrap-mode> {
    my $w = gtk_text_view_get_wrap_mode($!gtk-tv);
    return $w unless $enum;
    PangoWrapModeEnum($w);
  }

  method im_context_filter_keypress (GdkEvent() $event)
    is also<im-context-filter-keypress>
  {
    so gtk_text_view_im_context_filter_keypress($!gtk-tv, $event);
  }

  method move_mark_onscreen (GtkTextMark() $mark)
    is also<move-mark-onscreen>
  {
    so gtk_text_view_move_mark_onscreen($!gtk-tv, $mark);
  }

  method move_overlay (GtkWidget() $child, Int() $xpos, Int() $ypos)
    is also<move-overlay>
  {
    my gint ($x, $y) = ($xpos, $ypos);

    gtk_text_view_move_overlay($!gtk-tv, $child, $x, $y);
  }

  method move_visually (GtkTextIter() $iter, Int() $count)
    is also<move-visually>
  {
    my gint $c = $count;

    so gtk_text_view_move_visually($!gtk-tv, $iter, $c);
  }

  method place_cursor_onscreen is also<place-cursor-onscreen> {
    so gtk_text_view_place_cursor_onscreen($!gtk-tv);
  }

  method remove (GtkWidget() $child) {
    gtk_text_view_remove($!gtk-tv, $child);
  }

  method reset_cursor_blink is also<reset-cursor-blink> {
    gtk_text_view_reset_cursor_blink($!gtk-tv);
  }

  method reset_im_context is also<reset-im-context> {
    gtk_text_view_reset_im_context($!gtk-tv);
  }

  method scroll_mark_onscreen (GtkTextMark() $mark)
    is also<scroll-mark-onscreen>
  {
    gtk_text_view_scroll_mark_onscreen($!gtk-tv, $mark);
  }

  method scroll_to_iter (
    GtkTextIter() $iter,
    Num()         $within_margin,
    Int()         $use_align,
    Num()         $xalign,
    Num()         $yalign
  )
    is also<scroll-to-iter>
  {
    my gdouble  ($w, $x, $y) = ($within_margin, $xalign, $yalign);
    my gboolean  $u          =  $use_align.so.Int;

    gtk_text_view_scroll_to_iter($!gtk-tv, $iter, $w, $u, $x, $y);
  }

  method scroll_to_mark (
    GtkTextMark() $mark,
    Num()         $within_margin,
    Int()         $use_align,
    Num()         $xalign,
    Num()         $yalign
  )
    is also<scroll-to-mark>
  {
    my gdouble  ($w, $x, $y) = ($within_margin, $xalign, $yalign);
    my gboolean  $u          =  $use_align.so.Int;

    gtk_text_view_scroll_to_mark($!gtk-tv, $mark, $w, $u, $x, $y);
  }

  method set_accepts_tab (Int() $accepts_tab)
    is also<set-accepts-tab>
  {
    my gboolean $a = $accepts_tab.so.Int;

    gtk_text_view_set_accepts_tab($!gtk-tv, $a);
  }

  method set_bottom_margin (Int() $bottom_margin) is also<set-bottom-margin> {
    my gint $b = $bottom_margin;

    gtk_text_view_set_bottom_margin($!gtk-tv, $b);
  }

  method set_buffer (GtkTextBuffer() $buffer)
    is also<set-buffer>
  {
    gtk_text_view_set_buffer($!gtk-tv, $buffer);
  }

  method set_cursor_visible (Int() $setting)
    is also<set-cursor-visible>
  {
    my gboolean $s = $setting.so.Int;

    gtk_text_view_set_cursor_visible($!gtk-tv, $s);
  }

  method set_editable (Int() $setting)
    is also<set-editable>
  {
    my gboolean $s = $setting.so.Int;

    gtk_text_view_set_editable($!gtk-tv, $s);
  }

  method set_extra_menu (GMenuModel() $model)
    is also<set-extra-menu>
  {
    gtk_text_view_set_extra_menu($!gtk-tv, $model);
  }

  method set_gutter (Int() $win, GtkWidget() $widget)
    is also<set-gutter>
  {
    my GtkTextWindowType $w = $win;

    gtk_text_view_set_gutter($!gtk-tv, $w, $widget);
  }

  method set_indent (Int() $indent) is also<set-indent> {
    my gint $i = $indent;

    gtk_text_view_set_indent($!gtk-tv, $i);
  }

  method set_input_hints (Int() $hints) is also<set-input-hints> {
    my GtkInputHints $h = $hints;

    gtk_text_view_set_input_hints($!gtk-tv, $h);
  }

  method set_input_purpose (Int() $purpose) is also<set-input-purpose> {
    my GtkInputPurpose $p = $purpose;

    gtk_text_view_set_input_purpose($!gtk-tv, $p);
  }

  method set_justification (Int() $justification) is also<set-justification> {
    my GtkJustification $j = $justification;

    gtk_text_view_set_justification($!gtk-tv, $j);
  }

  method set_left_margin (Int() $left_margin) is also<set-left-margin> {
    my gint $l = $left_margin;

    gtk_text_view_set_left_margin($!gtk-tv, $l);
  }

  method set_monospace (Int() $monospace) is also<set-monospace> {
    my gboolean $m = $monospace.so.Int;

    gtk_text_view_set_monospace($!gtk-tv, $m);
  }

  method set_overwrite (Int() $overwrite) is also<set-overwrite> {
    my gboolean $o = $overwrite.so.Int;

    gtk_text_view_set_overwrite($!gtk-tv, $o);
  }

  method set_pixels_above_lines (Int() $pixels_above_lines)
    is also<set-pixels-above-lines>
  {
    my gint $p = $pixels_above_lines;

    gtk_text_view_set_pixels_above_lines($!gtk-tv, $p);
  }

  method set_pixels_below_lines (Int() $pixels_below_lines)
    is also<set-pixels-below-lines>
  {
    my gint $p = $pixels_below_lines;

    gtk_text_view_set_pixels_below_lines($!gtk-tv, $p);
  }

  method set_pixels_inside_wrap (Int() $pixels_inside_wrap)
    is also<set-pixels-inside-wrap>
  {
    my gint $p = $pixels_inside_wrap;

    gtk_text_view_set_pixels_inside_wrap($!gtk-tv, $p);
  }

  method set_right_margin (Int() $right_margin) is also<set-right-margin> {
    my gint $r = $right_margin;

    gtk_text_view_set_right_margin($!gtk-tv, $r);
  }

  method set_tabs (PangoTabArray() $tabs) is also<set-tabs> {
    gtk_text_view_set_tabs($!gtk-tv, $tabs);
  }

  method set_top_margin (Int() $top_margin) is also<set-top-margin> {
    my gint $t = $top_margin;

    gtk_text_view_set_top_margin($!gtk-tv, $t);
  }

  method set_wrap_mode (Int() $wrap_mode) is also<set-wrap-mode> {
    my GtkWrapMode $w = $wrap_mode;

    gtk_text_view_set_wrap_mode($!gtk-tv, $w);
  }

  method starts_display_line (GtkTextIter() $iter)
    is also<starts-display-line>
  {
    gtk_text_view_starts_display_line($!gtk-tv, $iter);
  }

  method window_to_buffer_coords (
    Int() $win,
    Int() $window_x,
    Int() $window_y,
    Int() $buffer_x is rw,
    Int() $buffer_y is rw
  )
    is also<window-to-buffer-coords>
  {
    my GtkTextWindowType  $w                  = $win;
    my gint              ($wx, $wy, $bx, $by) = ($window_x, $window_y, 0, 0);

    gtk_text_view_window_to_buffer_coords($!gtk-tv, $w, $wx, $wy, $bx, $by);
    ($buffer_x, $buffer_y) = ($bx, $by);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Text::View;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Text::View;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

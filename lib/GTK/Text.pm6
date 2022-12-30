use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text:ver<4>;

use GTK::Entry::Buffer:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Editable;
use GTK::Roles::Signals::Generic:ver<4>;

our subset GtkTextAncestry is export of Mu
  where GtkText | GtkEditable | GtkWidgetAncestry;

class GTK::Text:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Editable;

  has GtkText $!gtk-text is implementor;

  submethod BUILD ( :$gtk-text ) {
    self.setGtkText($gtk-text) if $gtk-text
  }

  method setGtkText (GtkTextAncestry $_) {
    my $to-parent;

    $!gtk-text = do {
      when GtkText {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkEditable {
        $!gtk-e    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkText, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkText, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkEditable;
  }

  method GTK::Raw::Definitions::GtkText
  { $!gtk-text }

  multi method new (
     $gtk-text where * ~~ GtkTextAncestry,

    :$ref = True
  ) {
    return unless $gtk-text;

    my $o = self.bless( :$gtk-text );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-text = gtk_text_new();

    $gtk-text ?? self.bless( :$gtk-text ) !! Nil
  }
  multi method new ($text) {
    ::?CLASS.new_with_buffer( GTK::Entry::Buffer.new($text) );
  }

  method new_with_buffer (GtkEntryBuffer() $buffer) {
    my $gtk-text = gtk_text_new_with_buffer($!gtk-text, $buffer);

    $gtk-text ?? self.bless( :$gtk-text ) !! Nil
  }

  # Type: boolean
  method activates-default is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activates-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activates-default', $gv);
      }
    );
  }

  # Type: PangoAttrList
  method attributes ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::AttrList.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('attributes', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Pango::AttrList.getTypePair
        );
      },
      STORE => -> $, PangoAttrList() $val is copy {
        $gv.object = $val;
        self.prop_set('attributes', $gv);
      }
    );
  }

  # Type: GtkEntryBuffer
  method buffer ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Gtk::Entry::Buffer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('buffer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Entry::Buffer.getTypePair
        );
      },
      STORE => -> $, GtkEntryBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: boolean
  method enable-emoji-completion is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-emoji-completion', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-emoji-completion', $gv);
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
  method im-module is rw  is g-property {
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

  # Type: GtkInputHints
  method input-hints ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkInputHints );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-hints', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        GtkInputHintsEnum($e);
      },
      STORE => -> Int() ,  $val is copy {
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
        my $e = $gv.enum;
        return $e unless $enum;
        GtkInputPurposeEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputPurpose) = $val;
        self.prop_set('input-purpose', $gv);
      }
    );
  }

  # Type: unichar
  method invisible-char is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('invisible-char', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('invisible-char', $gv);
      }
    );
  }

  # Type: boolean
  method invisible-char-set is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('invisible-char-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invisible-char-set', $gv);
      }
    );
  }

  # Type: int
  method max-length is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-length', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-length', $gv);
      }
    );
  }

  # Type: boolean
  method overwrite-mode is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overwrite-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('overwrite-mode', $gv);
      }
    );
  }

  # Type: string
  method placeholder-text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('placeholder-text', $gv);
      }
    );
  }

  # Type: boolean
  method propagate-text-width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('propagate-text-width', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('propagate-text-width', $gv);
      }
    );
  }

  # Type: int
  method scroll-offset is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scroll-offset', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scroll-offset does not allow writing'
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
          $gv.object,
          $raw,
          |Pango::Tabs.getTypePair
        );
      },
      STORE => -> $, PangoTabArray() $val is copy {
        $gv.object = $val;
        self.prop_set('tabs', $gv);
      }
    );
  }

  # Type: boolean
  method truncate-multiline is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('truncate-multiline', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('truncate-multiline', $gv);
      }
    );
  }

  # Type: boolean
  method visibility is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visibility', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visibility', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-text, 'activate');
  }

  method Backspace {
    self.connect($!gtk-text, 'backspace');
  }

  method Copy-Clipboard {
    self.connect($!gtk-text, 'copy-clipboard');
  }

  method Cut-Clipboard {
    self.connect($!gtk-text, 'cut-clipboard');
  }

  method Delete-From-Cursor {
    self.connect-enumP-int($!gtk-text, 'delete-from-cursor');
  }

  method Insert-At-Cursor {
    self.connect-string($!gtk-text, 'insert-at-cursor');
  }

  method Insert-Emoji {
    self.connect($!gtk-text, 'insert-emoji');
  }

  # method Move-Cursor

  method Paste-Clipboard {
    self.connect($!gtk-text, 'paste-clipboard');
  }

  method Preedit-Changed {
    self.connect($!gtk-text, 'preedit-changed');
  }

  method Toggle-Overwrite {
    self.connect($!gtk-text, 'toggle-overwrite');
  }

  proto method compute_cursor_extents (|)
  { * }

  multi method compute_cursor_extents (
    Int()              $position,
    graphene_rect_t() :$strong    = graphene_rect_t,
    graphene_rect_t() :$weak      = graphene_rect_t
  ) {
    samewith($position, $strong, $weak);
  }
  multi method compute_cursor_extents (
    Int()             $position,
    graphene_rect_t() $strong    = graphene_rect_t,
    graphene_rect_t() $weak      = graphene_rect_t
  ) {
    my gsize $p = $position;

    X::GLib::InvalidArguments.new(
      message => "Must use one of \$strong or \$weak in call to
                  .{ &?ROUTINE.name }"
    ).throw;

    gtk_text_compute_cursor_extents($!gtk-text, $p, $strong, $weak);
  }

  method get_activates_default  {
    so gtk_text_get_activates_default($!gtk-text),
  }

  method get_attributes ( :$raw = False ) {
    propReturnObject(
      gtk_text_get_attributes($!gtk-text),
      $raw,
      |Pango::AttrList.getTypePair
    );
  }

  method get_buffer ( :$raw = False ) {
    propReturnObject(
      gtk_text_get_buffer($!gtk-text),
      $raw,
      |GTK::Entry::Buffer.getTypePair
    );
  }

  method get_enable_emoji_completion {
    so gtk_text_get_enable_emoji_completion($!gtk-text);
  }

  method get_extra_menu ( :$raw = False ) {
    propReturnObject(
      gtk_text_get_extra_menu($!gtk-text),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_input_hints ( :$enum = True ) {
    my $h = gtk_text_get_input_hints($!gtk-text);
    return $h unless $enum;
    GtkInputHintsEnum($h);
  }

  method get_input_purpose ( :$enum = True ) {
    my $p = gtk_text_get_input_purpose($!gtk-text);
    return $p unless $enum;
    GtkInputPurposeEnum($p);
  }

  method get_invisible_char {
    gtk_text_get_invisible_char($!gtk-text);
  }

  method get_max_length {
    gtk_text_get_max_length($!gtk-text);
  }

  method get_overwrite_mode {
    so gtk_text_get_overwrite_mode($!gtk-text);
  }

  method get_placeholder_text {
    gtk_text_get_placeholder_text($!gtk-text);
  }

  method get_propagate_text_width {
    so gtk_text_get_propagate_text_width($!gtk-text);
  }

  method get_tabs ( :$raw = False ) {
    propReturnObject(
      gtk_text_get_tabs($!gtk-text),
      $raw,
      |Pango::Tabs.getTypePair
    );
  }

  method get_text_length {
    gtk_text_get_text_length($!gtk-text);
  }

  method get_truncate_multiline {
    so gtk_text_get_truncate_multiline($!gtk-text);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_get_type, $n, $t );
  }

  method get_visibility {
    so gtk_text_get_visibility($!gtk-text);
  }

  method grab_focus_without_selecting {
    gtk_text_grab_focus_without_selecting($!gtk-text);
  }

  method set_activates_default (Int() $activates) {
    my gboolean $a = $activates.so.Int;

    gtk_text_set_activates_default($!gtk-text, $a);
  }

  method set_attributes (PangoAttrList() $attrs) {
    gtk_text_set_attributes($!gtk-text, $attrs);
  }

  method set_buffer (GtkEntryBuffer() $buffer) {
    gtk_text_set_buffer($!gtk-text, $buffer);
  }

  method set_enable_emoji_completion (Int() $enable_emoji_completion) {
    my gboolean $e = $enable_emoji_completion.so.Int;

    gtk_text_set_enable_emoji_completion($!gtk-text, $e);
  }

  method set_extra_menu (GMenuModel() $model) {
    gtk_text_set_extra_menu($!gtk-text, $model);
  }

  method set_input_hints (Int() $hints) {
    my GtkInputHints $h = $hints;

    gtk_text_set_input_hints($!gtk-text, $h);
  }

  method set_input_purpose (Int() $purpose) {
    my GtkInputPurpose $p = $purpose;

    gtk_text_set_input_purpose($!gtk-text, $p);
  }

  method set_invisible_char (Int() $ch) {
    my gunichar $c = $ch;

    gtk_text_set_invisible_char($!gtk-text, $c);
  }

  method set_max_length (Int() $length) {
    my gint $l = $length;

    gtk_text_set_max_length($!gtk-text, $l);
  }

  method set_overwrite_mode (Int() $overwrite) {
    my gboolean $o = $overwrite.so.Int;

    gtk_text_set_overwrite_mode($!gtk-text, $o);
  }

  method set_placeholder_text (Str() $text) {
    gtk_text_set_placeholder_text($!gtk-text, $text);
  }

  method set_propagate_text_width (Int() $propagate_text_width) {
    my gboolean $p = $propagate_text_width.so.Int;

    gtk_text_set_propagate_text_width($!gtk-text, $p);
  }

  method set_tabs (PangoTabArray() $tabs) {
    gtk_text_set_tabs($!gtk-text, $tabs);
  }

  method set_truncate_multiline (Int() $truncate_multiline) {
    my gboolean $t = $truncate_multiline.so.Int;

    gtk_text_set_truncate_multiline($!gtk-text, $t);
  }

  method set_visibility (Int() $visible) {
    my gboolean $v = $visible.so.Int;

    gtk_text_set_visibility($!gtk-text, $v);
  }

  method unset_invisible_char {
    gtk_text_unset_invisible_char($!gtk-text);
  }

}

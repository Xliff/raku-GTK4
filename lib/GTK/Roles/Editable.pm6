use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Editable:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::Editable;

role GTK::Roles::Editable:ver<4> {
  also does GTK::Roles::Signals::Editable;

  has GtkEditable $!gtk-e is implementor;

  method GTK::Raw::Definitions::GtkEditable
  { $!gtk-e }
  method GtkEditable
  { $!gtk-e }

  method roleInit-GtkEditable is also<roleInit_GtkEditable> {
    return if $!gtk-e;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-e = cast( GtkEditable, i.get_value(self) );
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

  # Type: int
  method max-width-chars is rw  is g-property is also<max_width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-chars', $gv);
      }
    );
  }

  # Type: int
  method selection-bound is rw  is g-property is also<selection_bound> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selection-bound', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'selection-bound does not allow writing'
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

  # Type: int
  method width-chars is rw  is g-property is also<width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width-chars', $gv);
      }
    );
  }

  # Type: float
  method xalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  method Changed {
    self.connect($!gtk-e, 'changed');
  }

  method Delete-Text is also<Delete_Text> is also<Delete_Text> {
    self.connect-uintuint($!gtk-e, 'delete-text');
  }

  method Insert-Text is also<Insert_Text> is also<Insert_Text> {
    self.connect-insert-text($!gtk-e);
  }

  method delegate_get_property (
    GObject()    $object,
    Int()        $prop_id,
    GValue()     $value,
    GParamSpec() $pspec
  )
    is also<delegate-get-property>
  {
    my guint $p = $prop_id;

    gtk_editable_delegate_get_property($!gtk-e, $p, $value, $pspec);
  }

  method delegate_set_property (
    GObject()    $object,
    Int()        $prop_id,
    GValue()     $value,
    GParamSpec() $pspec
  )
    is also<delegate-set-property>
  {
    my guint $p = $prop_id;

    gtk_editable_delegate_set_property($!gtk-e, $p, $value, $pspec);
  }

  method delete_selection is also<delete-selection> {
    gtk_editable_delete_selection($!gtk-e);
  }

  method delete_text (Int() $start_pos, Int() $end_pos) is also<delete-text> {
    my gint ($s, $e) = ($start_pos, $end_pos);

    gtk_editable_delete_text($!gtk-e, $s, $e);
  }

  method finish_delegate is also<finish-delegate> {
    gtk_editable_finish_delegate($!gtk-e);
  }

  method get_alignment is also<get-alignment> {
    gtk_editable_get_alignment($!gtk-e);
  }

  method get_chars (Int() $start_pos, Int() $end_pos) is also<get-chars> {
    my gint ($s, $e) = ($start_pos, $end_pos);

    gtk_editable_get_chars($!gtk-e, $start_pos, $end_pos);
  }

  method get_delegate (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-delegate>
  {
    returnProperWidget(
      cast( GObject, gtk_editable_get_delegate($!gtk-e) ),
      $raw,
      $proper
    )
  }

  method get_editable is also<get-editable> {
    so gtk_editable_get_editable($!gtk-e);
  }

  method get_enable_undo is also<get-enable-undo> {
    so gtk_editable_get_enable_undo($!gtk-e);
  }

  method get_max_width_chars is also<get-max-width-chars> {
    gtk_editable_get_max_width_chars($!gtk-e);
  }

  method get_position is also<get-position> {
    gtk_editable_get_position($!gtk-e);
  }

  proto method get_selection_bounds (|)
    is also<get-selection-bounds>
  { * }

  multi method get_selection_bounds {
    samewith($, $);
  }
  multi method get_selection_bounds ($start_pos is rw, $end_pos is rw) {
    my gint ($s, $e) = 0 xx 2;

    gtk_editable_get_selection_bounds($!gtk-e, $s, $e);
    ($start_pos, $end_pos) = ($s, $e);
  }

  method get_text is also<get-text> {
    gtk_editable_get_text($!gtk-e);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_editable_get_type, $n, $t );
  }

  method get_width_chars is also<get-width-chars> {
    gtk_editable_get_width_chars($!gtk-e);
  }

  method init_delegate is also<init-delegate> {
    gtk_editable_init_delegate($!gtk-e);
  }

  method prepend_text (Str() $text, :$length = -1) is also<prepend-text> {
    self.insert_text($text, 0, :$length);
  }
  method prepend (Str() $text, :$length = -1) {
    self.prepend_text($text, :$length);
  }

  method append_text (Str() $text, :$length = -1) is also<append-text> {
    self.insert_text($text, self.get_text.chars, :$length);
  }
  method append (Str() $text, :$length = -1) {
    self.append_text($text, :$length);
  }

  method insert (Str() $text, $position, :$length = -1) {
    self.insert_text($text, $position, :$length);
  }

  proto method insert_text (|)
    is also<insert-text>
  { *}

  multi method insert_text (Str() $text, $position is rw, :$length = -1) {
    samewith($text, $length, $position);
  }
  multi method insert_text (
    Str() $text,
    Int() $length,
          $position is rw
  ) {
    my gint ($l, $p) = ($length, $position);

    gtk_editable_insert_text($!gtk-e, $text, $l, $p);
    $position = $p;
  }

  # method install_properties (Int() $first_prop) {
  #   my guint $f = $first_prop;
  #
  #   gtk_editable_install_properties($!gtk-e, $f);
  # }

  method select_region (Int() $start_pos, Int() $end_pos)
    is also<select-region>
  {
    my gint ($s, $e) = ($start_pos, $end_pos);

    gtk_editable_select_region($!gtk-e, $s, $e);
  }

  method set_alignment (Num() $xalign) is also<set-alignment> {
    my gfloat $x = $xalign;

    gtk_editable_set_alignment($!gtk-e, $x);
  }

  method set_editable (Int() $is_editable) is also<set-editable> {
    my gboolean $i = $is_editable.so.Int;

    gtk_editable_set_editable($!gtk-e, $i);
  }

  method set_enable_undo (Int() $enable_undo) is also<set-enable-undo> {
    my gboolean $e = $enable_undo.so.Int;

    gtk_editable_set_enable_undo($!gtk-e, $e);
  }

  method set_max_width_chars (Int() $n_chars) is also<set-max-width-chars> {
    my gint $n = $n_chars;

    gtk_editable_set_max_width_chars($!gtk-e, $n);
  }

  method set_position (Int() $position) is also<set-position> {
    my gint $p = $position;

    gtk_editable_set_position($!gtk-e, $p);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_editable_set_text($!gtk-e, $text);
  }

  method set_width_chars (Int() $n_chars) is also<set-width-chars> {
    my gint $n = $n_chars;

    gtk_editable_set_width_chars($!gtk-e, $n);
  }

}


our subset GtkEditableAncestry is export of Mu
  where GtkEditable | GObject;

class GTK::Editable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Editable;

  submethod BUILD ( :$gtk-editable ) {
    self.setGtkEditable($gtk-editable) if $gtk-editable
  }

  method setGtkEditable (GtkEditableAncestry $_) {
    my $to-parent;

    $!gtk-e = do {
      when GtkEditable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEditable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GtkEditableAncestry $gtk-editable, :$ref = True) {
    return unless $gtk-editable;

    my $o = self.bless( :$gtk-editable );
    $o.ref if $ref;
    $o;
  }

}

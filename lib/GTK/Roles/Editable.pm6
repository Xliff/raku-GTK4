use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Editable:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Editable:ver<4> {
  has GtkEditable $!gtk-e is implementor;

  method GTK::Raw::Definitions::GtkEditable
  { $!gtk-e }
  method GtkEditable
  { $!gtk-e }

  method roleInit-GtkEditable {
    return if $!gtk-e;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-e = cast( GtkEditable, i.get_value(self) );
  }

  method delegate_get_property (
    GObject()    $object,
    Int()        $prop_id,
    GValue()     $value,
    GParamSpec() $pspec
  ) {
    my guint $p = $prop_id;

    gtk_editable_delegate_get_property($!gtk-e, $p, $value, $pspec);
  }

  method delegate_set_property (
    GObject()    $object,
    Int()        $prop_id,
    GValue()     $value,
    GParamSpec() $pspec
  ) {
    my guint $p = $prop_id;

    gtk_editable_delegate_set_property($!gtk-e, $p, $value, $pspec);
  }

  method delete_selection {
    gtk_editable_delete_selection($!gtk-e);
  }

  method delete_text (Int() $start_pos, Int() $end_pos) {
    my gint ($s, $e) = ($start_pos, $end_pos);

    gtk_editable_delete_text($!gtk-e, $s, $e);
  }

  method finish_delegate {
    gtk_editable_finish_delegate($!gtk-e);
  }

  method get_alignment {
    gtk_editable_get_alignment($!gtk-e);
  }

  method get_chars (Int() $start_pos, Int() $end_pos) {
    my gint ($s, $e) = ($start_pos, $end_pos);

    gtk_editable_get_chars($!gtk-e, $start_pos, $end_pos);
  }

  method get_delegate (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      cast( GObject, gtk_editable_get_delegate($!gtk-e) ),
      $raw,
      $proper
    )
  }

  method get_editable {
    so gtk_editable_get_editable($!gtk-e);
  }

  method get_enable_undo {
    so gtk_editable_get_enable_undo($!gtk-e);
  }

  method get_max_width_chars {
    gtk_editable_get_max_width_chars($!gtk-e);
  }

  method get_position {
    gtk_editable_get_position($!gtk-e);
  }

  proto method get_selection_bounds (|)
  { * }

  multi method get_selection_bounds {
    samewith($, $);
  }
  multi method get_selection_bounds ($start_pos is rw, $end_pos is rw) {
    my gint ($s, $e) = 0 xx 2;

    gtk_editable_get_selection_bounds($!gtk-e, $s, $e);
    ($start_pos, $end_pos) = ($s, $e);
  }

  method get_text {
    gtk_editable_get_text($!gtk-e);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_editable_get_type, $n, $t );
  }

  method get_width_chars {
    gtk_editable_get_width_chars($!gtk-e);
  }

  method init_delegate {
    gtk_editable_init_delegate($!gtk-e);
  }

  method prepend_text (Str() $text, :$length = -1) {
    self.insert_text($text, 0, :$length);
  }
  method prepend (Str() $text, :$length = -1) {
    self.prepend_text($text, :$length);
  }

  method append_text (Str() $text, :$length = -1) {
    self.insert_text($text, self.get_text.chars, :$length);
  }
  method append (Str() $text, :$length = -1) {
    self.append_text($text, :$length);
  }

  method insert (Str() $text, $position, :$length = -1) {
    self.insert_text($text, $position, :$length);
  }

  proto method insert_text (|)
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

  method select_region (Int() $start_pos, Int() $end_pos) {
    my gint ($s, $e) = ($start_pos, $end_pos);

    gtk_editable_select_region($!gtk-e, $s, $e);
  }

  method set_alignment (Num() $xalign) {
    my gfloat $x = $xalign;

    gtk_editable_set_alignment($!gtk-e, $x);
  }

  method set_editable (Int() $is_editable) {
    my gboolean $i = $is_editable.so.Int;

    gtk_editable_set_editable($!gtk-e, $i);
  }

  method set_enable_undo (Int() $enable_undo) {
    my gboolean $e = $enable_undo.so.Int;

    gtk_editable_set_enable_undo($!gtk-e, $e);
  }

  method set_max_width_chars (Int() $n_chars) {
    my gint $n = $n_chars;

    gtk_editable_set_max_width_chars($!gtk-e, $n);
  }

  method set_position (Int() $position) {
    my gint $p = $position;

    gtk_editable_set_position($!gtk-e, $p);
  }

  method set_text (Str() $text) {
    gtk_editable_set_text($!gtk-e, $text);
  }

  method set_width_chars (Int() $n_chars) {
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

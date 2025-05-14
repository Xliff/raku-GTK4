use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::ComboBox::Text:ver<4>;

use GTK::ComboBox:ver<4>;

use GLib::Roles::Implementor;

our subset GtkComboBoxTextAncestry is export of Mu
  where GtkComboBoxText | GtkComboBoxAncestry;

class GTK::ComboBox::Text:ver<4> is GTK::ComboBox {
  has GtkComboBoxText $!gcbt is implementor;

  submethod BUILD ( :$gtk-combo-text ) {
    self.setGtkComboBoxText($gtk-combo-text)
      if $gtk-combo-text
  }

  method setGtkComboBoxText (GtkComboBoxTextAncestry $_) {
    my $to-parent;

    $!gcbt = do {
      when GtkComboBoxText {
        $to-parent = cast(GtkComboBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkComboBoxText, $_);
      }
    }
    self.setGtkComboBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkComboBoxText
    is also<GtkComboBoxText>
  { $!gcbt }

  multi method new (
    $gtk-combo-text where * ~~ GtkComboBoxTextAncestry,

    :$ref = True
  ) {
    return unless $gtk-combo-text;

    my $o = self.bless( :$gtk-combo-text );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *@items, *%a ) {
    my $gtk-combo-text = gtk_combo_box_text_new();

    my $o = $gtk-combo-text ?? self.bless( :$gtk-combo-text ) !! Nil;
    if $o {
      $o.setAttributes(%a) if +%a;
      $o.append_text($_) for @items;
    }
    $o
  }

  method new_with_entry ( *%a ) is also<new-with-entry> {
    my $gtk-combo-text = gtk_combo_box_text_new_with_entry();

    my $o = $gtk-combo-text ?? self.bless( :$gtk-combo-text ) !! Nil;
    $o.setAttributes(%a) if +%a;
    $o
  }

  method append (Str() $id, Str() $text) {
    gtk_combo_box_text_append($!gcbt, $id, $text);
  }

  method append_text (Str() $text) is also<append-text> {
    gtk_combo_box_text_append_text($!gcbt, $text);
  }

  method get_active_text is also<get-active-text> {
    gtk_combo_box_text_get_active_text($!gcbt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_combo_box_text_get_type, $n, $t );
  }

  method insert (Int() $position, Str() $id, Str() $text) {
    my gint $p = $position;

    gtk_combo_box_text_insert($!gcbt, $p, $id, $text);
  }

  method insert_text (Int() $position, Str() $text) is also<insert-text> {
    gtk_combo_box_text_insert_text($!gcbt, $position, $text);
  }

  method prepend (Str() $id, Str() $text) {
    gtk_combo_box_text_prepend($!gcbt, $id, $text);
  }

  method prepend_text (Str() $text) is also<prepend-text> {
    gtk_combo_box_text_prepend_text($!gcbt, $text);
  }

  method remove (Int() $position) {
    my gint $p = $position;

    gtk_combo_box_text_remove($!gcbt, $p);
  }

  method remove_all is also<remove-all> {
    gtk_combo_box_text_remove_all($!gcbt);
  }

}

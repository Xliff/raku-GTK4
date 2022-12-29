use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text::Tag::Table:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::TextTagTable:ver<4>;

our subset GtkTextTagTableAncestry is export of Mu
  where GtkTextTagTable | GObject;

class GTK::Text::Tag::Table:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::TextTagTable;

  has GtkTextTagTable $!gtk-ttt is implementor;

  submethod BUILD ( :$gtk-tag-table ) {
    self.setGtkTextTagTable($gtk-tag-table)
      if $gtk-tag-table
  }

  method setGtkTextTagTable (GtkTextTagTableAncestry $_) {
    my $to-parent;

    $!gtk-ttt = do {
      when GtkTextTagTable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTextTagTable, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTextTagTable
    is also<GtkTextTagTable>
  { $!gtk-ttt }

  multi method new (
     $gtk-tag-table where * ~~ GtkTextTagTableAncestry,

    :$ref = True
  ) {
    return unless $gtk-tag-table;

    my $o = self.bless( :$gtk-tag-table );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-tag-table = gtk_text_tag_table_new();

    $gtk-tag-table ?? self.bless( :$gtk-tag-table ) !! Nil;
  }

  method Tag-Added is also<Tag_Added> {
    self.connect-tag($!gtk-ttt, 'tag-added');
  }

  method Tag-Changed is also<Tag_Changed> {
    self.connect-tag-changed($!gtk-ttt);
  }

  method Tag-Removed is also<Tag_Removed> {
    self.connect-tag($!gtk-ttt, 'tag-removed');
  }

  method add (GtkTextTag() $tag) {
    gtk_text_tag_table_add($!gtk-ttt, $tag);
  }

  method foreach (&func, gpointer $data = gpointer) {
    gtk_text_tag_table_foreach($!gtk-ttt, &func, $data);
  }

  method get_size is also<get-size> {
    gtk_text_tag_table_get_size($!gtk-ttt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_tag_table_get_type, $n, $t );
  }

  method lookup (Str() $name, :$raw = False) {
    propReturnObject(
      gtk_text_tag_table_lookup($!gtk-ttt, $name),
      $raw,
      |GTK::Text::Tag.getTypePair
    );
  }

  method remove (GtkTextTag() $tag) {
    gtk_text_tag_table_remove($!gtk-ttt, $tag);
  }

}

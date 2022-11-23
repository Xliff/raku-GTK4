use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Model:ver<4>;

use GLib::Roles::Implementor;

class GTK::Tree::Path:ver<4> {
  also does GLib::Roles::Implementor;

  has GtkTreePath $!gtk-tp is implementor;

  submethod BUILD ( :$gtk-tree-path ) {
    $!gtk-tp = $gtk-tree-path if $gtk-tree-path;
  }

  method GTK::Raw::Definitions::GtkTreePath
  { $!gtk-tp }

  method new {
    my $gtk-tree-path = gtk_tree_path_new();

    $gtk-tree-path ?? self.bless( :$gtk-tree-path ) !! Nil
  }

  method new_first {
    my $gtk-tree-path = gtk_tree_path_new_first();

    $gtk-tree-path ?? self.bless( :$gtk-tree-path ) !! Nil
  }

  method new_from_indices (*@indices) {
    self.new_from_indicesv(@indices);
  }

  proto method new_from_indicesv (|)
  { * }

  multi method new_from_indicesv (@indices) {
    samewith(
      ArrayToCArray(gint, @indices),
      @indices.elems
    );
  }
  multi method new_from_indicesv (
    CArray[gint] $indices,
    Int()        $length
  ) {
    my gsize $l = $length;

    my $gtk-tree-path = gtk_tree_path_new_from_indicesv($indices, $l);

    $gtk-tree-path ?? self.bless( :$gtk-tree-path ) !! Nil
  }

  method new_from_string (Str() $string) {
    my $gtk-tree-path = gtk_tree_path_new_from_string($string);

    $gtk-tree-path ?? self.bless( :$gtk-tree-path ) !! Nil
  }

  method append_index (Int() $index) {
    my gint $i = $index;

    gtk_tree_path_append_index($!gtk-tp, $i);
  }

  method compare (GtkTreePath() $b) {
    so gtk_tree_path_compare($!gtk-tp, $b);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_tree_path_copy($!gtk-tp),
      $raw,
      |self.getTypePair
    )
  }

  method down {
    gtk_tree_path_down($!gtk-tp);
  }

  method free {
    gtk_tree_path_free($!gtk-tp);
  }

  method get_depth {
    gtk_tree_path_get_depth($!gtk-tp);
  }

  method get_indices ( :$carray = False ) {
    my $ca = gtk_tree_path_get_indices($!gtk-tp);
    return $ca if $carray;
    CArrayToArray($ca, self.get_depth);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_path_get_type, $n, $t );
  }

  method is_ancestor (GtkTreePath() $descendant) {
    gtk_tree_path_is_ancestor($!gtk-tp, $descendant);
  }

  method is_descendant (GtkTreePath() $ancestor) {
    gtk_tree_path_is_descendant($!gtk-tp, $ancestor);
  }

  method next {
    gtk_tree_path_next($!gtk-tp);
  }

  method prepend_index (
        gint        $index_
  ) {
    gtk_tree_path_prepend_index($!gtk-tp, $index_);
  }

  method prev {
    gtk_tree_path_prev($!gtk-tp);
  }

  method to_string {
    gtk_tree_path_to_string($!gtk-tp);
  }

  method up {
    gtk_tree_path_up($!gtk-tp);
  }

}

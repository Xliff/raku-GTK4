use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Model:ver<4>;

use GLib::Roles::Implementor;

class GTK::Tree::Iter {
  also does GLib::Roles::Implementor;

  has GtkTreeIter  $!gtk-ti is implementor handles<raku>;
  has GtkTreeModel $!gtk-tm;

  submethod BUILD (
    :$gtk-tree-model,
    :gtk-tree-iter( :$!gtk-ti)
  ) {
    $!gtk-tm = $gtk-tree-model if $gtk-tree-model;
  }

  method GTK::Raw::Structs::GtkTreeIter
    is also<GtkTreeIter>
  { $!gtk-ti }

  multi method new ( $gtk-tree-iter where *.^can('GtkTreeIter') ) {
    samewith($gtk-tree-iter.GtkTreeIter);
  }
  multi method new (GtkTreeIter $gtk-tree-iter) {
    $gtk-tree-iter ?? self.bless( :$gtk-tree-iter ) !! Nil;
  }
  multi method new ($gtk-tree-model is copy) {
    return Nil unless $gtk-tree-model;

    $gtk-tree-model .= GtkTreeModel if $gtk-tree-model.^can('GtkTreeModel');

    X::GLib::InvalidValue.new(
      message => 'Parameter must be GtkTreeModel-compatible!'
    ).throw unless $gtk-tree-model ~~ GtkTreeModel;

    my $gtk-tree-iter = GtkTreeIter.new;

    self.bless(
      :$gtk-tree-model,
      :$gtk-tree-iter
    );
  }

  method setTreeModel (GtkTreeModel() $tree-model) {
    $!gtk-tm = $tree-model;
  }

  method copy ( :$raw = False ) {
    my $o = propReturnObject(
      gtk_tree_iter_copy($!gtk-ti),
      $raw,
      |self.getTypePair
    );
    $o.setTreeModel($!gtk-tm);
    $o
  }

  method free {
    gtk_tree_iter_free($!gtk-ti);
  }

  method children (GtkTreeIter() $parent)
    is also<
      first_child_of
      first-child-of
    >
  {
    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    gtk_tree_model_iter_children($!gtk-tm, $!gtk-ti, $parent);
  }

  method has_child is also<has-child> {
    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    so gtk_tree_model_iter_has_child($!gtk-tm, $!gtk-ti);
  }

  method n_children is also<n-children> {
    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    gtk_tree_model_iter_n_children($!gtk-tm, $!gtk-ti);
  }

  method next {
    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    gtk_tree_model_iter_next($!gtk-tm, $!gtk-ti);
  }

  method nth_child (GtkTreeIter()  $parent, Int() $n)
    is also<
      nth-child
      nth_child_of
      nth-child-of
    >
  {
    my gint $nn = $n;

    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    gtk_tree_model_iter_nth_child($!gtk-tm, $!gtk-ti, $parent, $nn);
  }

  method parent (GtkTreeIter() $child)
    is also<
      parent_of
      parent-of
    >
  {
    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    gtk_tree_model_iter_parent($!gtk-tm, $!gtk-ti, $child);
  }

  method previous {
    $*ERR.say: 'Model not set!';
    return Nil unless $!gtk-tm;
    gtk_tree_model_iter_previous($!gtk-tm, $!gtk-ti);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_iter_get_type, $n, $t )
  }

}

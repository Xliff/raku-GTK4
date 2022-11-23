use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Model:ver<4>;

class GTK::Tree::Iter {
  has GtkTreeModel $!gtk-tm;
  has GtkTreeIter  $!gtk-ti is implementor;

  submethod BUILD (
    :gtk-tree-model(:$!gtk-tm),
    :gtk-tree-iter( :$!gtk-ti)
  ) { }

  multi method new (GtkTreeIter $gtk-tree-iter, :$ref = True, :$gtk-tree-model) {
    return Nil unless $gtk-tree-iter;

    my $o = self.bless(
      :$gtk-tree-model,
      :$gtk-tree-iter
    );
    #$o.ref if $ref;
    $o;
  }
  multi method new (GtkTreeModel() $gtk-tree-model) {
    return Nil unless $gtk-tree-model;

    my $gtk-tree-iter = GtkTreeIter.new;

    self.bless(
      :$gtk-tree-model,
      :$gtk-tree-iter
    );
  }

  method children (GtkTreeIter() $parent)
    is also<
      first_child_of
      first-child-of
    >
  {
    gtk_tree_model_iter_children($!gtk-tm, $!gtk-ti, $parent);
  }

  method has_child is also<has-child> {
    so gtk_tree_model_iter_has_child($!gtk-tm, $!gtk-ti);
  }

  method n_children is also<n-children> {
    gtk_tree_model_iter_n_children($!gtk-tm, $!gtk-ti);
  }

  method next {
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

    gtk_tree_model_iter_nth_child($!gtk-tm, $!gtk-ti, $parent, $nn);
  }

  method parent (GtkTreeIter() $child)
    is also<
      parent_of
      parent-of
    >
  {
    gtk_tree_model_iter_parent($!gtk-tm, $!gtk-ti, $child);
  }

  method previous {
    gtk_tree_model_iter_previous($!gtk-tm, $!gtk-ti);
  }

}

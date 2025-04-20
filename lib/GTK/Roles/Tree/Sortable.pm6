use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Sortable:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Tree::Sortable:ver<4> {
  has GtkTreeSortable $!gtk-ts is implementor;

  method GTK::Raw::Definitions::GtkTreeSortable { $!gtk-ts }
  method GtkTreeSortable                        { $!gtk-ts }

  method roleInit-GtkTreeSortable {
    return if $!gtk-ts;

    my \i    = findProperImplementor(self.^attributes);
    $!gtk-ts = cast( GtkTreeSortable, i.get_value(self) );
  }

  proto method get_sort_column_id (|)
  { * }

  multi method get_sort_column_id {
    samewith($, $)
  }
  multi method get_sort_column_id (
    $sort_column_id is rw,
    $order          is rw
  ) {
    my gint        $s = 0;
    my GtkSortType $o = 0;

    gtk_tree_sortable_get_sort_column_id($!gtk-ts, $s, $o);
    ($sort_column_id, $order) = ($s, $o);
  }

  method gtktreesortable_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_sortable_get_type, $n, $t );
  }

  method has_default_sort_func {
    so gtk_tree_sortable_has_default_sort_func($!gtk-ts);
  }

  method set_default_sort_func (
             &sort_func,
    gpointer $user_data  = gpointer,
             &destroy    = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gtk_tree_sortable_set_default_sort_func(
      $!gtk-ts,
      &sort_func,
      $user_data,
      &destroy
    );
  }

  method set_sort_column_id (
    gint            $sort_column_id,
    GtkSortType     $order
  ) {
    my gint        $s = $sort_column_id;
    my GtkSortType $o = $order;

    gtk_tree_sortable_set_sort_column_id($!gtk-ts, $s, $o);
  }

  method set_sort_func (
    Int()    $sort_column_id,
             &sort_func,
    gpointer $user_data,
             &destroy          = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    my gint $s = $sort_column_id;

    gtk_tree_sortable_set_sort_func(
      $!gtk-ts,
      $s,
      &sort_func,
      $user_data,
      &destroy
    );
  }

  method sort_column_changed {
    gtk_tree_sortable_sort_column_changed($!gtk-ts);
  }

}

our subset GtkTreeSortableAncestry is export of Mu
  where GtkTreeSortable | GObject;

class GTK::Tree::Sortable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Tree::Sortable;

  submethod BUILD ( :$gtk-tree-sortable ) {
    self.setGtkTreeSortable($gtk-tree-sortable) if $gtk-tree-sortable
  }

  method setGtkTreeSortable (GtkTreeSortableAncestry $_) {
    my $to-parent;

    $!gtk-ts = do {
      when GtkTreeSortable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeSortable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
    $gtk-tree-sortable where * ~~ GtkTreeSortableAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-sortable;

    my $o = self.bless( :$gtk-tree-sortable );
    $o.ref if $ref;
    $o;
  }

}

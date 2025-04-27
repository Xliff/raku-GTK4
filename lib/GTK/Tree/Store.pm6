use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::Tree::Store;

use GLib::Value;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTreeStoreAncestry is export of Mu
  where GtkTreeStore | GObject;

class GTK::Tree::Store:ver<4> {
  also does GLib::Roles::Object;

  has GtkTreeStore $!gtk-ts is implementor;

  submethod BUILD ( :$gtk-tree-store ) {
    self.setGtkTreeStore($gtk-tree-store) if $gtk-tree-store
  }

  method setGtkTreeStore (GtkTreeStoreAncestry $_) {
    my $to-parent;

    $!gtk-ts = do {
      when GtkTreeStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeStore, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeStore
    is also<GtkTreeStore>
  { $!gtk-ts }

  multi method new (
    $gtk-tree-store where * ~~ GtkTreeStoreAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-store;

    my $o = self.bless( :$gtk-tree-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (@types) {
    self.newv(@types);
  }
  multi method new (CArray[GType] $types) {
    self.newv($types);
  }

  multi method newv (@types) {
    samewith( @types.elems, ArrayToCArray(GType, @types) );
  }
  multi method newv (CArray[GType] $types) {
    gtk_tree_store_newv($!gtk-ts, $types);
  }

  method append (GtkTreeIter() $iter, GtkTreeIter() $parent) {
    gtk_tree_store_append($!gtk-ts, $iter, $parent);
  }

  method clear {
    gtk_tree_store_clear($!gtk-ts);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_store_get_type, $n, $t );
  }

  method insert (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    Int()         $position
  ) {
    my gint $p = $position;

    gtk_tree_store_insert($!gtk-ts, $iter, $parent, $p);
  }

  method insert_after (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    GtkTreeIter() $sibling
  )
    is also<insert-after>
  {
    gtk_tree_store_insert_after($!gtk-ts, $iter, $parent, $sibling);
  }

  method insert_before (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    GtkTreeIter() $sibling
  )
    is also<insert-before>
  {
    gtk_tree_store_insert_before($!gtk-ts, $iter, $parent, $sibling);
  }

  proto method insert_with_valuesv (|)
    is also<insert-with-valuesv>
  { * }

  multi method insert_with_valuesv (
     $iter,
     $parent,
     $position,
     @columns,
     @values,
    :$signed   = False,
    :$double   = True
  ) {
    samewith(
      $iter,
      $parent,
      $position,
      ArrayToCArray(gint, @columns),
      ArrayToCArray( GValue, valueToGValue(@values, :$signed, :$double) ),
      @values.elems
    );
  }
  multi method insert_with_valuesv (
    GtkTreeIter()           $iter,
    GtkTreeIter()           $parent,
    Int()                   $position,
    CArray[gint]            $columns,
    CArray[Pointer[GValue]] $values,
    Int()                   $n_values
  ) {
    my gint $p = $position;

    gtk_tree_store_insert_with_valuesv(
      $!gtk-ts,
      $iter,
      $parent,
      $position,
      $columns,
      $values,
      $n_values
    );
  }

  method is_ancestor (GtkTreeIter() $iter, GtkTreeIter() $descendant)
    is also<is-ancestor>
  {
    gtk_tree_store_is_ancestor($!gtk-ts, $iter, $descendant);
  }

  method iter_depth (GtkTreeIter() $iter) is also<iter-depth> {
    gtk_tree_store_iter_depth($!gtk-ts, $iter);
  }

  method iter_is_valid (GtkTreeIter() $iter) is also<iter-is-valid> {
    gtk_tree_store_iter_is_valid($!gtk-ts, $iter);
  }

  method move_after (GtkTreeIter() $iter, GtkTreeIter() $position)
    is also<move-after>
  {
    gtk_tree_store_move_after($!gtk-ts, $iter, $position);
  }

  method move_before (GtkTreeIter() $iter, GtkTreeIter() $position)
    is also<move-before>
  {
    gtk_tree_store_move_before($!gtk-ts, $iter, $position);
  }

  method prepend (GtkTreeIter() $iter, GtkTreeIter() $parent) {
    gtk_tree_store_prepend($!gtk-ts, $iter, $parent);
  }

  method remove (GtkTreeIter() $iter) {
    gtk_tree_store_remove($!gtk-ts, $iter);
  }

  multi method reorder ($parent, @new-order) {
    samewith( $parent, ArrayToCArray(gint, @new-order) )
  }
  multi method reorder (GtkTreeIter() $parent, CArray[gint] $new_order) {
    gtk_tree_store_reorder($!gtk-ts, $parent, $new_order);
  }

  proto method set_column_types (|)
    is also<set-column-types>
  { * }

  multi method set_column_types (@types) {
    samewith(
      @types.elems,
      ArrayToCArray(GType, @types)
    );
  }
  multi method set_column_types (Int() $n_columns, CArray[GType] $types) {
    my gint $n = $n_columns;

    gtk_tree_store_set_column_types($!gtk-ts, $n, $types);
  }

  method set_value (
    GtkTreeIter()  $iter,
    Int()          $column,
                   $value,
                  :$signed  = False,
                  :$double  = True
  )
    is also<set-value>
  {
    my gint $c = $column;

    my $v = do given $value {
      when .^can('GValue').not {
        valueToGValue($_, :$signed, :$double);
        proceed
      }
      when .^can('GValue') {
        .GValue
      }
      default {
        X::GLib::WTF.new.throw
      }
    }

    gtk_tree_store_set_value($!gtk-ts, $iter, $column, $v);
  }

  proto method set_valuesv (|)
    is also<set-valuesv>
  { * }

  multi method set_valuesv (
     $iter,
     @columns,
     @values,
    :$signed   = False,
    :$double   = True
  ) {
    samewith(
      $iter,
      ArrayToCArray(gint, @columns),
      ArrayToCArray(
        GValue,
        @values.map( valueToGValue($_, :$signed, :$double) )
      ),
      @values.elems
    );
  }
  multi method set_valuesv (
    GtkTreeIter()           $iter,
    CArray[gint]            $columns,
    CArray[Pointer[GValue]] $values,
    Int()                   $n_values
  ) {
    my gint $n = $n_values;

    gtk_tree_store_set_valuesv($!gtk-ts, $iter, $columns, $values, $n);
  }

  method swap (GtkTreeIter() $a,GtkTreeIter() $b) {
    gtk_tree_store_swap($!gtk-ts, $a, $b);
  }

}

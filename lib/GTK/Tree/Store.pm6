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

  multi method newv (@types is copy) {
    @types .= map({
      when    .defined   { $_ }
      when    $_ === Nil { G_TYPE_NONE }
      default            { GLib::Value.gTypeFromType($_) }
    });

    samewith( @types.elems, ArrayToCArray(GType, @types) );
  }
  multi method newv (CArray[GType] $types) {
    gtk_tree_store_newv($!gtk-ts, $types);
  }

  multi method append ($parent, :$raw = False) {
    samewith(GtkTreeIter.new, $parent, :$raw);
  }
  multi method append (
    GtkTreeIter()  $iter,
    GtkTreeIter()  $parent = GtkTreeIter,
                  :$raw    = False
  ) {
    gtk_tree_store_append($!gtk-ts, $iter, $parent);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  method clear {
    gtk_tree_store_clear($!gtk-ts);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_store_get_type, $n, $t );
  }

  multi method insert (
     $position,
    :$parent,
    :$iter       = GtkTreeIter.new,
    :$raw        = False
  ) {
    samewith($iter, $parent, $position, :$raw);
  }
  multi method insert (
     $iter,
     $position,
    :$parent    = GtkTreeIter,
    :$raw       = False
  ) {
    samewith($iter, $parent, $position, :$raw);
  }
  method insert (
    GtkTreeIter()  $iter,
    GtkTreeIter()  $parent,
    Int()          $position,
                  :$raw       = False
  ) {
    my gint $p = $position;

    gtk_tree_store_insert($!gtk-ts, $iter, $parent, $p);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  proto method insert_after (|)
    is also<insert-after>
  { * }

  multi method insert_after (
     $iter,
     $sibling,
    :$parent   = GtkTreeIter,
    :$raw      = False
  ) {
    samewith($iter, $parent, $sibling);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }
  multi method insert_after (
    GtkTreeIter()  $iter,
    GtkTreeIter()  $parent,
    GtkTreeIter()  $sibling,
                  :$raw      = False
  ) {
    gtk_tree_store_insert_after($!gtk-ts, $iter, $parent, $sibling);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  proto method insert_before (|)
    is also<insert-before>
  { * }

  multi method insert_before (
     $iter,
     $sibling,
    :$parent   = GtkTreeIter,
    :$raw      = False
  ) {
    samewith($iter, GtkTreeIter, $sibling, :$raw = False);
  }
  multi method insert_before (
    GtkTreeIter()  $iter,
    GtkTreeIter()  $parent,
    GtkTreeIter()  $sibling,
                  :$raw      = False
  ) {
    gtk_tree_store_insert_before($!gtk-ts, $iter, $parent, $sibling);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  proto method insert_with_valuesv (|)
    is also<insert-with-valuesv>
  { * }

  multi method insert_with_valuesv (
     $iter,
     $position,
     @columns,
     @values,
    :$parent     = GtkTreeIter
    :$signed     = False,
    :$double     = True
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

  method prepend ($parent, :$raw = False) {
    samewith(GtkTreeIter.new, $parent, :$raw);
  }
  method prepend (
    GtkTreeIter()  $iter,
    GtkTreeIter()  $parent = GtkTreeIter,
                  :$raw    = False
  ) {
    gtk_tree_store_prepend($!gtk-ts, $iter, $parent);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
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

  method !preSet (@col-vals --> Nil) {
    X::GLib::InvalidValues.new(
      message => "You must specify column number anc column value in {
       '' }the argument list. The list received does not have an even {
       '' }number of elements!"
    ).throw unless @col-vals %% 2;

    my @cv = @col-vals.rotor(2);
    @*c    = @cv.map( *.head );
    @*v    = @cv.map( *.tail );
  }

  method !postSet ( :$signed, :$double ) {
    $.set_valuesv($*i, @*c, @*v, :$signed, :$double);
  }

  multi method set (
     @values,
    :$prepend is required,
    :$parent               = GtkTreeIter,
    :$signed               = False,
    :$double               = True
  ) {
    samewith( |@values.kv, :$prepend, :$signed, :$double, :$parent );
  }
  multi method set (
     @values,
    :$append is required,
    :$parent               = GtkTreeIter,
    :$signed               = False,
    :$double               = True
  ) {
    samewith( |@values.kv, :$append, :$signed, :$double, :$parent);
  }
  multi method set (
     *@col-vals,
    :a(:$append) is required,
    :$signed                  = False,
    :$double                  = True,
    :$parent                  = GtkTreeIter
  ) {
    my (@*c, @*v);

    $append = GtkTreeIter.new if $append !~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.append($append, $parent);
    $*i.gist.say;
    self!postSet(:$signed, :$double);
  }
  multi method set (
     *@col-vals,
    :p(:$prepend) is required,
    :$signed                   = False,
    :$double                   = True,
    :$parent                   = GtkTreeIter
  ) {
    my (@*c, @*v);

    $prepend = GtkTreeIter.new if $prepend !~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.prepend($prepend, $parent);
    self!postSet(:$signed, :$double);
  }
  multi method set (
     *@col-vals,
    :$signed                   = False,
    :i(:$insert) is required,
    :$double                   = True,
    :$parent                   = GtkTreeIter
  ) {
    my (@*c, @*v);

    $insert = GtkTreeIter.new if $insert !~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.insert($insert, $parent);
    self!postSet(:$signed, :$double);
  }
  multi method set (
     *@col-vals,
    :$signed                   = False,
    :aft(:$after) is required,
    :$double                   = True,
    :$parent                   = GtkTreeIter,
    :sib(:$sibling)            = GtkTreeIter
  ) {
    my (@*c, @*v);

    $after = GtkTreeIter.new if $after !~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.insert_after($after, $parent, $sibling);
    self!postSet(:$signed, :$double);
  }
  multi method set (
     *@col-vals,
    :$signed                   = False,
    :b(:$before) is required,
    :$double                   = True,
    :$parent                   = GtkTreeIter,
    :sib(:$sibling)            = GtkTreeIter
  ) {
    my (@*c, @*v);

    $before = GtkTreeIter.new if $before !~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.insert_before($before, $parent, $sibling);
    self!postSet(:$signed, :$double);
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

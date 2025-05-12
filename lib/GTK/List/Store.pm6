use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::List::Store:ver<4>;

use GLib::Value;
use GTK::Tree::Iter:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;
use GTK::Roles::Tree::DnD:ver<4>;
use GTK::Roles::Tree::Model:ver<4>;
use GTK::Roles::Tree::Sortable:ver<4>;

our subset GtkListStoreAncestry is export of Mu
  where GtkListStore    |
        GtkTreeDragDest | GtkTreeDragSource |
        GtkTreeModel    |
        GtkTreeSortable | GObject;

class GTK::List::Store:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Tree::Drag::Dest;
  also does GTK::Roles::Tree::Drag::Source;
  also does GTK::Roles::Tree::Model;
  also does GTK::Roles::Tree::Sortable;

  has GtkListStore $!gls is implementor;

  submethod BUILD ( :$gtk-list-store ) {
    self.setGtkListStore($gtk-list-store) if $gtk-list-store
  }

  method setGtkListStore (GtkListStoreAncestry $_) {
    my $to-parent;

    $!gls = do {
      when GtkListStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkTreeDragDest {
        $!gtk-td = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkListStore, $_);
      }

      when GtkTreeDragSource {
        $!gtk-tsrc = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkListStore, $_);
      }

      when GtkTreeModel {
        $!gtk-tm = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkListStore, $_);
      }

      when GtkTreeSortable {
        $!gtk-tsort = $_;
        $to-parent  = cast(GObject, $_);
        cast(GtkListStore, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkListStore, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkTreeDragDest;
    self.roleInit-GtkTreeDragSource;
    self.roleInit-GtkTreeModel;
    self.roleInit-GtkTreeSortable;
  }

  method GTK::Raw::Definitions::GtkListStore
    is also<GtkListStore>
  { $!gls }

  proto method new (|)
  { * }

  multi method new (
    $gtk-list-store where * ~~ GtkListStoreAncestry,

    :$ref = True
  ) {
    return unless $gtk-list-store;

    my $o = self.bless( :$gtk-list-store );
    $o.ref if $ref;
    $o;
  }

  has $!columns is built;

  multi method new (Int() $n_columns) {
    my gint $n = $n_columns;

    my $gtk-list-store = gtk_list_store_new($n, Str);

    $gtk-list-store ?? self.bless( :$gtk-list-store ) !! Nil;
  }
  multi method new (@types) {
    self.newv(@types);
  }
  multi method new (*@types where *.elems > 1) {
    samewith(@types);
  }

  multi method newv (@types is copy) {
    @types .= map({
      when    .defined   { $_ }
      when    $_ === Nil { G_TYPE_NONE }
      default            { GLib::Value.gtypeFromType($_) }
    });

    samewith( @types.elems, ArrayToCArray(GType, @types) );
  }
  multi method newv (Int() $n_columns, CArray[GType] $types) {
    my gint $n = $n_columns;

    my $gtk-list-store = gtk_list_store_newv($n, $types);

    $gtk-list-store ?? self.bless( :$gtk-list-store ) !! Nil;
  }

  multi method append {
    samewith(GtkTreeIter.new);
  }
  multi method append (GtkTreeIter() $iter, :$raw = False) {
    gtk_list_store_append($!gls, $iter);
    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  method clear {
    gtk_list_store_clear($!gls);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_store_get_type, $n, $t );
  }

  method insert (
    GtkTreeIter() $iter,
    Int()         $position
  ) {
    my gint $p = $position;

    gtk_list_store_insert($!gls, $iter, $p);
  }

  method insert_after (GtkTreeIter() $iter, GtkTreeIter() $sibling)
    is also<insert-after>
  {
    gtk_list_store_insert_after($!gls, $iter, $sibling);
  }

  method insert_before (GtkTreeIter() $iter, GtkTreeIter() $sibling)
    is also<insert-before>
  {
    gtk_list_store_insert_before($!gls, $iter, $sibling);
  }

  proto method insert_with_valuesv (|)
    is also<insert-with-valuesv>
  { * }

  multi method insert_with_valuesv (
    GtkTreeIter() $iter,
    Int()         $position,
                  @columns,
    GValue()      $values,
  ) {
    samewith(
      $iter,
      $position,
      ArrayToCArray(gint, @columns),
      $values,
      @columns.elems
    );
  }
  multi method insert_with_valuesv (
    GtkTreeIter() $iter,
    Int()         $position,
    CArray[gint]  $columns,
    GValue()      $values,
    Int()         $n_values
  ) {
    my gint ($p, $n) = ($position, $n_values);

    gtk_list_store_insert_with_valuesv(
      $!gls,
      $iter,
      $p,
      $columns,
      $values,
      $n
    );
  }

  method iter_is_valid (GtkTreeIter() $iter) is also<iter-is-valid> {
    gtk_list_store_iter_is_valid($!gls, $iter);
  }

  method move_after (GtkTreeIter() $iter, GtkTreeIter() $position)
    is also<move-after>
  {
    gtk_list_store_move_after($!gls, $iter, $position);
  }

  method move_before (GtkTreeIter() $iter, GtkTreeIter() $position)
    is also<move-before>
  {
    gtk_list_store_move_before($!gls, $iter, $position);
  }

  method prepend (GtkTreeIter()  $iter) {
    gtk_list_store_prepend($!gls, $iter);
  }

  method remove (GtkTreeIter() $iter) {
    gtk_list_store_remove($!gls, $iter);
  }

  multi method reorder (@new-order) {
    samewith( ArrayToCArray(gint, @new-order) )
  }
  multi method reorder (CArray[gint] $new_order) {
    gtk_list_store_reorder($!gls, $new_order);
  }

  proto method set_column_types (|)
    is also<set-column-types>
  { * }

  multi method set_column_types (@types) {
    samewith(
      @types.elems,
      ArrayToCArray(GType, @types);
    );
  }
  multi method set_column_types (
    Int()          $n_columns,
    CArray[GType]  $types
  ) {
    my gint $n = $n_columns;

    $!columns = $n;

    gtk_list_store_set_column_types($!gls, $n, $types);
  }

  method !preSet (@col-vals --> Nil) {
    unless @col-vals %% 2 {
      my $lv = @col-vals.map({ .defined ?? $_ !! .^name }).join(', ');
      X::GLib::InvalidValue.new(
        message => "You must specify column number and column value in {
         '' }the argument list. The list received does not have an even {
         '' }number of elements! List elements were: ({ $lv })"
      ).throw unless @col-vals %% 2;
    }

    my @cv = @col-vals.rotor(2);
    @*c    = @cv.map( *.head );
    @*v    = @cv.map( *.tail );
  }

  method !postSet {
    $.set_valuesv($*i, @*c, @*v);
  }

  multi method set (*@col-vals, :a(:$append) is required is copy where *.so) {
    my (@*c, @*v);

    $append = $append.GtkTreeIter if $append.^can('GtkTreeIter');
    $append = GtkTreeIter.new     if $append === True;

    X::GLib::InvalidValue.new(
      message => '<append> must be GtkTreeIter-compatible or True'
    ).throw unless $append ~~ GtkTreeIter;

    self!preSet(@col-vals.kv);
    my $*i = $.append($append);
    self!postSet;
    $*i;
  }
  multi method set (*@col-vals, :p(:$prepend) is required is copy where *.so) {
    my (@*c, @*v);

    $prepend = GtkTreeIter.new if $prepend !~~ GtkTreeIter;

    self!preSet(@col-vals.kv);
    my $*i = $.prepend($prepend);
    self!postSet;
    $*i;
  }
  multi method set (*@col-vals, :i(:$insert) is required is copy where *.so) {
    my (@*c, @*v);

    $insert = GtkTreeIter.new if $insert !~~ GtkTreeIter;

    self!preSet(@col-vals.kv);
    my $*i = $.insert($insert);
    self!postSet;
    $*i;
  }
  multi method set (*@col-vals, :b(:$before) is required is copy where *.so) {
    my (@*c, @*v);

    $before = GtkTreeIter.new if $before !~~ GtkTreeIter;

    self!preSet(@col-vals.kv);
    my $*i = $.insert_before($before);
    self!postSet;
    $*i;
  }
  multi method set (*@col-vals, :aft(:$after) is required is copy where *.so) {
    my (@*c, @*v);

    $after = GtkTreeIter.new if $after !~~ GtkTreeIter;

    self!preSet(@col-vals.kv);
    my $*i = $.insert_after($after);
    self!postSet;
    $*i;
  }

  method set_value (
    GtkTreeIter()  $iter,
    Int()          $column,
    GValue()       $value
  )
    is also<set-value>
  {
    my gint $c = $column;

    gtk_list_store_set_value($!gls, $iter, $c, $value);
  }

  proto method set_valuesv (|)
    is also<set-valuesv>
  { * }

  multi method set_valuesv (
    GtkTreeIter()  $iter,
                   @columns,
                   @values,
                  :$signed    = False,
                  :$double    = True
  ) {
    samewith(
      $iter,
      ArrayToCArray(guint, @columns),
      GLib::Roles::TypedBuffer[GValue].new(
        @values.Array.map({ valueToGValue($_, :$signed, :$double) })
      ).p,
      @columns.elems
    );
  }
  multi method set_valuesv (
    GtkTreeIter() $iter,
    CArray[guint] $columns,
    gpointer      $values,
    Int()         $n_values
  ) {
    my gint $n = $n_values;

    gtk_list_store_set_valuesv($!gls, $iter, $columns, $values, $n);
  }

  method swap (GtkTreeIter() $a, GtkTreeIter() $b) {
    gtk_list_store_swap($!gls, $a, $b);
  }

}

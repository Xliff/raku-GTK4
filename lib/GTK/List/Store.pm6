use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::List::Store:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;
use GTK::Roles::Tree::DnD:ver<4>;
use GTK::Roles::Tree::Model:ver<4>;
use GTK::Roles::Tree::Sortable:ver<4>;

our subset GtkListStoreAncestry is export of Mu
  where GtkListStore    |
        #GtkDragDest | GtkDragSource |
        GtkTreeModel |
        GtkTreeSortable | GObject;

class GTK::List::Store:ver<4> {
  also does GLib::Roles::Object;
  # also does GTK::Roles::Tree::Drag::Dest;
  # also does GTK::Roles::Tree::Drag::Source;
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

      # when GtkDragDest {
      #   $!gtk-dd = $_;
      #   $to-parent = cast(GObject, $_);
      #   cast(GtkListStore, $_);
      # }
      #
      # when GtkDragSource {
      #   $!gtk-ds = $_;
      #   $to-parent = cast(GObject, $_);
      #   cast(GtkListStore, $_);
      # }

      when GtkTreeModel {
        $!gtk-tm = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkListStore, $_);
      }

      when GtkTreeSortable {
        $!gtk-ts = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkListStore, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkListStore, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkDragDest;
    self.roleInit-GtkDragSource;
    self.roleInit-GtkTreeModel;
    self.roleInit-GtktreeSortable;
  }

  method GTK::Raw::Definitions::GtkListStore
    is also<GtkListStore>
  { $!gls }

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

  multi method newv (@types) {
    samewith( @types.elems, ArrayToCArray(GType, @types) );
  }
  multi method newv (Int() $n_columns, CArray[GType] $types) {
    my gint $n = $n_columns;

    my $gtk-list-store = gtk_list_store_newv($n, $types);

    $gtk-list-store ?? self.bless( :$gtk-list-store ) !! Nil;
  }

  method append (GtkTreeIter() $iter) {
    gtk_list_store_append($!gls, $iter);
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
    X::GLib::InvalidValues.new(
      message => "You must specify column number anc column value in {
       '' }the argument list. The list received does not have an even {
       '' }number of elements!"
    ).throw unless @col-vals %% 2;

    @*cv = @col-vals.rotor(2);
    @*c  = @cv.map( *.head );
    @*v  = @cv.map( *.tail );
  }

  method !postSet {
    $.set_valuesv($*i, $*c, $*v);
  }

  method set (*@col-vals, :a(:$append) is required) {
    my (@*cv, @*c, @*v);

    self!preSet(@col-vals);
    my $*i = $.append;
    self!postSet;
  }

  method set (*@col-vals, :p(:$prepend) is required) {
    my (@*cv, @*c, @*v);

    self!preSet(@col-vals);
    my $*i = $.prepend;
    self!postSet;
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
    GtkTreeIter() $iter,
                  @columns,
                  @values
  ) {
    samewith(
      $iter,
      ArrayToCArray(guint, @columns),
      @columns.elems,
      GLib::Roles::TypedBuffer[GValue].new(
        @values.map({ valueToGValue($_, :$signed, :$double) })
      ).p
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

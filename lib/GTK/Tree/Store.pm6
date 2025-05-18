use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::Tree::Store;

use GLib::Value;
use GTK::Tree::Iter:ver<4>;
use GTK::Roles::Tree::DnD:ver<4>;
use GTK::Roles::Tree::Model:ver<4>;
use GTK::Roles::Tree::Sortable:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;

our subset GtkTreeStoreAncestry is export of Mu
  where GtkTreeStore | GtkTreeDragDest | GtkTreeDragSource |
        GtkTreeModel | GtkTreeSortable | GObject;

class GTK::Tree::Store:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Tree::Drag::Dest;
  also does GTK::Roles::Tree::Drag::Source;
  also does GTK::Roles::Tree::Model;
  also does GTK::Roles::Tree::Sortable;

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
        cast(GtkTreeStore, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkTreeDragDest;
    self.roleInit-GtkTreeDragSource;
    self.roleInit-GtkTreeModel;
    self.roleInit-GtkTreeSortable;
  }

  method GTK::Raw::Definitions::GtkTreeStore
    is also<GtkTreeStore>
  { $!gtk-ts }

  proto method new (|)
  { * }

  multi method new (
    $gtk-tree-store where * ~~ GtkTreeStoreAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-store;

    my $o = self.bless( :$gtk-tree-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (*@types where *.elems > 1) {
    samewith(@types);
  }
  multi method new (@types) {
    self.newv(@types);
  }
  multi method new ($n, CArray[GType] $types) {
    self.newv($n, $types);
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

    my $gtk-tree-store = gtk_tree_store_newv($n, $types);

    $gtk-tree-store ?? self.bless( :$gtk-tree-store ) !! Nil;
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
     $position   = 0,
    :$parent     = GtkTreeIter,
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
    CONTROL {
      when CX::Warn {
        .message.say;
        .backtrace.concise.say;
        .resume
      }

      default {
        .rethrow
      }
    }

    samewith($iter, $parent, $position, :$raw);
  }
  multi method insert (
    GtkTreeIter()  $iter,
    GtkTreeIter()  $parent,
    Int()          $position,
                  :$raw       = False
  ) {
    CONTROL {
      when CX::Warn {
        .message.say;
        .backtrace.concise.say;
        .resume
      }

      default {
        .rethrow
      }
    }

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
    :$parent     = GtkTreeIter,
    :$signed     = False,
    :$double     = True
  ) {
    samewith(
      $iter,
      $parent,
      $position,
      ArrayToCArray(gint, @columns),
      GLib::Roles::TypedBuffer[GValue].new(
        @values.map( valueToGValue($_, :$signed, :$double) )
      ).p,
      @values.elems
    );
  }
  multi method insert_with_valuesv (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    Int()         $position,
    CArray[gint]  $columns,
    gpointer      $values,
    Int()         $n_values
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

  method model ( :$raw = False ) {
    propReturnObject( $.GtkTreeModel, $raw, |GTK::Tree::Model.getTypePair );
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

  multi method prepend ($parent, :$raw = False) {
    samewith(GtkTreeIter.new, $parent, :$raw);
  }
  multi method prepend (
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

  method !postSet ( :$signed, :$double ) {
    $.set_valuesv($*i, @*c, @*v, :$signed, :$double);
  }

  multi method set (
     @values,
    :p(:$prepend) is required is copy where *.so,
    :v(:$values)  is required         where *.so,
    :$parent                                      = GtkTreeIter,
    :$signed                                      = False,
    :$double                                      = True
  ) {
    samewith( |@values.kv, :$prepend, :$signed, :$double, :$parent );
  }
  multi method set (
     @values,
    :a(:$append) is required is copy where *.so,
    :v(:$values) is required         where *.so,
    :$parent                                     = GtkTreeIter,
    :$signed                                     = False,
    :$double                                     = True
  ) {
    samewith( |@values.kv, :$append, :$signed, :$double, :$parent);
  }
  multi method set (
     $position,
     @values,
    :i(:$insert) is required is copy where *.so,
    :v(:$values) is required         where *.so,
    :$parent                                      = GtkTreeIter,
    :$signed                                      = False,
    :$double                                      = True
  ) {
    samewith(
       $position,
      |@values.kv,
      :$insert,
      :$signed,
      :$double,
      :$parent
    );
  }
  multi method set (
     *@col-vals where *.elems > 1,
    :a(:$append) is required is copy where *.so,
    :$signed                                     = False,
    :$double                                     = True,
    :$parent                                     = GtkTreeIter
  ) {
    my (@*c, @*v);

    $append = $append.GtkTreeIter if $append.^can('GtkTreeIter');
    $append = GtkTreeIter.new     if $append === True;

    X::GLib::InvalidValue.new(
      message => '<append> must be GtkTreeIter-compatible or True'
    ).throw unless $append ~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.append($append, $parent);
    self!postSet(:$signed, :$double);
    $*i;
  }
  multi method set (
     *@col-vals,
    :p(:$prepend) is required is copy where *.so,
    :$signed                                      = False,
    :$double                                      = True,
    :$parent                                      = GtkTreeIter
  ) {
    my (@*c, @*v);

    $prepend = $prepend.GtkTreeIter if $prepend.^can('GtkTreeIter');
    $prepend = GtkTreeIter.new      if $prepend === True;

    X::GLib::InvalidValue.new(
      message => '<append> must be GtkTreeIter-compatible or True'
    ).throw unless $prepend ~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.prepend($prepend, $parent);
    self!postSet(:$signed, :$double);
  }
  multi method set (
    $position,
    *@col-vals,
    :i(:$insert) is required is copy where *.so,
    :$signed                                     = False,
    :$double                                     = True,
    :$parent                                     = GtkTreeIter
  ) {
    my (@*c, @*v);

    $insert = $insert.GtkTreeIter if $insert.^can('GtkTreeIter');
    $insert = GtkTreeIter.new     if $insert === True;

    X::GLib::InvalidValue.new(
      message => '<append> must be GtkTreeIter-compatible or True'
    ).throw unless $insert ~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.insert($insert, $parent, $position);
    self!postSet(:$signed, :$double);
  }
  multi method set (
     *@col-vals,
    :aft(:$after) is required is copy where *.so,
    :$signed                                      = False,
    :$double                                      = True,
    :$parent                                      = GtkTreeIter,
    :sib(:$sibling)                               = GtkTreeIter
  ) {
    my (@*c, @*v);

    $after = GtkTreeIter.new if $after !~~ GtkTreeIter;

    self!preSet(@col-vals);
    my $*i = $.insert_after($after, $parent, $sibling);
    self!postSet(:$signed, :$double);
  }
  multi method set (
     *@col-vals,
    :b(:$before) is required is copy where *.so,
    :$signed                                     = False,
    :$double                                     = True,
    :$parent                                     = GtkTreeIter,
    :sib(:$sibling)                              = GtkTreeIter
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
     @values   is copy,
    :$signed            = False,
    :$double            = True
  ) {
    @values = @values.map({
      valueToGValue($_, :$signed, :$double)
    });

    say "Setting the following: { @values.map({ "{ .value // '»NIL«' } ({
         .type( :fundamental ) })" }) }" if checkDEBUG(3);

    samewith(
      $iter,
      ArrayToCArray(gint, @columns),
      GLib::Roles::TypedBuffer[GValue].new(@values).p,
      @values.elems
    );
  }
  multi method set_valuesv (
    GtkTreeIter() $iter,
    CArray[gint]  $columns,
    gpointer      $values,
    Int()         $n_values
  ) {
    my gint $n = $n_values;

    gtk_tree_store_set_valuesv($!gtk-ts, $iter, $columns, $values, $n);
  }

  method swap (GtkTreeIter() $a,GtkTreeIter() $b) {
    gtk_tree_store_swap($!gtk-ts, $a, $b);
  }

}

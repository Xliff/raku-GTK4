use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Model:ver<4>;
use GTK::Raw::Tree::DnD:ver<4>;

use GDK::Content::Provider:ver<4>;
use GTK::Tree::Iter:ver<4>;
use GTK::Tree::Path:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Tree::Model {
  has GtkTreeModel $!gtk-tm is implementor;

  method GTK::Raw::Definitions::GtkTreeModel { $!gtk-tm }
  method GtkTreeModel                        { $!gtk-tm }

  method roleInit-GtkTreeModel {
    return if $!gtk-tm;

    my \i    = findProperImplementor(self.^attributes);
    $!gtk-tm = cast( GtkTreeModel, i.get_value(self) )
  }

  method create_row_drag_content (GtkTreePath() $path, :$raw = False) {
    propReturnObject(
      gtk_tree_create_row_drag_content($!gtk-tm, $path),
      $raw,
      |GDK::Content::Provider.getTypePair
    );
  }

  method foreach (&func, gpointer $user_data = gpointer) {
    gtk_tree_model_foreach($!gtk-tm, &func, $user_data);
  }

  method get (GtkTreeIter() $iter, Int() $type) {
    my GType $t = $type;

    my $v = (
      do given $t {
        when G_TYPE_UINT   { CArray[uint32] }
        when G_TYPE_INT    { CArray[int32]  }
        when G_TYPE_FLOAT  { CArray[num32]  }
        when G_TYPE_DOUBLE { CArray[num64]  }
        when G_TYPE_UINT64 { CArray[uint64] }
        when G_TYPE_INT64  { CArray[int64]  }
      }
    ).allocate(1);

    $v[0] = $t == (G_TYPE_FLOAT, G_TYPE_DOUBLE).any
      ?? 0e0
      !! 0;

    gtk_tree_model_get(
      $!gtk-tm,
      $iter,
      $type,
      cast(gpointer, $v),
      -1
    );

    $v[0]
  }

  method get_column_types {
    do for ^$.get_n_columns {
      $.get_column_type($_);
    }
  }

  method get_column_type (Int() $index, :$enum = True) {
    my gint $i = $index;

    my $e = gtk_tree_model_get_column_type($!gtk-tm, $i);
    return $e unless $enum;
    my $ap = GTypeEnum.enums.antipairs.Hash;
    if $ap{$e}:exists {
      return $ap{$e};
    }
    $e;
  }

  method get_flags ( :set(:$flags) = True ) {
    my $f = gtk_tree_model_get_flags($!gtk-tm);
    return $f unless $flags;
    getFlags(GtkTreeModelFlagsEnum, $f);
  }

  proto method get_iter (|)
  { * }

  multi method get_iter (GtkTreePath() $path, :$raw = False) {
    return-with-all( samewith(GtkTreeIter.new, $path, :$raw) );
  }
  multi method get_iter (
    GtkTreeIter()  $iter,
    GtkTreePath()  $path,
                  :$raw   = False
  ) {
    my $rv = gtk_tree_model_get_iter($!gtk-tm, $iter, $path);
    return Nil unless $rv;

    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  proto method get_iter_first (|)
  { * }

  multi method get_iter_first ( :$raw = False ) {
    return-with-all( samewith(GtkTreeIter.new, :$raw) );
  }
  multi method get_iter_first (GtkTreeIter() $iter, :$raw = False) {
    my $rv = gtk_tree_model_get_iter_first($!gtk-tm, $iter);
    return Nil unless $rv;

    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  proto method get_iter_from_string (|)
  { * }

  multi method get_iter_from_string (Str() $path_string, :$raw = False) {
    return-with-all( samewith(GtkTreeIter.new, $path_string, :$raw) );
  }
  multi method get_iter_from_string (
    GtkTreeIter()  $iter,
    Str()          $path_string,
                  :$raw          = False
  ) {
    my $rv = gtk_tree_model_get_iter_from_string(
      $!gtk-tm,
      $iter,
      $path_string
    );
    return Nil unless $rv;

    propReturnObject($iter, $raw, |GTK::Tree::Iter.getTypePair);
  }

  method get_n_columns {
    gtk_tree_model_get_n_columns($!gtk-tm);
  }
  method elems {
    $.get_n_columns
  }

  has $!gtk-tmi;
  method iter {
    $!gtk-tmi = GTK::Tree::Iter.new($!gtk-tm) unless $!gtk-tmi;

    $!gtk-tmi;
  }

  method path ( :$raw = False ) {
    $.get_path( :$raw );
  }
  multi method get_path ( :$raw = False ) {
    samewith(GtkTreeIter.new, :$raw);
  }
  multi method get_path (GtkTreeIter() $iter, :$raw = False) {
    propReturnObject(
      gtk_tree_model_get_path($!gtk-tm, $iter),
      $raw,
      |GTK::Tree::Path.getTypePair
    );
  }

  method get_string_from_iter (GtkTreeIter() $iter) {
    gtk_tree_model_get_string_from_iter($!gtk-tm, $iter);
  }

  method gtktreemodel_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_model_get_type, $n, $t );
  }


  proto method get_value (|)
  { * }

  multi method get_value (GtkTreeIter() $iter, Int() $column) {
    samewith(
      $iter,
      $column,
      GLib::Value.new( self.get_column_type($column) )
    );
  }
  multi method get_value (
    GtkTreeIter()  $iter,
    Int()          $column,
    GValue()       $val,
                  :$gvalue  = False
  ) {
    my gint $c = $column;

    gtk_tree_model_get_value($!gtk-tm, $iter, $column, $val);
    return $val if $gvalue;
    $val.value
  }

  method get_values (GtkTreeIter() $iter) {
    generate-iterator(
      self,
      SUB      { self.get_n_columns       },
      sub (\k) { self.get_value($iter, k) }
    )
  }

  method ref_node (GtkTreeIter() $iter) {
    gtk_tree_model_ref_node($!gtk-tm, $iter);
  }

  has $!gtk-tm-row;
  method row {
    $!gtk-tm-row = GTK::Tree::Model::Row.new(
      gtk-tm => $!gtk-tm
    ) without $!gtk-tm-row;

    $!gtk-tm-row;
  }

  has $!gtk-tm-rows;
  method rows {
    $!gtk-tm-rows = GTK::Tree::Model::Rows.new(
      gtk-tm => $!gtk-tm
    ) without $!gtk-tm-rows;

    $!gtk-tm-rows
  }

  method unref_node (GtkTreeIter() $iter) {
    gtk_tree_model_unref_node($!gtk-tm, $iter);
  }

}

class GTK::Tree::Model::Row {
  has $!gtk-tm is built;

  method changed (GtkTreePath() $path, GtkTreeIter() $iter) {
    gtk_tree_model_row_changed($!gtk-tm, $path, $iter);
  }

  method deleted (GtkTreePath() $path) {
    gtk_tree_model_row_deleted($!gtk-tm, $path);
  }

  method has_child_toggled (GtkTreePath() $path, GtkTreeIter() $iter) {
    gtk_tree_model_row_has_child_toggled($!gtk-tm, $path, $iter);
  }

  method inserted (GtkTreePath() $path, GtkTreeIter() $iter) {
    gtk_tree_model_row_inserted($!gtk-tm, $path, $iter);
  }

}

class GTK::Tree::Model::Rows {
  has $!gtk-tm is built;

  method reordered (
    GtkTreePath()  $path,
    GtkTreeIter()  $iter,
    CArray[gint]   $new_order
  ) {
    gtk_tree_model_rows_reordered($!gtk-tm, $path, $iter, $new_order);
  }

  method reordered_with_length (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    CArray[gint]  $new_order,
    Int()         $length
  ) {
    my gint $l = $length;

    gtk_tree_model_rows_reordered_with_length(
      $!gtk-tm,
      $path,
      $iter,
      $new_order,
      $l
    );
  }

}

our subset GtkTreeModelAncestry is export of Mu
  where GtkTreeModel | GObject;

class GTK::Tree::Model {
  also does GLib::Roles::Object;
  also does GTK::Roles::Tree::Model;

  submethod BUILD ( :$gtk-tree-model ) {
    self.setGtkTreeModel($gtk-tree-model) if $gtk-tree-model
  }

  method setGtkTreeModel (GtkTreeModelAncestry $_) {
    my $to-parent;

    $!gtk-tm = do {
      when GtkTreeModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeModel, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
    $gtk-tree-model where * ~~ GtkTreeModelAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-model;

    my $o = self.bless( :$gtk-tree-model );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gtktreemodel_get_type
  }

}

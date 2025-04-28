use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Model:ver<4>;
use GTK::Raw::Tree::DnD:ver<4>;

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

  method get (GtkTreeIter() $iter, GType $type, gpointer $val) {
    gtk_tree_model_get($!gtk-tm, $iter, $type, $val, -1);
  }

  method get_column_type (Int() $index) {
    my gint $i = $index;

    gtk_tree_model_get_column_type($!gtk-tm, $i);
  }

  method get_flags ( :set(:$flags) = True ) {
    my $f = gtk_tree_model_get_flags($!gtk-tm);
    return $f unless $flags;
    getFlags(GtkTreeModelFlagsEnum, $f);
  }

  proto method get_iter (|)
  { * }

  multi method get_iter (GtkTreePath() $path) {
    return-with-all( samewith(GtkTreeIter.new, $path, :all) );
  }
  multi method get_iter (
    GtkTreeIter()  $iter,
    GtkTreePath()  $path,
                  :$all   = False
  ) {
    my $rv = gtk_tree_model_get_iter($!gtk-tm, $iter, $path);

    $all.not ?? $rv !! ($rv, $iter);
  }

  proto method get_iter_first (|)
  { * }

  multi method get_iter_first {
    return-with-all( samewith(GtkTreeIter.new, :all) );
  }
  multi method get_iter_first (GtkTreeIter() $iter, :$all = False) {
    my $rv = gtk_tree_model_get_iter_first($!gtk-tm, $iter);

    $all.not ?? $rv !! ($rv, $iter);
  }

  proto method get_iter_from_string (|)
  { * }

  multi method get_iter_from_string (Str() $path_string) {
    return-with-all( samewith(GtkTreeIter.new, $path_string, :all) );
  }
  multi method get_iter_from_string (
    GtkTreeIter()  $iter,
    Str()          $path_string,
                  :$all          = False
  ) {
    my $rv = gtk_tree_model_get_iter_from_string(
      $!gtk-tm,
      $iter,
      $path_string
    );

    $all.not ?? $rv !! ($rv, $iter);
  }

  method get_n_columns {
    gtk_tree_model_get_n_columns($!gtk-tm);
  }

  method get_path (GtkTreeIter() $iter) {
    gtk_tree_model_get_path($!gtk-tm, $iter);
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

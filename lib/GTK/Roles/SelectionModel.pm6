use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::SelectionModel:ver<4>;

use GTK::Bitset:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

use GIO::Roles::ListModel;

role GTK::Roles::SelectionModel:ver<4> {
  also does GIO::Roles::ListModel;

  has GtkSelectionModel $!gtk-sm is implementor;

  method roleInit-GtkSelectionModel {
    return if $!gtk-sm;

    my \i = findProperImplementor( self.^attributes );
    $!gtk-sm = cast( GtkSelectionModel, i.get_value(self) );
    self.roleInit-GListModel;
  }

  method GTK::Raw::Definitions::GtkSelectionModel
  { $!gtk-sm }

  method GtkSelectionModel
  { $!gtk-sm }

  method Selection-Changed {
    self.connect-uintuint($!gtk-sm, 'selection-changed');
  }

  method get_selection ( :$raw = False ) {
    propReturnObject(
      gtk_selection_model_get_selection($!gtk-sm),
      $raw,
      |GTK::Bitset.getTypePair
    );
  }

  method get_selection_in_range (
    Int()  $position,
    Int()  $n_items,
          :$raw = False
  ) {
    my guint ($p, $n) = ($position, $n_items);

    propReturnObject(
      gtk_selection_model_get_selection_in_range($!gtk-sm, $p, $n),
      $raw,
      |GTK::Bitset.getTypePair
    );
  }

  method gtkselectionmodel_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_selection_model_get_type, $n, $t );
  }

  method is_selected (Int() $position) {
    my guint $p = $position;

    so gtk_selection_model_is_selected($!gtk-sm, $p);
  }

  method select_all {
    gtk_selection_model_select_all($!gtk-sm);
  }

  method select_item (Int() $position, Int() $unselect_rest) {
    my guint    $p = $position;
    my gboolean $u = $unselect_rest.so.Int;

    gtk_selection_model_select_item($!gtk-sm, $p, $u);
  }

  method select_range (
    Int() $position,
    Int() $n_items,
    Int() $unselect_rest
  ) {
    my guint    ($p, $n) = ($position, $n_items);
    my gboolean  $u      =  $unselect_rest.so.Int;

    gtk_selection_model_select_range($!gtk-sm, $p, $n, $u);
  }

  method selection_changed (Int() $position, Int() $n_items) {
    my guint    ($p, $n) = ($position, $n_items);

    gtk_selection_model_selection_changed($!gtk-sm, $p, $n);
  }

  method set_selection (GtkBitset() $selected, GtkBitset() $mask) {
    gtk_selection_model_set_selection($!gtk-sm, $selected, $mask);
  }

  method unselect_all {
    gtk_selection_model_unselect_all($!gtk-sm);
  }

  method unselect_item (Int() $position) {
    my guint $p = $position;

    gtk_selection_model_unselect_item($!gtk-sm, $p);
  }

  method unselect_range (Int() $position, Int() $n_items) {
    my guint    ($p, $n) = ($position, $n_items);

    gtk_selection_model_unselect_range($!gtk-sm, $p, $n);
  }

}


our subset GtkSelectionModelAncestry is export of Mu
  where GtkSelectionModel | GListModel | GObject;

class GTK::Selection::Model {
  also does GLib::Roles::Object;
  also does GTK::Roles::SelectionModel;

  submethod BUILD ( :$gtk-selection-model ) {
    self.setGtkSelectionModel($gtk-selection-model) if $gtk-selection-model
  }

  method setGtkSelectionModel (GtkSelectionModelAncestry $_) {
    my $to-parent;

    $!gtk-sm = do {
      when GtkSelectionModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $to-parent = cast(GObject, $_);
        $!lm       = $_;
        cast(GtkSelectionModel, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSelectionModel, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel;
  }

  method new (
    $gtk-selection-model where * ~~ GtkSelectionModelAncestry,

    :$ref = True
  ) {
    return unless $gtk-selection-model;

    my $o = self.bless( :$gtk-selection-model );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    self.gtkselectionmodel_get_type;
  }

}

sub returnSelectedObjects ($model, \T, $O?) is export {
  $model.itemObjects($O !=== Nil);
  do gather for $model.elems {
    take $model.get_object(
      type-pair => (T, $O)
    ) if $model.is_selected($_);
  }
}

sub returnSelectionModel ($obj, $raw, $model, \T, $O?) is export {
  my $o = propReturnObject( $obj, $raw, |GTK::SelectionModel.getTypePair );
  return $o if $raw || $model;
  my @tp = (T, $O);
  my $non-object = $raw || $O === Nil;
  returnSelectedObjects( $o, |@tp[ ^($non-object ?? 1 !! 2) ] )
}

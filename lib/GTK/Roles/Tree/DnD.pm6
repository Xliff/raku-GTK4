use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::DnD:ver<4>;

use GTK::Tree::Path;

role GTK::Roles::Tree::Drag::Dest:ver<4> {
  has GtkTreeDragDest $!gtk-td is implementor;

  method roleInit-GtkTreeDragDest {
    return if $!gtk-td;

    my \i = findProperImplementor(self.^attributes);

    $!gtk-td = cast( GtkTreeDragDest, i.get_value(self) );
  }

  method data_received (GtkTreePath() $dest, GValue() $value) {
    gtk_tree_drag_dest_drag_data_received($!gtk-td, $dest, $value);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_drag_dest_get_type, $n, $t );
  }

  method row_drop_possible (GtkTreePath() $dest_path, GValue() $value) {
    so gtk_tree_drag_dest_row_drop_possible($!gtk-td, $dest_path, $value);
  }

}

class GTK::Tree::Drag::Data:ver<4> {

  proto method get_row_drag_data (|)
    is static
  { * }

  multi method get_row_drag_data ($value) {
    samewith( $value, newCArray(GtkTreeModel), newCArray(GtkTreePath) );
  }
  multi method get_row_drag_data (
    GtkSelectionData()    $data,
    GValue()              $value,
    CArray[GtkTreeModel]  $tree_model,
    CArray[GtkTreePath]   $path,
                         :$raw         = False
  ) {
    gtk_tree_get_row_drag_data($data, $value, $tree_model, $path);

    my \TM = ::('GTK::Tree::Model');

    constant TP = GTK::Tree::Path;

    (
      propReturnObject( ppr($tree_model), $raw, |TM.getTypePair ),
      propReturnObject( ppr($path),       $raw, |TP.getTypePair )
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_row_data_get_type, $n, $t );
  }

}

role GTK::Roles::Tree::Drag::Source:ver<4> {
  has GtkTreeDragSource $!gtk-tsrc is implementor;

  method roleInit-GtkTreeDragSource {
    return if $!gtk-tsrc;

    my \i = findProperImplementor(self.^attributes);

    $!gtk-tsrc = cast( GtkTreeDragSource, i.get_value(self) )
  }

  method data_delete (GtkTreePath() $path) {
    gtk_tree_drag_source_drag_data_delete($!gtk-tsrc, $path);
  }

  method getData (GtkTreePath() $path) {
    gtk_tree_drag_source_drag_data_get($!gtk-tsrc, $path);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_drag_source_get_type, $n, $t );
  }

  method row_draggable (GtkTreePath() $path) {
    so gtk_tree_drag_source_row_draggable($!gtk-tsrc, $path);
  }
}

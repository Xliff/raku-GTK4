use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::DnD:ver<4>;

use GTK::Tree::Path;

class GTK::Drag::Dest {
  has GtkTreeDragDest $!gtk-td is implementor;

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

class GTK::Tree::Drag::Data {

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

class GTK::Tree::Drag::Source {
  has GtkTreeDragSource $!gtk-ts is implementor;

  method data_delete (GtkTreePath() $path) {
    gtk_tree_drag_source_drag_data_delete($!gtk-ts, $path);
  }

  method get (GtkTreePath() $path) {
    gtk_tree_drag_source_drag_data_get($!gtk-ts, $path);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_drag_source_get_type, $n, $t );
  }

  method row_draggable (GtkTreePath() $path) {
    so gtk_tree_drag_source_row_draggable($!gtk-ts, $path);
  }
}

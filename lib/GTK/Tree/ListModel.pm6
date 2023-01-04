use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::ListModel:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTreeListModelAncestry is export of Mu
  where GtkTreeListModel | GObject;

class GTK::Tree::ListModel {
  also does GLib::Roles::Object;

  has GtkTreeListModel $!gtk-tlm is implementor;

  submethod BUILD ( :$gtk-tree-listmodel ) {
    self.setGtkTreeListModel($gtk-tree-listmodel) if $gtk-tree-listmodel;
  }

  method setGtkTreeListModel (GtkTreeListModelAncestry $_) {
    my $to-parent;

    $!gtk-tlm = do {
      when GtkTreeListModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeListModel, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeListModel
  { $!gtk-tlm }

  multi method new (
     $gtk-tree-listmodel where * ~~ GtkTreeListModelAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-listmodel;

    my $o = self.bless( :$gtk-tree-listmodel );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int()    $passthrough,
    Int()    $autoexpand,
             &create_func,
    gpointer $user_data,
             &user_destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    my gboolean ($p, $a) = ($passthrough, $autoexpand)».so.Int;

    my $gtk-tree-listmodel = gtk_tree_list_model_new(
      $p,
      $a,
      &create_func,
      $user_data,
      &user_destroy
    );

    $gtk-tree-listmodel ?? self.bless( :$gtk-tree-listmodel ) !! Nil;
  }

  # Type: boolean
  method autoexpand is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('autoexpand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('autoexpand', $gv);
      }
    );
  }


  # Type: boolean
  method expanded is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expanded', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('expanded', $gv);
      }
    );
  }

  # Type: GtkObject
  method item-type is rw  is g-property {
    my $gv = GLib::Value.new-enum( G_TYPE_UINT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        $gv.uint64;
      },
      STORE => -> $,  $val is copy {
        warn 'item-type does not allow writing'
      }
    );
  }

  # Type: GtkListModel
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'model does not allow writing'
      }
    );
  }

  # Type: uint
  method n-items is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-items', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-items does not allow writing'
      }
    );
  }

  # Type: boolean
  method passthrough is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('passthrough', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('passthrough', $gv);
      }
    );
  }

  method get_autoexpand {
    so gtk_tree_list_model_get_autoexpand($!gtk-tlm);
  }

  method get_child_row (Int() $position, :$raw = False) {
    my guint $p = $position;

    propReturnObject(
      gtk_tree_list_model_get_child_row($!gtk-tlm, $p),
      $raw,
      |GTK::Tree::ListModel::Row.getTypePair
    )
  }

  method get_model ( :$raw = False ) {
    propReturnObject(
      gtk_tree_list_model_get_model($!gtk-tlm),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_passthrough {
    so gtk_tree_list_model_get_passthrough($!gtk-tlm);
  }

  method get_row (Int() $position) {
    my guint $p = $position;

    propReturnObject(
      gtk_tree_list_model_get_row($!gtk-tlm, $p),
      $raw,
      |GTK::Tree::ListModel::Row.getTypePair
    );
  }

}


our subset GtkTreeListRowAncestry is export of Mu
  where GtkTreeListRow | GObject;

class GTK::Tree::ListModel::Row {
  also does GLib::Roles::Object;

  has GtkTreeListRow $!gtk-tlr is implementor;

  submethod BUILD ( :$gtk-tree-listmodelrow ) {
    self.setGtkTreeListRow($gtk-tree-listmodelrow) if $gtk-tree-listmodelrow;
  }

  method setGtkTreeListRow (GtkTreeListRowAncestry $_) {
    my $to-parent;

    $!gtk-tlr = do {
      when GtkTreeListRow {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeListRow, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeListRow
  { $!gtk-tlr }

  multi method new (
     $gtk-tree-listmodelrow where * ~~ GtkTreeListRowAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-listmodelrow;

    my $o = self.bless( :$gtk-tree-listmodelrow );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkListModel
  method children ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('children', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'children does not allow writing'
      }
    );
  }

  # Type: uint
  method depth is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('depth', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'depth does not allow writing'
      }
    );
  }

  # Type: boolean
  method expandable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expandable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'expandable does not allow writing'
      }
    );
  }

  # Type: GtkObject
  method item ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'item does not allow writing'
      }
    );
  }

  method get_child_row (Int() $position, :$raw = False) {
    my guint $p = $position;

    propReturnObject(
      gtk_tree_list_row_get_child_row($!gtk-tlr, $position),
      $raw,
      |self.getTypePair
    );
  }

  method get_children ( :$raw = False ) {
    propReturnObject(
      gtk_tree_list_row_get_children($!gtk-tlr),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_depth {
    gtk_tree_list_row_get_depth($!gtk-tlr);
  }

  method get_expanded {
    gtk_tree_list_row_get_expanded($!gtk-tlr);
  }

  method get_item ( :$raw = False ) {
    propReturnObject(
      gtk_tree_list_row_get_item($!gtk-tlr),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_parent ( :$raw = False ) {
    propReturnObject(
      gtk_tree_list_row_get_parent($!gtk-tlr),
      $raw,
      |self.getTypePair
    );
  }

  method get_position {
    gtk_tree_list_row_get_position($!gtk-tlr);
  }

  method is_expandable {
    so gtk_tree_list_row_is_expandable($!gtk-tlr);
  }

  method set_expanded (Int() $expanded) {
    my gboolean $e = $expanded.so.Int;

    gtk_tree_list_row_set_expanded($!gtk-tlr, $e);
  }

  method set_autoexpand (Int() $autoexpand) {
    my gboolean $a = $autoexpand.so.Int;

    gtk_tree_list_model_set_autoexpand($!gtk-tlr, $a);
  }

}

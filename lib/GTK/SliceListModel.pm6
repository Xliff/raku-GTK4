use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::SliceListModel:ver<4>;


use GLib::Roles::Implementor;
use GIO::Roles::ListModel;

our subset GtkSliceListModelAncestry is export of Mu
  where GtkSliceListModel | GObject;

class GTK::SliceListModel:ver<4> is GIO::ListModel {
  has GtkSliceListModel $!gtk-slm is implementor;

  submethod BUILD ( :$gtk-slice-listmodel ) {
    self.setGtkSliceListModel($gtk-slice-listmodel) if $gtk-slice-listmodel;
  }

  method setGtkSliceListModel (GtkSliceListModelAncestry $_) {
    my $to-parent;

    $!gtk-slm = do {
      when GtkSliceListModel {
        $to-parent = cast(GListModel, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSliceListModel, $_);
      }
    }
    self.setGListModel($to-parent);
  }

  method GTK::Raw::Definitions::GtkSliceListModel
    is also<GtkSliceListModel>
  { $!gtk-slm }

  multi method new (
    $gtk-slice-listmodel where * ~~ GtkSliceListModelAncestry,

    :$ref = True
  ) {
    return unless $gtk-slice-listmodel;

    my $o = self.bless( :$gtk-slice-listmodel );
    $o.ref if $ref;
    $o;
  }
  multi method new (GListModel() $model, Int() $offset, Int() $size) {
    my guint $o = $offset;
    my guint $s = $size;

    my $gtk-slice-listmodel = gtk_slice_list_model_new($model, $o, $s);

    $gtk-slice-listmodel ?? self.bless( :$gtk-slice-listmodel ) !! Nil;
  }

  # Type: GType
  method item-type is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new( GLib::Value.type-from-enum(GType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        $gv.valueFromEnum(GType)
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
      STORE => -> $, GListModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: uint
  method n-items is rw  is g-property is also<n_items> {
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

  # Type: uint
  method offset is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('offset', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('offset', $gv);
      }
    );
  }

  # Type: uint
  method size is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('size', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_slice_list_model_get_model($!gtk-slm),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_offset is also<get-offset> {
    gtk_slice_list_model_get_offset($!gtk-slm);
  }

  method get_size is also<get-size> {
    gtk_slice_list_model_get_size($!gtk-slm);
  }

  method set_model (GListModel() $model) is also<set-model> {
    gtk_slice_list_model_set_model($!gtk-slm, $model);
  }

  method set_offset (Int() $offset) is also<set-offset> {
    my guint $o = $offset;

    gtk_slice_list_model_set_offset($!gtk-slm, $o);
  }

  method set_size (Int() $size) is also<set-size> {
    my guint $s = $size;

    gtk_slice_list_model_set_size($!gtk-slm, $s);
  }

}

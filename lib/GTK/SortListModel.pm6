use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::SortListModel:ver<4>;

use GTK::Sorter:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;

class GTK::SortListModel:ver<4> {
  also does GLib::Roles::Object;

  has GtkSortListModel $!gtk-slm is implementor;

  method new (GListModel() $model, GtkSorter  $sorter) {
    my $gtk-sort-model = gtk_sort_list_model_new($model, $sorter);

    $gtk-sort-model ?? self.bless( :$gtk-sort-model ) !! Nil;
  }

  # Type: boolean
  method incremental is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('incremental', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('incremental', $gv);
      }
    );
  }

  # Type: GObject
  # cw: Yep! It really is. Should be GType, but the .c doesn't lie.
  method item-type ( :$raw = False ) is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new( GLib::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        warn 'item-type does not allow writing'
      }
    );
  }

  # Type: GtkListModel
  method model is rw  is g-property {
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
  method pending is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pending', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'pending does not allow writing'
      }
    );
  }

  # Type: GtkSorter
  method sorter ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Sorter.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sorter', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Sorter.getTypePair
        );
      },
      STORE => -> $, GtkSorter() $val is copy {
        $gv.object = $val;
        self.prop_set('sorter', $gv);
      }
    );
  }

  method get_incremental is also<get-incremental> {
    so gtk_sort_list_model_get_incremental($!gtk-slm);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_sort_list_model_get_model($!gtk-slm),
      $raw,
      GIO::ListModel.getTypePair
    );
  }

  method get_pending is also<get-pending> {
    so gtk_sort_list_model_get_pending($!gtk-slm);
  }

  method get_sorter ( :$raw = False ) is also<get-sorter> {
    propReturnObject(
      gtk_sort_list_model_get_sorter($!gtk-slm),
      $raw,
      |GTK::Sorter.getTypePair
    );
  }

  method set_incremental (Int() $incremental) is also<set-incremental> {
    my gboolean $i = $incremental.so.Int;

    gtk_sort_list_model_set_incremental($!gtk-slm, $i);
  }

  method set_model (GListModel() $model) is also<set-model> {
    gtk_sort_list_model_set_model($!gtk-slm, $model);
  }

  method set_sorter (GtkSorter() $sorter) is also<set-sorter> {
    gtk_sort_list_model_set_sorter($!gtk-slm, $sorter);
  }

}

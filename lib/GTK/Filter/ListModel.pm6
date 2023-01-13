use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Filter::ListModel:ver<4>;

use GTK::Filter;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset GtkFilterListModelAncestry is export of Mu
  where GtkFilterListModel | GListModel | GObject;

class GTK::Raw::FilterListModel:ver<4> {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has GtkFilterListModel $!gtk-flm is implementor;

  submethod BUILD ( :$gtk-filter-model ) {
    self.setGtkFilterListModel($gtk-filter-model) if $gtk-filter-model
  }

  method setGtkFilterListModel (GtkFilterListModelAncestry $_) {
    my $to-parent;

    $!gtk-flm = do {
      when GtkFilterListModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $!lm = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkFilterListModel, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkFilterListModel, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel;
  }

  method GTK::Raw::Definitions::GtkFilterListModel
    is also<GtkFilterListModel>
  { $!gtk-flm }

  multi method new (
     $gtk-filter-model where * ~~ GtkFilterListModelAncestry,

    :$ref = True
  ) {
    return unless $gtk-filter-model;

    my $o = self.bless( :$gtk-filter-model );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkFilter() $filter) {
    my $gtk-filter-list = gtk_filter_list_model_new($filter);

    $gtk-filter-list ?? self.bless( :$gtk-filter-list ) !! Nil;
  }

  # Type: GtkFilter
  method filter ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Filter.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('filter', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Filter.getTypePair
        );
      },
      STORE => -> $, GtkFilter() $val is copy {
        $gv.object = $val;
        self.prop_set('filter', $gv);
      }
    );
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

  # Type: GListModel
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

  method get_filter ( :$raw = False ) is also<get-filter> {
    propReturnObject(
      gtk_filter_list_model_get_filter($!gtk-flm),
      $raw,
      |GTK::Filter.getTypePair
    );
  }

  method get_incremental is also<get-incremental> {
    so gtk_filter_list_model_get_incremental($!gtk-flm);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_filter_list_model_get_model($!gtk-flm),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_pending is also<get-pending> {
    so gtk_filter_list_model_get_pending($!gtk-flm);
  }

  method set_filter (GtkFilter() $filter) is also<set-filter> {
    gtk_filter_list_model_set_filter($!gtk-flm, $filter);
  }

  method set_incremental (Int() $incremental) is also<set-incremental> {
    my gboolean $i = $incremental.so.Int;

    gtk_filter_list_model_set_incremental($!gtk-flm, $i);
  }

  method set_model (GListModel() $model) is also<set-model> {
    gtk_filter_list_model_set_model($!gtk-flm, $model);
  }

}

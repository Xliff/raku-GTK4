use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Selection::Single:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::SelectionModel:ver<4>;

our subset GtkSingleSelectionAncestry is export of Mu
  where GtkSingleSelection | GObject;

class GTK::Selection::Single:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::SelectionModel;

  has GtkSingleSelection $!gtk-ss is implementor;

  submethod BUILD ( :$gtk-single-selection ) {
    self.setGtkSingleSelection($gtk-single-selection) if $gtk-single-selection
  }

  method setGtkSingleSelection (GtkSingleSelectionAncestry $_) {
    my $to-parent;

    $!gtk-ss = do {
      when GtkSingleSelection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkSelectionModel {
        $to-parent = cast(GObject, $_);
        $!gtk-sm   = $_;
        cast(GtkSingleSelection, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSingleSelection, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkSelectionModel;
  }

  method GTK::Raw::Definitions::GtkSingleSelection
    is also<GtkSelectionSingle>
  { $!gtk-ss }

  multi method new (
    $gtk-single-selection where * ~~ GtkSingleSelectionAncestry,

    :$ref = True
  ) {
    return unless $gtk-single-selection;

    my $o = self.bless( :$gtk-single-selection );
    $o.ref if $ref;
    $o;
  }
  multi method new (GListModel() $model) {
    my $gtk-single-selection = gtk_single_selection_new($model);

    $gtk-single-selection ?? self.bless( :$gtk-single-selection ) !! Nil;
  }

  # Type: boolean
  method autoselect is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('autoselect', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('autoselect', $gv);
      }
    );
  }

  # Type: boolean
  method can-unselect is rw  is g-property is also<can_unselect> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-unselect', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('can-unselect', $gv);
      }
    );
  }

  # Type: GType
  method item-type is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new-enum( GType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        $gv.valueFromEnum(GType);
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
  method selected is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('selected', $gv);
      }
    );
  }

  # Type: GtkObject
  method selected-item ( :$raw = False )
    is rw
    is g-property
    is also<selected_item>
  {
    my $gv = GLib::Value.new( GLib::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected-item', $gv);
        propReturnObject(
          $gv.objec,
          $raw,
          |GLib::Object.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'selected-item does not allow writing'
      }
    );
  }

  method get_autoselect is also<get-autoselect> {
    so gtk_single_selection_get_autoselect($!gtk-ss);
  }

  method get_can_unselect is also<get-can-unselect> {
    so gtk_single_selection_get_can_unselect($!gtk-ss);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_single_selection_get_model($!gtk-ss),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_selected is also<get-selected> {
    gtk_single_selection_get_selected($!gtk-ss);
  }

  # cw: This NEEDS Object Resolution. See main TODO!
  method get_selected_item ( :$raw = False ) is also<get-selected-item> {
    propReturnObject(
      gtk_single_selection_get_selected_item($!gtk-ss),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method set_autoselect (Int() $autoselect) is also<set-autoselect> {
    my gboolean $a = $autoselect.so.Int;

    gtk_single_selection_set_autoselect($!gtk-ss, $a);
  }

  method set_can_unselect (Int() $can_unselect) is also<set-can-unselect> {
    my gboolean $c = $can_unselect.so.Int;

    gtk_single_selection_set_can_unselect($!gtk-ss, $c);
  }

  method set_model (GListModel() $model) is also<set-model> {
    gtk_single_selection_set_model($!gtk-ss, $model);
  }

  method set_selected (Int() $position) is also<set-selected> {
    my guint $p = $position;

    gtk_single_selection_set_selected($!gtk-ss, $p);
  }

}

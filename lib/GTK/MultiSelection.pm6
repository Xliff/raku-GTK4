use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;
use GTK::Roles::SelectionModel:ver<4>;

our subset GtkMultiSelectionAncestry is export of Mu
  where GtkMultiSelection | GObject;

class GTK::MultiSelect:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::SelectionModel;

  has GtkMultiSelection $!gtk-ms is implementor;

  submethod BUILD ( :$gtk_multi-select ) {
    self.setGtkMultiSelection($gtk_multi-select) if $gtk_multi-select
  }

  method setGtkMultiSelection (GtkMultiSelectionAncestry $_) {
    my $to-parent;

    $!gtk-ms = do {
      when GtkMultiSelection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMultiSelection, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkMultiSelection
  { $!gtk-ms }

  multi method new (
     $gtk_multi-select where * ~~ GtkMultiSelectionAncestry,
     
    :$ref = True
  ) {
    return unless $gtk_multi-select;

    my $o = self.bless( :$gtk_multi-select );
    $o.ref if $ref;
    $o;
  }

  method new (GListModel() $model) {
    my $gtk-multi-select = gtk_multi_selection_new($model);

    $gtk-multi-select ?? self.bless( :$gtk-multi-select ) !! Nil;
  }

  # Type: GObject
  method item-type ( :$raw = False ) is rw is g-property is also<item_type> {
    my $gv = GLib::Value.new( GLib::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        );
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

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_multi_selection_get_model($!gtk-ms),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method set_model (GListModel() $model) is also<set-model> {
    gtk_multi_selection_set_model($!gtk-ms, $model);
  }
}


### /usr/src/gtk4/gtk/gtkmultiselection.h

sub gtk_multi_selection_get_model (GtkMultiSelection $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_multi_selection_new (GListModel $model)
  returns GtkMultiSelection
  is      native(gtk4)
  is      export
{ * }

sub gtk_multi_selection_set_model (
  GtkMultiSelection $self,
  GListModel        $model
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::DropDown:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

class GTK::DropDown:ver<4> is GTK::Widget:ver<4> {
  has GtkDropDown $!gtk-dd is implementor;

  method new (
    GListModel()    $model,
    GtkExpression() $expression = GtkExpression
  ) {
    my $gtk-dropdown = gtk_drop_down_new($model, $expression);

    $gtk-dropdown ?? self.bless( :$gtk-dropdown ) !! Nil;
  }

  proto method new_from_strings (|)
  { * }

  multi method new_from_strings(*@strings) {
    samewith(@strings);
  }
  multi method new_from_strings (@strings) {
    samewith( ArrayToCArray(Str, @strings ,:null) );
  }
  multi method new_from_strings (CArray[Str] $strings) {
    my $gtk-dropdown = gtk_drop_down_new_from_strings($strings);

    $gtk-dropdown ?? self.bless( :$gtk-dropdown ) !! Nil;
  }

  # Type: boolean
  method enable-search is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-search', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-search', $gv);
      }
    );
  }

  # Type: GtkListItemFactory
  method factory ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GtkListItemFactory );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('factory', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::ListItemFactory.getTypePair
        );
      },
      STORE => -> $, GtkListItem() $val is copy {
        $gv.object = $val;
        self.prop_set('list-factory', $gv);
      }
    );
  }

  # Type: GtkListItemFactory
  method list-factory ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Factory::ListItem.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('list-factory', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::ListItemFactory.getTypePair
        );
      },
      STORE => -> $, GtkListItem() $val is copy {
        $gv.object = $val;
        self.prop_set('list-factory', $gv);
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
  method selected-item ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected-item', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'selected-item does not allow writing'
      }
    );
  }

  # Type: boolean
  method show-arrow is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-arrow', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-arrow', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-dd, 'Activate');
  }

  method get_enable_search {
    so gtk_drop_down_get_enable_search($!gtk-dd);
  }

  method get_expression ( :$raw = False ) {
    propReturnObject(
      gtk_drop_down_get_expression($!gtk-dd),
      $raw,
      |GTK::Expression.getTypePair
    );
  }

  method get_factory ( :$raw = False ) {
    propReturnObject(
      gtk_drop_down_get_factory($!gtk-dd),
      $raw,
      |GTK::Factory::ListItem.getTypePair
    );
  }

  method get_list_factory ( :$raw = False ) {
    propReturnObject(
      gtk_drop_down_get_list_factory($!gtk-dd),
      $raw,
      |GTK::Factory::ListItem.getTypePair
    );
  }

  method get_model ( :$raw = False ) {
    propReturnObject(
      gtk_drop_down_get_model($!gtk-dd),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_selected ( :$raw = False ) {
    gtk_drop_down_get_selected($!gtk-dd);
  }

  method get_selected_item ( :$raw = False ) {
    propReturnObject(
      gtk_drop_down_get_selected_item($!gtk-dd),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_show_arrow {
    so gtk_drop_down_get_show_arrow($!gtk-dd);
  }

  method set_enable_search (Int() $enable_search) {
    my gboolean $e = $enable_search.so.Int;

    gtk_drop_down_set_enable_search($!gtk-dd, $enable_search);
  }

  method set_expression (GtkExpression() $expression) {
    gtk_drop_down_set_expression($!gtk-dd, $expression);
  }

  method set_factory (GtkListItemFactory() $factory) {
    gtk_drop_down_set_factory($!gtk-dd, $factory);
  }

  method set_list_factory (GtkListItemFactory() $factory) {
    gtk_drop_down_set_list_factory($!gtk-dd, $factory);
  }

  method set_model (GListModel() $model) {
    gtk_drop_down_set_model($!gtk-dd, $model);
  }

  method set_selected (Int() $position) {
    my guint $p = $position;

    gtk_drop_down_set_selected($!gtk-dd, $p);
  }

  method set_show_arrow (Int() $show_arrow) {
    my gboolean $s = $show_arrow.so.Int;

    gtk_drop_down_set_show_arrow($!gtk-dd, $show_arrow);
  }

}

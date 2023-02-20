use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::List::View:ver<4>;

use GTK::List::Base:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::SelectionModel:ver<4>;

our subset GtkListViewAncestry is export of Mu
  where GtkListView | GtkListBaseAncestry;

class GTK::List::View:ver<4> is GTK::List::Base:ver<4> {
  has GtkListView $!gtk-lv is implementor;

  submethod BUILD ( :$gtk-list-view ) {
    self.setGtkListView($gtk-list-view) if $gtk-list-view
  }

  method setGtkListView (GtkListViewAncestry $_) {
    my $to-parent;

    $!gtk-lv = do {
      when GtkListView {
        $to-parent = cast(GtkListBase, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkListView, $_);
      }
    }
    self.setGtkListBase($to-parent);
  }

  method GTK::Raw::Definitions::GtkListView
    is also<GtkListView>
  { $!gtk-lv }

  multi method new (
    $gtk-list-view where * ~~ GtkListViewAncestry,

    :$ref = True
  ) {
    return unless $gtk-list-view;

    my $o = self.bless( :$gtk-list-view );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GtkSelectionModel()  $model,
    GtkListItemFactory() $factory
  ) {
    my $gtk-list-view = gtk_list_view_new($model, $factory);

    $gtk-list-view ?? self.bless( :$gtk-list-view ) !! Nil;
  }

  # Type: boolean
  method enable-rubberband is rw  is g-property is also<enable_rubberband> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-rubberband', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-rubberband', $gv);
      }
    );
  }

  # Type: GtkListItemFactory
  method factory ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::List::Item::Factory.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('factory', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::List::Item::Factory.getTypePair
        );
      },
      STORE => -> $, GtkListItemFactory() $val is copy {
        $gv.object = $val;
        self.prop_set('factory', $gv);
      }
    );
  }

  # Type: GtkSelectionModel
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::SelectionModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::SelectionModel.getTypePair
        );
      },
      STORE => -> $, GtkSelectionModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: boolean
  method show-separators is rw  is g-property is also<show_separators> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-separators', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-separators', $gv);
      }
    );
  }

  # Type: boolean
  method single-click-activate
    is rw
    is g-property
    is also<single_click_activate>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('single-click-activate', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('single-click-activate', $gv);
      }
    );
  }

  method Activate {
    self.connect-uint($!gtk-lv, 'activate');
  }

  method get_enable_rubberband  is also<get-enable-rubberband> {
    so gtk_list_view_get_enable_rubberband($!gtk-lv);
  }

  method get_factory  ( :$raw = False ) is also<get-factory> {
    propReturnObject(
      gtk_list_view_get_factory($!gtk-lv),
      $raw,
      |GTK::List::Item::Factory.getTypePair
    );
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_list_view_get_model($!gtk-lv),
      $raw,
      |GTK::Selection::Model.getTypePair
    );
  }

  method get_show_separators  is also<get-show-separators> {
    so gtk_list_view_get_show_separators($!gtk-lv);
  }

  method get_single_click_activate  is also<get-single-click-activate> {
    so gtk_list_view_get_single_click_activate($!gtk-lv);
  }

  method get_type is also<get-type> {
    state ($n, $t),

    unstable_get_type( self.^name, &gtk_list_view_get_type, $n, $t );
  }

  method set_enable_rubberband (Int() $enable_rubberband)
    is also<set-enable-rubberband>
  {
    gtk_list_view_set_enable_rubberband($!gtk-lv, $enable_rubberband);
  }

  method set_factory (GtkListItemFactory() $factory) is also<set-factory> {
    gtk_list_view_set_factory($!gtk-lv, $factory);
  }

  method set_model (GtkSelectionModel() $model) is also<set-model> {
    gtk_list_view_set_model($!gtk-lv, $model);
  }

  method set_show_separators (Int() $show_separators)
    is also<set-show-separators>
  {
    my gboolean $s = $show_separators.so.Int;

    gtk_list_view_set_show_separators($!gtk-lv, $s);
  }

  method set_single_click_activate (Int() $single_click_activate)
    is also<set-single-click-activate>
  {
    my gboolean $s = $single_click_activate.so.Int;

    gtk_list_view_set_single_click_activate($!gtk-lv, $s);
  }

}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::GridView:ver<4>;

use GTK::List::Base:ver<4>;
use GTK::List::Item::Factory:ver<4>;

use GLib::Roles::Implementor;

our subset GtkGridViewAncestry is export of Mu
  where GtkGridView | GtkListBaseAncestry;

class GTK::GridView:ver<4> is GTK::List::Base:ver<4> {
  has GtkGridView $!gtk-gv is implementor;

  submethod BUILD ( :$gtk-grid-view ) {
    self.setGtkGridView($gtk-grid-view) if $gtk-grid-view
  }

  method setGtkGridView (GtkGridViewAncestry $_) {
    my $to-parent;

    $!gtk-gv = do {
      when GtkGridView {
        $to-parent = cast(GtkListBase, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGridView, $_);
      }
    }
    self.setGtkListBase($to-parent);
  }

  method GTK::Raw::Definitions::GtkGridView
    is also<GtkGridView>
  { $!gtk-gv }

  multi method new (
    $gtk-grid-view where * ~~ GtkGridViewAncestry,

    :$ref = True
   ) {
    return unless $gtk-grid-view;

    my $o = self.bless( :$gtk-grid-view );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkListItemFactory() $factory) {
    my $gtk-grid-view = gtk_grid_view_new($factory);

    $gtk-grid-view ?? self.bless( :$gtk-grid-view ) !! Nil;
  }

  # Type: boolean
  method enable-rubberband
    is rw
    is g-property
    is also<enable_rubberband>
  {
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

  # Type: uint
  method max-columns is rw  is g-property is also<max_columns> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-columns', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('max-columns', $gv);
      }
    );
  }

  # Type: uint
  method min-columns is rw  is g-property is also<min_columns> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-columns', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('min-columns', $gv);
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
    self.connect-uint($!gtk-gv, 'activate');
  }

  method get_enable_rubberband is also<get-enable-rubberband>  {
    so gtk_grid_view_get_enable_rubberband($!gtk-gv);
  }

  method get_factory ( :$raw = False ) is also<get-factory> {
    propReturnObject(
      gtk_grid_view_get_factory($!gtk-gv),
      $raw,
      |GTK::List::Item::Factory.getTypePair
    );
  }

  method get_max_columns is also<get-max-columns> {
    gtk_grid_view_get_max_columns($!gtk-gv);
  }

  method get_min_columns is also<get-min-columns> {
    gtk_grid_view_get_min_columns($!gtk-gv);
  }

  method getColumnRange ( :$range = True ) {
    my @r = (self.get_min_columns, self.get_max_columns);
    return @r unless $range;
    Range.new( |@r );
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_grid_view_get_model($!gtk-gv),
      $raw,
      |GTK::SelectionModel.getTypePair
    );
  }

  method get_single_click_activate is also<get-single-click-activate> {
    so gtk_grid_view_get_single_click_activate($!gtk-gv);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_grid_view_get_type, $n, $t );
  }

  method set_enable_rubberband (Int() $enable_rubberband)
    is also<set-enable-rubberband>
  {
    my gboolean $e = $enable_rubberband.so.Int;

    gtk_grid_view_set_enable_rubberband($!gtk-gv, $e);
  }

  method set_factory (GtkListItemFactory() $factory) is also<set-factory> {
    gtk_grid_view_set_factory($!gtk-gv, $factory);
  }

  method set_max_columns (Int() $max_columns) is also<set-max-columns> {
    my guint $m = $max_columns;

    gtk_grid_view_set_max_columns($!gtk-gv, $m);
  }

  method set_min_columns (Int() $min_columns) is also<set-min-columns> {
    my guint $m = $min_columns;

    gtk_grid_view_set_min_columns($!gtk-gv, $m);
  }

  method set_model (GtkSelectionModel() $model) is also<set-model> {
    gtk_grid_view_set_model($!gtk-gv, $model);
  }

  method set_single_click_activate (Int() $single_click_activate)
    is also<set-single-click-activate>
  {
    my gboolean $s = $single_click_activate.so.Int;

    gtk_grid_view_set_single_click_activate($!gtk-gv, $s);
  }

}

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::GridView;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     %widgets = from-json( .slurp );
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::GridView;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

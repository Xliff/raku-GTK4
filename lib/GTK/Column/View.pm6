use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Column::View:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GIO::Roles::ListModel;
use GTK::Roles::SelectionModel:ver<4>;

our subset GtkColumnViewAncestry is export of Mu
  where GtkColumnView | GtkWidgetAncestry;

class GTK::Column::View:ver<4> is GTK::Widget:ver<4> {
  has GtkColumnView $!gtk-cv is implementor;

  submethod BUILD ( :$gtk-column-view ) {
    self.setGtkColumnView($gtk-column-view) if $gtk-column-view
  }

  method setGtkColumnView (GtkColumnViewAncestry $_) {
    my $to-parent;

    $!gtk-cv = do {
      when GtkColumnView {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkColumnView, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkColumnView
    is also<GtkColumnView>
  { $!gtk-cv }

  multi method new (
     $gtk-column-view where * ~~ GtkColumnViewAncestry,

    :$ref = True
  ) {
    return unless $gtk-column-view;

    my $o = self.bless( :$gtk-column-view );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkSelectionModel() $model) {
    my $gtk-column-view = gtk_column_view_new($model);

    $gtk-column-view ?? self.bless( :$gtk-column-view ) !! Nil;
  }

  # Type: GtkListModel
  method columns ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('columns', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'columns does not allow writing'
      }
    );
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
        $gv.GtkSelectionModel = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: boolean
  method reorderable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('reorderable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reorderable', $gv);
      }
    );
  }

  # Type: boolean
  method show-column-separators
    is rw
    is g-property
    is also<show_column_separators>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-column-separators', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-column-separators', $gv);
      }
    );
  }

  # Type: boolean
  method show-row-separators
    is rw
    is g-property
    is also<show_row_separators>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-row-separators', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-row-separators', $gv);
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
      STORE => -> $,  $val is copy {
        warn 'sorter does not allow writing'
      }
    );
  }

  method Activate {
    self.connect-uint($!gtk-cv, 'activate');
  }

  method append_column (GtkColumnViewColumn() $column)
    is also<append-column>
  {
    gtk_column_view_append_column($!gtk-cv, $column);
  }

  method get_columns is also<get-columns> {
    gtk_column_view_get_columns($!gtk-cv);
  }

  method get_enable_rubberband is also<get-enable-rubberband> {
    so gtk_column_view_get_enable_rubberband($!gtk-cv);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_column_view_get_model($!gtk-cv),
      $raw,
      |GTK::SelectionModel.getTypePair
    );
  }

  method get_reorderable is also<get-reorderable> {
    so gtk_column_view_get_reorderable($!gtk-cv);
  }

  method get_show_column_separators is also<get-show-column-separators> {
    so gtk_column_view_get_show_column_separators($!gtk-cv);
  }

  method get_show_row_separators is also<get-show-row-separators> {
    so gtk_column_view_get_show_row_separators($!gtk-cv);
  }

  method get_single_click_activate is also<get-single-click-activate> {
    so gtk_column_view_get_single_click_activate($!gtk-cv);
  }

  method get_sorter ( :$raw = False ) is also<get-sorter> {
    propReturnObject(
      gtk_column_view_get_sorter($!gtk-cv),
      $raw,
      |GTK::Sorter.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_column_view_get_type, $n, $t );
  }

  method insert_column (Int() $position, GtkColumnViewColumn() $column)
    is also<insert-column>
  {
    my guint $p = $position;

    gtk_column_view_insert_column($!gtk-cv, $p, $column);
  }

  method remove_column (GtkColumnViewColumn() $column)
    is also<remove-column>
  {
    gtk_column_view_remove_column($!gtk-cv, $column);
  }

  method set_enable_rubberband (Int() $enable_rubberband)
    is also<set-enable-rubberband>
  {
    my gboolean $e = $enable_rubberband.so.Int;

    gtk_column_view_set_enable_rubberband($!gtk-cv, $e);
  }

  method set_model (GtkSelectionModel() $model) is also<set-model> {
    gtk_column_view_set_model($!gtk-cv, $model);
  }

  method set_reorderable (Int() $reorderable) is also<set-reorderable> {
    my gboolean $r = $reorderable.so.Int;

    gtk_column_view_set_reorderable($!gtk-cv, $r);
  }

  method set_show_column_separators (Int() $show_column_separators)
    is also<set-show-column-separators>
  {
    my gboolean $s = $show_column_separators.so.Int;

    gtk_column_view_set_show_column_separators($!gtk-cv, $s);
  }

  method set_show_row_separators (Int() $show_row_separators)
    is also<set-show-row-separators>
  {
    my gboolean $s = $show_row_separators.so.Int;

    gtk_column_view_set_show_row_separators($!gtk-cv, $s);
  }

  method set_single_click_activate (Int() $single_click_activate)
    is also<set-single-click-activate>
  {
    my gboolean $s = $single_click_activate.so.Int;

    gtk_column_view_set_single_click_activate($!gtk-cv, $s);
  }

  method sort_by_column (GtkColumnViewColumn() $column, Int() $direction)
    is also<sort-by-column>
  {
    my GtkSortType $d = $direction;

    gtk_column_view_sort_by_column($!gtk-cv, $column, $d);
  }

}

# cw: Are macros good enough for this, yet? We should test it!
# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Column::View;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     if .slurp -> $j {
#       %widgets = try from-json($j) if +$j.lines;
#     }
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::Column::View;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

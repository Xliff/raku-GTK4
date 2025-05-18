use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::View::Column:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTreeViewColumnAncestry is export of Mu
  where GtkTreeViewColumn | GObject;

class GTK::Tree::View::Column:ver<4> {
  also does GLib::Roles::Object;

  has GtkTreeViewColumn $!gtk-tc is implementor;

  submethod BUILD ( :$gtk-view-column ) {
    self.setGtkTreeViewColumn($gtk-view-column) if $gtk-view-column
  }

  method setGtkTreeViewColumn (GtkTreeViewColumnAncestry $_) {
    my $to-parent;

    $!gtk-tc = do {
      when GtkTreeViewColumn {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeViewColumn, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeViewColumn
    is also<GtkTreeViewColumn>
  { $!gtk-tc }

  multi method new (
    $gtk-view-column where * ~~ GtkTreeViewColumnAncestry,

    :$ref = True
  ) {
    return unless $gtk-view-column;

    my $o = self.bless( :$gtk-view-column );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-view-column = gtk_tree_view_column_new();

    my $o = $gtk-view-column ?? self.bless( :$gtk-view-column ) !! Nil;
    $o.setAttributes( |%a ) if +%a && $o;
    $o;
  }

  method new_with_area (GtkCellArea() $area, *%a) is also<new-with-area> {
    my $gtk-view-column = gtk_tree_view_column_new_with_area($area);

    my $o = $gtk-view-column ?? self.bless( :$gtk-view-column ) !! Nil;
    $o.setAttributes( |%a ) if +%a && $o;
    $o;
  }

  # Type: float
  method alignment is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('alignment', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('alignment', $gv);
      }
    );
  }

  # Type: GtkCellArea
  method cell-area ( :$raw = False )
    is rw
    is g-property
    is also<cell_area>
  {
    my $gv = GLib::Value.new( GTK::Cell::Area.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cell-area', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Cell::Area.getTypePair
        );
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.object = $val;
        self.prop_set('cell-area', $gv);
      }
    );
  }

  # Type: boolean
  method clickable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('clickable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('clickable', $gv);
      }
    );
  }

  # Type: boolean
  method expand is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('expand', $gv);
      }
    );
  }

  # Type: int
  method fixed-width is rw  is g-property is also<fixed_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fixed-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('fixed-width', $gv);
      }
    );
  }

  # Type: int
  method max-width is rw  is g-property is also<max_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width', $gv);
      }
    );
  }

  # Type: int
  method min-width is rw  is g-property is also<min_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('min-width', $gv);
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
  method resizable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resizable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resizable', $gv);
      }
    );
  }

  # Type: GtkTreeViewColumnSizing
  method sizing ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new(
      GLib::Value.new-enum(GtkTreeViewColumnSizing)
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sizing', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GtkTreeViewColumnSizingEnum($s);
      },
      STORE => -> $,  $val is copy {
        $gv.value-from-enum(GtkTreeViewColumnSizing) = $val;
        self.prop_set('sizing', $gv);
      }
    );
  }

  # Type: int
  method sort-column-id is rw  is g-property is also<sort_column_id> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sort-column-id', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('sort-column-id', $gv);
      }
    );
  }

  # Type: boolean
  method sort-indicator is rw  is g-property is also<sort_indicator> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sort-indicator', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('sort-indicator', $gv);
      }
    );
  }

  # Type: GtkSortType
  method sort-order ( :$enum = True )
    is rw
    is g-property
    is also<sort_order>
  {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkSortType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sort-order', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GtkSortTypeEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.value-from-enum(GtkSortType) = $val;
        self.prop_set('sort-order', $gv);
      }
    );
  }

  # Type: int
  method spacing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('spacing', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: boolean
  method visible is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible', $gv);
      }
    );
  }

  # Type: GtkWidget
  method widget is rw  is g-property {
    my $gv = GLib::Value.new( GtkWidget );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('widget', $gv);
        $gv.GtkWidget;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkWidget = $val;
        self.prop_set('widget', $gv);
      }
    );
  }

  # Type: int
  method width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'width does not allow writing'
      }
    );
  }

  # Type: int
  method x-offset is rw  is g-property is also<x_offset> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('x-offset', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'x-offset does not allow writing'
      }
    );
  }

  method Clicked {
    self.connect($!gtk-tc, 'clicked');
  }

  method add_attribute (
    GtkCellRenderer() $cell_renderer,
    Str()             $attribute,
    Int()             $column
  )
    is also<add-attribute>
  {
    my gint $c = $column;

    gtk_tree_view_column_add_attribute(
      $!gtk-tc,
      $cell_renderer,
      $attribute,
      $column
    );
  }

  proto method cell_get_position (|)
    is also<cell-get-position>
  { *}

  multi method cell_get_position ($cell_renderer) {
    samewith($cell_renderer, $, $);
  }
  multi method cell_get_position (
    GtkCellRenderer() $cell_renderer,
                      $x_offset       is rw,
                      $width          is rw
  ) {
    my gint ($xo, $w) = 0 xx 2;

    gtk_tree_view_column_cell_get_position(
      $!gtk-tc,
      $cell_renderer,
      $xo,
      $w
    );
    ($x_offset, $width) = ($xo, $w);
  }

  proto method cell_get_size (|)
    is also<cell-get-size>
  { * }

  multi method cell_get_size {
    samewith($, $, $, $);
  }
  multi method cell_get_size (
    $x_offset is rw,
    $y_offset is rw,
    $width    is rw,
    $height   is rw
  ) {
    my gint ($xo, $yo, $w, $h) = 0 xx 4;

    gtk_tree_view_column_cell_get_size($!gtk-tc, $xo, $yo, $w, $h);
    ($x_offset, $y_offset, $width, $height) = ($xo, $yo, $w, $h);
  }

  method cell_is_visible is also<cell-is-visible> {
    gtk_tree_view_column_cell_is_visible($!gtk-tc);
  }

  method cell_set_cell_data (
    GtkTreeModel() $tree_model,
    GtkTreeIter()  $iter,
    Int()          $is_expander,
    Int()          $is_expanded
  )
    is also<cell-set-cell-data>
  {
    my gboolean ($i, $e) = ($is_expander, $is_expanded).map( *.so.Int );

    gtk_tree_view_column_cell_set_cell_data(
      $!gtk-tc,
      $tree_model,
      $iter,
      $i,
      $e
    );
  }

  method clear {
    gtk_tree_view_column_clear($!gtk-tc);
  }

  method clear_attributes (GtkCellRenderer() $cell_renderer)
    is also<clear-attributes>
  {
    gtk_tree_view_column_clear_attributes($!gtk-tc, $cell_renderer);
  }

  method clicked {
    gtk_tree_view_column_clicked($!gtk-tc);
  }

  method focus_cell (GtkCellRenderer() $cell) is also<focus-cell> {
    gtk_tree_view_column_focus_cell($!gtk-tc, $cell);
  }

  method get_alignment is also<get-alignment> {
    gtk_tree_view_column_get_alignment($!gtk-tc);
  }

  method get_button is also<get-button> {
    gtk_tree_view_column_get_button($!gtk-tc);
  }

  method get_clickable is also<get-clickable> {
    gtk_tree_view_column_get_clickable($!gtk-tc);
  }

  method get_expand is also<get-expand> {
    gtk_tree_view_column_get_expand($!gtk-tc);
  }

  method get_fixed_width is also<get-fixed-width> {
    gtk_tree_view_column_get_fixed_width($!gtk-tc);
  }

  method get_max_width is also<get-max-width> {
    gtk_tree_view_column_get_max_width($!gtk-tc);
  }

  method get_min_width is also<get-min-width> {
    gtk_tree_view_column_get_min_width($!gtk-tc);
  }

  method get_reorderable is also<get-reorderable> {
    gtk_tree_view_column_get_reorderable($!gtk-tc);
  }

  method get_resizable is also<get-resizable> {
    gtk_tree_view_column_get_resizable($!gtk-tc);
  }

  method get_sizing ( :$enum = True ) is also<get-sizing> {
    my $s = gtk_tree_view_column_get_sizing($!gtk-tc);
    return $s unless $enum;
    GtkTreeViewColumnSizingEnum($s);
  }

  method get_sort_column_id is also<get-sort-column-id> {
    gtk_tree_view_column_get_sort_column_id($!gtk-tc);
  }

  method get_sort_indicator is also<get-sort-indicator> {
    gtk_tree_view_column_get_sort_indicator($!gtk-tc);
  }

  method get_sort_order ( :$enum = True ) is also<get-sort-order> {
    my $s = gtk_tree_view_column_get_sort_order($!gtk-tc);
    return $s unless $enum;
    GtkSortTypeEnum($s);
  }

  method get_spacing is also<get-spacing> {
    gtk_tree_view_column_get_spacing($!gtk-tc);
  }

  method get_title is also<get-title> {
    gtk_tree_view_column_get_title($!gtk-tc);
  }

  method get_tree_view ( :$raw = False ) is also<get-tree-view> {
    propReturnObject(
      gtk_tree_view_column_get_tree_view($!gtk-tc),
      $raw,
      |::('GTK::Tree::View').getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_view_column_get_type, $n, $t );
  }

  method get_visible is also<get-visible> {
    gtk_tree_view_column_get_visible($!gtk-tc);
  }

  method get_widget is also<get-widget> {
    gtk_tree_view_column_get_widget($!gtk-tc);
  }

  method get_width is also<get-width> {
    gtk_tree_view_column_get_width($!gtk-tc);
  }

  method get_x_offset is also<get-x-offset> {
    gtk_tree_view_column_get_x_offset($!gtk-tc);
  }

  method push (GtkCellRenderer() $cell, :$expand = False, :$end = False) {
    $end ?? $.pack_end($cell, $expand)
         !! $.pack_start($cell, $expand)
  }

  method pack_end (GtkCellRenderer() $cell, Int() $expand)
    is also<pack-end>
  {
    my gboolean $e = $expand.so.Int;

    gtk_tree_view_column_pack_end($!gtk-tc, $cell, $e);
  }

  method pack_start (GtkCellRenderer() $cell, Int() $expand)
    is also<pack-start>
  {
    my gboolean $e = $expand.so.Int;
    gtk_tree_view_column_pack_start($!gtk-tc, $cell, $e);
  }

  method queue_resize is also<queue-resize> {
    gtk_tree_view_column_queue_resize($!gtk-tc);
  }

  method set_alignment (Num() $xalign) is also<set-alignment> {
    my gfloat $x = $xalign;

    gtk_tree_view_column_set_alignment($!gtk-tc, $x);
  }

  proto method set_attributes (|)
    is also<set-attributes>
  { * }

  multi method set_attributes ($cell_renderer, *%a) {
    samewith( $cell_renderer, |%a.kv );
  }
  multi method set_attributes (GtkCellRenderer() $cell_renderer, *@a ) {
    $.add-attribute($cell_renderer, |$_ ) for @a.rotor(2);
  }

  method set_cell_data_func (
    GtkCellRenderer() $cell_renderer,
                      &func,
    gpointer          $func_data       = gpointer,
                      &destroy         = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-cell-data-func>
  {
    gtk_tree_view_column_set_cell_data_func(
      $!gtk-tc,
      $cell_renderer,
      &func,
      $func_data,
      &destroy
    );
  }

  method set_clickable (Int() $clickable) is also<set-clickable> {
    my gboolean $c = $clickable.so.Int;

    gtk_tree_view_column_set_clickable($!gtk-tc, $c);
  }

  method set_expand (Int() $expand) is also<set-expand> {
    my gboolean $e = $expand.so.Int;

    gtk_tree_view_column_set_expand($!gtk-tc, $e);
  }

  method set_fixed_width (Int() $fixed_width) is also<set-fixed-width> {
    my gint $f = $fixed_width;

    gtk_tree_view_column_set_fixed_width($!gtk-tc, $f);
  }

  method set_max_width (Int() $max_width) is also<set-max-width> {
    my gint $m = $max_width;

    gtk_tree_view_column_set_max_width($!gtk-tc, $m);
  }

  method set_min_width (Int() $min_width) is also<set-min-width> {
    my gint $m = $min_width;

    gtk_tree_view_column_set_min_width($!gtk-tc, $m);
  }

  method set_reorderable (Int() $reorderable) is also<set-reorderable> {
    my gboolean $r = $reorderable.so.Int;

    gtk_tree_view_column_set_reorderable($!gtk-tc, $r);
  }

  method set_resizable (Int() $resizable) is also<set-resizable> {
    my gboolean $r = $resizable.so.Int;

    gtk_tree_view_column_set_resizable($!gtk-tc, $r);
  }

  method set_sizing (Int() $type) is also<set-sizing> {
    my GtkTreeViewColumnSizing $t = $type;

    gtk_tree_view_column_set_sizing($!gtk-tc, $t);
  }

  method set_sort_column_id (Int() $sort_column_id)
    is also<set-sort-column-id>
  {
    my gint $s = $sort_column_id;

    gtk_tree_view_column_set_sort_column_id($!gtk-tc, $s);
  }

  method set_sort_indicator (Int() $setting) is also<set-sort-indicator> {
    my gboolean $s = $setting.so.Int;

    gtk_tree_view_column_set_sort_indicator($!gtk-tc, $s);
  }

  method set_sort_order (Int() $order) is also<set-sort-order> {
    my GtkSortType $o = $order;

    gtk_tree_view_column_set_sort_order($!gtk-tc, $o);
  }

  method set_spacing (Int() $spacing) is also<set-spacing> {
    my gint $s = $spacing;

    gtk_tree_view_column_set_spacing($!gtk-tc, $s);
  }

  method set_title (Str() $title) is also<set-title> {
    gtk_tree_view_column_set_title($!gtk-tc, $title);
  }

  method set_visible (Int() $visible) is also<set-visible> {
    my gboolean $v = $visible.so.Int;

    gtk_tree_view_column_set_visible($!gtk-tc, $v);
  }

  method set_widget (GtkWidget() $widget) is also<set-widget> {
    gtk_tree_view_column_set_widget($!gtk-tc, $widget);
  }

}

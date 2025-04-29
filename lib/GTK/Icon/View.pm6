use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Icon::View:ver<4>;

use GLib::GList;
use GTK::Cell::Area:ver<4>;
use GTK::Cell::Renderer:ver<4>;
use GTK::Tree::Path:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkIconViewAncestry is export of Mu
  where GtkIconView | GtkWidgetAncestry;

class GTK::Icon::View:ver<4> is GTK::Widget {
  also does GTK::Roles::Signals::Generic;

  has GtkIconView $!gtk-iv is implementor;

  submethod BUILD ( :$gtk-icon-view ) {
    self.setGtkIconView($gtk-icon-view) if $gtk-icon-view
  }

  method setGtkIconView (GtkIconViewAncestry $_) {
    my $to-parent;

    $!gtk-iv = do {
      when GtkIconView {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkIconView, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkIconView
    is also<GtkIconView>
  { $!gtk-iv }

  multi method new (
    $gtk-icon-view where * ~~ GtkIconViewAncestry,

    :$ref = True
  ) {
    return unless $gtk-icon-view;

    my $o = self.bless( :$gtk-icon-view );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-icon-view = gtk_icon_view_new();

    $gtk-icon-view ?? self.bless( :$gtk-icon-view ) !! Nil;
  }

  method new_with_area (GtkCellArea() $area) is also<new-with-area> {
    my $gtk-icon-view = gtk_icon_view_new_with_area($area);

    $gtk-icon-view ?? self.bless( :$gtk-icon-view ) !! Nil;
  }

  method new_with_model (GtkTreeModel() $model) is also<new-with-model> {
    my $gtk-icon-view = gtk_icon_view_new_with_model($model);

    $gtk-icon-view ?? self.bless( :$gtk-icon-view ) !! Nil;
  }

  # Type: boolean
  method activate-on-single-click
    is rw
    is g-property
    is also<activate_on_single_click>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activate-on-single-click', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activate-on-single-click', $gv);
      }
    );
  }

  # Type: GtkCellArea
  method cell-area ( :$raw = False ) is rw  is g-property is also<cell_area> {
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

  # Type: int
  method column-spacing is rw  is g-property is also<column_spacing> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('column-spacing', $gv);
      }
    );
  }

  # Type: int
  method columns is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('columns', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('columns', $gv);
      }
    );
  }

  # Type: GtkOrientation
  method item-orientation ( :$enum = True )
    is rw
    is g-property
    is also<item_orientation>
  {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkOrientation) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-orientation', $gv);
        my $o = $gv.enum;
        return $o unless $enum;
        GtkOrientationEnum($o);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkOrientation) = $val;
        self.prop_set('item-orientation', $gv);
      }
    );
  }

  # Type: int
  method item-padding is rw  is g-property is also<item_padding> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-padding', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('item-padding', $gv);
      }
    );
  }

  # Type: int
  method item-width is rw  is g-property is also<item_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('item-width', $gv);
      }
    );
  }

  # Type: int
  method margin is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('margin', $gv);
      }
    );
  }

  # Type: int
  method markup-column is rw  is g-property is also<markup_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('markup-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('markup-column', $gv);
      }
    );
  }

  # Type: GtkTreeModel
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Tree::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Tree::Model.getTypePair
        );
      },
      STORE => -> $, GtkTreeModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: int
  method pixbuf-column is rw  is g-property is also<pixbuf_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixbuf-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixbuf-column', $gv);
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

  # Type: int
  method row-spacing is rw  is g-property is also<row_spacing> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('row-spacing', $gv);
      }
    );
  }

  # Type: GtkSelectionMode
  method selection-mode ( :$enum = True )
    is rw
    is g-property
    is also<selection_mode>
  {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkSelectionMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selection-mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum
        GtkSelectionModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSelectionMode) = $val;
        self.prop_set('selection-mode', $gv);
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

  # Type: int
  method text-column is rw  is g-property is also<text_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('text-column', $gv);
      }
    );
  }

  # Type: int
  method tooltip-column is rw  is g-property is also<tooltip_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('tooltip-column', $gv);
      }
    );
  }

  method Activate-Cursor-Item is also<Activate_Cursor_Item> {
    self.connect($!gtk-iv, 'activate-cursor-item');
  }

  method Item-Activated is also<Item_Activated> {
    self.connect-treepath($!gtk-iv, 'item-activated');
  }

  method Move-Cursor is also<Move_Cursor> {
    self.connect-move-cursor($!gtk-iv);
  }

  method Select-All is also<Select_All> {
    self.connect($!gtk-iv, 'select-all');
  }

  method Select-Cursor-Item is also<Select_Cursor_Item> {
    self.connect($!gtk-iv, 'select-cursor-item');
  }

  method Selection-Changed is also<Selection_Changed> {
    self.connect($!gtk-iv, 'selection-changed');
  }

  method Toggle-Cursor-Item is also<Toggle_Cursor_Item> {
    self.connect($!gtk-iv, 'toggle-cursor-item');
  }

  method Unselect-All is also<Unselect_All> {
    self.connect($!gtk-iv, 'unselect-all');
  }

  method create_drag_icon (GtkTreePath() $path) is also<create-drag-icon> {
    gtk_icon_view_create_drag_icon($!gtk-iv, $path);
  }

  method enable_model_drag_dest (GdkContentFormats() $formats,Int() $actions)
    is also<enable-model-drag-dest>
  {
    my GdkDragAction $a = $actions;

    gtk_icon_view_enable_model_drag_dest($!gtk-iv, $formats, $a);
  }

  method enable_model_drag_source (
    Int()               $start_button_mask,
    GdkContentFormats() $formats,
    Int()               $actions
  )
    is also<enable-model-drag-source>
  {
    my GdkModifierType $s = $start_button_mask;
    my GdkDragAction   $a = $actions;

    gtk_icon_view_enable_model_drag_source($!gtk-iv, $s, $formats, $a);
  }

  method get_activate_on_single_click is also<get-activate-on-single-click> {
    so gtk_icon_view_get_activate_on_single_click($!gtk-iv);
  }

  proto method get_cell_rect (|)
    is also<get-cell-rect>
  { * }

  multi method get_cell_rect ($path, $cell, :$raw = False) {
    samewith($path, $cell, GdkRectangle.new, :$raw);
  }
  multi method get_cell_rect (
    GtkTreePath()      $path,
    GtkCellRenderer()  $cell,
    GdkRectangle()     $rect,
                      :$raw   = False
  ) {
    my $rv = gtk_icon_view_get_cell_rect($!gtk-iv, $path, $cell, $rect);
    return Nil unless $rv;
    propReturnObject($rect, $raw, |GDK::Rectangle.getTypePair);

  }

  method get_column_spacing is also<get-column-spacing> {
    gtk_icon_view_get_column_spacing($!gtk-iv);
  }

  method get_columns is also<get-columns> {
    gtk_icon_view_get_columns($!gtk-iv);
  }

  proto method get_cursor (|)
    is also<get-cursor>
  { * }

  method get_cursor {
    samewith( newCArray(GtkTreePath), newCArray(GtkCellRenderer) );
  }
  method get_cursor (
    CArray[GtkTreePath]              $path,
    CArray[Pointer[GtkCellRenderer]] $cell
  ) {
    my $rv = gtk_icon_view_get_cursor($!gtk-iv, $path, $cell);
    return Nil unless $rv;

    (
      propReturnObject(ppr($path), $raw, |GTK::Tree::Path.getTypePair),
      propReturnObject(ppr($cell), $raw, |GTK::Cell::Renderer.getTypePair)
    );
  }

  proto method get_dest_item_at_pos (|)
    is also<get-dest-item-at-pos>
  { * }

  multi method get_dest_item_at_pos ($drag_x, $drag_y, :$raw = False) {
    samewith($drag_x, $drag_y, newCArray(GtkTreePath), $, :$raw)
  }
  multi method get_dest_item_at_pos (
    Int()               $drag_x,
    Int()               $drag_y,
    CArray[GtkTreePath] $path,
                        $pos     is rw
  ) {
    my gint                    ($dx, $dy) = ($drag_x, $drag_y);
    my GtkIconViewDropPosition  $p        =  0;

    my $rv = gtk_icon_view_get_dest_item_at_pos($!gtk-iv, $dx, $dy, $path, $p);
    return Nil unless $rv;

    (
      propReturnObject( ppr($path), $raw, |GTK::Tree::Path.getTypePair ),
      $pos = $p
    );
  }

  proto method get_drag_dest_item (|)
    is also<get-drag-dest-item>
  { * }

  multi method get_drag_dest_item ( :$raw = False ) {
    samewith( newCArray(GtkTreePath), $, :$raw )
  }
  multi method get_drag_dest_item (
    CArray[GtkTreePath] $path,
                        $pos    is rw
  ) {
    my GtkIconViewDropPosition $p = 0;

    gtk_icon_view_get_drag_dest_item($!gtk-iv, $path, $p);

    (
      propReturnObject( ppr($path), $raw, |GTK::Tree::Path.getTypePair ),
      $pos = $p
    );
  }

  proto method get_item_at_pos (|)
    is also<get-item-at-pos>
  { * }

  multi method get_item_at_pos ($x, $y, :$raw = False) {
    samewith(
       $x,
       $y,
       newCArray(GtkTreePath),
       newCArray(GtkCellRenderer,
      :$raw
    )
  }
  multi method get_item_at_pos (
    Int()                             $x,
    Int()                             $y,
    CArray[GtkTreePath]               $path,
    CArray[Pointer[GtkCellRenderer]]  $cell,
                                     :$raw   = False
  ) {
    my $rv = gtk_icon_view_get_item_at_pos($!gtk-iv, $x, $y, $path, $cell);
    return Nil unless $rv;

    (
      propReturnObject( ppr($path), $raw, |GTK::Tree::Path.getTypePair ),
      propReturnObject( ppr($cell), $raw, |GTK::Cell::Renderer.getTypePair )
    );
  }

  method get_item_column (GtkTreePath() $path) is also<get-item-column> {
    gtk_icon_view_get_item_column($!gtk-iv, $path);
  }

  method get_item_orientation ( :$enum = True ) is also<get-item-orientation> {
    my $o = gtk_icon_view_get_item_orientation($!gtk-iv);
    return $o unless $enum;
    GtkOrientationEnum($o);
  }

  method get_item_padding is also<get-item-padding> {
    gtk_icon_view_get_item_padding($!gtk-iv);
  }

  method get_item_row (GtkTreePath() $path) is also<get-item-row> {
    gtk_icon_view_get_item_row($!gtk-iv, $path);
  }

  method get_item_width is also<get-item-width> {
    gtk_icon_view_get_item_width($!gtk-iv);
  }

  method get_margin is also<get-margin> {
    gtk_icon_view_get_margin($!gtk-iv);
  }

  method get_markup_column is also<get-markup-column> {
    gtk_icon_view_get_markup_column($!gtk-iv);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_icon_view_get_model($!gtk-iv),
      $raw,
      |GTK::Tree::Model.getTypePair
    );
  }

  method get_path_at_pos (Int() $x, Int() $y) is also<get-path-at-pos> {
    my gint ($xx, $yy) = ($x, $y);

    propReturnObject(
      gtk_icon_view_get_path_at_pos($!gtk-iv, $xx, $yy),
      $raw,
      |GTK::Tree::Path.getTypePair
    );
  }

  method get_pixbuf_column is also<get-pixbuf-column> {
    gtk_icon_view_get_pixbuf_column($!gtk-iv);
  }

  method get_reorderable is also<get-reorderable> {
    gtk_icon_view_get_reorderable($!gtk-iv);
  }

  method get_row_spacing is also<get-row-spacing> {
    gtk_icon_view_get_row_spacing($!gtk-iv);
  }

  method get_selected_items ( :$raw = False, :gslist(:$glist) = False )
    is also<get-selected-items>
  {
    returnGList(
      gtk_icon_view_get_selected_items($!gtk-iv),
      $raw,
      $glist,
      |GTK::Tree::Path.getTypePair
    );
  }

  method get_selection_mode ( :$enum = True ) is also<get-selection-mode> {
    my $m = gtk_icon_view_get_selection_mode($!gtk-iv);
    return $m unless $enum;
    GtkSelectionModeEnum($m);
  }

  method get_spacing is also<get-spacing> {
    gtk_icon_view_get_spacing($!gtk-iv);
  }

  method get_text_column is also<get-text-column> {
    gtk_icon_view_get_text_column($!gtk-iv);
  }

  method get_tooltip_column is also<get-tooltip-column> {
    gtk_icon_view_get_tooltip_column($!gtk-iv);
  }

  proto method get_tooltip_context (|)
    is also<get-tooltip-context>
  { * }

  multi method get_tooltip_context ($x, $y, $keyboard_tip, :$raw = False) {
    samewith(
       $x,
       $y,
       $keyboard_tip,
       newCArray(GtkTreeModel),
       newCArray(GtkTreePath),
       GtkTreeIter.new,
      :$raw
    );
  }
  multi method get_tooltip_context (
    Int()                $x,
    Int()                $y,
    Int()                $keyboard_tip,
    CArray[GtkTreeModel] $model,
    CArray[GtkTreePath]  $path,
    GtkTreeIter          $iter
  ) {
    my gint     ($xx, $yy) = ($x, $y);
    my gboolean  $k        =  $keyboard_tip.so.Int;

    my $rv = gtk_icon_view_get_tooltip_context(
      $!gtk-iv,
      $xx,
      $yy,
      $k,
      $model,
      $path,
      $iter
    );
    return Nil unless $rv;

    (
      propReturnObject( ppr($model), $raw, |GTK::Tree::Model.getTypePair ),
      propReturnObject( ppr($path),  $raw, |GTK::Tree::Path. getTypePair ),
      propReturnObject( $iter,       $raw, |GTK::Tree::Iter. getTypePair )
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_icon_view_get_type, $n, $t );
  }

  proto method get_visible_range (|)
    is also<get-visible-range>
  { * }

  multi method get_visible_range ( :$raw = False ) {
    samewith( newCArray(GtkTreePath), newCArray(GtkTreePath) );
  }
  multi method get_visible_range (
    CArray[GtkTreePath]  $start_path,
    CArray[GtkTreePath]  $end_path,
                        :$raw          = False
  ) {
    my $rv = gtk_icon_view_get_visible_range($!gtk-iv, $start_path, $end_path);
    return Nil unless $rv;

    (
      propReturnObject( ppr($start_path), $raw, |GTK::Tree::Path.getTypePair,
      propReturnObject( ppr($end_path),   $raw, |GTK::Tree::Path.getTypePair
    )
  }

  method item_activated (GtkTreePath() $path) is also<item-activated> {
    gtk_icon_view_item_activated($!gtk-iv, $path);
  }

  method path_is_selected (GtkTreePath() $path) is also<path-is-selected> {
    gtk_icon_view_path_is_selected($!gtk-iv, $path);
  }

  method scroll_to_path (
    GtkTreePath() $path,
    Int()         $use_align,

    Num()         $row_align,
    Num()         $col_align
  )
    is also<scroll-to-path>
  {
    my gboolean  $u      =  $use_align.so.Int;
    my gfloat   ($r, $c) = ($row_align, $col_align);

    gtk_icon_view_scroll_to_path($!gtk-iv, $path, $u, $r, $c);
  }

  method select_all is also<select-all> {
    gtk_icon_view_select_all($!gtk-iv);
  }

  method select_path (GtkTreePath() $path) is also<select-path> {
    gtk_icon_view_select_path($!gtk-iv, $path);
  }

  method selected_foreach (&func, gpointer $data = gpointer)
    is also<selected-foreach>
  {
    gtk_icon_view_selected_foreach($!gtk-iv, &func, $data);
  }

  method set_activate_on_single_click (Int() $single)
    is also<set-activate-on-single-click>
  {
    my gboolean $s = $single.so.Int;

    gtk_icon_view_set_activate_on_single_click($!gtk-iv, $s);
  }

  method set_column_spacing (Int() $column_spacing)
    is also<set-column-spacing>
  {
    my gint $c = $column_spacing;

    gtk_icon_view_set_column_spacing($!gtk-iv, $c);
  }

  method set_columns (Int() $columns) is also<set-columns> {
    my gint $c = $columns;

    gtk_icon_view_set_columns($!gtk-iv, $c);
  }

  method set_cursor (
    GtkTreePath()     $path,
    GtkCellRenderer() $cell,
    Int()             $start_editing
  )
    is also<set-cursor>
  {
    my gboolean $s = $start_editing.so.Int;

    gtk_icon_view_set_cursor($!gtk-iv, $path, $cell, $s);
  }

  method set_drag_dest_item (GtkTreePath() $path, Int() $pos)
    is also<set-drag-dest-item>
  {
    my GtkIconViewDropPosition $p = $pos;

    gtk_icon_view_set_drag_dest_item($!gtk-iv, $path, $p);
  }

  method set_item_orientation (Int() $orientation)
    is also<set-item-orientation>
  {
    my GtkOrientation $o = $orientation;

    gtk_icon_view_set_item_orientation($!gtk-iv, $o);
  }

  method set_item_padding (Int() $item_padding) is also<set-item-padding> {
    muy gint $i = $item_padding;

    gtk_icon_view_set_item_padding($!gtk-iv, $i);
  }

  method set_item_width (Int() $item_width) is also<set-item-width> {
    my gint $i = $item_width;

    gtk_icon_view_set_item_width($!gtk-iv, $i);
  }

  method set_margin (Int() $margin) is also<set-margin> {
    my gint $m = $margin;

    gtk_icon_view_set_margin($!gtk-iv, $m);
  }

  method set_markup_column (Int() $column) is also<set-markup-column> {
    my gint $c = $column;

    gtk_icon_view_set_markup_column($!gtk-iv, $c);
  }

  method set_model (GtkTreeModel() $model) is also<set-model> {
    gtk_icon_view_set_model($!gtk-iv, $model);
  }

  method set_pixbuf_column (Int() $column) is also<set-pixbuf-column> {
    my gint $c = $column;

    gtk_icon_view_set_pixbuf_column($!gtk-iv, $c);
  }

  method set_reorderable (Int() $reorderable) is also<set-reorderable> {
    my gboolean $r = $reorderable.so.Int;

    gtk_icon_view_set_reorderable($!gtk-iv, $r);
  }

  method set_row_spacing (Int() $row_spacing) is also<set-row-spacing> {
    my gint $r = $row_spacing;

    gtk_icon_view_set_row_spacing($!gtk-iv, $r);
  }

  method set_selection_mode (Int() $mode) is also<set-selection-mode> {
    my GtkSelectionMode $m = $mode;

    gtk_icon_view_set_selection_mode($!gtk-iv, $m);
  }

  method set_spacing (Int() $spacing) is also<set-spacing> {
    my gint $s = $spacing;

    gtk_icon_view_set_spacing($!gtk-iv, $s);
  }

  method set_text_column (Int() $column) is also<set-text-column> {
    my gint $c = $column;

    gtk_icon_view_set_text_column($!gtk-iv, $c);
  }

  method set_tooltip_cell (
    GtkTooltip()      $tooltip,
    GtkTreePath()     $path,
    GtkCellRenderer() $cell
  )
    is also<set-tooltip-cell>
  {
    gtk_icon_view_set_tooltip_cell($!gtk-iv, $tooltip, $path, $cell);
  }

  method set_tooltip_column (Int() $column) is also<set-tooltip-column> {
    my gint $c = $column;

    gtk_icon_view_set_tooltip_column($!gtk-iv, $c);
  }

  method set_tooltip_item (GtkTooltip() $tooltip, GtkTreePath() $path)
    is also<set-tooltip-item>
  {
    gtk_icon_view_set_tooltip_item($!gtk-iv, $tooltip, $path);
  }

  method unselect_all is also<unselect-all> {
    gtk_icon_view_unselect_all($!gtk-iv);
  }

  method unselect_path (GtkTreePath() $path) is also<unselect-path> {
    gtk_icon_view_unselect_path($!gtk-iv, $path);
  }

  method unset_model_drag_dest is also<unset-model-drag-dest> {
    gtk_icon_view_unset_model_drag_dest($!gtk-iv);
  }

  method unset_model_drag_source is also<unset-model-drag-source> {
    gtk_icon_view_unset_model_drag_source($!gtk-iv);
  }

}

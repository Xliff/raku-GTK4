use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::View:ver<4>;

use GLib::GList;
use GTK::Widget:ver<4>;
use GTK::Tree::Path:ver<4>;
use GTK::Tree::View::Column:ver<4>;

constant TP  := GTK::Tree::Path;
constant TVC := GTK::Tree::View::Column;

use GTK::Roles::Signals::Tree::View:ver<4>;

our subset GtkTreeViewAncestry is export of Mu
  where GtkTreeView | GtkWidgetAncestry;

class GTK::Tree::View is GTK::Widget {
  also does GTK::Roles::Signals::Tree::View;

  has GtkTreeView $!gtk-tv is implementor;

  submethod BUILD ( :$gtk-tree-view ) {
    self.setGtkTreeView($gtk-tree-view) if $gtk-tree-view
  }

  method setGtkTreeView (GtkTreeViewAncestry $_) {
    my $to-parent;

    $!gtk-tv = do {
      when GtkTreeView {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeView, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeView
    is also<GtkTreeView>
  { $!gtk-tv }

  multi method new (
    $gtk-tree-view where * ~~ GtkTreeViewAncestry ,

    :$ref = True
  ) {
    return unless $gtk-tree-view;

    my $o = self.bless( :$gtk-tree-view );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-tree-view = gtk_tree_view_new();

    my $o = $gtk-tree-view ?? self.bless( :$gtk-tree-view ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_model (GtkTreeModel() $model, *%a)
    is also<new-with-model>
  {
    my $gtk-tree-view = gtk_tree_view_new_with_model($!gtk-tv, $model);

    my $o = $gtk-tree-view ?? self.bless( :$gtk-tree-view ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
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

  # Type: GtkTreeViewGridLines
  method enable-grid-lines ( :$enum = True )
    is rw
    is g-property
    is also<enable_grid_lines>
  {
    my $gv = GLib::Value.new(
      GLib::Value.new-enum(GtkTreeViewGridLines)
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-grid-lines', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        GtkTreeViewGridLinesEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.value-from-enum(GtkTreeViewGridLines) = $val;
        self.prop_set('enable-grid-lines', $gv);
      }
    );
  }

  # Type: boolean
  method enable-search
    is rw
    is g-property
    is also<enable_search>
  {
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

  # Type: boolean
  method enable-tree-lines
    is rw
    is g-property
    is also<enable_tree_lines>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-tree-lines', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-tree-lines', $gv);
      }
    );
  }

  # Type: GtkTreeViewColumn
  method expander-column ( :$raw = False )
    is rw
    is g-property
    is also<expander_column>
  {
    my $gv = GLib::Value.new( GTK::Tree::View::Column.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expander-column', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Tree::View::Column.getTypePair
        );
      },
      STORE => -> $, GtkTreeViewColumn() $val is copy {
        $gv.object = $val;
        self.prop_set('expander-column', $gv);
      }
    );
  }

  # Type: boolean
  method fixed-height-mode
    is rw
    is g-property
    is also<fixed_height_mode>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fixed-height-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fixed-height-mode', $gv);
      }
    );
  }

  # Type: boolean
  method headers-clickable
    is rw
    is g-property
    is also<headers_clickable>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('headers-clickable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('headers-clickable', $gv);
      }
    );
  }

  # Type: boolean
  method headers-visible
    is rw
    is g-property
    is also<headers_visible>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('headers-visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('headers-visible', $gv);
      }
    );
  }

  # Type: boolean
  method hover-expand
    is rw
    is g-property
    is also<hover_expand>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hover-expand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hover-expand', $gv);
      }
    );
  }

  # Type: boolean
  method hover-selection
    is rw
    is g-property
    is also<hover_selection>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hover-selection', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hover-selection', $gv);
      }
    );
  }

  # Type: int
  method level-indentation
    is rw
    is g-property
    is also<level_indentation>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('level-indentation', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('level-indentation', $gv);
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
  method rubber-banding
    is rw
    is g-property
    is also<rubber_banding>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rubber-banding', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('rubber-banding', $gv);
      }
    );
  }

  # Type: int
  method search-column
    is rw
    is g-property
    is also<search_column>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('search-column', $gv);
      }
    );
  }

  # Type: boolean
  method show-expanders
    is rw
    is g-property
    is also<show_expanders>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-expanders', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-expanders', $gv);
      }
    );
  }

  # Type: int
  method tooltip-column
    is rw
    is g-property
    is also<tooltip_column>
  {
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

  # Is originally:
  # GtkTreeView *tree_view --> void
  method Columns-Changed is also<Columns_Changed> {
    self.connect($!gtk-tv, 'columns-changed');
  }

  # Is originally:
  # GtkTreeView *tree_view --> void
  method Cursor-Changed is also<Cursor_Changed> {
    self.connect($!gtk-tv, 'cursor-changed');
  }

  # Is originally:
  # GtkTreeView *tree_view,  gboolean logical,  gboolean expand,  gboolean open_all --> gboolean
  method Expand-Collapse-Cursor-Row is also<Expand_Collapse_Cursor_Row> {
    self.connect-expand-collapse-cursor-row($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view,  GtkMovementStep step,  int count,  gboolean extend,  gboolean modify --> gboolean
  method Move-Cursor is also<Move_Cursor> {
    self.connect-move-cursor($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view,  GtkTreePath *path,  GtkTreeViewColumn *column --> void
  method Row-Activated is also<Row_Activated> {
    self.connect-row-activated($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path --> void
  method Row-Collapsed is also<Row_Collapsed> {
    self.connect-row-collapsed($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path --> void
  method Row-Expanded is also<Row_Expanded> {
    self.connect-row-expanded($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view --> gboolean
  method Select-All is also<Select_All> {
    self.connect-rbool($!gtk-tv, 'select-all');
  }

  # Is originally:
  # GtkTreeView *tree_view --> gboolean
  method Select-Cursor-Parent is also<Select_Cursor_Parent> {
    self.connect-rbool($!gtk-tv, 'select-cursor-parent');
  }

  # Is originally:
  # GtkTreeView *tree_view,  gboolean start_editing --> gboolean
  method Select-Cursor-Row is also<Select_Cursor_Row> {
    self.connect-rbool($!gtk-tv, 'select-cursor-row');
  }

  # Is originally:
  # GtkTreeView *tree_view --> gboolean
  method Start-Interactive-Search is also<Start_Interactive_Search> {
    self.connect-rbool($!gtk-tv, 'start-interactive-search');
  }

  # Is originally:
  # GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path --> gboolean
  method Test-Collapse-Row is also<Test_Collapse_Row> {
    self.connect-test-collapse-row($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path --> gboolean
  method Test-Expand-Row is also<Test_Expand_Row> {
    self.connect-test-expand-row($!gtk-tv);
  }

  # Is originally:
  # GtkTreeView *tree_view --> gboolean
  method Toggle-Cursor-Row is also<Toggle_Cursor_Row> {
    self.connect-rbool($!gtk-tv, 'toggle-cursor-row');
  }

  # Is originally:
  # GtkTreeView *tree_view --> gboolean
  method Unselect-All is also<Unselect_All> {
    self.connect-rbool($!gtk-tv, 'unselect-all');
  }

  method append_column (GtkTreeViewColumn() $column) is also<append-column> {
    gtk_tree_view_append_column($!gtk-tv, $column);
  }

  method collapse_all is also<collapse-all> {
    gtk_tree_view_collapse_all($!gtk-tv);
  }

  method collapse_row (GtkTreePath() $path) is also<collapse-row> {
    gtk_tree_view_collapse_row($!gtk-tv, $path);
  }

  method columns_autosize is also<columns-autosize> {
    gtk_tree_view_columns_autosize($!gtk-tv);
  }

  proto method convert_bin_window_to_tree_coords (|)
    is also<convert-bin-window-to-tree-coords>
  { * }

  multi method convert_bin_window_to_tree_coords ($bx, $by) {
    samewith($bx, $by, $, $);
  }
  multi method convert_bin_window_to_tree_coords (
    Int() $bx,
    Int() $by,
          $tx is rw,
          $ty is rw
  ) {
    my gint ($x, $y, $ttx, $tty) = ($bx, $by, 0, 0);

    gtk_tree_view_convert_bin_window_to_tree_coords(
      $!gtk-tv,
      $x,
      $y,
      $ttx,
      $tty
    );

    ($tx, $ty) = ($ttx, $tty);
  }

  proto method convert_bin_window_to_widget_coords (|)
    is also<convert-bin-window-to-widget-coords>
  { * }

  multi method convert_bin_window_to_widget_coords ($bx, $by) {
    samewith($bx, $by, $, $);
  }
  multi method convert_bin_window_to_widget_coords (
    Int() $bx,
    Int() $by,
          $wx is rw,
          $wy is rw
  ) {
    my gint ($x, $y, $wwx, $wwy) = ($bx, $by, 0, 0);

    gtk_tree_view_convert_bin_window_to_widget_coords(
      $!gtk-tv,
      $bx,
      $by,
      $wwx,
      $wwy
    );

    ($wx, $wy) = ($wwx, $wwy);
  }

  proto method convert_tree_to_bin_window_coords (|)
    is also<convert-tree-to-bin-window-coords>
  { * }

  multi method convert_tree_to_bin_window_coords ($tx, $ty) {
    samewith($tx, $ty, $, $);
  }
  multi method convert_tree_to_bin_window_coords (
    Int() $tx,
    Int() $ty,
          $bx is rw,
          $by is rw
  ) {
    my gint ($x, $y, $bbx, $bby) = ($tx, $ty, 0, 0);

    gtk_tree_view_convert_tree_to_bin_window_coords(
      $!gtk-tv,
      $tx,
      $ty,
      $bbx,
      $bby
    );

    ($bx, $by) = ($bbx, $bby);
  }

  proto method convert_tree_to_widget_coords (|)
    is also<convert-tree-to-widget-coords>
  { * }

  multi method convert_tree_to_widget_coords (Int() $tx, Int() $ty) {
    samewith($tx, $ty, $, $);
  }
  multi method convert_tree_to_widget_coords (
    Int() $tx,
    Int() $ty,
          $wx is rw,
          $wy is rw
  ) {
    my gint ($x, $y, $wwx, $wwy) = ($tx, $ty, 0, 0);

    gtk_tree_view_convert_tree_to_widget_coords(
      $!gtk-tv,
      $tx,
      $ty,
      $wwx,
      $wwy
    );

    ($wx, $wy) = ($wwx, $wwy)
  }

  proto method convert_widget_to_bin_window_coords (|)
    is also<convert-widget-to-bin-window-coords>
  { * }

  multi method convert_widget_to_bin_window_coords ($wx, $wy) {
    samewith($wx, $wy, $, $);
  }
  multi method convert_widget_to_bin_window_coords (
    Int() $wx,
    Int() $wy,
          $bx is rw,
          $by is rw
  ) {
    my gint ($x, $y, $bbx, $bby) = ($wx, $wy, 0, 0);

    gtk_tree_view_convert_widget_to_bin_window_coords(
      $!gtk-tv,
      $x,
      $y,
      $bbx,
      $bby
    );

    ($bbx, $bby) = ($bx, $by)
  }

  proto method convert_widget_to_tree_coords (|)
    is also<convert-widget-to-tree-coords>
  { * }

  multi method convert_widget_to_tree_coords ($wx, $wy) {
    samewith($wx, $wy, $, $);
  }
  multi method convert_widget_to_tree_coords (
    Int() $wx,
    Int() $wy,
          $tx is rw,
          $ty is rw
  ) {
    my gint ($x, $y, $ttx, $tty) = ($wx, $wy, 0, 0);

    gtk_tree_view_convert_widget_to_tree_coords(
      $!gtk-tv,
      $wx,
      $wy,
      $tx,
      $ty
    );

    ($tx, $ty) = ($ttx, $tty);
  }

  method create_row_drag_icon (GtkTreePath() $path) is also<create-row-drag-icon> {
    gtk_tree_view_create_row_drag_icon($!gtk-tv, $path);
  }

  method enable_model_drag_dest (
    GdkContentFormats() $formats,
    Int()               $actions
  )
    is also<enable-model-drag-dest>
  {
    my GdkDragAction $a = $actions;

    gtk_tree_view_enable_model_drag_dest($!gtk-tv, $formats, $a);
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

    gtk_tree_view_enable_model_drag_source($!gtk-tv, $s, $formats, $a);
  }

  method expand_all is also<expand-all> {
    gtk_tree_view_expand_all($!gtk-tv);
  }

  method expand_row (GtkTreePath() $path, Int() $open_all) is also<expand-row> {
    my gboolean $o = $open_all;

    gtk_tree_view_expand_row($!gtk-tv, $path, $o);
  }

  method expand_to_path (GtkTreePath() $path) is also<expand-to-path> {
    gtk_tree_view_expand_to_path($!gtk-tv, $path);
  }

  method get_activate_on_single_click is also<get-activate-on-single-click> {
    so gtk_tree_view_get_activate_on_single_click($!gtk-tv);
  }

  proto method get_background_area (|)
    is also<get-background-area>
  { * }

  multi method get_background_area (GtkTreePath() $path, :$raw = False) {
    samewith($path, GtkTreeViewColumn, GdkRectangle.new, :$raw);
  }
  multi method get_background_area (
    GtkTreePath()        $path,
    GtkTreeViewColumn()  $column,
                        :$raw     = False
  ) {
    samewith($path, $column, GdkRectangle.new);
  }
  multi method get_background_area (
    GtkTreePath()        $path,
    GtkTreeViewColumn()  $column,
    GdkRectangle()       $rect,
                        :$raw     = False
  ) {
    gtk_tree_view_get_background_area($!gtk-tv, $path, $column, $rect);

    propReturnObject($rect, $raw, |GDK::Rectangle.getTypePair)
  }

  proto method get_cell_area (|)
    is also<get-cell-area>
  { * }

  multi method get_cell_area ($path, $column, :$raw = False) {
    samewith($path, $column, GdkRectangle.new, :$raw);
  }
  multi method get_cell_area (
    GtkTreePath()        $path,
    GtkTreeViewColumn()  $column,
    GdkRectangle()       $rect,
                        :$raw     = False
  ) {
    gtk_tree_view_get_cell_area($!gtk-tv, $path, $column, $rect);

    propReturnObject($rect, $raw, |GDK::Rectangle.getTypePair)
  }

  method get_column (Int() $n, :$raw = False) is also<get-column> {
    my gint $nn = $n;

    propReturnObject(
      gtk_tree_view_get_column($!gtk-tv, $nn),
      $raw,
      |GTK::Tree::View::Column.getTypePair
    );
  }

  method get_columns ( :$raw = False, :gslist(:$glist) = False )
    is also<get-columns>
  {
    returnGList(
      gtk_tree_view_get_columns($!gtk-tv),
      $raw,
      $glist,
      |GTK::Tree::View::Column.getTypePair
    );
  }

  proto method get_cursor (|)
    is also<get-cursor>
  { * }

  multi method get_cursor ( :$raw = False ) {
    samewith( newCArray(GtkTreePath), newCArray(GtkTreeViewColumn) );
  }
  multi method get_cursor (
    CArray[GtkTreePath]        $path,
    CArray[GtkTreeViewColumn]  $focus_column,
                              :$raw           = False
  ) {
    gtk_tree_view_get_cursor($!gtk-tv, $path, $focus_column);

    (
      propReturnObject( ppr($path),         :$raw, |TP.getTypePair ),
      propReturnObject( ppr($focus_column), :$raw, |TVC.getTypePair )
    )
  }

  proto method get_dest_row_at_pos (|)
    is also<get-dest-row-at-pos>
  { * }

  multi method get_dest_row_at_pos (
    Int()  $drag_x,
    Int()  $drag_y,
          :$raw     = False,
          :$enum    = True
  ) {
    samewith($drag_x, $drag_y, newCArray(GtkTreePath), $, :$raw, :$enum );
  }
  multi method get_dest_row_at_pos (
    Int()                $drag_x,
    Int()                $drag_y,
    CArray[GtkTreePath]  $path,
                         $pos     is rw,
                        :$raw            = False,
                        :$enum           = True
  ) {
    my GtkTreeViewDropPosition $p = $pos;

    my $rv = gtk_tree_view_get_dest_row_at_pos(
      $!gtk-tv,
      $drag_x,
      $drag_y,
      $path,
      $p
    );

    return Nil unless $rv;

    $pos = $p;
    (
      propReturnObject( ppr($path), $raw, |TP.getTypePair ),
      $enum ?? $p !! GtkTreeViewDropPositionEnum($p)
    )
  }

  proto method get_drag_dest_row (|)
    is also<get-drag-dest-row>
  { * }

  multi method get_drag_dest_row ( :$raw = False ) {
    samewith( newCArray(GtkTreePath), $, :$raw );
  }
  multi method get_drag_dest_row (
    CArray[GtkTreePath]  $path,
                         $pos   is rw,
                        :$raw          = False,
                        :$enum         = True
  ) {
    my GtkTreeViewDropPosition $p = $pos;

    gtk_tree_view_get_drag_dest_row($!gtk-tv, $path, $p);
    $pos = $p;

    (
      propReturnObject( ppr($path), $raw, |TP.getTypePair ),
      $enum ?? $p !! GtkTreeViewDropPositionEnum($p)
    );
  }

  method get_enable_search is also<get-enable-search> {
    so gtk_tree_view_get_enable_search($!gtk-tv);
  }

  method get_enable_tree_lines is also<get-enable-tree-lines> {
    so gtk_tree_view_get_enable_tree_lines($!gtk-tv);
  }

  method get_expander_column ( :$raw = False )
    is also<get-expander-column>
  {
    propReturnObject(
      gtk_tree_view_get_expander_column($!gtk-tv),
      $raw,
      |GTK::Tree::View::Column.getTypePair
    );
  }

  method get_fixed_height_mode is also<get-fixed-height-mode> {
    so gtk_tree_view_get_fixed_height_mode($!gtk-tv);
  }

  method get_grid_lines ( :$enum = True ) is also<get-grid-lines> {
    my $e = gtk_tree_view_get_grid_lines($!gtk-tv);
    return $e unless $enum;
    GtkTreeViewGridLinesEnum($e);
  }

  method get_headers_clickable is also<get-headers-clickable> {
    so gtk_tree_view_get_headers_clickable($!gtk-tv);
  }

  method get_headers_visible is also<get-headers-visible> {
    so gtk_tree_view_get_headers_visible($!gtk-tv);
  }

  method get_hover_expand is also<get-hover-expand> {
    so gtk_tree_view_get_hover_expand($!gtk-tv);
  }

  method get_hover_selection is also<get-hover-selection> {
    so gtk_tree_view_get_hover_selection($!gtk-tv);
  }

  method get_level_indentation is also<get-level-indentation> {
    gtk_tree_view_get_level_indentation($!gtk-tv);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_tree_view_get_model($!gtk-tv),
      $raw,
      |GTK::Tree::Model.getTypePair
    )
  }

  method get_n_columns is also<get-n-columns> {
    gtk_tree_view_get_n_columns($!gtk-tv);
  }

  proto method get_path_at_pos (|)
    is also<get-path-at-pos>
  { * }

  multi method get_path_at_pos ($x, $y) {
    samewith(
      $x,
      $y,
      newCArray(GtkTreePath),
      newCArray(GtkTreeViewColumn),
      $,
      $
    );
  }
  multi method get_path_at_pos (
    Int()                      $x,
    Int()                      $y,
    CArray[GtkTreePath]        $path,
    CArray[GtkTreeViewColumn]  $column,
                               $cell_x is rw,
                               $cell_y is rw,
                              :$raw           = False
  ) {
    my gint ($xx, $yy, $cx, $cy) = ($x, $y, 0, 0);

    gtk_tree_view_get_path_at_pos(
      $!gtk-tv,
      $xx,
      $yy,
      $path,
      $column,
      $cx,
      $cy
    );

    ($cell_x, $cell_y) = ($cx, $cy);

    (
      propReturnObject( ppr($path),   $raw, |TP.getTypePair  ),
      propReturnObject( ppr($column), $raw, |TVC.getTypePair ),
      $cell_x,
      $cell_y
    );
  }

  method get_reorderable is also<get-reorderable> {
    so so gtk_tree_view_get_reorderable($!gtk-tv);
  }

  method get_row_separator_func ( :$raw = False )
    is also<get-row-separator-func>
  {
    my $fp = gtk_tree_view_get_row_separator_func($!gtk-tv);
    return $fp if $raw;
    cast(
      :(GtkTreeModel, GtkTreeIter, gpointer --> gboolean ),
      $fp
    );
  }

  method get_rubber_banding is also<get-rubber-banding> {
    so gtk_tree_view_get_rubber_banding($!gtk-tv);
  }

  method get_search_column is also<get-search-column> {
    gtk_tree_view_get_search_column($!gtk-tv);
  }

  method get_search_entry ( :$raw  = False ) is also<get-search-entry> {
    propReturnObject(
      gtk_tree_view_get_search_entry($!gtk-tv),
      $raw,
      |GTK::Editable.getTypePair
    );
  }

  method get_search_equal_func ( :$raw = False )
    is also<get-search-equal-func>
  {
    my $fp = gtk_tree_view_get_search_equal_func($!gtk-tv);
    return $fp if $raw;
    cast(
      :(GtkTreeModel, gint, Str, GtkTreeIter, gpointer --> gboolean),
      $fp
    );
  }

  method get_selection ( :$raw = False ) is also<get-selection> {
    propReturnObject(
      gtk_tree_view_get_selection($!gtk-tv),
      $raw,
      |GTK::Tree::Selection.getTypePair
    );
  }

  method get_show_expanders is also<get-show-expanders> {
    so gtk_tree_view_get_show_expanders($!gtk-tv);
  }

  method get_tooltip_column is also<get-tooltip-column> {
    gtk_tree_view_get_tooltip_column($!gtk-tv);
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
    Int()                 $x,
    Int()                 $y,
    Int()                 $keyboard_tip,
    CArray[GtkTreeModel]  $model,
    CArray[GtkTreePath]   $path,
    GtkTreeIter()         $iter,
                         :$raw           = False
  ) {
    my gint     ($xx, $yy) = ($x, $y);
    my gboolean  $k        =  $keyboard_tip.so.Int;

    gtk_tree_view_get_tooltip_context(
      $!gtk-tv,
      $xx,
      $yy,
      $k,
      $model,
      $path,
      $iter
    );

    (
      propReturnObject( ppr($model), $raw, |GTK::Tree::Model.getTypePair ),
      propReturnObject( ppr($path),  $raw, |GTK::Tree::Path.getTypePair  ),
      propReturnObject( $iter,       $raw, |GTK::Tree::Iter.getTypePair  )
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_view_get_type, $n, $t );
  }

  proto method get_visible_range (|)
    is also<get-visible-range>
  { * }

  multi method get_visible_range ( :$raw = False ) {
    samewith( |newCArray(GtkTreePath) xx 2, :$raw );
  }
  multi method get_visible_range (
    CArray[GtkTreePath]  $start_path,
    CArray[GtkTreePath]  $end_path,
                        :$raw         = False
  ) {
    gtk_tree_view_get_visible_range($!gtk-tv, $start_path, $end_path);

    (
      propReturnObject( ppr($start_path), $raw, |GTK::Tree::Path.getTypePair ),
      propReturnObject( ppr($end_path),   $raw, |GTK::Tree::Path.getTypePair )
    );
  }

  proto method get_visible_rect (|)
    is also<get-visible-rect>
  { * }

  multi method get_visible_rect ( :$raw = False ) {
    samewith(GdkRectangle.new, :$raw)
  }
  multi method get_visible_rect (GdkRectangle() $visible_rect, :$raw = False) {
    gtk_tree_view_get_visible_rect($!gtk-tv, $visible_rect);

    propReturnObject($visible_rect, $raw, |GDK::Rectangle.getTypePair);
  }

  method insert_column (GtkTreeViewColumn() $column, Int() $position)
    is also<insert-column>
  {
    my gint $p = $position;

    gtk_tree_view_insert_column($!gtk-tv, $column, $p);
  }

  method insert_column_with_data_func (
    Int()             $position,
    Str()             $title,
    GtkCellRenderer() $cell,
                      &func,
    gpointer          $data      = gpointer,
                      &dnotify   = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<insert-column-with-data-func>
  {
    my gint $p = $position;

    gtk_tree_view_insert_column_with_data_func(
      $!gtk-tv,
      $p,
      $title,
      $cell,
      &func,
      $data,
      &dnotify
    );
  }

  proto method is_blank_at_pos (|)
    is also<is-blank-at-pos>
  { * }

  multi method is_blank_at_pos ($x, $y, :$raw = False) {
    samewith(
      $x,
      $y,
      newCArray(GtkTreePath),
      newCArray(GtkTreeViewColumn),
      $,
      $
    );
  }
  multi method is_blank_at_pos (
    Int()                      $x,
    Int()                      $y,
    CArray[GtkTreePath]        $path,
    CArray[GtkTreeViewColumn]  $column,
                               $cell_x is rw,
                               $cell_y is rw,
                              :$raw           = False
  ) {
    my gint ($xx, $yy, $cx, $cy) = ($x, $y, $cell_x, $cell_y);

    gtk_tree_view_is_blank_at_pos(
      $!gtk-tv,
      $xx,
      $yy,
      $path,
      $column,
      $cx,
      $cy
    );

    ($cell_x, $cell_y) = ($cx, $cy);

    (
      propReturnObject( ppr($path),   $raw, |TP.getTypePair  ),
      propReturnObject( ppr($column), $raw, |TVC.getTypePair ),
      $cell_x,
      $cell_y
    );
  }

  method is_rubber_banding_active is also<is-rubber-banding-active> {
    so gtk_tree_view_is_rubber_banding_active($!gtk-tv);
  }

  method map_expanded_rows (
             &func,
    gpointer $data  = gpointer
  )
    is also<map-expanded-rows>
  {
    gtk_tree_view_map_expanded_rows($!gtk-tv, &func, $data);
  }

  method move_column_after (
    GtkTreeViewColumn() $column,
    GtkTreeViewColumn() $base_column
  )
    is also<move-column-after>
  {
    gtk_tree_view_move_column_after($!gtk-tv, $column, $base_column);
  }

  method remove_column (GtkTreeViewColumn() $column)
    is also<remove-column>
  {
    gtk_tree_view_remove_column($!gtk-tv, $column);
  }

  method row_activated (GtkTreePath() $path, GtkTreeViewColumn() $column)
    is also<row-activated>
  {
    gtk_tree_view_row_activated($!gtk-tv, $path, $column);
  }

  method row_expanded (GtkTreePath() $path) is also<row-expanded> {
    gtk_tree_view_row_expanded($!gtk-tv, $path);
  }

  method scroll_to_cell (
    GtkTreePath()       $path,
    GtkTreeViewColumn() $column,
    Int()               $use_align,
    Num()               $row_align,
    Num()               $col_align
  )
    is also<scroll-to-cell>
  {
    my gboolean  $u      =  $use_align.so.Int;
    my gfloat   ($r, $c) = ($row_align, $col_align);

    gtk_tree_view_scroll_to_cell($!gtk-tv, $path, $column, $u, $r, $c);
  }

  method scroll_to_point (Int() $tree_x, Int() $tree_y)
    is also<scroll-to-point>
  {
    my gint ($tx, $ty) = ($tree_x, $tree_y);

    gtk_tree_view_scroll_to_point($!gtk-tv, $tx, $ty);
  }

  method set_activate_on_single_click (Int() $single)
    is also<set-activate-on-single-click>
  {
    my gboolean $s = $single.so.Int;

    gtk_tree_view_set_activate_on_single_click($!gtk-tv, $s);
  }

  method set_column_drag_function (
             &func,
    gpointer $user_data = gpointer,
             &destroy   = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-column-drag-function>
  {
    gtk_tree_view_set_column_drag_function(
      $!gtk-tv,
      &func,
      $user_data,
      &destroy
    );
  }

  method set_cursor (
    GtkTreePath()       $path,
    GtkTreeViewColumn() $focus_column,
    Int()               $start_editing
  )
    is also<set-cursor>
  {
    my gboolean $s = $start_editing.so.Int;

    gtk_tree_view_set_cursor(
      $!gtk-tv,
      $path,
      $focus_column,
      $s
    );
  }

  method set_cursor_on_cell (
    GtkTreePath()       $path,
    GtkTreeViewColumn() $focus_column,
    GtkCellRenderer()   $focus_cell,
    Int()               $start_editing
  )
    is also<set-cursor-on-cell>
  {
    my gboolean $s = $start_editing.so.Int;

    gtk_tree_view_set_cursor_on_cell(
      $!gtk-tv,
      $path,
      $focus_column,
      $focus_cell,
      $s
    );
  }

  method set_drag_dest_row (GtkTreePath() $path, Int() $pos)
    is also<set-drag-dest-row>
  {
    my GtkTreeViewDropPosition $p = $pos;

    gtk_tree_view_set_drag_dest_row($!gtk-tv, $path, $p);
  }

  method set_enable_search (Int() $enable_search)
    is also<set-enable-search>
  {
    my gboolean $e = $enable_search.so.Int;

    gtk_tree_view_set_enable_search($!gtk-tv, $e);
  }

  method set_enable_tree_lines (Int() $enabled)
    is also<set-enable-tree-lines>
  {
    my gboolean $e = $enabled.so.Int;

    gtk_tree_view_set_enable_tree_lines($!gtk-tv, $e);
  }

  method set_expander_column (GtkTreeViewColumn() $column)
    is also<set-expander-column>
  {
    gtk_tree_view_set_expander_column($!gtk-tv, $column);
  }

  method set_fixed_height_mode (Int() $enable)
    is also<set-fixed-height-mode>
  {
    my gboolean $e = $enable.so.Int;

    gtk_tree_view_set_fixed_height_mode($!gtk-tv, $e);
  }

  method set_grid_lines (Int() $grid_lines) is also<set-grid-lines> {
    my GtkTreeViewGridLines $g = $grid_lines;

    gtk_tree_view_set_grid_lines($!gtk-tv, $g);
  }

  method set_headers_clickable (Int() $setting)
    is also<set-headers-clickable>
  {
    my gboolean $s = $setting.so.Int;

    gtk_tree_view_set_headers_clickable($!gtk-tv, $s);
  }

  method set_headers_visible (Int() $headers_visible)
    is also<set-headers-visible>
  {
    my gboolean $h = $headers_visible.so.Int;

    gtk_tree_view_set_headers_visible($!gtk-tv, $h);
  }

  method set_hover_expand (Int() $expand) is also<set-hover-expand> {
    my gboolean $e = $expand.so.Int;

    gtk_tree_view_set_hover_expand($!gtk-tv, $e);
  }

  method set_hover_selection (Int() $hover) is also<set-hover-selection> {
    my gboolean $h = $hover.so.Int;

    gtk_tree_view_set_hover_selection($!gtk-tv, $h);
  }

  method set_level_indentation (Int() $indentation)
    is also<set-level-indentation>
  {
    my gint $i = $indentation;

    gtk_tree_view_set_level_indentation($!gtk-tv, $i);
  }

  method set_model (GtkTreeModel() $model) is also<set-model> {
    gtk_tree_view_set_model($!gtk-tv, $model);
  }

  method set_reorderable (Int() $reorderable) is also<set-reorderable> {
    my gboolean $r = $reorderable.so.Int;

    gtk_tree_view_set_reorderable($!gtk-tv, $r);
  }

  method set_row_separator_func (
             &func,
    gpointer $data    = gpointer,
             &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-row-separator-func>
  {
    gtk_tree_view_set_row_separator_func($!gtk-tv, &func, $data, &destroy);
  }

  method set_rubber_banding (Int() $enable) is also<set-rubber-banding> {
    my gboolean $e = $enable.so.Int;

    gtk_tree_view_set_rubber_banding($!gtk-tv, $e);
  }

  method set_search_column (Int() $column) is also<set-search-column> {
    my gint $c = $column;

    gtk_tree_view_set_search_column($!gtk-tv, $c);
  }

  method set_search_entry (GtkEditable() $entry) is also<set-search-entry> {
    gtk_tree_view_set_search_entry($!gtk-tv, $entry);
  }

  method set_search_equal_func (
             &search_equal_func,
    gpointer $search_user_data   = gpointer,
             &search_destroy     = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-search-equal-func>
  {
    gtk_tree_view_set_search_equal_func(
      $!gtk-tv,
      &search_equal_func,
      $search_user_data,
      &search_destroy
    );
  }

  method set_show_expanders (Int() $enabled)
    is also<set-show-expanders>
  {
    my gboolean $e = $enabled.so.Int;

    gtk_tree_view_set_show_expanders($!gtk-tv, $enabled);
  }

  method set_tooltip_cell (
    GtkTooltip()        $tooltip,
    GtkTreePath()       $path,
    GtkTreeViewColumn() $column,
    GtkCellRenderer()   $cell
  )
    is also<set-tooltip-cell>
  {
    gtk_tree_view_set_tooltip_cell($!gtk-tv, $tooltip, $path, $column, $cell);
  }

  method set_tooltip_column (Int() $column) is also<set-tooltip-column> {
    my gint $c = $column;

    gtk_tree_view_set_tooltip_column($!gtk-tv, $c);
  }

  method set_tooltip_row (GtkTooltip() $tooltip, GtkTreePath() $path)
    is also<set-tooltip-row>
  {
    gtk_tree_view_set_tooltip_row($!gtk-tv, $tooltip, $path);
  }

  method unset_rows_drag_dest is also<unset-rows-drag-dest> {
    gtk_tree_view_unset_rows_drag_dest($!gtk-tv);
  }

  method unset_rows_drag_source is also<unset-rows-drag-source> {
    gtk_tree_view_unset_rows_drag_source($!gtk-tv);
  }

}

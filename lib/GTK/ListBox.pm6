use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::ListBox:ver<4>;

use GLib::GList;
use GTK::Widget;

use GLib::Roles::Implementor;
use GTK::Roles::Signals::FlowBox:ver<4>; # connect-move-cursor2
use GTK::Roles::Signals::ListBox:ver<4>; # connect-list-box-row

our subset GtkListBoxAncestry is export of Mu
  where GtkListBox | GtkWidgetAncestry;

class GTK::ListBox::Row:ver<4> is GTK::Widget:ver<4>
{ ... }

class GTK::ListBox:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Signals::FlowBox;
  also does GTK::Roles::Signals::ListBox;

  has GtkListBox $!gtk-lb is implementor;

  submethod BUILD ( :$gtk-list-box ) {
    self.setGtkListBox($gtk-list-box) if $gtk-list-box
  }

  method setGtkListBox (GtkListBoxAncestry $_) {
    my $to-parent;

    $!gtk-lb = do {
      when GtkListBox {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkListBox, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkListBox
    is also<GtkListBox>
  { $!gtk-lb }

  multi method new (
    $gtk-list-box where * ~~ GtkListBoxAncestry,

    :$ref = True
  ) {
    return unless $gtk-list-box;

    my $o = self.bless( :$gtk-list-box );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-list-box = gtk_list_box_new();

    $gtk-list-box ?? self.bless( :$gtk-list-box ) !! Nil;
  }

  # Type: boolean
  method accept-unpaired-release
    is rw
    is g-property
    is also<accept_unpaired_release>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accept-unpaired-release', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accept-unpaired-release', $gv);
      }
    );
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

  # Type: GtkSelectionMode
  method selection-mode ( :$enum = True )
    is rw
    is g-property
    is also<selection_mode>
  {
    my $gv = GLib::Value.new-enum( GtkSelectionMode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selection-mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkSelectionModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSelectionMode) = $val;
        self.prop_set('selection-mode', $gv);
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

  method Activate-Cursor-Row {
    self.connect($!gtk-lb, 'activate-cursor-row');
  }

  method Move-Cursor {
    self.connect-move-cursor2($!gtk-lb, 'move-cursor');
  }

  method Row-Activated {
    self.connect-list-box-row($!gtk-lb, 'row-activated');
  }

  method Row-Selected {
    self.connect-list-box-row($!gtk-lb, 'row-selected');
  }

  method Select-All {
    self.connect($!gtk-lb, 'select-all');
  }

  method Selected-Rows-Changed {
    self.connect($!gtk-lb, 'selected-rows-changed');
  }

  method Toggle-Cursor-Row {
    self.connect($!gtk-lb, 'toggle-cursor-row');
  }

  method Unselect-All {
    self.connect($!gtk-lb, 'unselect-all');
  }

  method append (GtkWidget() $child) {
    gtk_list_box_append($!gtk-lb, $child);
  }

  method bind_model (
    GListModel() $model,
                 &create_widget_func,
    gpointer     $user_data           = gpointer,
                 &user_data_free_func = %DEFAULT-CALLBACKS<GDestroyNotify>,
  )
    is also<bind-model>
  {
    gtk_list_box_bind_model(
      $!gtk-lb,
      $model,
      &create_widget_func,
      $user_data,
      &user_data_free_func
    );
  }

  method drag_highlight_row (GtkListBoxRow() $row)
    is also<drag-highlight-row>
  {
    gtk_list_box_drag_highlight_row($!gtk-lb, $row);
  }

  method drag_unhighlight_row is also<drag-unhighlight-row> {
    gtk_list_box_drag_unhighlight_row($!gtk-lb);
  }

  method get_activate_on_single_click is also<get-activate-on-single-click> {
    so gtk_list_box_get_activate_on_single_click($!gtk-lb);
  }

  method get_adjustment ( :$raw = False ) is also<get-adjustment> {
    propReturnObject(
      gtk_list_box_get_adjustment($!gtk-lb),
      $raw,
      |GTK::Adjustment.getTypePair
    );
  }

  method get_row_at_index (Int() $index, :$raw = False)
    is also<get-row-at-index>
  {
    my gint $i = $index;

    propReturnObject(
      gtk_list_box_get_row_at_index($!gtk-lb, $i),
      $raw,
      |GTK::ListBox::Row.getTypePair
    );
  }

  method get_row_at_y (Int() $y, :$raw = False) is also<get-row-at-y> {
    my gint $yy = $y;

    propReturnObject(
      gtk_list_box_get_row_at_y($!gtk-lb, $yy),
      $raw,
      |GTK::ListBox::Row.getTypePair
    );
  }

  method get_selected_row ( :$raw = False ) is also<get-selected-row> {
    propReturnObject(
      gtk_list_box_get_selected_row($!gtk-lb),
      $raw,
      |GTK::ListBox::Row.getTypePair
    );
  }

  method get_selected_rows ( :$raw = False, :$glist = False )
    is also<get-selected-rows>
  {
    returnGList(
      gtk_list_box_get_selected_rows($!gtk-lb),
      $raw,
      $glist,
      |GTK::ListBox::Row.getTypePair
    )
  }

  method get_selection_mode ( :$enum = True ) is also<get-selection-mode> {
    my $m = gtk_list_box_get_selection_mode($!gtk-lb);
    return $m unless $enum;
    GtkSelectionModeEnum($m);
  }

  method get_show_separators is also<get-show-separators> {
    so gtk_list_box_get_show_separators($!gtk-lb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_box_get_type, $n, $t );
  }

  method insert (GtkWidget() $child, Int() $position = -1) {
    my gint $p = $position;

    gtk_list_box_insert($!gtk-lb, $child, $p);
  }

  method invalidate_filter is also<invalidate-filter> {
    gtk_list_box_invalidate_filter($!gtk-lb);
  }

  method invalidate_headers is also<invalidate-headers> {
    gtk_list_box_invalidate_headers($!gtk-lb);
  }

  method invalidate_sort is also<invalidate-sort> {
    gtk_list_box_invalidate_sort($!gtk-lb);
  }

  method prepend (GtkWidget() $child) {
    gtk_list_box_prepend($!gtk-lb, $child);
  }

  method remove (GtkWidget() $child) {
    gtk_list_box_remove($!gtk-lb, $child);
  }

  method select_all is also<select-all> {
    gtk_list_box_select_all($!gtk-lb);
  }

  method select_row (GtkListBoxRow() $row) is also<select-row> {
    gtk_list_box_select_row($!gtk-lb, $row);
  }

  method selected_foreach (&func, gpointer $data = gpointer)
    is also<selected-foreach>
  {
    gtk_list_box_selected_foreach($!gtk-lb, &func, $data);
  }

  method set_activate_on_single_click (Int() $single)
    is also<set-activate-on-single-click>
  {
    my gboolean $s = $single.so.Int;

    gtk_list_box_set_activate_on_single_click($!gtk-lb, $s);
  }

  method set_adjustment (GtkAdjustment() $adjustment) is also<set-adjustment> {
    gtk_list_box_set_adjustment($!gtk-lb, $adjustment);
  }

  method set_filter_func (
             &filter_func,
    gpointer $user_data    = gpointer,
             &destroy      = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-filter-func>
  {
    gtk_list_box_set_filter_func(
      $!gtk-lb,
      &filter_func,
      $user_data,
      &destroy
    );
  }

  method set_header_func (
             &update_header,
    gpointer $user_data      = gpointer,
             &destroy        = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-header-func>
  {
    gtk_list_box_set_header_func(
      $!gtk-lb,
      &update_header,
      $user_data,
      &destroy
    );
  }

  method set_placeholder (GtkWidget() $placeholder) is also<set-placeholder> {
    gtk_list_box_set_placeholder($!gtk-lb, $placeholder);
  }

  method set_selection_mode (Int() $mode) is also<set-selection-mode> {
    my GtkSelectionMode $m = $mode.so.Int;

    gtk_list_box_set_selection_mode($!gtk-lb, $mode);
  }

  method set_show_separators (Int() $show_separators)
    is also<set-show-separators>
  {
    my gboolean $s = $show_separators;

    gtk_list_box_set_show_separators($!gtk-lb, $show_separators);
  }

  method set_sort_func (
             &sort_func,
    gpointer $user_data  = gpointer,
             &destroy    = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-sort-func>
  {
    gtk_list_box_set_sort_func($!gtk-lb, &sort_func, $user_data, &destroy);
  }

  method unselect_all is also<unselect-all> {
    gtk_list_box_unselect_all($!gtk-lb);
  }

  method unselect_row (GtkListBoxRow() $row) is also<unselect-row> {
    gtk_list_box_unselect_row($!gtk-lb, $row);
  }

}

our subset GtkListBoxRowAncestry is export of Mu
  where GtkListBoxRow | GtkWidgetAncestry;

class GTK::ListBox::Row:ver<4> {
  has GtkListBoxRow $!gtk-lbr is implementor;

  submethod BUILD ( :$gtk-list-box-row ) {
    self.setGtkListBoxRow($gtk-list-box-row) if $gtk-list-box-row
  }

  method setGtkListBoxRow (GtkListBoxRowAncestry $_) {
    my $to-parent;

    $!gtk-lbr = do {
      when GtkListBoxRow {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkListBoxRow, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkListBoxRow
    is also<GtkListBoxRow>
  { $!gtk-lbr }

  multi method new (
    $gtk-list-box-row where * ~~ GtkListBoxRowAncestry,

    :$ref = True
  ) {
    return unless $gtk-list-box-row;

    my $o = self.bless( :$gtk-list-box-row );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-list-box-row = gtk_list_box_row_new();

    $gtk-list-box-row ?? self.bless( :$gtk-list-box-row ) !! Nil;
  }

  # Type: boolean
  method activatable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activatable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activatable', $gv);
      }
    );
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget($gv.object, $raw, $proper)
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method selectable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selectable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('selectable', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-lbr, 'activate');
  }

  method changed {
    gtk_list_box_row_changed($!gtk-lbr);
  }

  method get_activatable is also<get-activatable> {
    so gtk_list_box_row_get_activatable($!gtk-lbr);
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_list_box_row_get_child($!gtk-lbr),
      $raw,
      $proper
    )
  }

  method get_header (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-header>
  {
    returnProperWidget(
      gtk_list_box_row_get_header($!gtk-lbr),
      $raw,
      $proper
    )
  }

  method get_index is also<get-index> {
    gtk_list_box_row_get_index($!gtk-lbr);
  }

  method get_selectable is also<get-selectable> {
    so gtk_list_box_row_get_selectable($!gtk-lbr);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_box_row_get_type, $n, $t );
  }

  method is_selected is also<is-selected> {
    so gtk_list_box_row_is_selected($!gtk-lbr);
  }

  method set_activatable (Int() $activatable) is also<set-activatable> {
    my gboolean $a = $activatable.so.Int;

    gtk_list_box_row_set_activatable($!gtk-lbr, $a);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_list_box_row_set_child($!gtk-lbr, $child);
  }

  method set_header (GtkWidget() $header) is also<set-header> {
    gtk_list_box_row_set_header($!gtk-lbr, $header);
  }

  method set_selectable (Int() $selectable) is also<set-selectable> {
    my gboolean $s = $selectable.so.Int;

    gtk_list_box_row_set_selectable($!gtk-lbr, $s);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::ListBox;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::ListBox;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

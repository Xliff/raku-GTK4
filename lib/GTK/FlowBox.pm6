use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::FlowBox:ver<4>;

use GLib::GList;
use GTK::Widget;

use GLib::Roles::Implementor;

our subset GtkFlowBoxAncestry is export of Mu
  where GtkFlowBox | GtkWidgetAncestry;

class GTK::FlowBox:ver<4> is GTK::Widget:ver<4> {
  has GtkFlowBox $!gtk-flow is implementor;

  submethod BUILD ( :$gtk-flow-box ) {
    self.setGtkFlowBox($gtk-flow-box)
      if $gtk-flow-box
  }

  method setGtkFlowBox (GtkFlowBoxAncestry $_) {
    my $to-parent;

    $!gtk-flow = do {
      when GtkFlowBox {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFlowBox, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Structs::GtkFlowBox
    is also<GtkFlowBox>
  { $!gtk-flow }

  multi method new (GtkFlowBoxAncestry $gtk-flow-box, :$ref = True) {
    return unless $gtk-flow-box;

    my $o = self.bless( :$gtk-flow-box );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-flow-box = gtk_flow_box_new();

    $gtk-flow-box ?? self.bless( :$gtk-flow-box ) !! Nil;
  }

  # Type: GTKWidget
  method child (
           :$raw    = False,
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
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: GTKSelectionMode
  method selection-mode ( :$enum = True )
    is also<selection_mode>
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkSelectionMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selection-mode', $gv);
        my $m = $gv.enum; # $gv.valueFromEnum(GtkSelectionMode);
        return $m unless $enum;
        GtkSelectionModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSelectionMode) = $val;
        #$gv.enum = $val;
        self.prop_set('selection-mode', $gv);
      }
    );
  }

  # Type: boolean
  method activate-on-single-click
    is also<activate_on_single_click>
    is rw
    is g-property
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

  # Type: boolean
  method accept-unpaired-release
    is also<accept_unpaired_release>
    is rw
    is g-property
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
  method homogeneous is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('homogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('homogeneous', $gv);
      }
    );
  }

  # Type: uint
  method min-children-per-line
    is also<min_children_per_line>
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-children-per-line', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('min-children-per-line', $gv);
      }
    );
  }

  # Type: uint
  method max-children-per-line
    is also<max_children_per_line>
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-children-per-line', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('max-children-per-line', $gv);
      }
    );
  }

  # Type: uint
  method row-spacing is also<row_spacing> is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row-spacing', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('row-spacing', $gv);
      }
    );
  }

  # Type: uint
  method column-spacing is also<column_spacing> is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-spacing', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('column-spacing', $gv);
      }
    );
  }

  # Remember class specific signals!s

  method Activate-Cursor-Child {
    self.connect($!gtk-flow, 'activate-cursor-child');
  }

  method Child-Activated is also<Child_Activated> {
    self.connect-child-activated($!gtk-flow);
  }



  method Select-All {
    self.connect($!gtk-flow, 'select-all');
  }

  method Selected-Child-Changed {
    self.connect($!gtk-flow, 'selected-child-changed');
  }

  method Toggle-Cursor-Child {
    self.connect($!gtk-flow, 'toggle-cursor-child');
  }

  method Unselect-All {
    self.connect($!gtk-flow, 'unselect-all');
  }

  method append (GtkWidget()  $child) {
    gtk_flow_box_append($!gtk-flow, $child);
  }

  constant DC := %DEFAULT-CALLBACKS;
  method bind_model (
    GListModel() $model,
                 &create_widget_func,
    gpointer     $user_data,
                 &user_data_free_func = DC<GDestroyNotify>
  )
    is also<bind-model>
  {
    gtk_flow_box_bind_model(
      $!gtk-flow,
      $model,
      &create_widget_func,
      $user_data,
      &user_data_free_func
    );
  }

  method get_activate_on_single_click is also<get-activate-on-single-click> {
    so gtk_flow_box_get_activate_on_single_click($!gtk-flow);
  }

  method get_child_at_index (Int()  $idx, :$raw  = False)
    is also<get-child-at-index>
  {
    my gint $i = $idx;

    propReturnObject(
      gtk_flow_box_get_child_at_index($!gtk-flow, $i),
      $raw,
      GTK::FlowBox::Child.getTypePair
    )
  }

  method get_child_at_pos (Int() $x, Int() $y) is also<get-child-at-pos> {
    my gint ($xx, $yy) = ($xx, $yy);

    gtk_flow_box_get_child_at_pos($!gtk-flow, $xx, $yy);
  }

  method get_column_spacing is also<get-column-spacing> {
    gtk_flow_box_get_column_spacing($!gtk-flow);
  }

  method get_homogeneous is also<get-homogeneous> {
    so gtk_flow_box_get_homogeneous($!gtk-flow);
  }

  method get_max_children_per_line is also<get-max-children-per-line> {
    gtk_flow_box_get_max_children_per_line($!gtk-flow);
  }

  method get_min_children_per_line is also<get-min-children-per-line> {
    gtk_flow_box_get_min_children_per_line($!gtk-flow);
  }

  method get_row_spacing is also<get-row-spacing> {
    gtk_flow_box_get_row_spacing($!gtk-flow);
  }

  method get_selected_children (
    :$raw           = False,
    :$glist         = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-selected-children>
  {
    my $wl = returnGList(
      gtk_flow_box_get_selected_children($!gtk-flow),
      $raw,
      $glist
    );
    $wl.map({ returnProperWidget($_, $raw, $proper) });
  }

  method get_selection_mode ( :$enum = True ) is also<get-selection-mode> {
    my $s = gtk_flow_box_get_selection_mode($!gtk-flow);
    return $s unless $enum;
    GtkSelectionMode($s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_flow_box_get_type, $n, $t );
  }

  method insert (GtkWidget() $widget, Int() $position = -1)
    # cw:Backwards compatibility
    is also<add>
  {
    my gint $p = $position;

    gtk_flow_box_insert($!gtk-flow, $widget, $p);
  }

  method invalidate_filter is also<invalidate-filter> {
    gtk_flow_box_invalidate_filter($!gtk-flow);
  }

  method invalidate_sort is also<invalidate-sort> {
    gtk_flow_box_invalidate_sort($!gtk-flow);
  }

  method prepend (GtkWidget() $child) {
    gtk_flow_box_prepend($!gtk-flow, $child);
  }

  method remove (GtkWidget() $widget) {
    gtk_flow_box_remove($!gtk-flow, $widget);
  }

  method select_all is also<select-all> {
    gtk_flow_box_select_all($!gtk-flow);
  }

  method select_child (GtkFlowBoxChild() $child) is also<select-child> {
    gtk_flow_box_select_child($!gtk-flow, $child);
  }

  method selected_foreach (&func, gpointer $data = gpointer)
    is also<selected-foreach>
  {
    gtk_flow_box_selected_foreach($!gtk-flow, &func, $data);
  }

  method set_activate_on_single_click (Int() $single)
    is also<set-activate-on-single-click>
  {
    my gboolean $s = $single;

    gtk_flow_box_set_activate_on_single_click($!gtk-flow, $s);
  }

  method set_column_spacing (Int() $spacing) is also<set-column-spacing> {
    my guint $s = $spacing;

    gtk_flow_box_set_column_spacing($!gtk-flow, $s);
  }

  method set_filter_func (
             &filter_func,
    gpointer $user_data    = gpointer,
             &destroy      = DC<GDestroyNotify>
  )
    is also<set-filter-func>
  {
    gtk_flow_box_set_filter_func(
      $!gtk-flow,
      &filter_func,
      $user_data,
      &destroy
    );
  }

  method set_hadjustment (Int() $adjustment) is also<set-hadjustment> {
    my GtkAdjustment $a = $adjustment;

    gtk_flow_box_set_hadjustment($!gtk-flow, $a);
  }

  method set_homogeneous (Int() $homogeneous) is also<set-homogeneous> {
    my gboolean $h = $homogeneous;

    gtk_flow_box_set_homogeneous($!gtk-flow, $h);
  }

  method set_max_children_per_line (Int() $n_children)
    is also<set-max-children-per-line>
  {
    my guint $n = $n_children;

    gtk_flow_box_set_max_children_per_line($!gtk-flow, $n);
  }

  method set_min_children_per_line (Int() $n_children)
    is also<set-min-children-per-line>
  {
    my guint $n = $n_children;

    gtk_flow_box_set_min_children_per_line($!gtk-flow, $n);
  }

  method set_row_spacing (Int() $spacing) is also<set-row-spacing> {
    my guint $s = $spacing;

    gtk_flow_box_set_row_spacing($!gtk-flow, $s);
  }

  method set_selection_mode (Int() $mode) is also<set-selection-mode> {
    my GtkSelectionMode $m = $mode;

    gtk_flow_box_set_selection_mode($!gtk-flow, $m);
  }

  method set_sort_func (
             &sort_func,
    gpointer $user_data  = gpointer,
             &destroy    = DC<GDestroyNotfiy>
  )
    is also<set-sort-func>
  {
    gtk_flow_box_set_sort_func($!gtk-flow, &sort_func, $user_data, &destroy);
  }

  method set_vadjustment (Int() $adjustment) is also<set-vadjustment> {
    my GtkAdjustment $a = $adjustment;

    gtk_flow_box_set_vadjustment($!gtk-flow, $a);
  }

  method unselect_all is also<unselect-all> {
    gtk_flow_box_unselect_all($!gtk-flow);
  }

  method unselect_child (GtkFlowBoxChild() $child) is also<unselect-child> {
    gtk_flow_box_unselect_child($!gtk-flow, $child);
  }

}

INIT {
  my \O = GTK::FlowBox;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}


  # method child_changed {
  #   gtk_flow_box_child_changed($!gtk-flow);
  # }
  #
  # method child_get_child {
  #   gtk_flow_box_child_get_child($!gtk-flow);
  # }
  #
  # method child_get_index {
  #   gtk_flow_box_child_get_index($!gtk-flow);
  # }
  #
  # method child_get_type {
  #   gtk_flow_box_child_get_type();
  # }
  #
  # method child_is_selected {
  #   gtk_flow_box_child_is_selected($!gtk-flow);
  # }
  #
  # method child_new {
  #   gtk_flow_box_child_new();
  # }
  #
  # method child_set_child (GtkWidget       $child) {
  #   gtk_flow_box_child_set_child($!gtk-flow, $child);
  # }

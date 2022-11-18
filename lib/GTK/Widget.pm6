use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Widget:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


class GTK::Widget:ver<4> {
  also does GLib::Roles::Object;

  has GtkWidget $!gtk-w is implementor;

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: GTKWidget
  method parent ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( self.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('parent', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |self.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'parent does not allow writing'
      }
    );
  }

  # Type: GTKRoot
  method root is rw  is g-property {
    my $gv = GLib::Value.new( GTKRoot );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('root', $gv);
        $gv.GTKRoot;
      },
      STORE => -> $,  $val is copy {
        warn 'root does not allow writing'
      }
    );
  }

  # Type: int
  method width-request is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width-request', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width-request', $gv);
      }
    );
  }

  # Type: int
  method height-request is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height-request', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height-request', $gv);
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

  # Type: boolean
  method sensitive is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('sensitive', $gv);
      }
    );
  }

  # Type: boolean
  method can-focus is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('can-focus', $gv);
      }
    );
  }

  # Type: boolean
  method focusable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('focusable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('focusable', $gv);
      }
    );
  }

  # Type: boolean
  method has-focus is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-focus does not allow writing'
      }
    );
  }

  # Type: boolean
  method can-target is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-target', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('can-target', $gv);
      }
    );
  }

  # Type: boolean
  method focus-on-click is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('focus-on-click', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('focus-on-click', $gv);
      }
    );
  }

  # Type: boolean
  method has-default is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-default does not allow writing'
      }
    );
  }

  # Type: boolean
  method receives-default is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('receives-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('receives-default', $gv);
      }
    );
  }

  # Type: GTKCursor
  method cursor is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Cursor.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cursor', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Cursor.getTypePair
        );
      },
      STORE => -> $, GdkCursor() $val is copy {
        $gv.object = $val;
        self.prop_set('cursor', $gv);
      }
    );
  }

  # Type: boolean
  method has-tooltip is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-tooltip', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-tooltip', $gv);
      }
    );
  }

  # Type: string
  method tooltip-text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tooltip-text', $gv);
      }
    );
  }

  # Type: string
  method tooltip-markup is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-markup', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tooltip-markup', $gv);
      }
    );
  }

  # Type: GTKAlign
  method halign ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkAlign) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('halign', $gv);
        my $a = $gv.valueFromEnum(GtkAlign);
        return $a unless $enum;
        GtkAlignEnum($a);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkAlign) = $val;
        self.prop_set('halign', $gv);
      }
    );
  }

  # Type: GTKAlign
  method valign is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkAlign) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('valign', $gv);
        my $a = $gv.valueFromEnum(GtkAlign);
        return $a unless $enum;
        GtkAlignEnum($a);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkAlign) = $val;
        self.prop_set('valign', $gv);
      }
    );
  }

  # Type: int
  method margin-start is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('margin-start', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('margin-start', $gv);
      }
    );
  }

  # Type: int
  method margin-end is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('margin-end', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('margin-end', $gv);
      }
    );
  }

  # Type: int
  method margin-top is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('margin-top', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('margin-top', $gv);
      }
    );
  }

  # Type: int
  method margin-bottom is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('margin-bottom', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('margin-bottom', $gv);
      }
    );
  }

  # Type: boolean
  method hexpand is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hexpand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hexpand', $gv);
      }
    );
  }

  # Type: boolean
  method hexpand-set is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hexpand-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hexpand-set', $gv);
      }
    );
  }

  # Type: boolean
  method vexpand is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('vexpand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('vexpand', $gv);
      }
    );
  }

  # Type: boolean
  method vexpand-set is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('vexpand-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('vexpand-set', $gv);
      }
    );
  }

  # Type: double
  method opacity is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('opacity', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('opacity', $gv);
      }
    );
  }

  # Type: GTKOverflow
  method overflow ( :$enum = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkOverflow) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overflow', $gv);
        my $o = $gv.valueFromEnum(GtkOverflow);
        return $o unless $enum;
        GtkOverflowEnum($o);
      },
      STORE => -> $, Int() $val is copy {
        $gv.$gv.valueFromEnum(GtkOverflow) = $val;
        self.prop_set('overflow', $gv);
      }
    );
  }

  # Type: int
  method scale-factor is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-factor', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scale-factor does not allow writing'
      }
    );
  }

  # Type: string
  method css-name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('css-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('css-name', $gv);
      }
    );
  }

  # Type: GTKStrv
  method css-classes is rw  is g-property {
    my $gv = GLib::Value.new( GTKStrv );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('css-classes', $gv);
        $gv.GTKStrv;
      },
      STORE => -> $,  $val is copy {
        $gv.GTKStrv = $val;
        self.prop_set('css-classes', $gv);
      }
    );
  }

  # Type: GTKLayoutManager
  method layout-manager ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::LayoutManager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('layout-manager', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::LayoutManager.getTypePair
        );
      },
      STORE => -> $, GTK::LayoutManager() $val is copy {
        $gv.object = $val;
        self.prop_set('layout-manager', $gv);
      }
    );
  }

  method Destroy {
    self.connect($!gtk-w, 'destroy');
  }

  method Direction-Changed {
    self.connect-uint($!gtk-w, 'direction-changed');
  }

  method Hide {
    self.connect($!gtk-w, 'hide');
  }

  method Keynav-Failed {
    self.connect-uint($!gtk-w, 'keynav-failed');
  }

  method Map {
    self.connect($!gtk-w, 'map');
  }

  method Mnemonic-Activate {
    self.connect-uint-ruint($!gtk-w, 'mnemonic-activate');
  }

  method Move-Focus {
    self.connect-uint($!gtk-w, 'move-focus');
  }

  method Query-Tooltip {
    self.connect-query-tooltip($!gtk-w);
  }

  method Realize {
    self.connect($!gtk-w, 'realize');
  }

  method Show {
    self.connect($!gtk-w, 'show');
  }

  method State-Flags-Changed {
    self.connect-uint($!gtk-w, 'state-flags-changed');
  }

  method Unmap {
    self.connect($!gtk-w, 'unmap');
  }

  method Unrealize {
    self.connect($!gtk-w, 'unrealize');
  }

  method action_set_enabled (Str() $action_name, Int() $enabled) {
    my gboolean $e = $enabled.so.Int;

    gtk_widget_action_set_enabled($!gtk-w, $action_name, $e);
  }

  method activate {
    gtk_widget_activate($!gtk-w);
  }

  method activate_action (Str() $name, Str() $format_string) {
    gtk_widget_activate_action($!gtk-w, $name, $format_string);
  }

  method activate_action_variant (Str() $name, GVariant() $args) {
    gtk_widget_activate_action_variant($!gtk-w, $name, $args);
  }

  method activate_default {
    gtk_widget_activate_default($!gtk-w);
  }

  method add_controller (GtkEventController() $controller) {
    gtk_widget_add_controller($!gtk-w, $controller);
  }

  method add_css_class (Str() $css_class) {
    gtk_widget_add_css_class($!gtk-w, $css_class);
  }

  method add_mnemonic_label (GtkWidget() $label) {
    gtk_widget_add_mnemonic_label($!gtk-w, $label);
  }

  method add_tick_callback (
                    &callback,
    gpointer        $user_data = gpointer,
                    &notify    = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gtk_widget_add_tick_callback($!gtk-w, &callback, $user_data, &notify);
  }

  method allocate (
    Int()          $width,
    Int()          $height,
    Int()          $baseline,
    GskTransform() $transform
  ) {
    my gint ($w, $h, $b) = ($width, $height, $baseline);

    gtk_widget_allocate($!gtk-w, $w, $h, $b, $transform);
  }

  method child_focus (Int() $direction) {
    my GtkDirectionType $d = $direction;

    gtk_widget_child_focus($!gtk-w, $d);
  }

  method compute_bounds (
    GtkWidget       $target,
    graphene_rect_t $out_bounds
  ) {
    gtk_widget_compute_bounds($!gtk-w, $target, $out_bounds);
  }

  method compute_expand (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    gtk_widget_compute_expand($!gtk-w, $o);
  }

  method compute_point (
    GtkWidget        $target,
    graphene_point_t $point,
    graphene_point_t $out_point
  ) {
    gtk_widget_compute_point($!gtk-w, $target, $point, $out_point);
  }

  method compute_transform (
    GtkWidget         $target,
    graphene_matrix_t $out_transform
  ) {
    gtk_widget_compute_transform($!gtk-w, $target, $out_transform);
  }

  method contains (
    gdouble   $x,
    gdouble   $y
  ) {
    gtk_widget_contains($!gtk-w, $x, $y);
  }

  method create_pango_context ( :$raw = False ) {
    propReturnObject(
      gtk_widget_create_pango_context($!gtk-w),
      $raw,
      |Pango::Context.getTypePair
    );
  }

  method create_pango_layout (Str() $text, :$raw = False) {
    propReturnObject(
      gtk_widget_create_pango_layout($!gtk-w, $text),
      $rawm
      |Pango::Layout.getTypePair
    );
  }

  method dispose_template (Int() $widget_type) {
    my GType $w = $widget_type;

    gtk_widget_dispose_template($!gtk-w, $w);
  }

  method error_bell {
    gtk_widget_error_bell($!gtk-w);
  }

  method get_allocated_baseline {
    gtk_widget_get_allocated_baseline($!gtk-w);
  }

  method get_allocated_height {
    gtk_widget_get_allocated_height($!gtk-w);
  }

  method get_allocated_width {
    gtk_widget_get_allocated_width($!gtk-w);
  }

  method get_allocation (GtkAllocation() $allocation) {
    gtk_widget_get_allocation($!gtk-w, $allocation);
  }

  method get_ancestor (Int() $widget_type) {
    my GType $w = $widget_type;

    gtk_widget_get_ancestor($!gtk-w, $w);
  }

  method get_can_focus {
    so gtk_widget_get_can_focus($!gtk-w);
  }

  method get_can_target {
    so gtk_widget_get_can_target($!gtk-w);
  }

  method get_child_visible {
    so gtk_widget_get_child_visible($!gtk-w);
  }

  method get_clipboard ( :$raw = False ){
    propReturnObject(
      gtk_widget_get_clipboard($!gtk-w),
      $raw,
      |GDK::Clipboard.getTypePair
    );
  }

  method get_css_classes {
    gtk_widget_get_css_classes($!gtk-w);
  }

  method get_css_name ( :$carray = False ) {
    my $c = gtk_widget_get_css_name($!gtk-w);
    return $c if $carray;
    CArrayToArray($c);
  }

  method get_cursor ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_cursor($!gtk-w),
      $raw,
      |GDK::Cursor.getTypePair
    );
  }

  method get_default_direction ( :$enum = True ) {
    my $d = gtk_widget_get_default_direction($!gtk-w);
    return $d unless $enum;
    $d;
  }

  method get_direction ( $enum = True ) {
    my $d = gtk_widget_get_direction($!gtk-w);
    return $d unless $enum;
    GtkTextDirectionEnum($d);
  }

  method get_display ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_display($!gtk-w),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_first_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_widget_get_first_child($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_focus_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_widget_get_focus_child($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_focus_on_click {
    so gtk_widget_get_focus_on_click($!gtk-w);
  }

  method get_focusable {
    so gtk_widget_get_focusable($!gtk-w);
  }

  method get_font_map ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_font_map($!gtk-w),
      $raw,
      |Pango::FontMap.getTypePair
    );
  }

  method get_font_options ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_font_options($!gtk-w),
      $raw,
      cairo_font_options_t,
      Cairo::FontOptions
    );
  }

  method get_frame_clock ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_frame_clock($!gtk-w),
      $raw,
      |GDK::FrameClock.getTypePair
    );
  }

  method get_halign ( :$enum = True ) {
    my $h = gtk_widget_get_halign($!gtk-w);
    return $h unless $enum;
    GtkAlignEnum($h);
  }

  method get_has_tooltip {
    so gtk_widget_get_has_tooltip($!gtk-w);
  }

  method get_height {
    gtk_widget_get_height($!gtk-w);
  }

  method get_hexpand {
    so gtk_widget_get_hexpand($!gtk-w);
  }

  method get_hexpand_set {
    so gtk_widget_get_hexpand_set($!gtk-w);
  }

  method get_last_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperObject(
      gtk_widget_get_last_child($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_layout_manager ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_layout_manager($!gtk-w),
      $raw,
      |GTK::LayoutManager.getTypePair
    );
  }

  method get_mapped {
    so gtk_widget_get_mapped($!gtk-w);
  }

  method get_margin_bottom {
    gtk_widget_get_margin_bottom($!gtk-w);
  }

  method get_margin_end {
    gtk_widget_get_margin_end($!gtk-w);
  }

  method get_margin_start {
    gtk_widget_get_margin_start($!gtk-w);
  }

  method get_margin_top {
    gtk_widget_get_margin_top($!gtk-w);
  }

  method get_name {
    gtk_widget_get_name($!gtk-w);
  }

  method get_native ( :raw = False ) {
    propReturnObject(
      gtk_widget_get_native($!gtk-w),
      $raw,
      |GTK::Native.getTypePair
    );
  }

  method get_next_sibling (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_widget_get_next_sibling($!gtk-w),
      $raw,
      $proper
    )
  }

  method get_opacity {
    gtk_widget_get_opacity($!gtk-w);
  }

  method get_overflow ( :$enum = True ) {
    my $o =  gtk_widget_get_overflow($!gtk-w);
    return $o unless $enum;
    GtkOverflowEnum($o);
  }

  method get_pango_context ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_pango_context($!gtk-w),
      $raw,
      |Pango::Context.getTypePair
    );
  }

  method get_parent (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_widget_get_parent($!gtk-w),
      $raw,
      $proper
    )
  }

  method get_preferred_size (
    GtkRequisition() $minimum_size,
    GtkRequisition() $natural_size
  ) {
    gtk_widget_get_preferred_size($!gtk-w, $minimum_size, $natural_size);
  }

  method get_prev_sibling (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    propReturnObject(
      gtk_widget_get_prev_sibling($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_primary_clipboard ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_primary_clipboard($!gtk-w),
      $raw,
      |GDK::Clipboard.getTypePair
    )
  }

  method get_realized {
    so gtk_widget_get_realized($!gtk-w);
  }

  method get_receives_default {
    so gtk_widget_get_receives_default($!gtk-w);
  }

  method get_request_mode ( :$enum = False ) {
    my $rm = gtk_widget_get_request_mode($!gtk-w);
    return $rm unless $enum;
    GtkSizeRequestModeEnum($rm);
  }

  method get_root (
    :$root          = False
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    my $r = gtk_widget_get_root($!gtk-w);
    return propReturnObject($r, $raw, |GTK::Root.getTypePair) if $root;
    returnProperWidget($r, $raw, $proper);
  }

  method get_scale_factor {
    gtk_widget_get_scale_factor($!gtk-w);
  }

  method get_sensitive {
    so gtk_widget_get_sensitive($!gtk-w);
  }

  method get_settings ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_settings($!gtk-w),
      $raw,
      |GTK::Settings.getTypePair
    );
  }

  method get_size (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    gtk_widget_get_size($!gtk-w, $o);
  }

  proto method get_size_request (|)

  multi method get_size_request {
    samewith($, $)
  }
  multi method get_size_request ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_widget_get_size_request($!gtk-w, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_state_flags ( :set(:$flags) = True ) {
    my $s = gtk_widget_get_state_flags($!gtk-w);
    return $s unless $flags
    getFlags(GtkStateFlags, $s);
  }

  method get_style_context ( :$raw = False ) {
    propReturnObject(
      gtk_widget_get_style_context($!gtk-w),
      $raw,
      |GTK::StyleContext.getTypePair
    );
  }

  method get_template_child (Int() $widget_type, Str() $name) {
    my GType $w = $widget_type;

    gtk_widget_get_template_child($!gtk-w, $w, $name);
  }

  method get_tooltip_markup {
    gtk_widget_get_tooltip_markup($!gtk-w);
  }

  method get_tooltip_text {
    gtk_widget_get_tooltip_text($!gtk-w);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_widget_get_type, $n, $t );
  }

  method get_valign ( :$enum = True ) {
    my $v = gtk_widget_get_valign($!gtk-w);
    return $v unless $enum;
    GtkAlignEnum($v);
  }

  method get_vexpand {
    so gtk_widget_get_vexpand($!gtk-w);
  }

  method get_vexpand_set {
    so gtk_widget_get_vexpand_set($!gtk-w);
  }

  method get_visible {
    so gtk_widget_get_visible($!gtk-w);
  }

  method get_width {
    gtk_widget_get_width($!gtk-w);
  }

  method grab_focus {
    so gtk_widget_grab_focus($!gtk-w);
  }

  method has_css_class (Str() $css_class) {
    so gtk_widget_has_css_class($!gtk-w, $css_class);
  }

  method has_default {
    so gtk_widget_has_default($!gtk-w);
  }

  method has_focus {
    so gtk_widget_has_focus($!gtk-w);
  }

  method has_visible_focus {
    so gtk_widget_has_visible_focus($!gtk-w);
  }

  method hide {
    gtk_widget_hide($!gtk-w);
  }

  method in_destruction {
    so gtk_widget_in_destruction($!gtk-w);
  }

  method insert_action_group (Str() $name, GActionGroup() $group) {
    gtk_widget_insert_action_group($!gtk-w, $name, $group);
  }

  method insert_after (GtkWidget() $parent, GtkWidget() $previous_sibling) {
    gtk_widget_insert_after($!gtk-w, $parent, $previous_sibling);
  }

  method insert_before (GtkWidget() $parent, GtkWidget() $next_sibling) {
    gtk_widget_insert_before($!gtk-w, $parent, $next_sibling);
  }

  method is_ancestor (GtkWidget() $ancestor) {
    so gtk_widget_is_ancestor($!gtk-w, $ancestor);
  }

  method is_drawable {
    so gtk_widget_is_drawable($!gtk-w);
  }

  method is_focus {
    so gtk_widget_is_focus($!gtk-w);
  }

  method is_sensitive {
    so gtk_widget_is_sensitive($!gtk-w);
  }

  method is_visible {
    so gtk_widget_is_visible($!gtk-w);
  }

  method keynav_failed (Int() $direction) {
    my GtkDirectionType $d = $direction;

    so gtk_widget_keynav_failed($!gtk-w, $d);
  }

  method list_mnemonic_labels {
    gtk_widget_list_mnemonic_labels($!gtk-w);
  }

  method map {
    gtk_widget_map($!gtk-w);
  }

  multi method measure (Int() $orientation, Int() $for_size) {
    samewith($orientation, $for_size, $, $, $, $);
  }
  multi method measure (
    Int() $orientation,
    Int() $for_size,
          $minimum          is rw,
          $natural          is rw,
          $minimum_baseline is rw,
          $natural_baseline is rw
  ) {
    my GtkOrientation $o = $orientation;
    my gint           $f = $for_size;

    my gint ($m, $n, $mb, $nb) = 0 xx 4;
    gtk_widget_measure($!gtk-w, $orientation, $f, $m, $n, $mb, $nb);
    ($minimum, $natural, $minimum_baseline, $natural_baseline) =
      ($m, $n, $mb, $nb)
  }

  method mnemonic_activate (Int() $group_cycling) {
    my gboolean $g = $group_cycling;

    gtk_widget_mnemonic_activate($!gtk-w, $g);
  }

  method observe_children (
    :$raw                   = False,
    :raw_model(:$raw-model) = False
    :$model                 = False
    :quick(:$fast)          = False,
    :slow(:$proper)         = $fast.not
   ) {
    my $lm = propReturnObject(
      gtk_widget_observe_children($!gtk-w),
      $raw,
      |GIO::ListModel.getTypePair
    );
    return $lm if $raw-model;
    $lm does GLib::Roles::TypedArray[
      GtkWidget,
      $model ?? $raw !! True,
      GTK::Widget
    ];
    return $lm if $model;
    $lm.Array.map({ returnProperWidget($_, $raw, $proper) });
  }

  method observe_controllers (
    :$raw                   = False,
    :raw_model(:$raw-model) = False
    :$model                 = False
  ) {
    my $om = propReturnObject(
      gtk_widget_observe_controllers($!gtk-w);
      $raw,
      |GIO::ListModel.getTypePair
    );
    return $lm if $raw-model;
    $lm does GLib::Roles::TypedArray[
      GtkEventController,
      $raw,
      GTK::EventController
    ];
    return $lm if $model;
    $lm.Array;
  }

  method pick (
    Num()  $x,
    Num()  $y,
    Int()  $flags,

           :quick(:$fast)  = False,
           :$raw           = False,
           :slow(:$proper) = $fast.not
  ) {
    my gdouble      ($xx, $yy) = ($x, $y)
    my GtkPickFlags  $f        =  $flags;

    returnProperWidget(
      gtk_widget_pick($!gtk-w, $xx, $yy, $f),
      $raw,
      $proper
    );
  }

  method queue_allocate {
    gtk_widget_queue_allocate($!gtk-w);
  }

  method queue_draw {
    gtk_widget_queue_draw($!gtk-w);
  }

  method queue_resize {
    gtk_widget_queue_resize($!gtk-w);
  }

  method realize {
    gtk_widget_realize($!gtk-w);
  }

  method remove_controller (GtkEventController() $controller) {
    gtk_widget_remove_controller($!gtk-w, $controller);
  }

  method remove_css_class (Str() $css_class) {
    gtk_widget_remove_css_class($!gtk-w, $css_class);
  }

  method remove_mnemonic_label (GtkWidget() $label) {
    gtk_widget_remove_mnemonic_label($!gtk-w, $label);
  }

  method remove_tick_callback (Int() $id) {
    my guint $i = $id;
    gtk_widget_remove_tick_callback($!gtk-w, $id);
  }

  method set_can_focus (Int()  $can_focus) {
    my gboolean $c = $can_focus.so.Int;

    gtk_widget_set_can_focus($!gtk-w, $c);
  }

  method set_can_target (Int() $can_target) {
    my gboolean $c = $can_target.so.Int;

    gtk_widget_set_can_target($!gtk-w, $c);
  }

  multi method set_child_visible (Int() $child_visible) {
    my gboolean $c = $child_visible.so.Int;

    gtk_widget_set_child_visible($!gtk-w, $c);
  }

  proto method set_css_classes (|)
  { * }

  method set_css_classes (@classes) {
    samewith( ArrayToCArray(Str, @classes, :null);
  }
  method set_css_classes (CArray[Str] $classes) {
    gtk_widget_set_css_classes($!gtk-w, $classes);
  }

  method set_cursor (GdkCursor() $cursor) {
    gtk_widget_set_cursor($!gtk-w, $cursor);
  }

  method set_cursor_from_name (Str() $name) {
    gtk_widget_set_cursor_from_name($!gtk-w, $name);
  }

  method set_default_direction (Int() $direction) is static {
    my GtkTextDirection $d = $direction;

    gtk_widget_set_default_direction($d);
  }

  method set_direction (Int() $dir) {
    my GtkTextDirection $d = $dir;

    gtk_widget_set_direction($!gtk-w, $d);
  }

  method set_focus_child (GtkWidget() $child) {
    gtk_widget_set_focus_child($!gtk-w, $child);
  }

  method set_focus_on_click (Int() $focus_on_click) {
    my gboolean $f = $focus_on_click.so.Int;

    gtk_widget_set_focus_on_click($!gtk-w, $f);
  }

  method set_focusable (Int() $focusable) {
    my gboolean $f = $focusable.so.Int;

    gtk_widget_set_focusable($!gtk-w, $f);
  }

  method set_font_map (PangoFontMap() $font_map) {
    gtk_widget_set_font_map($!gtk-w, $font_map);
  }

  method set_font_options (cairo_font_options_t() $options) {
    gtk_widget_set_font_options($!gtk-w, $options);
  }

  method set_halign (Int() $align) {
    my GtkAlign $a = $align;

    gtk_widget_set_halign($!gtk-w, $a);
  }

  method set_has_tooltip (Int() $has_tooltip) {
    my gboolean $h = $has_tooltip.so.Int;

    gtk_widget_set_has_tooltip($!gtk-w, $h);
  }

  method set_hexpand (Int() $expand) {
    my gboolean $e = $expand.so.Int;

    gtk_widget_set_hexpand($!gtk-w, $e);
  }

  method set_hexpand_set (Int() $set) {
    my gboolean $s = $set.so.Int;

    gtk_widget_set_hexpand_set($!gtk-w, $s);
  }

  method set_layout_manager (GtkLayoutManager() $layout_manager) {
    gtk_widget_set_layout_manager($!gtk-w, $layout_manager);
  }

  method set_margin_bottom (Int() $margin) {
    my gint $m = $margin;

    gtk_widget_set_margin_bottom($!gtk-w, $m);
  }

  method set_margin_end (Int() $margin) {
    my gint $m = $margin;

    gtk_widget_set_margin_end($!gtk-w, $m);
  }

  method set_margin_start (Int() $margin) {
    my gint $m = $margin;

    gtk_widget_set_margin_start($!gtk-w, $m);
  }

  method set_margin_top (Int() $margin) {
    my gint $m = $margin;

    gtk_widget_set_margin_top($!gtk-w, $m);
  }

  method set_name (Str() $name) {
    gtk_widget_set_name($!gtk-w, $name);
  }

  method set_opacity (Num() $opacity) {
    my gdouble $o = $opacity;

    gtk_widget_set_opacity($!gtk-w, $o);
  }

  method set_overflow (Int() $overflow) {
    my GtkOverflow $o = $overflow;

    gtk_widget_set_overflow($!gtk-w, $o);
  }

  method set_parent (GtkWidget() $parent) {
    gtk_widget_set_parent($!gtk-w, $parent);
  }

  method set_receives_default (Int() $receives_default) {
    my gboolean $r = $receives_default.so.Int;

    gtk_widget_set_receives_default($!gtk-w, $r);
  }

  method set_sensitive (Int() $sensitive) {
    my gboolean $s = $sensitive.so.Int;

    gtk_widget_set_sensitive($!gtk-w, $s);
  }

  method set_size_request (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gtk_widget_set_size_request($!gtk-w, $w, $h);
  }

  method set_state_flags (Int() $flags, Int() $clear) {
    my GtkStateFlags $f = $flags;
    my gboolean      $c = $clear;

    gtk_widget_set_state_flags($!gtk-w, $f, $c);
  }

  method set_tooltip_markup (Str() $markup) {
    gtk_widget_set_tooltip_markup($!gtk-w, $markup);
  }

  method set_tooltip_text (Str() $text) {
    gtk_widget_set_tooltip_text($!gtk-w, $text);
  }

  method set_valign (Int() $align) {
    my GtkAlign $a = $align;

    gtk_widget_set_valign($!gtk-w, $align);
  }

  method set_vexpand (Int() $expand) {
    my gboolean $e = $expand.so.Int;

    gtk_widget_set_vexpand($!gtk-w, $e);
  }

  method set_vexpand_set (Int() $set) {
    my gboolean $s = $set.so.Int;

    gtk_widget_set_vexpand_set($!gtk-w, $s);
  }

  method set_visible (Int() $visible) {
    my gboolean $v = $visible.so.Int;

    gtk_widget_set_visible($!gtk-w, $v);
  }

  method should_layout {
    so gtk_widget_should_layout($!gtk-w);
  }

  method show {
    gtk_widget_show($!gtk-w);
  }

  method size_allocate (GtkAllocation() $allocation, Int() $baseline) {
    my gint $b = $baseline;

    gtk_widget_size_allocate($!gtk-w, $allocation, $b);
  }

  method snapshot_child (GtkWidget() $child, GtkSnapshot() $snapshot) {
    gtk_widget_snapshot_child($!gtk-w, $child, $snapshot);
  }

  proto method translate_coordinates (|)
  { *}

  multi method translate_coordinates (
    GtkWidget() $dest_widget,
    Num()       $src_x,
    Num()       $src_y
  ) {
    samewith($dest_widget, $src_x, $src_y, $, $);
  }
  multi method translate_coordinates (
    GtkWidget() $dest_widget,
    Num()       $src_x,
    Num()       $src_y,
                $dest_x is rw,
                $dest_y is rw
  ) {
    my gdouble ($sx, $sy, $dx, $dy) = ($src_x, $src_y, 0e0, 0e0);

    gtk_widget_translate_coordinates(
      $!gtk-w,
      $dest_widget,
      $sx,
      $sy,
      $dx,
      $dy
     );
     ($dest_x, $dest_y) = ($dx, $dy);
  }

  method trigger_tooltip_query {
    gtk_widget_trigger_tooltip_query($!gtk-w);
  }

  method unmap {
    gtk_widget_unmap($!gtk-w);
  }

  method unparent {
    gtk_widget_unparent($!gtk-w);
  }

  method unrealize {
    gtk_widget_unrealize($!gtk-w);
  }

  method unset_state_flags (Int() $flags) {
    my GtkStateFlags $f = $flags;

    gtk_widget_unset_state_flags($!gtk-w, $f\);
  }

}

INIT {
  my \O = GTK::Widget;
  %widget-types{O.get_type} = {
    name        => 'Widget',
    object      => O,
    pair        => O.getTypePair
  }
}

class GTK::Requisition {
  has GtkRequisition $!gtk-r is implementor;

  method new {
    my $gtk-requisition = gtk_requisition_new();

    $gtk-requisition ?? self.bless( :$gtk-requisition ) !! Nil;
  }

  method copy {
    gtk_requisition_copy($!gtk-r);
  }

  method free {
    gtk_requisition_free($!gtk-r);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_requisition_get_type, $n, $t );
  }
}

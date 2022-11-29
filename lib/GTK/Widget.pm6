use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Widget:ver<4>;

use Pango::Context;
use Pango::FontMap;
use Pango::Layout;
use GDK::Clipboard:ver<4>;
use GDK::Cursor:ver<4>;
use GDK::Display:ver<4>;
use GDK::FrameClock:ver<4>;
use GTK::LayoutManager:ver<4>;
#use GTK::Settings:ver<4>;
#use GTK::StyleContext:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;
use GTK::Roles::Accessible:ver<4>;
use GTK::Roles::Buildable:ver<4>;
use GTK::Roles::Constraint::Target:ver<4>;
use GTK::Roles::Root:ver<4>;
use GTK::Roles::Native:ver<4>;

our subset GtkWidgetAncestry is export of Mu
  where GtkWidget | GtkAccessible | GtkBuildable | GtkConstraintTarget |
        GObject;

class GTK::Widget:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Accessible;
  also does GTK::Roles::Buildable;
  also does GTK::Roles::Constraint::Target;

  has GtkWidget $!gtk-w is implementor;

  submethod BUILD ( :$gtk-widget ) {
    self.setGtkWidget($gtk-widget) if $gtk-widget;
  }

  method setGtkWidget (GtkWidgetAncestry $_) {
    my $to-parent;

    $!gtk-w = do {
      when GtkWidget {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkAccessible {
        $!gtk-a    = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkWidget, $_);
      }

      when GtkBuildable {
        $!gtk-b    = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkWidget, $_);
      }

      when GtkBuildable {
        $!gtk-ct   = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkWidget, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkWidget, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkAccessible;
    self.roleInit-GtkBuildable;
    self.roleInit-GtkConstraintTarget;
  }

  method GTK::Raw::Structs::GtkWidget
    is also<GtkWidget>
  { $!gtk-w }

  multi method new (GtkWidgetAncestry $gtk-widget, :$ref = True) {
    return unless $gtk-widget;

    my $o = self.bless( :$gtk-widget );
    $o.ref if $ref;
    $o;
  }

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
  method root ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Gtk::Root.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('root', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Root.getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        warn 'root does not allow writing'
      }
    );
  }

  # Type: int
  method width-request is rw  is g-property is also<width_request> {
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
  method height-request is rw  is g-property is also<height_request> {
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
  method can-focus is rw  is g-property is also<can_focus> {
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
  method can-target is rw  is g-property is also<can_target> {
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
  method focus-on-click is rw  is g-property is also<focus_on_click> {
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
  method receives-default is rw  is g-property is also<receives_default> {
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
  method cursor ( :$raw = False ) is rw  is g-property {
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
  method has-tooltip is rw  is g-property is also<has_tooltip> {
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
  method tooltip-text is rw  is g-property is also<tooltip_text> {
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
  method tooltip-markup is rw  is g-property is also<tooltip_markup> {
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
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkAlign) );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('halign', $gv);
        my $a = $gv.enum;
        $enum ?? GtkAlignEnum($a) !! $a;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkAlign) = $val;
        self.prop_set('halign', $gv);
      }
    );
  }

  # Type: GTKAlign
  method valign ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkAlign) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('valign', $gv);
        my $a = $gv.enum;
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
  method margin-start
    is rw
    is g-property
    is also<
      margin_start
      margin-left
      margin_left
    >
  {
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
  method margin-end
    is rw
    is g-property
    is also<
      margin_end
      margin_right
      margin-right
    >
 {
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
  method margin-top is rw  is g-property is also<margin_top> {
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
  method margin-bottom is rw  is g-property is also<margin_bottom> {
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
  method hexpand-set is rw  is g-property is also<hexpand_set> {
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
  method vexpand-set is rw  is g-property is also<vexpand_set> {
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
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkOverflow) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overflow', $gv);
        my $o = $gv.enum;
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
  method scale-factor is rw  is g-property is also<scale_factor> {
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
  method css-name is rw  is g-property is also<css_name> {
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
  method css-classes ( :$raw = False, :$carray = False )
    is rw
    is g-property
    is also<css_classes>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('css-classes', $gv);
        return $gv.pointer if $raw;
        my $r = cast(CArray[Str], $gv.pointer);
        return $r if $carray;
        CArrayToArray($r);
      },
      STORE => -> $, $val is copy {
        $gv.pointer = propAssignArray(Str, $val);
        self.prop_set('css-classes', $gv);
      }
    );
  }

  # Type: GtkLayoutManager
  method layout-manager ( :$raw = False )
    is rw
    is g-property
    is also<layout_manager>
  {
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

  method size-request is also<size_request> is rw {
    Proxy.new:
      FETCH => -> $                           { self.get_size_request },
      STORE => -> $, @size where *.elems == 2 { self.set_size_request( |@size ) };
  }

  method margins is rw {
    Proxy.new:
      FETCH => -> $ {
        ( .get-margin-left, .get-margin-right,
          .get-margin-top,  .get-margin-bottom ) given self;
      },

      STORE => -> $, $val is copy {
        $val = $val xx 4 if $val ~~ Int;
        $val .= Array if $val.^can('Array');
        # cw: We use CArray for its type safety...
        my $v = ArrayToCArray(uint32, $val) if $val ~~ Array;
        X::GLib::InvalidSize.new(
          message => 'margin value must be Array-compatible with 4 elements!'
        ).throw unless $v.elems == 4;
        # cw: ...however that means we have to spell out our assignments
        self.set-margin-left(   $v[0] );
        self.set-margin-right(  $v[1] );
        self.set-margin-top(    $v[2] );
        self.set-margin-bottom( $v[3] );
      }
  }

  method Destroy {
    self.connect($!gtk-w, 'destroy');
  }

  method Direction-Changed is also<Direction_Changed> {
    self.connect-uint($!gtk-w, 'direction-changed');
  }

  method Hide {
    self.connect($!gtk-w, 'hide');
  }

  method Keynav-Failed is also<Keynav_Failed> {
    self.connect-uint($!gtk-w, 'keynav-failed');
  }

  method Map {
    self.connect($!gtk-w, 'map');
  }

  method Mnemonic-Activate is also<Mnemonic_Activate> {
    self.connect-uint-ruint($!gtk-w, 'mnemonic-activate');
  }

  method Move-Focus is also<Move_Focus> {
    self.connect-uint($!gtk-w, 'move-focus');
  }

  method Query-Tooltip is also<Query_Tooltip> {
    self.connect-query-tooltip($!gtk-w);
  }

  method Realize {
    self.connect($!gtk-w, 'realize');
  }

  method Show {
    self.connect($!gtk-w, 'show');
  }

  method State-Flags-Changed is also<State_Flags_Changed> {
    self.connect-uint($!gtk-w, 'state-flags-changed');
  }

  method Unmap {
    self.connect($!gtk-w, 'unmap');
  }

  method Unrealize {
    self.connect($!gtk-w, 'unrealize');
  }

  method action_set_enabled (Str() $action_name, Int() $enabled)
    is also<action-set-enabled>
  {
    my gboolean $e = $enabled.so.Int;

    gtk_widget_action_set_enabled($!gtk-w, $action_name, $e);
  }

  method activate {
    gtk_widget_activate($!gtk-w);
  }

  method activate_action (Str() $name, Str() $format_string)
    is also<activate-action>
  {
    gtk_widget_activate_action($!gtk-w, $name, $format_string);
  }

  method activate_action_variant (Str() $name, GVariant() $args)
    is also<activate-action-variant>
  {
    gtk_widget_activate_action_variant($!gtk-w, $name, $args);
  }

  method activate_default is also<activate-default> {
    gtk_widget_activate_default($!gtk-w);
  }

  method add_controller (GtkEventController() $controller)
    is also<add-controller>
  {
    gtk_widget_add_controller($!gtk-w, $controller);
  }

  method add_css_class (Str() $css_class) is also<add-css-class> {
    gtk_widget_add_css_class($!gtk-w, $css_class);
  }

  method add_mnemonic_label (GtkWidget() $label)
    is also<add-mnemonic-label>
  {
    gtk_widget_add_mnemonic_label($!gtk-w, $label);
  }

  method add_tick_callback (
                    &callback,
    gpointer        $user_data = gpointer,
                    &notify    = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<add-tick-callback>
  {
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

  method child_focus (Int() $direction) is also<child-focus> {
    my GtkDirectionType $d = $direction;

    gtk_widget_child_focus($!gtk-w, $d);
  }

  method compute_bounds (
    GtkWidget       $target,
    graphene_rect_t $out_bounds
  )
    is also<compute-bounds>
  {
    gtk_widget_compute_bounds($!gtk-w, $target, $out_bounds);
  }

  method compute_expand (Int() $orientation) is also<compute-expand> {
    my GtkOrientation $o = $orientation;

    gtk_widget_compute_expand($!gtk-w, $o);
  }

  method compute_point (
    GtkWidget        $target,
    graphene_point_t $point,
    graphene_point_t $out_point
  )
    is also<compute-point>
  {
    gtk_widget_compute_point($!gtk-w, $target, $point, $out_point);
  }

  method compute_transform (
    GtkWidget         $target,
    graphene_matrix_t $out_transform
  )
    is also<compute-transform>
  {
    gtk_widget_compute_transform($!gtk-w, $target, $out_transform);
  }

  method contains (
    gdouble   $x,
    gdouble   $y
  ) {
    gtk_widget_contains($!gtk-w, $x, $y);
  }

  method create_pango_context ( :$raw = False ) is also<create-pango-context> {
    propReturnObject(
      gtk_widget_create_pango_context($!gtk-w),
      $raw,
      |Pango::Context.getTypePair
    );
  }

  method create_pango_layout (Str() $text, :$raw = False)
    is also<create-pango-layout>
  {
    propReturnObject(
      gtk_widget_create_pango_layout($!gtk-w, $text),
      $raw,
      |Pango::Layout.getTypePair
    );
  }

  method dispose_template (Int() $widget_type) is also<dispose-template> {
    my GType $w = $widget_type;

    gtk_widget_dispose_template($!gtk-w, $w);
  }

  method error_bell is also<error-bell> {
    gtk_widget_error_bell($!gtk-w);
  }

  method get_allocated_baseline is also<get-allocated-baseline> {
    gtk_widget_get_allocated_baseline($!gtk-w);
  }

  method get_allocated_height is also<get-allocated-height> {
    gtk_widget_get_allocated_height($!gtk-w);
  }

  method get_allocated_width is also<get-allocated-width> {
    gtk_widget_get_allocated_width($!gtk-w);
  }

  method get_allocation (GtkAllocation() $allocation)
    is also<get-allocation>
  {
    gtk_widget_get_allocation($!gtk-w, $allocation);
  }

  method get_ancestor (Int() $widget_type) is also<get-ancestor> {
    my GType $w = $widget_type;

    gtk_widget_get_ancestor($!gtk-w, $w);
  }

  method get_can_focus is also<get-can-focus> {
    so gtk_widget_get_can_focus($!gtk-w);
  }

  method get_can_target is also<get-can-target> {
    so gtk_widget_get_can_target($!gtk-w);
  }

  method get_child_visible is also<get-child-visible> {
    so gtk_widget_get_child_visible($!gtk-w);
  }

  method get_clipboard ( :$raw = False )is also<get-clipboard> {
    propReturnObject(
      gtk_widget_get_clipboard($!gtk-w),
      $raw,
      |GDK::Clipboard.getTypePair
    );
  }

  method get_css_classes is also<get-css-classes> {
    gtk_widget_get_css_classes($!gtk-w);
  }

  method get_css_name ( :$carray = False ) is also<get-css-name> {
    my $c = gtk_widget_get_css_name($!gtk-w);
    return $c if $carray;
    CArrayToArray($c);
  }

  method get_cursor ( :$raw = False ) is also<get-cursor> {
    propReturnObject(
      gtk_widget_get_cursor($!gtk-w),
      $raw,
      |GDK::Cursor.getTypePair
    );
  }

  method get_default_direction ( :$enum = True )
    is static
    is also<get-default-direction>
  {
    my $d = gtk_widget_get_default_direction();
    return $d unless $enum;
    $d;
  }

  method get_direction ( $enum = True ) is also<get-direction> {
    my $d = gtk_widget_get_direction($!gtk-w);
    return $d unless $enum;
    GtkTextDirectionEnum($d);
  }

  method get_display ( :$raw = False ) is also<get-display> {
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
  )
    is also<get-first-child>
  {
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
  )
    is also<get-focus-child>
  {
    returnProperWidget(
      gtk_widget_get_focus_child($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_focus_on_click is also<get-focus-on-click> {
    so gtk_widget_get_focus_on_click($!gtk-w);
  }

  method get_focusable is also<get-focusable> {
    so gtk_widget_get_focusable($!gtk-w);
  }

  method get_font_map ( :$raw = False ) is also<get-font-map> {
    propReturnObject(
      gtk_widget_get_font_map($!gtk-w),
      $raw,
      |Pango::FontMap.getTypePair
    );
  }

  method get_font_options ( :$raw = False ) is also<get-font-options> {
    propReturnObject(
      gtk_widget_get_font_options($!gtk-w),
      $raw,
      cairo_font_options_t,
      Cairo::FontOptions
    );
  }

  method get_frame_clock ( :$raw = False ) is also<get-frame-clock> {
    propReturnObject(
      gtk_widget_get_frame_clock($!gtk-w),
      $raw,
      |GDK::FrameClock.getTypePair
    );
  }

  method get_halign ( :$enum = True ) is also<get-halign> {
    my $h = gtk_widget_get_halign($!gtk-w);
    return $h unless $enum;
    GtkAlignEnum($h);
  }

  method get_has_tooltip is also<get-has-tooltip> {
    so gtk_widget_get_has_tooltip($!gtk-w);
  }

  method get_height is also<get-height> {
    gtk_widget_get_height($!gtk-w);
  }

  method get_hexpand is also<get-hexpand> {
    so gtk_widget_get_hexpand($!gtk-w);
  }

  method get_hexpand_set is also<get-hexpand-set> {
    so gtk_widget_get_hexpand_set($!gtk-w);
  }

  method get_last_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-last-child>
  {
    returnProperWidget(
      gtk_widget_get_last_child($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_layout_manager ( :$raw = False ) is also<get-layout-manager> {
    propReturnObject(
      gtk_widget_get_layout_manager($!gtk-w),
      $raw,
      |GTK::LayoutManager.getTypePair
    );
  }

  method get_mapped is also<get-mapped> {
    so gtk_widget_get_mapped($!gtk-w);
  }

  method get_margin_bottom is also<get-margin-bottom> {
    gtk_widget_get_margin_bottom($!gtk-w);
  }

  method get_margin_end
    is also<
      get-margin-end
      get_margin_right
      get-margin-right
    >
  {
    gtk_widget_get_margin_end($!gtk-w);
  }

  method get_margin_start
    is also<
      get-margin-start
      get_margin_left
      get-margin-left
    >
  {
    gtk_widget_get_margin_start($!gtk-w);
  }

  method get_margin_top is also<get-margin-top> {
    gtk_widget_get_margin_top($!gtk-w);
  }

  method get_name is also<get-name> {
    gtk_widget_get_name($!gtk-w);
  }

  method get_native ( :$raw = False ) is also<get-native> {
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
  )
    is also<get-next-sibling>
  {
    returnProperWidget(
      gtk_widget_get_next_sibling($!gtk-w),
      $raw,
      $proper
    )
  }

  method get_opacity is also<get-opacity> {
    gtk_widget_get_opacity($!gtk-w);
  }

  method get_overflow ( :$enum = True ) is also<get-overflow> {
    my $o =  gtk_widget_get_overflow($!gtk-w);
    return $o unless $enum;
    GtkOverflowEnum($o);
  }

  method get_pango_context ( :$raw = False ) is also<get-pango-context> {
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
  )
    is also<get-parent>
  {
    returnProperWidget(
      gtk_widget_get_parent($!gtk-w),
      $raw,
      $proper
    )
  }

  method get_preferred_size (
    GtkRequisition() $minimum_size,
    GtkRequisition() $natural_size
  )
    is also<get-preferred-size>
  {
    gtk_widget_get_preferred_size($!gtk-w, $minimum_size, $natural_size);
  }

  method get_prev_sibling (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-prev-sibling>
  {
    returnProperWidget(
      gtk_widget_get_prev_sibling($!gtk-w),
      $raw,
      $proper
    );
  }

  method get_primary_clipboard ( :$raw = False ) is also<get-primary-clipboard> {
    propReturnObject(
      gtk_widget_get_primary_clipboard($!gtk-w),
      $raw,
      |GDK::Clipboard.getTypePair
    )
  }

  method get_realized is also<get-realized> {
    so gtk_widget_get_realized($!gtk-w);
  }

  method get_receives_default is also<get-receives-default> {
    so gtk_widget_get_receives_default($!gtk-w);
  }

  method get_request_mode ( :$enum = False ) is also<get-request-mode> {
    my $rm = gtk_widget_get_request_mode($!gtk-w);
    return $rm unless $enum;
    GtkSizeRequestModeEnum($rm);
  }

  method get_root (
    :$root          = False,
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-root>
  {
    my $r = gtk_widget_get_root($!gtk-w);
    return propReturnObject($r, $raw, |GTK::Root.getTypePair) if $root;
    returnProperWidget($r, $raw, $proper);
  }

  method get_scale_factor is also<get-scale-factor> {
    gtk_widget_get_scale_factor($!gtk-w);
  }

  method get_sensitive is also<get-sensitive> {
    so gtk_widget_get_sensitive($!gtk-w);
  }

  method get_settings ( :$raw = False ) is also<get-settings> {
    propReturnObject(
      gtk_widget_get_settings($!gtk-w),
      $raw,
      |GTK::Settings.getTypePair
    );
  }

  method get_size (Int() $orientation) is also<get-size> {
    my GtkOrientation $o = $orientation;

    gtk_widget_get_size($!gtk-w, $o);
  }

  proto method get_size_request (|)
    is also<get-size-request>
  { * }

  multi method get_size_request {
    samewith($, $)
  }
  multi method get_size_request ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_widget_get_size_request($!gtk-w, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_state_flags ( :set(:$flags) = True ) is also<get-state-flags> {
    my $s = gtk_widget_get_state_flags($!gtk-w);
    return $s unless $flags;
    getFlags(GtkStateFlags, $s);
  }

  method get_style_context ( :$raw = False ) is also<get-style-context> {
    propReturnObject(
      gtk_widget_get_style_context($!gtk-w),
      $raw,
      |GTK::StyleContext.getTypePair
    );
  }

  method get_template_child (Int() $widget_type, Str() $name)
    is also<get-template-child>
  {
    my GType $w = $widget_type;

    gtk_widget_get_template_child($!gtk-w, $w, $name);
  }

  method get_tooltip_markup is also<get-tooltip-markup> {
    gtk_widget_get_tooltip_markup($!gtk-w);
  }

  method get_tooltip_text is also<get-tooltip-text> {
    gtk_widget_get_tooltip_text($!gtk-w);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_widget_get_type, $n, $t );
  }

  method get_valign ( :$enum = True ) is also<get-valign> {
    my $v = gtk_widget_get_valign($!gtk-w);
    return $v unless $enum;
    GtkAlignEnum($v);
  }

  method get_vexpand is also<get-vexpand> {
    so gtk_widget_get_vexpand($!gtk-w);
  }

  method get_vexpand_set is also<get-vexpand-set> {
    so gtk_widget_get_vexpand_set($!gtk-w);
  }

  method get_visible is also<get-visible> {
    so gtk_widget_get_visible($!gtk-w);
  }

  method get_width is also<get-width> {
    gtk_widget_get_width($!gtk-w);
  }

  method grab_focus is also<grab-focus> {
    so gtk_widget_grab_focus($!gtk-w);
  }

  method has_css_class (Str() $css_class) is also<has-css-class> {
    so gtk_widget_has_css_class($!gtk-w, $css_class);
  }

  method has_default {
    so gtk_widget_has_default($!gtk-w);
  }

  method has_focus {
    so gtk_widget_has_focus($!gtk-w);
  }

  method has_visible_focus is also<has-visible-focus> {
    so gtk_widget_has_visible_focus($!gtk-w);
  }

  method hide {
    gtk_widget_hide($!gtk-w);
  }

  method in_destruction is also<in-destruction> {
    so gtk_widget_in_destruction($!gtk-w);
  }

  method insert_action_group (Str() $name, GActionGroup() $group)
    is also<insert-action-group>
  {
    gtk_widget_insert_action_group($!gtk-w, $name, $group);
  }

  method insert_after (GtkWidget() $parent, GtkWidget() $previous_sibling)
    is also<insert-after>
  {
    gtk_widget_insert_after($!gtk-w, $parent, $previous_sibling);
  }

  method insert_before (GtkWidget() $parent, GtkWidget() $next_sibling)
    is also<insert-before>
  {
    gtk_widget_insert_before($!gtk-w, $parent, $next_sibling);
  }

  method is_ancestor (GtkWidget() $ancestor) is also<is-ancestor> {
    so gtk_widget_is_ancestor($!gtk-w, $ancestor);
  }

  method is_drawable is also<is-drawable> {
    so gtk_widget_is_drawable($!gtk-w);
  }

  method is_focus is also<is-focus> {
    so gtk_widget_is_focus($!gtk-w);
  }

  method is_sensitive is also<is-sensitive> {
    so gtk_widget_is_sensitive($!gtk-w);
  }

  method is_visible is also<is-visible> {
    so gtk_widget_is_visible($!gtk-w);
  }

  method keynav_failed (Int() $direction) is also<keynav-failed> {
    my GtkDirectionType $d = $direction;

    so gtk_widget_keynav_failed($!gtk-w, $d);
  }

  method list_mnemonic_labels is also<list-mnemonic-labels> {
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

  method mnemonic_activate (Int() $group_cycling) is also<mnemonic-activate> {
    my gboolean $g = $group_cycling;

    gtk_widget_mnemonic_activate($!gtk-w, $g);
  }

  method observe_children (
    :$raw                   = False,
    :raw_model(:$raw-model) = False,
    :$model                 = False,
    :quick(:$fast)          = False,
    :slow(:$proper)         = $fast.not
   )
    is also<observe-children>
  {
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
    :raw_model(:$raw-model) = False,
    :$model                 = False
  )
    is also<observe-controllers>
  {
    my $om = propReturnObject(
      gtk_widget_observe_controllers($!gtk-w);
      $raw,
      |GIO::ListModel.getTypePair
    );
    return $om if $raw-model;
    $om does GLib::Roles::TypedArray[
      GtkEventController,
      $raw,
      GTK::EventController
    ];
    return $om if $model;
    $om.Array;
  }

  method pick (
    Num()  $x,
    Num()  $y,
    Int()  $flags,

           :quick(:$fast)  = False,
           :$raw           = False,
           :slow(:$proper) = $fast.not
  ) {
    my gdouble      ($xx, $yy) = ($x, $y);
    my GtkPickFlags  $f        =  $flags;

    returnProperWidget(
      gtk_widget_pick($!gtk-w, $xx, $yy, $f),
      $raw,
      $proper
    );
  }

  method queue_allocate is also<queue-allocate> {
    gtk_widget_queue_allocate($!gtk-w);
  }

  method queue_draw is also<queue-draw> {
    gtk_widget_queue_draw($!gtk-w);
  }

  method queue_resize is also<queue-resize> {
    gtk_widget_queue_resize($!gtk-w);
  }

  method realize {
    gtk_widget_realize($!gtk-w);
  }

  method remove_controller (GtkEventController() $controller)
    is also<remove-controller>
  {
    gtk_widget_remove_controller($!gtk-w, $controller);
  }

  method remove_css_class (Str() $css_class) is also<remove-css-class> {
    gtk_widget_remove_css_class($!gtk-w, $css_class);
  }

  method remove_mnemonic_label (GtkWidget() $label)
    is also<remove-mnemonic-label>
  {
    gtk_widget_remove_mnemonic_label($!gtk-w, $label);
  }

  method remove_tick_callback (Int() $id) is also<remove-tick-callback> {
    my guint $i = $id;
    gtk_widget_remove_tick_callback($!gtk-w, $id);
  }

  method set_can_focus (Int()  $can_focus) is also<set-can-focus> {
    my gboolean $c = $can_focus.so.Int;

    gtk_widget_set_can_focus($!gtk-w, $c);
  }

  method set_can_target (Int() $can_target) is also<set-can-target> {
    my gboolean $c = $can_target.so.Int;

    gtk_widget_set_can_target($!gtk-w, $c);
  }

  multi method set_child_visible (Int() $child_visible)
    is also<set-child-visible>
  {
    my gboolean $c = $child_visible.so.Int;

    gtk_widget_set_child_visible($!gtk-w, $c);
  }

  proto method set_css_classes (|)
    is also<set-css-classes>
  { * }

  multi method set_css_classes (@classes) {
    samewith( ArrayToCArray(Str, @classes, :null) );
  }
  multi method set_css_classes (CArray[Str] $classes) {
    gtk_widget_set_css_classes($!gtk-w, $classes);
  }

  method set_cursor (GdkCursor() $cursor) is also<set-cursor> {
    gtk_widget_set_cursor($!gtk-w, $cursor);
  }

  method set_cursor_from_name (Str() $name) is also<set-cursor-from-name> {
    gtk_widget_set_cursor_from_name($!gtk-w, $name);
  }

  method set_default_direction (Int() $direction)
    is static
    is also<set-default-direction>
  {
    my GtkTextDirection $d = $direction;

    gtk_widget_set_default_direction($d);
  }

  method set_direction (Int() $dir) is also<set-direction> {
    my GtkTextDirection $d = $dir;

    gtk_widget_set_direction($!gtk-w, $d);
  }

  method set_focus_child (GtkWidget() $child) is also<set-focus-child> {
    gtk_widget_set_focus_child($!gtk-w, $child);
  }

  method set_focus_on_click (Int() $focus_on_click)
    is also<set-focus-on-click>
  {
    my gboolean $f = $focus_on_click.so.Int;

    gtk_widget_set_focus_on_click($!gtk-w, $f);
  }

  method set_focusable (Int() $focusable) is also<set-focusable> {
    my gboolean $f = $focusable.so.Int;

    gtk_widget_set_focusable($!gtk-w, $f);
  }

  method set_font_map (PangoFontMap() $font_map) is also<set-font-map> {
    gtk_widget_set_font_map($!gtk-w, $font_map);
  }

  method set_font_options (cairo_font_options_t() $options)
    is also<set-font-options>
  {
    gtk_widget_set_font_options($!gtk-w, $options);
  }

  method set_halign (Int() $align) is also<set-halign> {
    my GtkAlign $a = $align;

    gtk_widget_set_halign($!gtk-w, $a);
  }

  method set_has_tooltip (Int() $has_tooltip) is also<set-has-tooltip> {
    my gboolean $h = $has_tooltip.so.Int;

    gtk_widget_set_has_tooltip($!gtk-w, $h);
  }

  method set_hexpand (Int() $expand) is also<set-hexpand> {
    my gboolean $e = $expand.so.Int;

    gtk_widget_set_hexpand($!gtk-w, $e);
  }

  method set_hexpand_set (Int() $set) is also<set-hexpand-set> {
    my gboolean $s = $set.so.Int;

    gtk_widget_set_hexpand_set($!gtk-w, $s);
  }

  method set_layout_manager (GtkLayoutManager() $layout_manager)
    is also<set-layout-manager>
  {
    gtk_widget_set_layout_manager($!gtk-w, $layout_manager);
  }

  method set_margin_bottom (Int() $margin) is also<set-margin-bottom> {
    my gint $m = $margin;

    gtk_widget_set_margin_bottom($!gtk-w, $m);
  }

  method set_margin_end (Int() $margin)
    is also<
      set-margin-end
      set_margin_right
      set-margin-right
    >
  {
    my gint $m = $margin;

    gtk_widget_set_margin_end($!gtk-w, $m);
  }

  method set_margin_start (Int() $margin)
    is also<
      set-margin-start
      set_margin_left
      set-margin-left
    >
  {
    my gint $m = $margin;

    gtk_widget_set_margin_start($!gtk-w, $m);
  }

  method set_margin_top (Int() $margin) is also<set-margin-top> {
    my gint $m = $margin;

    gtk_widget_set_margin_top($!gtk-w, $m);
  }

  method set_name (Str() $name) is also<set-name> {
    gtk_widget_set_name($!gtk-w, $name);
  }

  method set_opacity (Num() $opacity) is also<set-opacity> {
    my gdouble $o = $opacity;

    gtk_widget_set_opacity($!gtk-w, $o);
  }

  method set_overflow (Int() $overflow) is also<set-overflow> {
    my GtkOverflow $o = $overflow;

    gtk_widget_set_overflow($!gtk-w, $o);
  }

  method set_parent (GtkWidget() $parent) is also<set-parent> {
    gtk_widget_set_parent($!gtk-w, $parent);
  }

  method set_receives_default (Int() $receives_default)
    is also<set-receives-default>
  {
    my gboolean $r = $receives_default.so.Int;

    gtk_widget_set_receives_default($!gtk-w, $r);
  }

  method set_sensitive (Int() $sensitive) is also<set-sensitive> {
    my gboolean $s = $sensitive.so.Int;

    gtk_widget_set_sensitive($!gtk-w, $s);
  }

  method set_size_request (Int() $width, Int() $height)
    is also<set-size-request>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_widget_set_size_request($!gtk-w, $w, $h);
  }

  method set_state_flags (Int() $flags, Int() $clear)
    is also<set-state-flags>
  {
    my GtkStateFlags $f = $flags;
    my gboolean      $c = $clear;

    gtk_widget_set_state_flags($!gtk-w, $f, $c);
  }

  method set_tooltip_markup (Str() $markup) is also<set-tooltip-markup> {
    gtk_widget_set_tooltip_markup($!gtk-w, $markup);
  }

  method set_tooltip_text (Str() $text) is also<set-tooltip-text> {
    gtk_widget_set_tooltip_text($!gtk-w, $text);
  }

  method set_valign (Int() $align) is also<set-valign> {
    my GtkAlign $a = $align;

    gtk_widget_set_valign($!gtk-w, $align);
  }

  method set_vexpand (Int() $expand) is also<set-vexpand> {
    my gboolean $e = $expand.so.Int;

    gtk_widget_set_vexpand($!gtk-w, $e);
  }

  method set_vexpand_set (Int() $set) is also<set-vexpand-set> {
    my gboolean $s = $set.so.Int;

    gtk_widget_set_vexpand_set($!gtk-w, $s);
  }

  method set_visible (Int() $visible) is also<set-visible> {
    my gboolean $v = $visible.so.Int;

    gtk_widget_set_visible($!gtk-w, $v);
  }

  method should_layout is also<should-layout> {
    so gtk_widget_should_layout($!gtk-w);
  }

  method show
    is also<
      show_all
      show-all
    >
  {
    gtk_widget_show($!gtk-w);
  }

  method size_allocate (GtkAllocation() $allocation, Int() $baseline)
    is also<size-allocate>
  {
    my gint $b = $baseline;

    gtk_widget_size_allocate($!gtk-w, $allocation, $b);
  }

  method snapshot_child (GtkWidget() $child, GtkSnapshot() $snapshot)
    is also<snapshot-child>
  {
    gtk_widget_snapshot_child($!gtk-w, $child, $snapshot);
  }

  proto method translate_coordinates (|)
    is also<translate-coordinates>
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

  method trigger_tooltip_query is also<trigger-tooltip-query> {
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

  method unset_state_flags (Int() $flags) is also<unset-state-flags> {
    my GtkStateFlags $f = $flags;

    gtk_widget_unset_state_flags($!gtk-w, $f);
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


our subset GtkRequisitionAncestry is export of Mu
  where GtkRequisition | GObject;

class GTK::Requisition {
  also does GLib::Roles::Object;

  has GtkRequisition $!gtk-r is implementor;

  submethod BUILD ( :$gtk-widget ) {
    self.setGtkRequisition($gtk-widget)
      if $gtk-widget
  }

  method setGtkRequisition (GtkRequisitionAncestry $_) {
    my $to-parent;

    $!gtk-r = do {
      when GtkRequisition {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkRequisition, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkRequisition
    is also<GtkRequisition>
  { $!gtk-r }

  multi method new (GtkRequisitionAncestry $gtk-widget, :$ref = True) {
    return unless $gtk-widget;

    my $o = self.bless( :$gtk-widget );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-requisition = gtk_requisition_new();

    $gtk-requisition ?? self.bless( :$gtk-requisition ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_requisition_copy($!gtk-r),
      $raw,
      |self.getTypePair
    )
  }

  method free {
    gtk_requisition_free($!gtk-r);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_requisition_get_type, $n, $t );
  }
}

INIT {
  my \O = GTK::Widget;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

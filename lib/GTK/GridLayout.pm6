use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::GridLayout:ver<4>;

use GTK::LayoutManager:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GtkGridLayoutAncestry is export of Mu
  where GtkGridLayout | GtkLayoutManagerAncestry;

class GTK::Layout::Grid:ver<4> is GTK::LayoutManager:ver<4> {
  has GtkGridLayout $!gtk-gl is implementor;

  submethod BUILD ( :$gtk-grid-layout ) {
    self.setGtkGridLayout($gtk-grid-layout) if $gtk-grid-layout
  }

  method setGtkGridLayout (GtkGridLayoutAncestry $_) {
    my $to-parent;

    $!gtk-gl = do {
      when GtkGridLayout {
        $to-parent = cast(GtkLayoutManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGridLayout, $_);
      }
    }
    self.setGtkLayoutManager($to-parent);
  }

  method GTK::Raw::Definitions::GtkGridLayout
    is also<GtkGridLayout>
  { $!gtk-gl }

  multi method new (
     $gtk-grid-layout where * ~~ GtkGridLayoutAncestry,

    :$ref = True
  ) {
    return unless $gtk-grid-layout;

    my $o = self.bless( :$gtk-grid-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-grid-layout = gtk_grid_layout_new();

    $gtk-grid-layout ?? self.bless( :$gtk-grid-layout ) !! Nil;
  }

  # Type: int
  method baseline-row is rw  is g-property is also<baseline_row> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('baseline-row', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('baseline-row', $gv);
      }
    );
  }

  # Type: boolean
  method column-homogeneous is rw  is g-property is also<column_homogeneous> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-homogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('column-homogeneous', $gv);
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

  # Type: boolean
  method row-homogeneous is rw  is g-property is also<row_homogeneous> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row-homogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('row-homogeneous', $gv);
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

  method get_baseline_row is also<get-baseline-row> {
    gtk_grid_layout_get_baseline_row($!gtk-gl);
  }

  method get_column_homogeneous is also<get-column-homogeneous> {
    so gtk_grid_layout_get_column_homogeneous($!gtk-gl);
  }

  method get_column_spacing is also<get-column-spacing> {
    gtk_grid_layout_get_column_spacing($!gtk-gl);
  }

  method get_row_baseline_position (Int() $row, :$enum = True)
    is also<get-row-baseline-position>
  {
    my gint $r = $row;

    my $p = gtk_grid_layout_get_row_baseline_position($!gtk-gl, $row);
    return $p unless $enum;
    GtkBaselinePositionEnum($p);
  }

  method get_row_homogeneous is also<get-row-homogeneous> {
    so gtk_grid_layout_get_row_homogeneous($!gtk-gl);
  }

  method get_row_spacing is also<get-row-spacing> {
    gtk_grid_layout_get_row_spacing($!gtk-gl);
  }

  method set_baseline_row(Int() $row) is also<set-baseline-row> {
    my gint $r = $row;

    gtk_grid_layout_set_baseline_row($!gtk-gl, $r);
  }

  method set_column_homogeneous (Int() $homogeneous)
    is also<set-column-homogeneous>
  {
    my gboolean $h = $homogeneous.so.Int;

    gtk_grid_layout_set_column_homogeneous($!gtk-gl, $h);
  }

  method set_column_spacing (Int() $spacing) is also<set-column-spacing> {
    my guint $s = $spacing;

    gtk_grid_layout_set_column_spacing($!gtk-gl, $s);
  }

  method set_row_baseline_position (Int() $row, Int() $pos)
    is also<set-row-baseline-position>
  {
    my gint                $r = $row;
    my GtkBaselinePosition $p = $pos;

    gtk_grid_layout_set_row_baseline_position($!gtk-gl, $r, $p);
  }

  method set_row_homogeneous (Int() $homogeneous)
    is also<set-row-homogeneous>
  {
    my gboolean $h = $homogeneous.so.Int;

    gtk_grid_layout_set_row_homogeneous($!gtk-gl, $h);
  }

  method set_row_spacing (Int() $spacing) is also<set-row-spacing> {
    my guint $s = $spacing;

    gtk_grid_layout_set_row_spacing($!gtk-gl, $s);
  }

}


our subset GtkGridLayoutChildAncestry is export of Mu
  where GtkGridLayoutChild | GObject;

class GTK::Layout::Grid::Child {
  also does GLib::Roles::Object;

  has GtkGridLayoutChild $!gtk-glc is implementor;

  submethod BUILD ( :$gtk-grid-layout-child ) {
    self.setGtkGridLayoutChild($gtk-grid-layout-child)
      if $gtk-grid-layout-child
  }

  method setGtkGridLayoutChild (GtkGridLayoutChildAncestry $_) {
    my $to-parent;

    $!gtk-glc = do {
      when GtkGridLayoutChild {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGridLayoutChild, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkGridLayoutChild
    is also<GtkGridLayoutChild>
  { $!gtk-glc }

  multi method new (
     $gtk-grid-layout-child where * ~~ GtkGridLayoutChildAncestry,

    :$ref = True
  ) {
    return unless $gtk-grid-layout-child;

    my $o = self.bless( :$gtk-grid-layout-child );
    $o.ref if $ref;
    $o;
  }

  # Type: int
  method column is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('column', $gv);
      }
    );
  }

  # Type: int
  method column-span is rw  is g-property is also<column_span> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-span', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('column-span', $gv);
      }
    );
  }

  # Type: int
  method row is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('row', $gv);
      }
    );
  }
  # Type: int
  method row-span is rw  is g-property is also<row_span> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row-span', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('row-span', $gv);
      }
    );
  }

  method get_column is also<get-column> {
    gtk_grid_layout_child_get_column($!gtk-glc);
  }

  method get_column_span is also<get-column-span> {
    gtk_grid_layout_child_get_column_span($!gtk-glc);
  }

  method get_row is also<get-row> {
    gtk_grid_layout_child_get_row($!gtk-glc);
  }

  method get_row_span is also<get-row-span> {
    gtk_grid_layout_child_get_row_span($!gtk-glc);
  }

  method set_column (Int() $column) is also<set-column> {
    my gint $c = $column;

    gtk_grid_layout_child_set_column($!gtk-glc, $c);
  }

  method set_column_span (Int() $span) is also<set-column-span> {
    my gint $s = $span;

    gtk_grid_layout_child_set_column_span($!gtk-glc, $s);
  }

  method set_row (Int() $row) is also<set-row> {
    my gint $r = $row;

    gtk_grid_layout_child_set_row($!gtk-glc, $r);
  }

  method set_row_span (Int() $span) is also<set-row-span> {
    my gint $s = $span;

    gtk_grid_layout_child_set_row_span($!gtk-glc, $s);
  }

}

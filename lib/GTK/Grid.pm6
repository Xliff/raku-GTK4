use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Grid:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;

our subset GtkGridAncestry is export of Mu
  where GtkGrid | GtkWidgetAncestry;

class GTK::Grid:ver<4> is GTK::Widget:ver<4> {
  has GtkGrid $!gtk-g is implementor;

  has         %.children;

  submethod BUILD ( :$gtk-grid ) {
    self.setGtkGrid($gtk-grid) if $gtk-grid
  }

  method setGtkGrid (GtkGridAncestry $_) {
    my $to-parent;

    $!gtk-g = do {
      when GtkGrid {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGrid, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkGrid
    is also<GtkGrid>
  { $!gtk-g }

  multi method new (GtkGridAncestry $gtk-grid, :$ref = True) {
    return unless $gtk-grid;

    my $o = self.bless( :$gtk-grid );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-grid = gtk_grid_new();

    $gtk-grid ?? self.bless( :$gtk-grid ) !! Nil;
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

  method attach (
    GtkWidget() $child,
    Int()       $column,
    Int()       $row,
    Int()       $width,
    Int()       $height
  ) {
    my gint ($c, $r, $w, $h) = ($column, $row, $width, $height);

    %!children{ +$child } = ($column, $row, $width, $height, $child);

    gtk_grid_attach($!gtk-g, $child, $c, $r, $w, $h);
  }

  method attach_next_to (
    GtkWidget() $child,
    GtkWidget() $sibling,
    Int()       $side,
    Int()       $width,
    Int()       $height
  )
    is also<attach-next-to>
  {
    my gint ($w, $h) = ($width, $height);

    my GtkPositionType $s = $side;

    gtk_grid_attach_next_to($!gtk-g, $child, $sibling, $s, $w, $h);
    %!children{ +$child } = ( |self.query_child($child), $child );
  }

  method get_baseline_row is also<get-baseline-row> {
    gtk_grid_get_baseline_row($!gtk-g);
  }

  method get_child_at (Int() $column, Int() $row) is also<get-child-at> {
    my gint ($c, $r) = ($column, $row);

    gtk_grid_get_child_at($!gtk-g, $c, $r);
  }

  method getChildren (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    %!children.pairs.sort( *.key ).map({
       .tail = returnProperWidget( .tail, $raw, $proper );
       $_;
    });
  }

  method get_column_homogeneous is also<get-column-homogeneous> {
    so gtk_grid_get_column_homogeneous($!gtk-g);
  }

  method get_column_spacing is also<get-column-spacing> {
    gtk_grid_get_column_spacing($!gtk-g);
  }

  method get_row_baseline_position (Int() $row) is also<get-row-baseline-position> {
    my gint $r = $row;

    gtk_grid_get_row_baseline_position($!gtk-g, $r);
  }

  method get_row_homogeneous is also<get-row-homogeneous> {
    so gtk_grid_get_row_homogeneous($!gtk-g);
  }

  method get_row_spacing is also<get-row-spacing> {
    gtk_grid_get_row_spacing($!gtk-g);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_grid_get_type, $n, $t );
  }

  method insert_column (Int() $position) is also<insert-column> {
    my gint $p = $position;

    gtk_grid_insert_column($!gtk-g, $p);
  }

  method insert_next_to (
    GtkWidget() $sibling,
    Int()       $side
  )
    is also<insert-next-to>
  {
    my GtkPositionType $s = $side;

    gtk_grid_insert_next_to($!gtk-g, $sibling, $s);
  }

  method insert_row (Int() $position) is also<insert-row> {
    my gint $p =  $position;

    gtk_grid_insert_row($!gtk-g, $p);
  }

  proto method query_child (|)
    is also<query-child>
  { * }

  multi method query_child (GtkWidget() $child) {
    samewith($child, $, $, $, $);
  }
  multi method query_child (
    GtkWidget() $child,
                $row    is rw,
                $column is rw,
                $width  is rw,
                $height is rw
  ) {
    my gint ($c, $r, $w, $h) = 0 xx 4;

    gtk_grid_query_child($!gtk-g, $child, $c, $r, $w, $h);

    ($row, $column, $width, $height) = ($c, $r, $w, $h);
  }

  method remove (GtkWidget() $child) {
    %!children{ +$child } = True;

    gtk_grid_remove($!gtk-g, $child);
  }

  method remove_column (Int() $position) is also<remove-column> {
    my gint $p = $position;

    gtk_grid_remove_column($!gtk-g, $position);
    %!children{ $_ }:delete for %!children.values.grep({ .[0] == $p });
  }

  method remove_row (Int() $position) is also<remove-row> {
    my gint $p = $position;

    gtk_grid_remove_row($!gtk-g, $p);
    %!children{ $_ }:delete for %!children.values.grep({ .[1] == $p });
  }

  method set_baseline_row (Int() $row) is also<set-baseline-row> {
    my gint $r =$row;

    gtk_grid_set_baseline_row($!gtk-g, $r);
  }

  method set_column_homogeneous (Int() $homogeneous) is also<set-column-homogeneous> {
    my gboolean $h = $homogeneous.so.Int;

    gtk_grid_set_column_homogeneous($!gtk-g, $h);
  }

  method set_column_spacing (Int() $spacing) is also<set-column-spacing> {
    my gint $s = $spacing;

    gtk_grid_set_column_spacing($!gtk-g, $s);
  }

  method set_row_baseline_position (Int() $row, Int() $pos) is also<set-row-baseline-position> {
    my gint                $r = $row;
    my GtkBaselinePosition $p = $pos;

    gtk_grid_set_row_baseline_position($!gtk-g, $r, $p);
  }

  method set_row_homogeneous (Int() $homogeneous) is also<set-row-homogeneous> {
    my gboolean $h = $homogeneous.so.Int;

    gtk_grid_set_row_homogeneous($!gtk-g, $h);
  }

  method set_row_spacing (Int() $spacing) is also<set-row-spacing> {
    my guint $s = $spacing;

    gtk_grid_set_row_spacing($!gtk-g, $s);
  }

}

INIT {
  my \O = GTK::Grid;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}


use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Area::Context:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkCellAreaContextAncestry is export of Mu
  where GtkCellAreaContext | GObject;

class GTK::Cell::Area::Context {
  also does GLib::Roles::Object;

  has GtkCellAreaContext $!gtk-cac is implementor;

  submethod BUILD ( :$gtk-area-context ) {
    self.setGtkCellAreaContext($gtk-area-context) if $gtk-area-context
  }

  method setGtkCellAreaContext (GtkCellAreaContextAncestry $_) {
    my $to-parent;

    $!gtk-cac = do {
      when GtkCellAreaContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellAreaContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellAreaContext
    is also<GtkCellAreaContext>
  { $!gtk-cac }

  multi method new (
    $gtk-area-context where * ~~ GtkCellAreaContextAncestry,

    :$ref = True
  ) {
    return unless $gtk-area-context;

    my $o = self.bless( :$gtk-area-context );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkCellArea
  method area ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GTK::Cell::Area').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('area', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GTK::Cell::Area').getTypePair
        )
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.object = $val;
        self.prop_set('area', $gv);
      }
    );
  }

  # Type: int
  method minimum-height is rw  is g-property is also<minimum_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('minimum-height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'minimum-height does not allow writing'
      }
    );
  }

  # Type: int
  method minimum-width is rw  is g-property is also<minimum_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('minimum-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'minimum-width does not allow writing'
      }
    );
  }

  # Type: int
  method natural-height is rw  is g-property is also<natural_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'natural-height does not allow writing'
      }
    );
  }

  # Type: int
  method natural-width is rw  is g-property is also<natural_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'natural-width does not allow writing'
      }
    );
  }

  method allocate (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gtk_cell_area_context_allocate($!gtk-cac, $w, $h);
  }

  proto method get_allocation (|)
    is also<get-allocation>
  { * }

  multi method get_allocation is also<allocation> {
    samewith($, $);
  }
  multi method get_allocation ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_cell_area_context_get_allocation($!gtk-cac, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_area ( :$raw = False ) {
    propReturnObject(
      gtk_cell_area_context_get_area($!gtk-cac),
      $raw,
      |::('GTK::Cell::Area').getTypePair
    );
  }

  proto method get_preferred_height ( | )
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height
    is also<
      preferred-height
      preferred_height
    >
  {
    samewith($, $);
  }
  multi method get_preferred_height (
    $minimum_height is rw,
    $natural_height is rw
  )
  {
    my gint ($m, $n) = 0 xx 2;

    gtk_cell_area_context_get_preferred_height($!gtk-cac, $m, $n);
    ($minimum_height, $natural_height) = ($m, $n);
  }

  proto method get_preferred_height_for_width (|)
    is also<get-preferred-height-for-width>
  { * }

  multi method get_preferred_height_for_width ($width) {
    samewith($width, $, $);
  }
  multi method get_preferred_height_for_width (
    Int() $width,
          $minimum_height is rw,
          $natural_height is rw
  ) {
    my gint ($w, $m, $n) = ($width, 0, 0);

    gtk_cell_area_context_get_preferred_height_for_width(
      $!gtk-cac,
      $w,
      $m,
      $n
    );
    ($minimum_height, $natural_height) = ($m, $n);
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width
    is also<
      preferred_width
      preferred-width
    >
  {
    samewith($, $);
  }
  multi method get_preferred_width (
    $minimum_width is rw,
    $natural_width is rw
  ) {
    my gint ($m, $n) = 0 xx 2;

    gtk_cell_area_context_get_preferred_width($!gtk-cac, $m, $n);
    ($minimum_width, $natural_width) = ($m, $n);
  }

  proto method get_preferred_width_for_height (|)
    is also<get-preferred-width-for-height>
  { * }

  multi method get_preferred_width_for_height ($height) {
    samewith($height, $, $);
  }
  multi method get_preferred_width_for_height (
    Int() $height,
          $minimum_width is rw,
          $natural_width is rw
  ) {
    my gint ($h, $m, $n) = ($height, 0, 0);

    gtk_cell_area_context_get_preferred_width_for_height(
      $!gtk-cac,
      $h,
      $m,
      $n
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_area_context_get_type, $n, $t );
  }

  method push_preferred_height (
    Int() $minimum_height,
    Int() $natural_height
  )
    is also<push-preferred-height>
  {
    my gint ($m, $n) = ($minimum_height, $natural_height);

    gtk_cell_area_context_push_preferred_height($!gtk-cac, $m, $n);
  }

  method push_preferred_width (
    Int() $minimum_width,
    Int() $natural_width
  )
    is also<push-preferred-width>
  {
    my gint ($m, $n) = ($minimum_width, $natural_width);

    gtk_cell_area_context_push_preferred_width($!gtk-cac, $m, $n);
  }

  method reset {
    gtk_cell_area_context_reset($!gtk-cac);
  }

}

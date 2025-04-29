use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Area::Box:ver<4>;

use GTK::Cell::Area:ver<4>;

use GLib::Roles::Implementor;

our subset GtkCellAreaBoxAncestry is export of Mu
  where GtkCellAreaBox | GtkCellAreaAncestry;

class GTK::Cell::Area::Box is GTK::Cell::Area {
  has GtkCellAreaBox $!gtk-cab is implementor;

  submethod BUILD ( :$gtk-area-box ) {
    self.setGtkCellAreaBox($gtk-area-box) if $gtk-area-box
  }

  method setGtkCellAreaBox (GtkCellAreaBoxAncestry $_) {
    my $to-parent;

    $!gtk-cab = do {
      when GtkCellAreaBox {
        $to-parent = cast(GtkCellArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellAreaBox, $_);
      }
    }
    self.setGtkCellArea($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellAreaBox
    is also<GtkCellAreaBox>
  { $!gtk-cab }

  multi method new (
    $gtk-area-box where * ~~ GtkCellAreaBoxAncestry,

    :$ref = True
  ) {
    return unless $gtk-area-box;

    my $o = self.bless( :$gtk-area-box );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-area-box = gtk_cell_area_box_new();

    my $o = $gtk-area-box ?? self.bless( :$gtk-area-box ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
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

  method get_spacing is also<get-spacing> {
    gtk_cell_area_box_get_spacing($!gtk-cab);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_area_box_get_type, $n, $t );
  }

  method pack_end (
    GtkCellRenderer() $renderer,
    Int()             $expand,
    Int()             $align,
    Int()             $fixed
  )
    is also<pack-end>
  {
    my gboolean ($e, $a, $f) = ($expand, $align, $fixed).map( *.so.Int );

    gtk_cell_area_box_pack_end($!gtk-cab, $renderer, $e, $a, $f);
  }

  method pack_start (
    GtkCellRenderer() $renderer,
    Int()             $expand,
    Int()             $align,
    Int()             $fixed
  )
    is also<pack-start>
  {
    my gboolean ($e, $a, $f) = ($expand, $align, $fixed).map( *.so.Int );

    gtk_cell_area_box_pack_start($!gtk-cab, $renderer, $e, $a, $f);
  }

  method push (
    GtkCellRenderer() $cell,
                     :$expand = False,
                     :$align  = False,
                     :$fixed  = False,
                     :$end    = False
  ) {
    $end ?? $.pack_end($cell, $expand, $align, $fixed)
         !! $.pack_start($cell, $expand, $align, $fixed)
  }

  method set_spacing (Int() $spacing) is also<set-spacing> {
    gtk_cell_area_box_set_spacing($!gtk-cab, $spacing);
  }

}

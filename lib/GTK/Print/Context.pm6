use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Print::Context:ver<4>;

use Cairo;
use Pango::Context;
use Pango::FontMap;
use Pango::Layout;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkPrintContextAncestry is export of Mu
  where GtkPrintContext | GObject;

class GTK::Print::Context:ver<4> {
  also does GLib::Roles::Object;

  has GtkPrintContext $!gtk-pc is implementor;

  submethod BUILD ( :$gtk-print-context ) {
    self.setGtkPrintContext($gtk-print-context)
      if $gtk-print-context
  }

  method setGtkPrintContext (GtkPrintContextAncestry $_) {
    my $to-parent;

    $!gtk-pc = do {
      when GtkPrintContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrintContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrintContext
    is also<GtkPrintContext>
  { $!gtk-pc }

  multi method new (
     $gtk-print-context where * ~~ GtkPrintContextAncestry,

    :$ref = True
  ) {
    return unless $gtk-print-context;

    my $o = self.bless( :$gtk-print-context );
    $o.ref if $ref;
    $o;
  }

  method cairo_context is rw is g-accessor is also<cairo-context> {
    Proxy.new:
      FETCH => -> $     { self.get_cairo_context    },
      STORE => -> $, \v { self.set_cairo_context(v) }
  }

  method create_pango_context ( :$raw = False ) is also<create-pango-context> {
    propReturnObject(
      gtk_print_context_create_pango_context($!gtk-pc),
      $raw,
      |Pango::Context.getTypePair
    );
  }

  method create_pango_layout ( :$raw = False ) is also<create-pango-layout> {
    propReturnObject(
      gtk_print_context_create_pango_layout($!gtk-pc),
      $raw,
      |Pango::Layout.getTypePair
    );
  }

  method get_cairo_context ( :$raw = False ) is also<get-cairo-context> {
    propReturnObject(
      gtk_print_context_get_cairo_context($!gtk-pc),
      $raw,
      cairo_t,
      Cairo::Context
    );
  }

  method get_dpi_x is also<get-dpi-x> {
    gtk_print_context_get_dpi_x($!gtk-pc);
  }

  method get_dpi_y is also<get-dpi-y> {
    gtk_print_context_get_dpi_y($!gtk-pc);
  }

  proto method get_hard_margins (|)
    is also<get-hard-margins>
  { * }

  multi method get_hard_margins {
    samewith($, $, $, $);
  }
  multi method get_hard_margins (
    $top    is rw,
    $bottom is rw,
    $left   is rw,
    $right  is rw
  ) {
    my gdouble ($t, $b, $l, $r) = 0e0 xx 4;

    gtk_print_context_get_hard_margins($!gtk-pc, $t, $b, $l, $r);
    ($top, $bottom, $left, $right) = ($t, $b, $l, $r);
  }

  method get_height is also<get-height> {
    gtk_print_context_get_height($!gtk-pc);
  }

  method get_page_setup is also<get-page-setup> {
    gtk_print_context_get_page_setup($!gtk-pc);
  }

  method get_pango_fontmap ( :$raw = False ) is also<get-pango-fontmap> {
    propReturnObject(
      gtk_print_context_get_pango_fontmap($!gtk-pc),
      $raw,
      |Pango::FontMap.getTypePairf
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_context_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gtk_print_context_get_width($!gtk-pc);
  }

  method set_cairo_context (cairo_t() $cr, Num() $dpi_x, Num() $dpi_y)
    is also<set-cairo-context>
  {
    my gdouble ($dx, $dy) = ($dpi_x, $dpi_y);

    gtk_print_context_set_cairo_context($!gtk-pc, $cr, $dx, $dy);
  }

}

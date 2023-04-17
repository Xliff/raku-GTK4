use v6.c;

use NativeCall;

# cw: Can't use ::Raw::Types here.
use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Subs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;

role GTK::Roles::SymbolicPaintable:ver<4> {
  has GtkSymbolicPaintable $!gtk-sp is implementor;

  method roleInit-GtkSymbolicPaintable {
    return if $!gtk-sp;

    my \i    = findProperImplementor(self.^attributes);
    $!gtk-sp = cast( GtkSymbolicPaintable, i.get_value(self) )
  }

  multi method snapshot_symbolic (
    GdkSnapshot $snapshot,
    Num()       $width,
    Num()       $height,
                @colors,
  ) {
    samewith(
      $snapshot,
      $width,
      $height,
      GLib::Roles::TypedBuffer[GdkRGBA].new(@colors).p,
      @colors.elems
    );
  }
  multi method snapshot_symbolic (
    GdkSnapshot() $snapshot,
    Num()         $width,
    Num()         $height,
    Pointer       $colors,
    Int()         $n_colors
  ) {
    my gdouble ($w, $h) = ($width, $height);
    my gsize    $n      =  $n_colors;

    gtk_symbolic_paintable_snapshot_symbolic(
      $!gtk-sp,
      $snapshot,
      $w,
      $h,
      $colors,
      $n
    );
  }

}

our subset GtkSymbolicPaintableAncestry is export of Mu
  where GtkSymbolicPaintable | GObject;

use Method::Also;

class GTK::SymbolicPaintable:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::SymbolicPaintable;

  submethod BUILD ( :$gtk-sym-paintable ) {
    self.setGtkSymbolicPaintable($gtk-sym-paintable) if $gtk-sym-paintable
  }

  method setGtkSymbolicPaintable (GtkSymbolicPaintableAncestry $_) {
    my $to-parent;

    $!gtk-sp = do {
      when GtkSymbolicPaintable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSymbolicPaintable, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkSymbolicPaintable
    is also<GtkSymbolicPaintable>
  { $!gtk-sp }

  method new (
     $gtk-sym-paintable where * ~~ GtkSymbolicPaintableAncestry,

    :$ref = True
  ) {
    return unless $gtk-sym-paintable;

    my $o = self.bless( :$gtk-sym-paintable );
    $o.ref if $ref;
    $o;
  }

}

### /usr/src/gtk4/gtk/gtksymbolicpaintable.h

sub gtk_symbolic_paintable_snapshot_symbolic (
  GtkSymbolicPaintable $paintable,
  GdkSnapshot          $snapshot,
  gdouble              $width,
  gdouble              $height,
  GdkRGBA              $colors,
  gsize                $n_colors
)
  is      native(gtk4)
  is      export
{ * }

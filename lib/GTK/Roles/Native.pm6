use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Native:ver<4>;

use GDK::Surface;
use GSK::Renderer;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Native:ver<4> {
  has GtkNative is implementor $!gtk-n;

  method roleInit-GtkNative {
    return if $!gtk-n;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-n = cast( GtkNative, i.get_value(self) );
  }

  method new (GdkSurface() $surface) is static {
    self.get_for_surface($surface);
  }

  method get_for_surface is static {
    my $gtk-native = gtk_native_get_for_surface($!gtk-n);

    $gtk-native ?? self.bless( :$gtk-native ) !! Nil;
  }

  method get_renderer ( :$raw = False ) {
    propReturnObject(
      gtk_native_get_renderer($!gtk-n),
      $raw,
      |GSK::Renderer.getTypePair
    )
  }

  method get_surface ( :$raw = False ) {
    propReturnObject(
      gtk_native_get_surface($!gtk-n),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  proto method get_surface_transform (|)
  { * }

  multi method get_surface_transform {
    samewith($, $);
  }
  multi method get_surface_transform ($x is rw, $y is rw) {{
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gtk_native_get_surface_transform($!gtk-n, $x, $y);
    ($x, $y) = ($xx, $yy);
  }

  method realize {
    gtk_native_realize($!gtk-n);
  }

  method unrealize {
    gtk_native_unrealize($!gtk-n);
  }

}

our subset GtkNativeAncestry is export of Mu
  where GtkNative | GObject;

class GTK::Native {
  also does GLib::Raw::Objects;
  also does GTK::Roles::Native;

  submethod BUILD ( :$gtk-native ) {
    self.setGtkNative($gtk-native) if $gtk-native
  }

  method setGtkNative (GtkBuildableAncestry $_) {
    my $to-parent;

    $!gtk-b = do {
      when GtkBuildable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkBuildable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GtkNativeAncestry $gtk-native, :$ref = True) {
    return unless $gtk-native;

    my $o = self.bless( :$gtk-native );
    $o.ref if $ref;
    $o;
  }

}

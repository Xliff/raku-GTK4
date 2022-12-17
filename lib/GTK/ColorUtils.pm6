use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;

use GLib::Roles::StaticClass;

class GTK::ColorUtils {
  also does GLib::Roles::StaticClass;

  proto method hsv_to_rgb (|)
  { * }

  multi method hsv_to_rgb (Num() $h, Num() $s, Num() $v) {
    samewith($h, $s, $v, $, $, $);
  }
  multi method hsv_to_rgb (
    Num() $h,
    Num() $s,
    Num() $v,
          $r is rw,
          $g is rw,
          $b is rw
  ) {
    my gfloat ($hh, $ss, $vv) = ($h, $s, $v);
    my gfloat ($rr, $gg, $bb) = 0e0 xx 3;

    gtk_hsv_to_rgb($hh, $ss, $vv, $rr, $gg, $bb);
    ($r, $g, $b) = ($rr, $gg, $bb);
  }

  proto method rgb_to_hsv (|)
  { * }

  multi method hsv_to_rgb (Num() $r, Num() $g, Num() $b) {
    samewith($r, $g, $b, $, $, $);
  }
  multi method hsv_to_rgb (
    Num() $r,
    Num() $g,
    Num() $b,
          $h is rw,
          $s is rw,
          $v is rw
  ) {
    my gfloat ($rr, $gg, $bb) = ($r, $g, $b);
    my gfloat ($hh, $ss, $vv) = 0e0 xx 3;

    gtk_hsv_to_rgb($rr, $gg, $bb, $hh, $ss, $vv);
    ($h, $s, $v) = ($hh, $ss, $vv);
  }

}

use MONKEY-TYPING;

use GDK::RGBA;

augment class GDK::RGBA {
  method to_hsv is also<to-hsv> {
    GTK::ColorUtils.rgb_to_hsv(self.r, self.g, self.b);
  }

  method from_hsv (Num() $h, Num() $s, Num() $v) is also<from-hsv> {
    (self.r, self.g, self.b) = GTK::ColorUtils.hsv_to_rgv($h, $s, $v);
  }
}

### /usr/src/gtk4/gtk/gtkcolorutils.h

sub gtk_hsv_to_rgb (
  gfloat $h,
  gfloat $s,
  gfloat $v,
  gfloat $r  is rw,
  gfloat $g  is rw,
  gfloat $b  is rw
)
  is native(gtk4)
  is export
{ * }

sub gtk_rgb_to_hsv (
  gfloat $r,
  gfloat $g,
  gfloat $b,
  gfloat $h  is rw,
  gfloat $s  is rw,
  gfloat $v  is rw,
)
  is native(gtk4)
  is export
{ * }

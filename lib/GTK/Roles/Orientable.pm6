use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Orientable:ver<4> {
  has GtkOrientable $!gtk-o is implementor;

  method GTK::Raw::Definitions::GtkOrientable
  { $!gtk-o }
  method GtkOrientable
  { $!gtk-o }

  method roleInit-GtkOrientable {
    return if $!gtk-o;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-o = cast( GtkOrientable, i.get_value(self) )
  }

  # Type: GTKOrientation
  method orientation ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkOrientation) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('orientation', $gv);
        my $o = $gv.valueFromEnum(GtkOrientation);
        return $o unless $enum;
        GtkOrientationEnum($o);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkOrientation) = $val;
        self.prop_set('orientation', $gv);
      }
    );
  }

  method get_orientation {
    gtk_orientable_get_orientation($!gtk-o);
  }

  method gtkorientable_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_orientable_get_type, $n, $t );
  }

  method set_orientation (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    gtk_orientable_set_orientation($!gtk-o, $o);
  }

}


our subset GtkOrientableAncestry is export of Mu
  where GtkOrientable | GObject;

class GTK::Orientable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Orientable;

  submethod BUILD ( :$gtk-orientable ) {
    self.setGtkOrientable($gtk-orientable) if $gtk-orientable
  }

  method setGtkOrientable (GtkOrientableAncestry $_) {
    my $to-parent;

    $!gtk-o = do {
      when GtkOrientable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkOrientable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GtkOrientableAncestry $gtk-orientable, :$ref = True) {
    return unless $gtk-orientable;

    my $o = self.bless( :$gtk-orientable );
    $o.ref if $ref;
    $o;
  }

}

### /usr/src/gtk4-4.8.1+ds/gtk/gtkorientable.h

sub gtk_orientable_get_orientation (GtkOrientable $orientable)
  returns GtkOrientation
  is      native(gtk4)
  is      export
{ * }

sub gtk_orientable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_orientable_set_orientation (
  GtkOrientable  $orientable,
  GtkOrientation $orientation
)
  is      native(gtk4)
  is      export
{ * }

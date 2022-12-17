use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Accessible:ver<4>;

role GTK::Roles::Accessible::Range:ver<4> {
  has GtkAccessibleRange $!gtk-ar is implementor;

  method roleInit-GtkAccessibleRange {
    return if $!gtk-ar;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-ar = cast( GtkAccessibleRange, i.get_value(self) );
  }

  method set_current_value (Num() $value) is also<set-current-value> {
    my gdouble $v = $value;

    gtk_accessible_range_set_current_value($v);
  }

  method gtkaccessiblerange_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_accessible_range_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gtk/gtkaccessiblerange.h

sub gtk_accessible_range_set_current_value (gdouble $v)
  is native(gtk4)
  is export
{ * }

sub gtk_accessible_range_get_type ()
  returns GType
  is      native(gtk4)
  is      export
{ * }


our subset GtkAccessibleRangeAncestry is export of Mu
  where GtkAccessibleRange | GObject;

class GTK::Accessible::Range:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Accessible;
  also does GTK::Roles::Accessible::Range;

  submethod BUILD ( :$gtk-accessible-range ) {
    self.setGtkAccessible($gtk-accessible-range) if $gtk-accessible-range
  }

  method setGtkAccessible (GtkAccessibleRangeAncestry $_) {
    my $to-parent;

    $!gtk-a = do {
      when GtkAccessibleRange {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkAccessible {
        $!gtk-a    = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkAccessibleRange, $_);
      }

      when GtkAccessibleRange {
        $!gtk-ar   = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkAccessibleRange, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkAccessibleRange, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkAccessible;
    self.roleInit-GtkAccessibleRange;
  }

  method GTK::Raw::Definitions::GtkAccessibleRange
    is also<GtkAccessibleRange>
  { $!gtk-a }

  multi method new (
    GtkAccessibleAncestry $gtk-accessible-range,

    :$ref = True
  ) {
    return unless $gtk-accessible-range;

    my $o = self.bless( :$gtk-accessible-range );
    $o.ref if $ref;
    $o;
  }

}

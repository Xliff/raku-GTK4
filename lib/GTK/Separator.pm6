use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;

our subset GtkSeparatorAncestry is export of Mu
  where GtkSeparator | GtkWidgetAncestry;

class GTK::Separator:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;

  has GtkSeparator $!gtk-s is implementor;

  submethod BUILD ( :$gtk-separator ) {
    self.setGtkSeparator($gtk-separator) if $gtk-separator
  }

  method setGtkSeparator (GtkSeparatorAncestry $_) {
    my $to-parent;

    $!gtk-s = do {
      when GtkSeparator {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkOrientable {
        $!gtk-o    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkSeparator, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSeparator, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkSeparator
    is also<GtkSeparator>
  { $!gtk-s }

  multi method new (GtkSeparatorAncestry $gtk-separator, :$ref = True) {
    return unless $gtk-separator;

    my $o = self.bless( :$gtk-separator );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    my $gtk-separator = gtk_separator_new($o);

    $gtk-separator ?? self.bless( :$gtk-separator ) !! Nil;
  }
  multi method new (:horizontal(:$h) = True, :vertical(:$v) = $h.not ) {
    samewith(
      $v ?? GTK_ORIENTATION_VERTICAL !! GTK_ORIENTATION_HORIZONTAL
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_separator_get_type, $n, $t );
  }

}



### /usr/src/gtk4-4.8.1+ds/gtk/gtkseparator.h

sub gtk_separator_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_separator_new (GtkOrientation $orientation)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

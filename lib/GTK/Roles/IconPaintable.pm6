use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::IconTheme:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

role GTK::Roles::IconPaintable:ver<4> {
  has GtkIconPaintable $!gtk-ip is implementor;

  method roleInit-GtkIconPaintable {
    return unless $!gtk-ip;

    my \i    = findProperImplementor(self.^attributes);
    $!gtk-ip = cast( GtkIconPaintable, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkIconPaintable
  { $!gtk-ip }
  method GtkIconPaintable
  { $!gtk-ip }

  method new_for_file (GFile() $file, Int() $size, Int() $scale) {
    my gint ($si, $sc) = ($size, $scale);

    my $gtk-icon-paintable = gtk_icon_paintable_new_for_file($file, $si, $sc);

    $gtk-icon-paintable ?? self.bless( :$gtk-icon-paintable ) !! Nil;
  }

  method get_file ( :$raw = False ) {
    propReturnObject(
      gtk_icon_paintable_get_file($!gtk-ip),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_icon_name {
    gtk_icon_paintable_get_icon_name($!gtk-ip);
  }

  method gtkiconpaintable_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_icon_paintable_get_type, $n, $t );
  }

  method is_symbolic {
    so gtk_icon_paintable_is_symbolic($!gtk-ip);
  }

}

our subset GtkIconPaintableAncestry is export of Mu
  where GtkIconPaintable | GObject;

class GTK::IconPaintable:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::IconPaintable;

  submethod BUILD ( :$gtk-icon-paintable ) {
    self.setGtkIconPaintable($gtk-icon-paintable) if $gtk-icon-paintable
  }

  method setGtkIconPaintable (GtkIconPaintableAncestry $_) {
    my $to-parent;

    $!gtk-ip = do {
      when GtkIconPaintable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkIconPaintable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
     $gtk-icon-paintable where * ~~ GtkIconPaintableAncestry,

    :$ref = True
  ) {
    return unless $gtk-icon-paintable;

    my $o = self.bless( :$gtk-icon-paintable );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gtkiconpaintable_get_type
  }

}

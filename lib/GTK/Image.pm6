use v6.c;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Definitions;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Image:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;
use GIO::Roles::Icon;
use GDK::Roles::Paintable:ver<4>;

class GTK::Image:ver<4> is GTK::Widget:ver<4> {
  has GtkImage $!gtk-i is implementor;

  method new {
    my $gtk-image = gtk_image_new();

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_file (Str() $filename) {
    my $gtk-image = gtk_image_new_from_file($!gtk-i, $filename);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_gicon (GIcon() $icon) {
    my $gtk-image = gtk_image_new_from_gicon($!gtk-i, $icon);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_icon_name (Str() $icon_name) {
    my $gtk-image = gtk_image_new_from_icon_name($!gtk-i, $icon_name);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_paintable (GdkPaintable() $paintable) {
    my $gtk-image = gtk_image_new_from_paintable($!gtk-i, $paintable);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_pixbuf (GdkPixbuf() $pixbuf) {
    my $gtk-image = gtk_image_new_from_pixbuf($!gtk-i, $pixbuf);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_resource (Str() $resource_path) {
    my $gtk-image = gtk_image_new_from_resource($!gtk-i, $resource_path);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  # Type: GTKPaintable
  method paintable ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Paintable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('paintable', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Paintable.getTypePair
        );
      },
      STORE => -> $, GdkPaintable() $val is copy {
        $gv.object = $val;
        self.prop_set('paintable', $gv);
      }
    );
  }

  # Type: string
  method file is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: GTKIconSize
  method icon-size ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkIconSize) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-size', $gv);
        my $i = $gv.valueFromEnum(GtkIconSize);
        return $i unless $enum;
        GtkIconSizeEnum($i)
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkIconSize) = $val;
        self.prop_set('icon-size', $gv);
      }
    );
  }

  # Type: int
  method pixel-size is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixel-size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixel-size', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: GIcon
  method gicon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gicon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
        );
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('gicon', $gv);
      }
    );
  }

  # Type: string
  method resource is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resource', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('resource', $gv);
      }
    );
  }

  # Type: GtkImageType
  method storage-type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkImageType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('storage-type', $gv);
        my $t = $gv.valueFromEnum(GtkImageType);
        return $t unless $enum;
        GtkImageTypeEnum($t);
      },
      STORE => -> $,  $val is copy {
        warn 'storage-type does not allow writing'
      }
    );
  }

  # Type: boolean
  method use-fallback is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-fallback', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-fallback', $gv);
      }
    );
  }

  method clear {
    gtk_image_clear($!gtk-i);
  }

  method get_gicon ( :$raw = False ) {
    propReturnObject(
      gtk_image_get_gicon($!gtk-i),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name {
    gtk_image_get_icon_name($!gtk-i);
  }

  method get_icon_size {
    gtk_image_get_icon_size($!gtk-i);
  }

  method get_paintable ( :$raw = False ) {
    propReturnObject(
      gtk_image_get_paintable($!gtk-i),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method get_pixel_size {
    gtk_image_get_pixel_size($!gtk-i);
  }

  method get_storage_type (:$enum = True) {
    my $t = gtk_image_get_storage_type($!gtk-i);
    return $t unless $enum;
    GtkImageTypeEnum($t);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_image_get_type, $n, $t );
  }

  method set_from_file (Str() $filename) {
    gtk_image_set_from_file($!gtk-i, $filename);
  }

  method set_from_gicon (GIcon() $icon) {
    gtk_image_set_from_gicon($!gtk-i, $icon);
  }

  method set_from_icon_name (Str() $icon_name) {
    gtk_image_set_from_icon_name($!gtk-i, $icon_name);
  }

  method set_from_paintable (GdkPaintable() $paintable) {
    gtk_image_set_from_paintable($!gtk-i, $paintable);
  }

  method set_from_pixbuf (GdkPixbuf() $pixbuf) {
    gtk_image_set_from_pixbuf($!gtk-i, $pixbuf);
  }

  method set_from_resource (Str() $resource_path) {
    gtk_image_set_from_resource($!gtk-i, $resource_path);
  }

  method set_icon_size (Int() $icon_size) {
    my GtkIconSize $i = $icon_size;

    gtk_image_set_icon_size($!gtk-i, $i);
  }

  method set_pixel_size (Int() $pixel_size) {
    my gint $p = $pixel_size;

    gtk_image_set_pixel_size($!gtk-i, $p);
  }

}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Definitions;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Image:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;
use GIO::Roles::Icon;
use GDK::Roles::Paintable:ver<4>;

our subset GtkImageAncestry is export of Mu
  where GtkImage | GdkPaintable | GtkWidgetAncestry;

class GTK::Image:ver<4> is GTK::Widget:ver<4> {
  also does GDK::Roles::Paintable;

  has GtkImage $!gtk-i is implementor;

  submethod BUILD ( :$gtk-image ) {
    self.setGtkImage($gtk-image) if $gtk-image
  }

  method setGtkImage (GtkImageAncestry $_) {
    my $to-parent;

    $!gtk-i = do {
      when GtkImage {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GdkPaintable {
        $!gdk-p = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkImage, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkImage, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GdkPaintable;
  }

  method GTK::Raw::Definitions::GtkImage
    is also<GtkImage>
  { $!gtk-i }

  multi method new (GtkImageAncestry $gtk-image, :$ref = True) {
    return unless $gtk-image;

    my $o = self.bless( :$gtk-image );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-image = gtk_image_new();

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_file (Str() $filename) is also<new-from-file> {
    my $gtk-image = gtk_image_new_from_file($filename);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_gicon (GIcon() $icon) is also<new-from-gicon> {
    my $gtk-image = gtk_image_new_from_gicon($icon);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_icon_name (Str() $icon_name) is also<new-from-icon-name> {
    my $gtk-image = gtk_image_new_from_icon_name($icon_name);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_paintable (GdkPaintable() $paintable)
    is also<new-from-paintable>
  {
    my $gtk-image = gtk_image_new_from_paintable($paintable);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_pixbuf (GdkPixbuf() $pixbuf) is also<new-from-pixbuf> {
    my $gtk-image = gtk_image_new_from_pixbuf($pixbuf);

    $gtk-image ?? self.bless( :$gtk-image ) !! Nil;
  }

  method new_from_resource (Str() $resource_path) is also<new-from-resource> {
    my $gtk-image = gtk_image_new_from_resource($resource_path);

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
  method icon-size ( :$enum = True ) is rw  is g-property is also<icon_size> {
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
  method pixel-size is rw  is g-property is also<pixel_size> {
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
  method icon-name is rw  is g-property is also<icon_name> {
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
  method storage-type ( :$enum = True )
    is rw
    is g-property
    is also<storage_type>
  {
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
  method use-fallback is rw  is g-property is also<use_fallback> {
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

  method get_gicon ( :$raw = False ) is also<get-gicon> {
    propReturnObject(
      gtk_image_get_gicon($!gtk-i),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name is also<get-icon-name> {
    gtk_image_get_icon_name($!gtk-i);
  }

  method get_icon_size is also<get-icon-size> {
    gtk_image_get_icon_size($!gtk-i);
  }

  method get_paintable ( :$raw = False ) is also<get-paintable> {
    propReturnObject(
      gtk_image_get_paintable($!gtk-i),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method get_pixel_size is also<get-pixel-size> {
    gtk_image_get_pixel_size($!gtk-i);
  }

  method get_storage_type (:$enum = True) is also<get-storage-type> {
    my $t = gtk_image_get_storage_type($!gtk-i);
    return $t unless $enum;
    GtkImageTypeEnum($t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_image_get_type, $n, $t );
  }

  method set_from_file (Str() $filename) is also<set-from-file> {
    gtk_image_set_from_file($!gtk-i, $filename);
  }

  method set_from_gicon (GIcon() $icon) is also<set-from-gicon> {
    gtk_image_set_from_gicon($!gtk-i, $icon);
  }

  method set_from_icon_name (Str() $icon_name) is also<set-from-icon-name> {
    gtk_image_set_from_icon_name($!gtk-i, $icon_name);
  }

  method set_from_paintable (GdkPaintable() $paintable)
    is also<set-from-paintable>
  {
    gtk_image_set_from_paintable($!gtk-i, $paintable);
  }

  method set_from_pixbuf (GdkPixbuf() $pixbuf) is also<set-from-pixbuf> {
    gtk_image_set_from_pixbuf($!gtk-i, $pixbuf);
  }

  method set_from_resource (Str() $resource_path) is also<set-from-resource> {
    gtk_image_set_from_resource($!gtk-i, $resource_path);
  }

  method set_icon_size (Int() $icon_size) is also<set-icon-size> {
    my GtkIconSize $i = $icon_size;

    gtk_image_set_icon_size($!gtk-i, $i);
  }

  method set_pixel_size (Int() $pixel_size) is also<set-pixel-size> {
    my gint $p = $pixel_size;

    gtk_image_set_pixel_size($!gtk-i, $p);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Image;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Image;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

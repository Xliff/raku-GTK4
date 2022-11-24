use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Definitions;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Picture:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkPictureAncestry is export of Mu
  where GtkPicture | GtkWidgetAncestry;

class GTK::Picture:ver<4> is GTK::Widget:ver<4> {
  has GtkPicture $!gtk-pic is implementor;

  submethod BUILD ( :$gtk-picture ) {
    self.setGtkPicture($gtk-picture) if $gtk-picture
  }

  method setGtkPicture (GtkPictureAncestry $_) {
    my $to-parent;

    $!gtk-pic = do {
      when GtkPicture {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPicture, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkPicture
    is also<GtkPicture>
  { $!gtk-pic }

  multi method new (GtkPictureAncestry $gtk-picture, :$ref = True) {
    return unless $gtk-picture;

    my $o = self.bless( :$gtk-picture );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-picture = gtk_picture_new();

    $gtk-picture ?? self.bless( :$gtk-picture ) !! Nil;
  }

  method new_for_file (GFile() $file) is also<new-for-file> {
    my $gtk-picture = gtk_picture_new_for_file($!gtk-pic, $file);

    $gtk-picture ?? self.bless( :$gtk-picture ) !! Nil;
  }

  method new_for_filename (Str() $filename) is also<new-for-filename> {
    my $gtk-picture = gtk_picture_new_for_filename($!gtk-pic, $filename);

    $gtk-picture ?? self.bless( :$gtk-picture ) !! Nil;
  }

  method new_for_paintable (GdkPaintable() $paintable)
    is also<new-for-paintable>
  {
    my $gtk-picture = gtk_picture_new_for_paintable($!gtk-pic, $paintable);

    $gtk-picture ?? self.bless( :$gtk-picture ) !! Nil;
  }

  method new_for_pixbuf (GdkPixbuf() $pixbuf) is also<new-for-pixbuf> {
    my $gtk-picture = gtk_picture_new_for_pixbuf($!gtk-pic, $pixbuf);

    $gtk-picture ?? self.bless( :$gtk-picture ) !! Nil;
  }

  method new_for_resource (Str() $resource_path) is also<new-for-resource> {
    my $gtk-picture = gtk_picture_new_for_resource($!gtk-pic, $resource_path);

    $gtk-picture ?? self.bless( :$gtk-picture ) !! Nil;
  }

  # Type: GdkPaintable
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

  # Type: GFile
  method file ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::File.getTypePair
        );
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: string
  method alternative-text is rw  is g-property is also<alternative_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('alternative-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('alternative-text', $gv);
      }
    );
  }

  # Type: boolean
  method keep-aspect-ratio is rw  is g-property is also<keep_aspect_ratio> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('keep-aspect-ratio', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('keep-aspect-ratio', $gv);
      }
    );
  }

  # Type: boolean
  method can-shrink is rw  is g-property is also<can_shrink> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('can-shrink', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('can-shrink', $gv);
      }
    );
  }

  # Type: GTKContentFit
  method content-fit ( :$enum = False )
    is rw
    is g-property
    is also<content_fit>
  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkContentFit) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-fit', $gv);
        my $f = $gv.valueFromEnum(GtkContentFit);
        return $f unless $enum;
        GtkContentFitEnum($f);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkContentFit) = $val;
        self.prop_set('content-fit', $gv);
      }
    );
  }

  method get_alternative_text is also<get-alternative-text> {
    gtk_picture_get_alternative_text($!gtk-pic);
  }

  method get_can_shrink is also<get-can-shrink> {
    so gtk_picture_get_can_shrink($!gtk-pic);
  }

  method get_content_fit ( :$enum = True ) is also<get-content-fit> {
    my $f = gtk_picture_get_content_fit($!gtk-pic);
    return $f unless $enum;
    GtkContentFitEnum($f);
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      gtk_picture_get_file($!gtk-pic),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_keep_aspect_ratio is also<get-keep-aspect-ratio> {
    so gtk_picture_get_keep_aspect_ratio($!gtk-pic);
  }

  method get_paintable ( :$raw = False ) is also<get-paintable> {
    propReturnObject(
      gtk_picture_get_paintable($!gtk-pic),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method set_alternative_text (Str() $alternative_text)
    is also<set-alternative-text>
  {
    gtk_picture_set_alternative_text($!gtk-pic, $alternative_text);
  }

  method set_can_shrink (Int() $can_shrink) is also<set-can-shrink> {
    my gboolean $c = $can_shrink.so.Int;

    gtk_picture_set_can_shrink($!gtk-pic, $c);
  }

  method set_content_fit (Int() $content_fit) is also<set-content-fit> {
    my GtkContentFit $c = $content_fit;

    gtk_picture_set_content_fit($!gtk-pic, $c);
  }

  method set_file (GFile() $file) is also<set-file> {
    gtk_picture_set_file($!gtk-pic, $file);
  }

  method set_filename (Str() $filename) is also<set-filename> {
    gtk_picture_set_filename($!gtk-pic, $filename);
  }

  method set_keep_aspect_ratio (Int() $keep_aspect_ratio)
    is also<set-keep-aspect-ratio>
  {
    my gboolean  $k = $keep_aspect_ratio.so.Int;

    gtk_picture_set_keep_aspect_ratio($!gtk-pic, $k);
  }

  method set_paintable (GdkPaintable() $paintable) is also<set-paintable> {
    gtk_picture_set_paintable($!gtk-pic, $paintable);
  }

  method set_pixbuf (GdkPixbuf() $pixbuf) is also<set-pixbuf> {
    gtk_picture_set_pixbuf($!gtk-pic, $pixbuf);
  }

  method set_resource (Str() $resource_path) is also<set-resource> {
    gtk_picture_set_resource($!gtk-pic, $resource_path);
  }

}

INIT {
  my \O = GTK::Picture;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

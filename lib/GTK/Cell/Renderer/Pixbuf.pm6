use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Renderer::Toggle:ver<4>;

use GTK::Cell::Renderer:ver<4>;

our subset GtkCellRendererPixbufAncestry is export of Mu
  where GtkCellRendererPixbuf | GtkCellRendererAncestry;

class GTK::Cell::Renderer::Pixbuf:ver<4> is GTK::Cell::Renderer {
  has GtkCellRendererPixbuf $!gtk-crp is implementor;

  submethod BUILD ( :$gtk-renderer-pixbuf ) {
    self.setGtkCellRendererPixbuf($gtk-renderer-pixbuf)
      if $gtk-renderer-pixbuf
  }

  method setGtkCellRendererPixbuf (GtkCellRendererPixbufAncestry $_) {
    my $to-parent;

    $!gtk-crp = do {
      when GtkCellRendererPixbuf {
        $to-parent = cast(GtkCellRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellRendererPixbuf, $_);
      }
    }
    self.setGtkCellRenderer($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellRendererPixbuf
    is also<GtkCellRendererPixbuf>
  { $!gtk-crp }

  multi method new (
    $gtk-renderer-pixbuf where * ~~ GtkCellRendererPixbufAncestry,

    :$ref = True
  ) {
    return unless $gtk-renderer-pixbuf;

    my $o = self.bless( :$gtk-renderer-pixbuf );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-renderer-pixbuf = gtk_cell_renderer_pixbuf_new();

    $gtk-renderer-pixbuf ?? self.bless( :$gtk-renderer-pixbuf ) !! Nil;
  }

  # Type: GtkIcon
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

  # Type: GtkIconSize
  method icon-size ( :$enum = True )
    is rw
    is g-property
    is also<icon_size>
  {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkIconSize) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-size', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GtkIconSizeEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkIconSize) = $val;
        self.prop_set('icon-size', $gv);
      }
    );
  }

  # Type: GtkPixbuf
  method pixbuf ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Pixbuf.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'pixbuf does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf', $gv);
      }
    );
  }

  # Type: GtkPixbuf
  method pixbuf-expander-closed ( :$raw = False )
    is rw
    is g-property
    is also<pixbuf_expander_closed>
  {
    my $gv = GLib::Value.new( GDK::Pixbuf.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixbuf-expander-closed', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Pixbuf.getTypePair
        )
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf-expander-closed', $gv);
      }
    );
  }

  # Type: GtkPixbuf
  method pixbuf-expander-open ( :$raw = False )
    is rw
    is g-property
    is also<pixbuf_expander_open>
  {
    my $gv = GLib::Value.new( GDK::Pixbuf.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixbuf-expander-open', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Pixbuf.getTypePair
        )
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf-expander-open', $gv);
      }
    );
  }

  # Type: GtkTexture
  method texture ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Texture.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('texture', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Texture.getTypePair
        );
      },
      STORE => -> $, GdkTexture() $val is copy {
        $gv.object = $val;
        self.prop_set('texture', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_cell_renderer_pixbuf_get_type,
      $n,
      $t
    );
  }

}

### /usr/src/gtk4/gtk/deprecated/gtkcellrendererpixbuf.h

sub gtk_cell_renderer_pixbuf_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_pixbuf_new
  returns GtkCellRenderer
  is      native(gtk4)
  is      export
{ * }

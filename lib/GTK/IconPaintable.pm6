use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::IconTheme:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;
use GIO::Roles::GFile;
use GDK::Roles::Paintable:ver<4>;
use GTK::Roles::SymbolicPaintable:ver<4>;

our subset GtkIconPaintableAncestry is export of Mu
  where GtkIconPaintable | GtkSymbolicPaintable | GdkPaintable | GObject;

class GTK::IconPaintable:ver<4> {
  also does GLib::Roles::Object;
  also does GDK::Roles::Paintable;
  also does GTK::Roles::SymbolicPaintable;

  has GtkIconPaintable $!gtk-ip is implementor;

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

      when GtkSymbolicPaintable {
        $to-parent = cast(GObject, $_);
        $!gtk-sp   = $_;
        cast(GtkIconPaintable, $_);
      }

      when GdkPaintable {
        $to-parent = cast(GObject, $_);
        $!gdk-p    = $_;
        cast(GtkIconPaintable, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkIconPaintable, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GdkPaintable;
    self.roleInit-GtkSymbolicPaintable;
  }

  method GTK::Raw::Definitions::GtkIconPaintable
    is also<GtkIconPaintable>
  { $!gtk-ip }

  method new (
     $gtk-icon-paintable where * ~~ GtkIconPaintableAncestry,

    :$ref = True
  ) {
    return unless $gtk-icon-paintable;

    my $o = self.bless( :$gtk-icon-paintable );
    $o.ref if $ref;
    $o;
  }

  method new_for_file (
    GFile() $file,
    Int()   $size,
    Int()   $scale
  )
    is also<new-for-file>
  {
    my gint ($si, $sc) = ($size, $scale);

    my $gtk-icon-paintable = gtk_icon_paintable_new_for_file($file, $si, $sc);

    $gtk-icon-paintable ?? self.bless( :$gtk-icon-paintable ) !! Nil;
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

  proto method is-symbolic (|)
    is also<is_symbolic>
  { * }


  # Type: boolean
  multi method is-symbolic
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-symbolic', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-symbolic', $gv);
      }
    );
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      gtk_icon_paintable_get_file($!gtk-ip),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_icon_name is also<get-icon-name> {
    gtk_icon_paintable_get_icon_name($!gtk-ip);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_icon_paintable_get_type, $n, $t );
  }

  multi method is-symbolic ( :m(:meth(:$method)) is required )
    is also<
      get_is_symbolic
      get-is-symbolic
    >
  {
    so gtk_icon_paintable_is_symbolic($!gtk-ip);
  }

}

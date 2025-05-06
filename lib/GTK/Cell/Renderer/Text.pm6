use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Cell::Renderer:ver<4>;

use GLib::Roles::Implementor;

our subset GtkCellRendererTextAncestry is export of Mu
  where GtkCellRendererText | GtkCellRendererAncestry;

class GTK::Cell::Renderer::Text:ver<4> is GTK::Cell::Renderer {
  has GtkCellRendererText $!gtk-crt is implementor;

  submethod BUILD ( :$gtk-renderer-text ) {
    self.setGtkCellRendererText($gtk-renderer-text) if $gtk-renderer-text
  }

  method setGtkCellRendererText (GtkCellRendererTextAncestry $_) {
    my $to-parent;

    $!gtk-crt = do {
      when GtkCellRendererText {
        $to-parent = cast(GtkCellRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellRendererText, $_);
      }
    }
    self.setGtkCellRenderer($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellRendererText
    is also<GtkCellRendererText>
  { $!gtk-crt }

  multi method new (
    $gtk-renderer-text where * ~~ GtkCellRendererTextAncestry,

    :$ref = True
  ) {
    return unless $gtk-renderer-text;

    my $o = self.bless( :$gtk-renderer-text );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-renderer-text = gtk_cell_renderer_text_new();

    $gtk-renderer-text ?? self.bless( :$gtk-renderer-text ) !! Nil;
  }

  # Type: PangoAlignment
  method alignment ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(PangoAlignment) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('alignment', $gv);
        my $a = $gv.enum;
        return $a unless $enum;
        PangoAlignmentEnum($a);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoAlignment) = $val;
        self.prop_set('alignment', $gv);
      }
    );
  }

  # Type: GtkAttrList
  method attributes ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::AttrList.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('attributes', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |Pango::AttrList.getTypePair
        );
      },
      STORE => -> $, PangoAttrList() $val is copy {
        $gv.pointer = $val;
        self.prop_set('attributes', $gv);
      }
    );
  }

  # Type: string
  method background is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'background does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('background', $gv);
      }
    );
  }

  # Type: GdkRgba
  method background-rgba ( :$raw = False )
    is rw
    is g-property
    is also<background_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background-rgba', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::RGBA.getTypePair
        );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.pointer = $val;
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: boolean
  method editable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('editable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method ellipsize ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(PangoEllipsizeMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ellipsize', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        PangoEllipsizeModeEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoEllipsizeMode) = $val;
        self.prop_set('ellipsize', $gv);
      }
    );
  }

  # Type: string
  method family is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('family', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('family', $gv);
      }
    );
  }

  # Type: string
  method font is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('font', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font', $gv);
      }
    );
  }

  # Type: GtkFontDescription
  method font-desc ( :$raw = False ) is rw  is g-property is also<font_desc> {
    my $gv = GLib::Value.new( Pango::FontDescription.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('font-desc', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |Pango::FontDescription.getTypePair
        );
      },
      STORE => -> $, PangoFontDescription() $val is copy {
        $gv.object = $val;
        self.prop_set('font-desc', $gv);
      }
    );
  }

  # Type: string
  method foreground is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'foreground does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('foreground', $gv);
      }
    );
  }

  # Type: GtkRgba
  method foreground-rgba ( :$raw = False )
    is rw
    is g-property
    is also<foreground_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('foreground-rgba', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |GDK::RGBA.getTypePair
        );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.pointer = $val;
        self.prop_set('foreground-rgba', $gv);
      }
    );
  }

  # Type: string
  method language is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('language', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('language', $gv);
      }
    );
  }

  # Type: string
  method markup is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'markup does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('markup', $gv);
      }
    );
  }

  # Type: int
  method max-width-chars is rw  is g-property is also<max_width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-chars', $gv);
      }
    );
  }

  # Type: string
  method placeholder-text is rw  is g-property is also<placeholder_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('placeholder-text', $gv);
      }
    );
  }

  # Type: int
  method rise is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rise', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('rise', $gv);
      }
    );
  }

  # Type: double
  method scale is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('scale', $gv);
      }
    );
  }

  # Type: boolean
  method single-paragraph-mode
    is rw
    is g-property
    is also<single_paragraph_mode>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('single-paragraph-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('single-paragraph-mode', $gv);
      }
    );
  }

  # Type: int
  method size is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  # Type: double
  method size-points is rw  is g-property is also<size_points> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('size-points', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('size-points', $gv);
      }
    );
  }

  # Type: PangoStretch
  method stretch ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(PangoStretch) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('stretch', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        PangoStretchEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoStretch) = $val;
        self.prop_set('stretch', $gv);
      }
    );
  }

  # Type: boolean
  method strikethrough is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('strikethrough', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough', $gv);
      }
    );
  }

  # Type: PangoStyle
  method style ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(PangoStyle) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('style', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        PangoStyleEnum($s);
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(PangoStyle) = $val;
        self.prop_set('style', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: PangoUnderline
  method underline ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(PangoUnderline) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('underline', $gv);
        my $u = $gv.enum;
        return $u unless $enum;
        PangoUnderlineEnum($u);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoUnderline) = $val;
        self.prop_set('underline', $gv);
      }
    );
  }

  # Type: GtkVariant
  method variant ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Variant.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('variant', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |GLib::Variant.getTypePair
        );
      },
      STORE => -> $, GVariant() $val is copy {
        $gv.pointer = $val;
        self.prop_set('variant', $gv);
      }
    );
  }

  # Type: int
  method weight is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('weight', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('weight', $gv);
      }
    );
  }

  # Type: int
  method width-chars is rw  is g-property is also<width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width-chars', $gv);
      }
    );
  }

  # Type: PangoWrapMode
  method wrap-mode ( :$enum = True ) is rw  is g-property is also<wrap_mode> {
    my $gv = GLib::Value.new( GLib::Value.new-enum(PangoWrapMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        PangoWrapModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoWrapMode) = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  # Type: int
  method wrap-width is rw  is g-property is also<wrap_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('wrap-width', $gv);
      }
    );
  }

  method Edited {
    self.connect-strstr($!gtk-crt, 'edited');
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_text_get_type, $n, $t );
  }

  method set_fixed_height_from_font (Int() $number_of_rows)
    is also<set-fixed-height-from-font>
  {
    my gint $n = $number_of_rows;

    gtk_cell_renderer_text_set_fixed_height_from_font($!gtk-crt, $n);
  }

}

### /usr/src/gtk4/gtk/deprecated/gtkcellrenderertext.h

sub gtk_cell_renderer_text_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_text_new
  returns GtkCellRenderer
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_renderer_text_set_fixed_height_from_font (
  GtkCellRendererText $renderer,
  gint                $number_of_rows
)
  is      native(gtk4)
  is      export
{ * }

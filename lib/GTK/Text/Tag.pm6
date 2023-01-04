use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text::Tag:ver<4>;

use GLib::Variant;
use Pango::FontDescription;
use Pango::Tabs;
use GDK::RGBA:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTextTagAncestry is export of Mu
  where GtkTextTag | GObject;

class GTK::Text::Tag:ver<4> {
  also does GLib::Roles::Object;

  has GtkTextTag $!gtk-tt is implementor;

  submethod BUILD ( :$gtk-text-tag ) {
    self.setGtkTextTag($gtk-text-tag) if $gtk-text-tag
  }

  method setGtkTextTag (GtkTextTagAncestry $_) {
    my $to-parent;

    $!gtk-tt = do {
      when GtkTextTag {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTextTag, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Structs::GtkTextTag
    is also<GtkTextTag>
  { $!gtk-tt }

  multi method new (
     $gtk-text-tag where * ~~ GtkTextTagAncestry,

    :$ref = True
  ) {
    return unless $gtk-text-tag;

    my $o = self.bless( :$gtk-text-tag );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str $name) {
    my $gtk-text-tag = gtk_text_tag_new($name);

    $gtk-text-tag ?? self.bless( :$gtk-text-tag ) !! Nil;
  }

  # Type: boolean
  method accumulative-margin
    is rw
    is g-property
    is also<accumulative_margin>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accumulative-margin', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accumulative-margin', $gv);
      }
    );
  }

  # Type: boolean
  method allow-breaks is rw  is g-property is also<allow_breaks> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('allow-breaks', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('allow-breaks', $gv);
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

  # Type: boolean
  method background-full-height
    is rw
    is g-property
    is also<background_full_height>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background-full-height', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-full-height', $gv);
      }
    );
  }

  # Type: GtkRgba
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
          $gv.boxed,
          $raw,
          |GDK::RGBA.getTypePair
        )
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.boxed = $val;
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: GtkTextDirection
  method direction ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkTextDirection );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('direction', $gv);
        my $d = $gv.enum;
        return $d unless $enum;
        GtkTextDirectionEnum($d);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkTextDirection) = $val;
        self.prop_set('direction', $gv);
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

  # Type: boolean
  method fallback is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fallback', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fallback', $gv);
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

  # Type: PangoFontDescription
  method font-desc ( :$raw = False ) is rw  is g-property is also<font_desc> {
    my $gv = GLib::Value.new( Pango::FontDescription.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('font-desc', $gv);
        propReturnObject(
          $gv.object,
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
  method font-features is rw  is g-property is also<font_features> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('font-features', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font-features', $gv);
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

  # Type: GdkRgba
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
          $gv.boxed,
          $raw,
          |GDK::RGBA.getTypePair
        )
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.boxed = $val;
        self.prop_set('foreground-rgba', $gv);
      }
    );
  }

  # Type: int
  method indent is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indent', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('indent', $gv);
      }
    );
  }

  # Type: boolean
  method insert-hyphens is rw  is g-property is also<insert_hyphens> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('insert-hyphens', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('insert-hyphens', $gv);
      }
    );
  }

  # Type: boolean
  method invisible is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('invisible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invisible', $gv);
      }
    );
  }

  # Type: GtkJustification
  method justification ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkJustification );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('justification', $gv);
        my $j = $gv.enum;
        return $j unless $enum;
        GtkJustification($j);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkJustification) = $val;
        self.prop_set('justification', $gv);
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

  # Type: int
  method left-margin is rw  is g-property is also<left_margin> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('left-margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('left-margin', $gv);
      }
    );
  }

  # Type: int
  method letter-spacing is rw  is g-property is also<letter_spacing> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('letter-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('letter-spacing', $gv);
      }
    );
  }

  # Type: float
  method line-height is rw  is g-property is also<line_height> {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('line-height', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('line-height', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: PangoOverline
  method overline ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( PangoOverline );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overline', $gv);
        my $o = $gv.enum;
        PangoOverline($o);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoOverline) = $val;
        self.prop_set('overline', $gv);
      }
    );
  }

  # Type: GtkRgba
  method overline-rgba ( :$raw = False )
    is rw
    is g-property
    is also<overline_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overline-rgba', $gv);
        propReturnObject(
          $gv.boxed,
          $raw,
          |GDK::RGBA.getTypePair
        );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.boxed = $val;
        self.prop_set('overline-rgba', $gv);
      }
    );
  }

  # Type: string
  method paragraph-background
    is rw
    is g-property
    is also<paragraph_background>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'paragraph-background does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('paragraph-background', $gv);
      }
    );
  }

  # Type: GdkRgba
  method paragraph-background-rgba ( :$raw = False )
    is rw
    is g-property
    is also<paragraph_background_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('paragraph-background-rgba', $gv);
        propReturnObject(
          $gv.boxed,
          $raw,
          |GDK::RGBA.getTypePair
        )
      },

      STORE => -> $, GdkRGBA()  $val is copy {
        $gv.boxed = $val;
        self.prop_set('paragraph-background-rgba', $gv);
      }
    );
  }

  # Type: int
  method pixels-above-lines is rw  is g-property is also<pixels_above_lines> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixels-above-lines', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-above-lines', $gv);
      }
    );
  }

  # Type: int
  method pixels-below-lines is rw  is g-property is also<pixels_below_lines> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixels-below-lines', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-below-lines', $gv);
      }
    );
  }

  # Type: int
  method pixels-inside-wrap is rw  is g-property is also<pixels_inside_wrap> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixels-inside-wrap', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-inside-wrap', $gv);
      }
    );
  }

  # Type: int
  method right-margin is rw  is g-property is also<right_margin> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('right-margin', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('right-margin', $gv);
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
  method sentence is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sentence', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('sentence', $gv);
      }
    );
  }

  # Type: PangoShowSpaces
  method show-spaces ( :$enum = True )
    is rw
    is g-property
    is also<show_spaces>
  {
    my $gv = GLib::Value.new-enum( PangoShowFlags );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-spaces', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        PangoShowFlagsEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoShowFlags) = $val;
        self.prop_set('show-spaces', $gv);
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
    my $gv = GLib::Value.new-enum( PangoStretch );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('stretch', $gv);
        my $p = $gv.enum;
        PangoStretchEnum($p);
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

  # Type: GtkRgba
  method strikethrough-rgba ( :$raw = False )
    is rw
    is g-property
    is also<strikethrough_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('strikethrough-rgba', $gv);
        propReturnObject(
          $gv.boxed,
          $raw,
          |GDK::RGBA.getTypePair
        );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.boxed = $val;
        self.prop_set('strikethrough-rgba', $gv);
      }
    );
  }

  # Type: PangoStyle
  method style ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( PangoStyle );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('style', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        PangoStyleEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoStyle) = $val;
        self.prop_set('style', $gv);
      }
    );
  }

  # Type: PangoTabArray
  method tabs ( :$raw = False )  is rw  is g-property {
    my $gv = GLib::Value.new( Pango::Tabs.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tabs', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |Pango::Tabs.getTypePair
        )
      },
      STORE => -> $, PangoTabArray() $val is copy {
        $gv.pointer = $val;
        self.prop_set('tabs', $gv);
      }
    );
  }

  # Type: PangoTextTransform
  method text-transform ( :$enum = True )
    is rw
    is g-property
    is also<text_transform>
  {
    my $gv = GLib::Value.new( PangoTextTransform );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-transform', $gv);
        my $t = $gv.enum;
        return unless $enum;
        PangoTextTransformEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkTextTransform) = $val;
        self.prop_set('text-transform', $gv);
      }
    );
  }

  # Type: PangoUnderline
  method underline ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( PangoUnderline );
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

  # Type: GtkRgba
  method underline-rgba ( :$raw = False )
    is rw
    is g-property
    is also<underline_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('underline-rgba', $gv);
        propReturnObject(
          $gv.boxed,
          $raw,
          |GDK::RGBA.getTypePair
        );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.boxed = $val;
        self.prop_set('underline-rgba', $gv);
      }
    );
  }

  # Type: GVariant
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

  # Type: boolean
  method word is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('word', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('word', $gv);
      }
    );
  }

  # Type: GtkWrapMode
  method wrap-mode ( :$enum = True ) is rw  is g-property is also<wrap_mode> {
    my $gv = GLib::Value.new-enum( GtkWrapMode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-mode', $gv);
        my $w = $gv.enum;
        return $w unless $enum;
        GtkWrapModeEnum($w);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkWrapMode) = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  method changed (Int() $size_changed) {
    my gboolean $s = $size_changed.so.Int;

    gtk_text_tag_changed($!gtk-tt, $s);
  }

  method get_priority (GtkTextTag() $tag) is also<get-priority> {
    gtk_text_tag_get_priority($!gtk-tt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_tag_get_type, $n, $t );
  }

  method set_priority (Int() $priority) is also<set-priority> {
    my gint $p = $priority;

    gtk_text_tag_set_priority($!gtk-tt, $p);
  }
}

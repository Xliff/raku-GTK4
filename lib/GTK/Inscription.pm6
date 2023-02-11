use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Inscription:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkInscriptionAncestry is export of Mu
  where GtkInscription | GtkWidgetAncestry;

class GTK::Inscription:ver<4> is GTK::Widget:ver<4> {
  has GtkInscription $!gtk-i is implementor;

  submethod BUILD ( :$gtk-inscription ) {
    self.setGtkInscription($gtk-inscription) if $gtk-inscription
  }

  method setGtkInscription (GtkInscriptionAncestry $_) {
    my $to-parent;

    $!gtk-i = do {
      when GtkInscription {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkInscription, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkInscription
    is also<GtkInscription>
  { $!gtk-i }

  multi method new (
     $gtk-inscription where * ~~ GtkInscriptionAncestry,

    :$ref = True
  ) {
    return unless $gtk-inscription;

    my $o = self.bless( :$gtk-inscription );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $text = Str) {
    my $gtk-inscription = gtk_inscription_new($text);

    $gtk-inscription ?? self.bless( :$gtk-inscription ) !! Nil;
  }

  # Type: PangoAttrList
  method attributes ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::AttrList.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('attributes', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Pango::AttrList.getTypePair
        );
      },
      STORE => -> $, PangoAttrList() $val is copy {
        $gv.object = $val;
        self.prop_set('attributes', $gv);
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

  # Type: uint
  method min-chars is rw  is g-property is also<min_chars> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-chars', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('min-chars', $gv);
      }
    );
  }

  # Type: uint
  method min-lines is rw  is g-property is also<min_lines> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-lines', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('min-lines', $gv);
      }
    );
  }

  # Type: uint
  method nat-chars is rw  is g-property is also<nat_chars> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('nat-chars', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('nat-chars', $gv);
      }
    );
  }

  # Type: uint
  method nat-lines is rw  is g-property is also<nat_lines> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('nat-lines', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('nat-lines', $gv);
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

  # Type: GtkInscriptionOverflow
  method text-overflow ( :$enum = True )
    is rw
    is g-property
    is also<text_overflow>
  {
    my $gv = GLib::Value.new-enum( GtkInscriptionOverflow );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-overflow', $gv);
        my $o = $gv.enum;
        return $o unless $enum;
        GtkInscriptionOverflowEnum($o);
      },
      STORE => -> $, Int()  $val is copy {
        $gv.valueFromEnum(GtkInscriptionOverflow) = $val;
        self.prop_set('text-overflow', $gv);
      }
    );
  }

  # Type: GtkWrapMode
  method wrap-mode ( :$enum = True ) is rw  is g-property is also<wrap_mode> {
    my $gv = GLib::Value.new-enum( GtkWrapMode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkWrapModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkWrapMode) = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  # Type: float
  method xalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: float
  method yalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  method get_attributes is also<get-attributes> {
    gtk_inscription_get_attributes($!gtk-i);
  }

  method get_min_chars is also<get-min-chars> {
    gtk_inscription_get_min_chars($!gtk-i);
  }

  method get_min_lines is also<get-min-lines> {
    gtk_inscription_get_min_lines($!gtk-i);
  }

  method get_nat_chars is also<get-nat-chars> {
    gtk_inscription_get_nat_chars($!gtk-i);
  }

  method get_nat_lines is also<get-nat-lines> {
    gtk_inscription_get_nat_lines($!gtk-i);
  }

  method get_text is also<get-text> {
    gtk_inscription_get_text($!gtk-i);
  }

  method get_text_overflow is also<get-text-overflow> {
    gtk_inscription_get_text_overflow($!gtk-i);
  }

  method get_wrap_mode is also<get-wrap-mode> {
    gtk_inscription_get_wrap_mode($!gtk-i);
  }

  method get_xalign is also<get-xalign> {
    gtk_inscription_get_xalign($!gtk-i);
  }

  method get_yalign is also<get-yalign> {
    gtk_inscription_get_yalign($!gtk-i);
  }

  method set_attributes (PangoAttrList() $attrs) is also<set-attributes> {
    gtk_inscription_set_attributes($!gtk-i, $attrs);
  }

  method set_markup (Str() $markup) is also<set-markup> {
    gtk_inscription_set_markup($!gtk-i, $markup);
  }

  method set_min_chars (Int() $min_chars) is also<set-min-chars> {
    my guint $m = $min_chars;

    gtk_inscription_set_min_chars($!gtk-i, $m);
  }

  method set_min_lines (Int() $min_lines) is also<set-min-lines> {
    my guint $m = $min_lines;

    gtk_inscription_set_min_lines($!gtk-i, $m);
  }

  method set_nat_chars (Int() $nat_chars) is also<set-nat-chars> {
    my guint $n = $nat_chars;

    gtk_inscription_set_nat_chars($!gtk-i, $n);
  }

  method set_nat_lines (Int() $nat_lines) is also<set-nat-lines> {
    my guint $n = $nat_lines;

    gtk_inscription_set_nat_lines($!gtk-i, $n);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_inscription_set_text($!gtk-i, $text);
  }

  method set_text_overflow (Int() $overflow) is also<set-text-overflow> {
    my GtkInscriptionOverflow $o = $overflow;

    gtk_inscription_set_text_overflow($!gtk-i, $o);
  }

  method set_wrap_mode (Int() $wrap_mode) is also<set-wrap-mode> {
    my PangoWrapMode $w = $wrap_mode;

    gtk_inscription_set_wrap_mode($!gtk-i, $w);
  }

  method set_xalign (Num() $xalign) is also<set-xalign> {
    my gfloat $x = $xalign;

    gtk_inscription_set_xalign($!gtk-i, $x);
  }

  method set_yalign (Num() $yalign) is also<set-yalign> {
    my gfloat $y = $yalign;

    gtk_inscription_set_yalign($!gtk-i, $y);
  }

}

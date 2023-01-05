use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Text::Mark:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTextMarkAncestry is export of Mu
  where GtkTextMark | GObject;

class GTK::Text::Mark {
  also does GLib::Roles::Object;

  has GtkTextMark $!gtk-tm is implementor;

  submethod BUILD ( :$gtk-text-mark ) {
    self.setGtkTextMark($gtk-text-mark) if $gtk-text-mark
  }

  method setGtkTextMark (GtkTextMarkAncestry $_) {
    my $to-parent;

    $!gtk-tm = do {
      when GtkTextMark {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTextMark, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTextMark
    is also<GtkTextMark>
  { $!gtk-tm }

  multi method new (
     $gtk-text-mark where * ~~ GtkTextMarkAncestry,

    :$ref = True
  ) {
    return unless $gtk-text-mark;

    my $o = self.bless( :$gtk-text-mark );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, Int() $left_gravity = False) {
    my gboolean $l = $left_gravity.so.Int;

    my $gtk-text-mark = gtk_text_mark_new($name, $left_gravity);

    $gtk-text-mark ?? self.bless( :$gtk-text-mark ) !! Nil;
  }

  # Type: boolean
  method left-gravity is rw  is g-property is also<left_gravity> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('left-gravity', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('left-gravity', $gv);
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

  method visible is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_visible    },
      STORE => -> $, \v { self.set_visible(v) }
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_text_mark_get_buffer($!gtk-tm),
      $raw,
      |::('GTK::Text::Buffer').getTypePair
    );
  }

  method get_deleted is also<get-deleted> {
    so gtk_text_mark_get_deleted($!gtk-tm);
  }

  method get_left_gravity is also<get-left-gravity> {
    so gtk_text_mark_get_left_gravity($!gtk-tm);
  }

  method get_name is also<get-name> {
    gtk_text_mark_get_name($!gtk-tm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_mark_get_type, $t, $n );
  }

  method get_visible is also<get-visible> {
    so gtk_text_mark_get_visible($!gtk-tm);
  }

  method set_visible (Int() $setting) is also<set-visible> {
    my gboolean $s = $setting.so.Int;

    gtk_text_mark_set_visible($!gtk-tm, $setting);
  }

}

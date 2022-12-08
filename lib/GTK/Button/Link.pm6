use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Button::Link:ver<4>;

use GTK::Button:ver<4>;

use GLib::Roles::Implementor;

our subset GtkLinkButtonAncestry is export of Mu
  where GtkLinkButton | GtkButtonAncestry;

class GTK::Button::Link:ver<4> is GTK::Button:ver<4> {
  has GtkLinkButton $!gtk-lb is implementor;

  submethod BUILD ( :$gtk-link-button ) {
    self.setGtkLinkButton($gtk-link-button) if $gtk-link-button
  }

  method setGtkLinkButton (GtkLinkButtonAncestry $_) {
    my $to-parent;

    $!gtk-lb = do {
      when GtkLinkButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkLinkButton, $_);
      }
    }
    self.setGtkButton($to-parent);
  }

  method GTK::Raw::Definitions::GtkLinkButton
    is also<GtkLinkButton>
  { $!gtk-lb }

  multi method new (
    $gtk-link-button where * ~~ GtkLinkButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-link-button;

    my $o = self.bless( :$gtk-link-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $uri) {
    my $gtk-link-button = gtk_link_button_new($uri);

    $gtk-link-button ?? self.bless( :$gtk-link-button ) !! Nil;
  }

  method new_with_label (Str() $uri, Str() $label) is also<new-with-label> {
    my $gtk-link-button = gtk_link_button_new_with_label($uri, $label);

    $gtk-link-button ?? self.bless( :$gtk-link-button ) !! Nil;
  }

  # Type: string
  method uri is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('uri', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('uri', $gv);
      }
    );
  }

  # Type: boolean
  method visited is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visited', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visited', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_link_button_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    gtk_link_button_get_uri($!gtk-lb);
  }

  method get_visited is also<get-visited> {
    gtk_link_button_get_visited($!gtk-lb);
  }

  method set_uri (Str() $uri) is also<set-uri> {
    gtk_link_button_set_uri($!gtk-lb, $uri);
  }

  method set_visited (Int() $visited) is also<set-visited> {
    my gboolean $v = $visited.so.Int;

    gtk_link_button_set_visited($!gtk-lb, $v);
  }

}

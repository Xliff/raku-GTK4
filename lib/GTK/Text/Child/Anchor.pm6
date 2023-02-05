use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Text::Child::Anchor {
  also does GLib::Roles::Object;

  has GtkTextChildAnchor $!gtk-tc is implementor;

  method new {
    my $gtk-text-anchor = gtk_text_child_anchor_new();

    $gtk-text-anchor ?? self.bless( :$gtk-text-anchor ) !! Nil;
  }

  method new_with_replacement (Str() $character) {
    my $gtk-text-anchor = gtk_text_child_anchor_new_with_replacement(
      $character
    );

    $gtk-text-anchor ?? self.bless( :$gtk-text-anchor ) !! Nil;
  }

  method get_deleted {
    gtk_text_child_anchor_get_deleted($!gtk-tc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_child_anchor_get_type, $n, $t );
  }

  proto method get_widgets (|)
  { * }

  multi method get_widgets ( :$raw = False ) {
    samewith($);
  }
  multi method get_widgets ($out_len is rw, :$raw = False) {
    my gint $o  = 0;
    my      $wa = gtk_text_child_anchor_get_widgets($!gtk-tc, $o);

    $out_len = $o;
    CArrayToArray(
      $wa,
      -> $_ {
        propReturnObject( .deref, $raw, |GTK::Widget.getType )
      },
      size => $o;
    );
  }
}

### /usr/src/gtk4/gtk/gtktextchild.h

sub gtk_text_child_anchor_get_deleted (GtkTextChildAnchor $anchor)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_child_anchor_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_child_anchor_get_widgets (
  GtkTextChildAnchor $anchor,
  guint              $out_len is rw
)
  returns CArray[Pointer[GtkWidget]]
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_child_anchor_new
  returns GtkTextChildAnchor
  is      native(gtk4)
  is      export
{ * }

sub gtk_text_child_anchor_new_with_replacement (Str $character)
  returns GtkTextChildAnchor
  is      native(gtk4)
  is      export
{ * }

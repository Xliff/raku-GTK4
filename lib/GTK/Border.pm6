use v6.c;

use NativeCall;

use GTK::Raw::Types;

use GLib::Roles::Implementor;

class GTK::Border {
  also does GLib::Roles::Implementor;

  has GtkBorder $!gtk-b is implementor;

  submethod BUILD ( :gtk-border($!gtk-b) )
  { }

  method new {
    my $gtk-border = gtk_border_new();

    $gtk-border ?? self.bless( :$gtk-border ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_border_copy($!gtk-b),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    gtk_border_free($!gtk-b);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_border_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gtk/gtkborder.h

sub gtk_border_copy (GtkBorder $border_)
  returns GtkBorder
  is      native(gtk4)
  is      export
{ * }

sub gtk_border_free (GtkBorder $border_)
  is      native(gtk4)
  is      export
{ * }

sub gtk_border_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_border_new
  returns GtkBorder
  is      native(gtk4)
  is      export
{ * }

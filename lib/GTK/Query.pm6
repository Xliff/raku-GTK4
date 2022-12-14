use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Query:ver<4> {
  has GtkQuery $!gtk-q is implementor;

  method new {
    my $gtk-query = gtk_query_new();

    $gtk-query ?? self.bless( :$gtk-query ) !! Nil;
  }

  method get_location {
    gtk_query_get_location($!gtk-q);
  }

  method get_text {
    gtk_query_get_text($!gtk-q);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_query_get_type, $n, $t );
  }

  method matches_string (Str() $string) {
    gtk_query_matches_string($!gtk-q, $string);
  }

  method set_location (GFile() $file) {
    gtk_query_set_location($!gtk-q, $file);
  }

  method set_text (Str() $text) {
    gtk_query_set_text($!gtk-q, $text);
  }

}

### /usr/src/gtk4/gtk/gtkquery.h

sub gtk_query_get_location (GtkQuery $query)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_query_get_text (GtkQuery $query)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_query_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_query_matches_string (
  GtkQuery $query,
  Str      $string
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_query_new
  returns GtkQuery
  is      native(gtk4)
  is      export
{ * }

sub gtk_query_set_location (
  GtkQuery $query,
  GFile    $file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_query_set_text (
  GtkQuery $query,
  Str      $text
)
  is      native(gtk4)
  is      export
{ * }

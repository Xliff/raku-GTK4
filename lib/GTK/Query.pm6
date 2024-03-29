use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkQueryAncestry is export of Mu
  where GtkQuery | GObject;

class GTK::Query:ver<4> {
  also does GLib::Roles::Object;

  has GtkQuery $!gtk-q is implementor;

  submethod BUILD ( :$gtk-query ) {
    self.setGtkQuery($gtk-query) if $gtk-query
  }

  method setGtkQuery (GtkQueryAncestry $_) {
    my $to-parent;

    $!gtk-q = do {
      when GtkQuery {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkQuery, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkQuery
    is also<GtkQuery>
  { $!gtk-q }

  multi method new ($gtk-query where * ~~ GtkQueryAncestry, :$ref = True) {
    return unless $gtk-query;

    my $o = self.bless( :$gtk-query );
    $o.ref if $ref;
    $o;
  }

  method new {
    my $gtk-query = gtk_query_new();

    $gtk-query ?? self.bless( :$gtk-query ) !! Nil;
  }

  method get_location is also<get-location> {
    gtk_query_get_location($!gtk-q);
  }

  method get_text is also<get-text> {
    gtk_query_get_text($!gtk-q);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_query_get_type, $n, $t );
  }

  method matches_string (Str() $string) is also<matches-string> {
    so gtk_query_matches_string($!gtk-q, $string);
  }

  method set_location (GFile() $file) is also<set-location> {
    gtk_query_set_location($!gtk-q, $file);
  }

  method set_text (Str() $text) is also<set-text> {
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

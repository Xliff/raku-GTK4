use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkSpinnerAncestry is export of Mu
  where GtkSpinner | GtkWidgetAncestry;

class GTK::Spinner:ver<4> is GTK::Widget:ver<4> {
  has GtkSpinner $!gtk-s is implementor;

  submethod BUILD ( :$gtk-spinner ) {
    self.setGtkSpinner($gtk-spinner) if $gtk-spinner
  }

  method setGtkSpinner (GtkSpinnerAncestry $_) {
    my $to-parent;

    $!gtk-s = do {
      when GtkSpinner {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSpinner, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkSpinner
    is also<GtkSpinner>
  { $!gtk-s }

  multi method new (GtkSpinnerAncestry $gtk-spinner, :$ref = True) {
    return unless $gtk-spinner;

    my $o = self.bless( :$gtk-spinner );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-spinner = gtk_spinner_new();

    $gtk-spinner ?? self.bless( :$gtk-spinner ) !! Nil;
  }

  method get_spinning is also<get-spinning> {
    so gtk_spinner_get_spinning($!gtk-s);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_spinner_get_type, $n, $t );
  }

  method set_spinning (Int() $spinning) is also<set-spinning> {
    my gboolean $s = $spinning;

    gtk_spinner_set_spinning($!gtk-s, $s);
  }

  method start {
    gtk_spinner_start($!gtk-s);
  }

  method stop {
    gtk_spinner_stop($!gtk-s);
  }

}

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Spinner;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     %widgets = from-json( .slurp );
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::Spinner;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

### /usr/src/gtk4-4.8.1+ds/gtk/gtkspinner.h

sub gtk_spinner_get_spinning (GtkSpinner $spinner)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_spinner_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_spinner_new
  returns GtkSpinner
  is      native(gtk4)
  is      export
{ * }

sub gtk_spinner_set_spinning (GtkSpinner $spinner, gboolean $spinning)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spinner_start (GtkSpinner $spinner)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spinner_stop (GtkSpinner $spinner)
  is      native(gtk4)
  is      export
{ * }

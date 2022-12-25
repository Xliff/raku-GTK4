use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;
use GTK::Roles::Scrollable:ver<4>;

our subset GtkListBaseAncestry is export of Mu
  where GtkListBase | GtkOrientable | GtkScrollable | GtkWidgetAncestry;

class GTK::ListBase:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Scrollable;

  has GtkListBase $!gtk-lb is implementor;

  submethod BUILD ( :$gtk-list-base ) {
    self.setGtkListBase($gtk-list-base) if $gtk-list-base
  }

  method setGtkListBase (GtkListBaseAncestry $_) {
    my $to-parent;

    $!gtk-lb = do {
      when GtkListBase {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkListBase, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkOrietable;
    self.roleInit-GtkScrollable;
  }

  method GTK::Raw::Definitions::GtkListBase
    is also<GtkListBase>
  { $!gtk-lb }

  multi method new ($gtk-list-base where * ~~ GtkListBaseAncestry , :$ref = True) {
    return unless $gtk-list-base;

    my $o = self.bless( :$gtk-list-base );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_base_get_type, $n, $t );
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::ListBase;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::ListBase;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

### /usr/src/gtk4-4.8.1+ds/gtk/gtklistbase.h

sub gtk_list_base_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

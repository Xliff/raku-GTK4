use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset GtkSorterAncestry is export of Mu
  where GtkSorter | GObject;

class GTK::Sorter:ver<4> {
  also does GLib::Roles::Object;

  has GtkSorter $!gtk-sort is implementor;

  submethod BUILD ( :$gtk-s ) {
    self.setGtkSorter($gtk-s) if $gtk-s
  }

  method setGtkSorter (GtkSorterAncestry $_) {
    my $to-parent;

    $!gtk-sort = do {
      when GtkSorter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSorter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkSorter
    is also<GtkSorter>
  { $!gtk-sort }

  multi method new ($gtk-s where * ~~ GtkSorterAncestry, :$ref = True) {
    return unless $gtk-s;

    my $o = self.bless( :$gtk-s );
    $o.ref if $ref;
    $o;
  }

  method Changed {
    self.connect-uint($!gtk-sort, 'changed');
  }

  method changed (Int() $change) {
    my GtkSorterChange $c = $change;

    gtk_sorter_changed($!gtk-sort, $c);
  }

  method compare (GObject() $item1, GObject() $item2, :$enum = True) {
    my $o = gtk_sorter_compare($!gtk-sort, $item1, $item2);
    return $o unless $enum;
    GtkOrderingEnum($o);
  }

  method get_order ( :$enum = True ) is also<get-order> {
    my $o = gtk_sorter_get_order($!gtk-sort);
    return $o unless $enum;
    GtkSorterOrderEnum($o);
  }

}

### /usr/src/gtk4/gtk/gtksorter.h

sub gtk_sorter_changed (
  GtkSorter       $self,
  GtkSorterChange $change
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_sorter_compare (
  GtkSorter $self,
  gpointer  $item1,
  gpointer  $item2
)
  returns GtkOrdering
  is      native(gtk4)
  is      export
{ * }

sub gtk_sorter_get_order (GtkSorter $self)
  returns GtkSorterOrder
  is      native(gtk4)
  is      export
{ * }

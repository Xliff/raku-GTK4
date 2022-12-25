use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

class GTK::Sorter {
  also does GLib::Roles::Object;

  has GtkSorter $!gtk-sort is implementor;

  method Changed {
    self.connect-uint($!gtk-sort, 'changed');
  }

  method changed () {
    my GtkSorterChange $c = $change;

    gtk_sorter_changed($!gtk-sort, $c);
  }

  method compare (GObject() $item1, GObject() $item2, :$enum = True) {
    my $o = gtk_sorter_compare($!gtk-sort, $item1, $item2);
    return $o unless $enum;
    GtkOrderingEnum($o);
  }

  method get_order ( :$enum = True ) {
    my $o = gtk_sorter_get_order($!gtk-sort);
    return $o unless $enum;
    GtkSortOrderEnum($o);
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

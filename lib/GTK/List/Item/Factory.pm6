use v6.c;

use NativeCall;
use Method::Also;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkListItemFactoryAncestry is export of Mu
  where GtkListItemFactory | GObject;

class GTK::List::Item::Factory:ver<4> {
  also does GLib::Roles::Object;

  has GtkListItemFactory $!gtk-lif is implementor;

  submethod BUILD ( :$gtk-item-factory ) {
    self.setGtkListItemFactory($gtk-item-factory) if $gtk-item-factory
  }

  method setGtkListItemFactory (GtkListItemFactoryAncestry $_) {
    my $to-parent;

    $!gtk-lif = do {
      when GtkListItemFactory {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkListItemFactory, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkListItemFactory
    is also<GtkListItemFactory>
  { $!gtk-lif }

  multi method new (
     $gtk-item-factory where * ~~ GtkListItemFactoryAncestry,

    :$ref = True
  ) {
    return unless $gtk-item-factory;

    my $o = self.bless( :$gtk-item-factory );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_item_factory_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gtk/gtklistitemfactory.h

sub gtk_list_item_factory_get_type ()
  returns GType
  is      native(gtk4)
  is      export
{ * }

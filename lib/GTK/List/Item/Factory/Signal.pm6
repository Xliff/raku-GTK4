use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::List::Item::Factory:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSignalListItemFactoryAncestry is export of Mu
  where GtkSignalListItemFactory | GtkListItemFactoryAncestry;

class GLib::List::Item::Factory::Signal is GTK::List::Item::Factory {
  has GtkSignalListItemFactory $!gtk-slif is implementor;

  submethod BUILD ( :$gtk-signal-factory ) {
    self.setGtkSignalListItemFactory($gtk-signal-factory)
      if $gtk-signal-factory
  }

  method setGtkSignalListItemFactory (GtkSignalListItemFactoryAncestry $_) {
    my $to-parent;

    $!gtk-slif = do {
      when GtkSignalListItemFactory {
        $to-parent = cast(GtkListItemFactory, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSignalListItemFactory, $_);
      }
    }
    self.setGtkListItemFactory($to-parent);
  }

  method GTK::Raw::Definitions::GtkSignalListItemFactory
    is also<GtkSignalListItemFactory>
  { $!gtk-slif }

  multi method new (
     $gtk-signal-factory where * ~~ GtkSignalListItemFactoryAncestry,

    :$ref = True
  ) {
    return unless $gtk-signal-factory;

    my $o = self.bless( :$gtk-signal-factory );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-signal-item-factory = gtk_signal_list_item_factory_new();

    $gtk-signal-item-factory ?? self.bless( :$gtk-signal-item-factory )
                             !! Nil;
  }

  method Bind {
    self.connect-object($!gtk-slif, 'bind');
  }

  method Setup {
    self.connect-object($!gtk-slif, 'setup');
  }

  method Teardown {
    self.connect-object($!gtk-slif, 'teardown');
  }

  method Unbind {
    self.connect-object($!gtk-slif, 'unbind');
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_signal_list_item_factory_get_type,
      $n,
      $t
    );
  }

}

### /usr/src/gtk4/gtk/gtksignallistitemfactory.h

sub gtk_signal_list_item_factory_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_signal_list_item_factory_new
  returns GtkSignalListItemFactory
  is      native(gtk4)
  is      export
{ * }

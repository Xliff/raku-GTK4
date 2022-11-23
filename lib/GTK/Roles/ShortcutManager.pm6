use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::ShortcutManager {
  has GtkShortcutManager $!gtk-sm is implementor;

  method roleInit-GtkShortcutManager {
    return if $!gtk-sm;

    my \i    = findProperImplementor(self.^attributes);
    $!gtk-sm = cast( GtkShortcutManager, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkShortcutManager
  { $!gtk-sm }

  method GtkShortcutManager
  { $!gtk-sm }

  # method add_controller     { ... }
  # method remove_controller  { ... }

  method gtkshortcutmanager_get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_shortcut_manager_get_type,
      $n,
      $t
    );
  }

}

our subset GtkShortcutManagerAncestry is export of Mu
  where GtkShortcutManager | GObject;

class GTK::ShortcutsManager {
  also does GLib::Roles::Object;
  also does GTK::Roles::ShortcutManager;

  submethod BUILD ( :$gtk-shortcut-manager ) {
    self.setGtkShortcutManager($gtk-shortcut-manager)
      if $gtk-shortcut-manager
  }

  method setGtkShortcutManager (GtkShortcutManagerAncestry $_) {
    my $to-parent;

    $!gtk-sm = do {
      when GtkShortcutManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
    GtkShortcutManagerAncestry  $gtk-shortcut-manager,
                               :$ref                   = True
  ) {
    return unless $gtk-shortcut-manager;

    my $o = self.bless( :$gtk-shortcut-manager );
    $o.ref if $ref;
    $o;
  }

  method add_controller (GtkShortcutController() $controller) {
    invoke-vfunc( $!gtk-sm.add-controller, &*ROUTINE, $controller )
  }

  method remove_controller (GtkShortcutController() $controller) {
    invoke-vfunc( $!gtk-sm.remove-controller, &*ROUTINE, $controller )
  }

  method get_type {
    self.gtkshortcutmanager_get_type
  }

}

sub gtk_shortcut_manager_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

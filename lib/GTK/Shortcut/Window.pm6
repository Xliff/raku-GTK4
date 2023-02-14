use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Window:ver<4>;

use GLib::Roles::Implementor;

our subset GtkShortcutsWindowAncestry is export of Mu
  where GtkShortcutsWindow | GtkWindowAncestry;

class GTK::Shortcut::Window:ver<4> is GTK::Window:ver<4> {
  has GtkShortcutsWindow $!gtk-sw is implementor;

  submethod BUILD ( :$gtk-shortcuts-window ) {
    self.setGtkShortcutsWindow($gtk-shortcuts-window)
      if $gtk-shortcuts-window
  }

  method setGtkShortcutsWindow (GtkShortcutsWindowAncestry $_) {
    my $to-parent;

    $!gtk-sw = do {
      when GtkShortcutsWindow {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutsWindow, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutsWindow
    is also<GtkShortcutsWindow>
  { $!gtk-sw }

  multi method new (
    $gtk-shortcuts-window where * ~~ GtkShortcutsWindowAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcuts-window;

    my $o = self.bless( :$gtk-shortcuts-window );
    $o.ref if $ref;
    $o;
  }
  multi method new (*%opts) {
    my $gtk-shortcuts-window = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    my $o = $gtk-shortcuts-window ?? self.bless( :$gtk-shortcuts-window )
                                  !! Nil;

    $o.setAtttributes(%opts) if +%opts;
    $o;
  }

  # Type: string
  method section-name is rw  is g-property is also<section_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('section-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('section-name', $gv);
      }
    );
  }

  # Type: string
  method view-name is rw  is g-property is also<view_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view-name', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_shortcuts_window_get_type, $n, $t );
  }

}


### /usr/src/gtk4/gtk/gtkshortcutswindow.h

sub gtk_shortcuts_window_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::ApplicationWindow:ver<4>;

use GTK::Window:ver<4>;

use GLib::Roles::Implementor;

our subset GtkApplicationWindowAncestry is export of Mu
  where GtkApplicationWindow | GtkWindowAncestry;

class GTK::ApplicationWindow:ver<4> is GTK::Window {
  has GtkApplicationWindow $!gtk-aw is implementor;

  submethod BUILD ( :$gtk-app-window ) {
    self.setGtkApplicationWindow($gtk-app-window) if $gtk-app-window;
  }

  method setGtkApplicationWindow (GtkApplicationWindowAncestry $_) {
    my $to-parent;

    $!gtk-aw = do {
      when GtkApplicationWindow {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkApplicationWindow, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method GTK::Raw::Definitions::GtkApplicationWindow
    is also<GtkApplicationWindow>
  { $!gtk-aw }

  multi method new (
    GtkApplicationWindowAncestry  $gtk-app-window,
                                 :$ref             = True
  ) {
    return unless $gtk-app-window;

    my $o = self.bless( :$gtk-app-window );
    $o.ref if $ref;
    $o;
  }

  method new {
    my $gtk-app-window = gtk_application_window_new();

    $gtk-app-window ?? self.bless( :$gtk-app-window ) !! Nil;
  }

  method show-menubar is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-menubar', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-menubar', $gv);
      }
    );
  }

  method get_help_overlay ( :$raw = False ) is also<get-help-overlay> {
    propReturnObject(
      gtk_application_window_get_help_overlay($!gtk-aw),
      $raw,
      |GTK::Shortcuts::Window.getTypePair
    );
  }

  method get_id is also<get-id> {
    gtk_application_window_get_id($!gtk-aw);
  }

  method get_show_menubar is also<get-show-menubar> {
    so gtk_application_window_get_show_menubar($!gtk-aw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_application_window_get_type, $n, $t );
  }

  method set_help_overlay (GtkShortcutsWindow() $help_overlay)
    is also<set-help-overlay>
  {
    gtk_application_window_set_help_overlay($!gtk-aw, $help_overlay);
  }

  method set_show_menubar (Int() $show_menubar) is also<set-show-menubar> {
    my gboolean $s = $show_menubar.so.Int;

    gtk_application_window_set_show_menubar($!gtk-aw, $s);
  }

}

use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::GList;

use GLib::Roles::Object;

our subset GtkWindowGroupAncestry is export of Mu
  where GtkWindowGroup | GObject;

class GTK::Window::Group {
  also does GLib::Roles::Object;

  has GtkWindowGroup $!gtk-win-g is implementor;

  submethod BUILD ( :$gtk-window-group ) {
    self.setGtkWindowGroup($gtk-window-group) if $gtk-window-group
  }

  method setGtkWindowGroup (GtkWindowGroupAncestry $_) {
    my $to-parent;

    $!gtk-win-g = do {
      when GtkWindowGroup {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkWindowGroup, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkWindowGroup
    is also<GtkWindowGroup>
  { $!gtk-win-g }

  multi method new (GtkWindowGroupAncestry $gtk-window-group, :$ref = True) {
    return unless $gtk-window-group;

    my $o = self.bless( :$gtk-window-group );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-window-group = gtk_window_group_new();

    $gtk-window-group ?? self.bless( :$gtk-window-group ) !! Nil;
  }

  method add_window (GtkWindow() $window) is also<add-window> {
    gtk_window_group_add_window($!gtk-win-g, $window);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_window_group_get_type, $n, $t );
  }

  method list_windows ( :$raw = False, :$glist = False) is also<list-windows> {
    returnGList(
      gtk_window_group_list_windows($!gtk-win-g),
      $raw,
      $glist,
      |::('GTK::Window').getTypePair
    );
  }

  method remove_window (GtkWindow() $window) is also<remove-window> {
    gtk_window_group_remove_window($!gtk-win-g, $window);
  }

}

### /usr/src/gtk4-4.8.1+ds/gtk/gtkwindowgroup.h

sub gtk_window_group_add_window (
  GtkWindowGroup $window_group,
  GtkWindow      $window
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_group_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_group_list_windows (GtkWindowGroup $window_group)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_group_new
  returns GtkWindowGroup
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_group_remove_window (
  GtkWindowGroup $window_group,
  GtkWindow      $window
)
  is      native(gtk4)
  is      export
{ * }

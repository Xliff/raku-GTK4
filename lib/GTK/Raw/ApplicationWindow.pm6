use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Application::Window:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkapplicationwindow.h

sub gtk_application_window_get_help_overlay (GtkApplicationWindow $window)
  returns GtkShortcutsWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_window_get_id (GtkApplicationWindow $window)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_window_get_show_menubar (GtkApplicationWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_window_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_window_new (GtkApplication $application)
  returns GtkApplicationWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_window_set_help_overlay (
  GtkApplicationWindow $window,
  GtkShortcutsWindow   $help_overlay
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_window_set_show_menubar (
  GtkApplicationWindow $window,
  gboolean             $show_menubar
)
  is      native(gtk4)
  is      export
{ * }

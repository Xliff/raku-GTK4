use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Application:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkapplication.h

sub gtk_application_add_window (
  GtkApplication $application,
  GtkWindow      $window
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_accels_for_action (
  GtkApplication $application,
  Str            $detailed_action_name
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_actions_for_accel (
  GtkApplication $application,
  Str            $accel
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_active_window (GtkApplication $application)
  returns GtkWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_menu_by_id (
  GtkApplication $application,
  Str            $id
)
  returns GMenu
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_menubar (GtkApplication $application)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_window_by_id (
  GtkApplication $application,
  guint          $id
)
  returns GtkWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_get_windows (GtkApplication $application)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_inhibit (
  GtkApplication             $application,
  GtkWindow                  $window,
  GtkApplicationInhibitFlags $flags,
  Str                        $reason
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_list_action_descriptions (GtkApplication $application)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_new (
  Str               $application_id,
  GApplicationFlags $flags
)
  returns GtkApplication
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_remove_window (
  GtkApplication $application,
  GtkWindow      $window
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_set_accels_for_action (
  GtkApplication $application,
  Str            $detailed_action_name,
  CArray[Str]    $accels
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_set_menubar (
  GtkApplication $application,
  GMenuModel     $menubar
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_application_uninhibit (
  GtkApplication $application,
  guint          $cookie
)
  is      native(gtk4)
  is      export
{ * }

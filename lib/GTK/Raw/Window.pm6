use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GSK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Window:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkwindow.h

sub gtk_window_close (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_destroy (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_fullscreen (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_fullscreen_on_monitor (
  GtkWindow  $window,
  GdkMonitor $monitor
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_application (GtkWindow $window)
  returns GtkApplication
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_child (GtkWindow $window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_decorated (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_default_icon_name
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_default_size (
  GtkWindow $window,
  gint      $width   is rw,
  gint      $height  is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_default_widget (GtkWindow $window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_deletable (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_destroy_with_parent (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_focus (GtkWindow $window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_focus_visible (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_group (GtkWindow $window)
  returns GtkWindowGroup
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_handle_menubar_accel (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_hide_on_close (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_icon_name (GtkWindow $window)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_mnemonics_visible (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_modal (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_resizable (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_title (GtkWindow $window)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_titlebar (GtkWindow $window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_toplevels
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_transient_for (GtkWindow $window)
  returns GtkWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_has_group (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_is_active (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_is_fullscreen (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_is_maximized (GtkWindow $window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_list_toplevels
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_maximize (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_minimize (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_present (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_present_with_time (
  GtkWindow $window,
  guint32   $timestamp
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_application (
  GtkWindow      $window,
  GtkApplication $application
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_auto_startup_notification (gboolean $setting)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_child (
  GtkWindow $window,
  GtkWidget $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_decorated (
  GtkWindow $window,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_default_icon_name (Str $name)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_default_size (
  GtkWindow $window,
  gint      $width,
  gint      $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_default_widget (
  GtkWindow $window,
  GtkWidget $default_widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_deletable (
  GtkWindow $window,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_destroy_with_parent (
  GtkWindow $window,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_display (
  GtkWindow  $window,
  GdkDisplay $display
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_focus (
  GtkWindow $window,
  GtkWidget $focus
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_focus_visible (
  GtkWindow $window,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_handle_menubar_accel (
  GtkWindow $window,
  gboolean  $handle_menubar_accel
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_hide_on_close (
  GtkWindow $window,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_icon_name (
  GtkWindow $window,
  Str       $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_interactive_debugging (gboolean $enable)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_mnemonics_visible (
  GtkWindow $window,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_modal (
  GtkWindow $window,
  gboolean  $modal
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_resizable (
  GtkWindow $window,
  gboolean  $resizable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_startup_id (
  GtkWindow $window,
  Str       $startup_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_title (
  GtkWindow $window,
  Str       $title
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_titlebar (
  GtkWindow $window,
  GtkWidget $titlebar
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_set_transient_for (
  GtkWindow $window,
  GtkWindow $parent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_unfullscreen (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_unmaximize (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_unminimize (GtkWindow $window)
  is      native(gtk4)
  is      export
{ * }

### /usr/src/gtk4/gtk/gtkshow.h

sub gtk_show_uri (
  GtkWindow $parent,
  Str       $uri,
  guint32   $timestamp
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_show_uri_full (
  GtkWindow           $parent,
  Str                 $uri,
  guint32             $timestamp,
  GCancellable        $cancellable,
                      &callback (GtkWindow, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_show_uri_full_finish (
  GtkWindow               $parent,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

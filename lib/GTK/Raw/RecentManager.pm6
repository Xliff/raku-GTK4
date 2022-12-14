use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::RecentManager:ver<4>;

### /usr/src/gtk4/gtk/gtkrecentmanager.h

sub _gtk_recent_manager_sync
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_add_full (
  GtkRecentManager $manager,
  Str              $uri,
  GtkRecentData    $recent_data
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_add_item (
  GtkRecentManager $manager,
  Str              $uri
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_error_quark
  returns GQuark
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_get_default
  returns GtkRecentManager
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_get_items (GtkRecentManager $manager)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_create_app_info (
  GtkRecentInfo           $info,
  Str                     $app_name,
  CArray[Pointer[GError]] $error
)
  returns GAppInfo
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_exists (GtkRecentInfo $info)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_added (GtkRecentInfo $info)
  returns GDateTime
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_age (GtkRecentInfo $info)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_application_info (
  GtkRecentInfo     $info,
  Str               $app_name,
  CArray[Str]       $app_exec,
  guint             $count is rw,
  CArray[GDateTime] $stamp
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_applications (
  GtkRecentInfo $info,
  gsize         $length
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_description (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_display_name (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_gicon (GtkRecentInfo $info)
  returns GIcon
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_groups (
  GtkRecentInfo $info,
  gsize         $length
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_mime_type (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_modified (GtkRecentInfo $info)
  returns GDateTime
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_private_hint (GtkRecentInfo $info)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_short_name (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_uri (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_uri_display (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_get_visited (GtkRecentInfo $info)
  returns GDateTime
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_has_application (
  GtkRecentInfo $info,
  Str           $app_name
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_has_group (
  GtkRecentInfo $info,
  Str           $group_name
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_is_local (GtkRecentInfo $info)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_last_application (GtkRecentInfo $info)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_match (
  GtkRecentInfo $info_a,
  GtkRecentInfo $info_b
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_ref (GtkRecentInfo $info)
  returns GtkRecentInfo
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_info_unref (GtkRecentInfo $info)
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_has_item (
  GtkRecentManager $manager,
  Str              $uri
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_lookup_item (
  GtkRecentManager        $manager,
  Str                     $uri,
  CArray[Pointer[GError]] $error
)
  returns GtkRecentInfo
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_move_item (
  GtkRecentManager        $manager,
  Str                     $uri,
  Str                     $new_uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_new
  returns GtkRecentManager
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_purge_items (
  GtkRecentManager        $manager,
  CArray[Pointer[GError]] $error
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_recent_manager_remove_item (
  GtkRecentManager        $manager,
  Str                     $uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

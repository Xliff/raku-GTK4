use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::IconTheme:ver<4>;

### /usr/src/gtk4/gtk/gtkicontheme.h

sub gtk_icon_theme_add_resource_path (
  GtkIconTheme $self,
  Str          $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_add_search_path (
  GtkIconTheme $self,
  Str          $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_error_quark
  returns GQuark
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_display (GtkIconTheme $self)
  returns GdkDisplay
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_for_display (GdkDisplay $display)
  returns GtkIconTheme
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_icon_names (GtkIconTheme $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_icon_sizes (
  GtkIconTheme $self,
  Str          $icon_name
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_resource_path (GtkIconTheme $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_search_path (GtkIconTheme $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_theme_name (GtkIconTheme $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_paintable_get_file (GtkIconPaintable $self)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_paintable_get_icon_name (GtkIconPaintable $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_paintable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_paintable_is_symbolic (GtkIconPaintable $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_paintable_new_for_file (
  GFile $file,
  gint  $size,
  gint  $scale
)
  returns GtkIconPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_has_gicon (
  GtkIconTheme $self,
  GIcon        $gicon
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_has_icon (
  GtkIconTheme $self,
  Str          $icon_name
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_lookup_by_gicon (
  GtkIconTheme       $self,
  GIcon              $icon,
  gint               $size,
  gint               $scale,
  GtkTextDirection   $direction,
  GtkIconLookupFlags $flags
)
  returns GtkIconPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_lookup_icon (
  GtkIconTheme       $self,
  Str                $icon_name,
  Str                $fallbacks,
  gint               $size,
  gint               $scale,
  GtkTextDirection   $direction,
  GtkIconLookupFlags $flags
)
  returns GtkIconPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_new
  returns GtkIconTheme
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_set_resource_path (
  GtkIconTheme $self,
  CArray[Str]  $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_set_search_path (
  GtkIconTheme $self,
  CArray[Str]  $path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_icon_theme_set_theme_name (
  GtkIconTheme $self,
  Str          $theme_name
)
  is      native(gtk4)
  is      export
{ * }

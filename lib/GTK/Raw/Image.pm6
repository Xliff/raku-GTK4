use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Image:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkimage.h

sub gtk_image_clear (GtkImage $image)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_gicon (GtkImage $image)
  returns GIcon
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_icon_name (GtkImage $image)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_icon_size (GtkImage $image)
  returns GtkIconSize
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_paintable (GtkImage $image)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_pixel_size (GtkImage $image)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_storage_type (GtkImage $image)
  returns GtkImageType
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new_from_file (Str $filename)
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new_from_gicon (GIcon $icon)
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new_from_icon_name (Str $icon_name)
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new_from_paintable (GdkPaintable $paintable)
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new_from_pixbuf (GdkPixbuf $pixbuf)
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_new_from_resource (Str $resource_path)
  returns GtkImage
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_from_file (
  GtkImage $image,
  Str      $filename
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_from_gicon (
  GtkImage $image,
  GIcon    $icon
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_from_icon_name (
  GtkImage $image,
  Str      $icon_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_from_paintable (
  GtkImage     $image,
  GdkPaintable $paintable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_from_pixbuf (
  GtkImage  $image,
  GdkPixbuf $pixbuf
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_from_resource (
  GtkImage $image,
  Str      $resource_path
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_icon_size (
  GtkImage    $image,
  GtkIconSize $icon_size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_image_set_pixel_size (
  GtkImage $image,
  gint     $pixel_size
)
  is      native(gtk4)
  is      export
{ * }

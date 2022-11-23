use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Picture:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkpicture.h

sub gtk_picture_get_alternative_text (GtkPicture $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_get_can_shrink (GtkPicture $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_get_content_fit (GtkPicture $self)
  returns GtkContentFit
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_get_file (GtkPicture $self)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_get_keep_aspect_ratio (GtkPicture $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_get_paintable (GtkPicture $self)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_new
  returns GtkPicture
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_new_for_file (GFile $file)
  returns GtkPicture
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_new_for_filename (Str $filename)
  returns GtkPicture
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_new_for_paintable (GdkPaintable $paintable)
  returns GtkPicture
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_new_for_pixbuf (GdkPixbuf $pixbuf)
  returns GtkPicture
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_new_for_resource (Str $resource_path)
  returns GtkPicture
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_alternative_text (
  GtkPicture $self,
  Str        $alternative_text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_can_shrink (
  GtkPicture $self,
  gboolean   $can_shrink
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_content_fit (
  GtkPicture    $self,
  GtkContentFit $content_fit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_file (
  GtkPicture $self,
  GFile      $file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_filename (
  GtkPicture $self,
  Str        $filename
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_keep_aspect_ratio (
  GtkPicture $self,
  gboolean   $keep_aspect_ratio
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_paintable (
  GtkPicture   $self,
  GdkPaintable $paintable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_pixbuf (
  GtkPicture $self,
  GdkPixbuf  $pixbuf
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_picture_set_resource (
  GtkPicture $self,
  Str        $resource_path
)
  is      native(gtk4)
  is      export
{ * }

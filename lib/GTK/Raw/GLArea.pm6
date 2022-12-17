use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::GLArea:ver<4>;

### /usr/src/gtk4/gtk/gtkglarea.h

sub gtk_gl_area_attach_buffers (GtkGLArea $area)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_auto_render (GtkGLArea $area)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_context (GtkGLArea $area)
  returns GdkGLContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_error (GtkGLArea $area)
  returns GError
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_has_depth_buffer (GtkGLArea $area)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_has_stencil_buffer (GtkGLArea $area)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_required_version (
  GtkGLArea $area,
  gint      $major is rw,
  gint      $minor is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_get_use_es (GtkGLArea $area)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_make_current (GtkGLArea $area)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_queue_render (GtkGLArea $area)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_set_auto_render (
  GtkGLArea $area,
  gboolean  $auto_render
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_set_error (
  GtkGLArea       $area,
  Pointer[GError] $error
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_set_has_depth_buffer (
  GtkGLArea $area,
  gboolean  $has_depth_buffer
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_set_has_stencil_buffer (
  GtkGLArea $area,
  gboolean  $has_stencil_buffer
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_set_required_version (
  GtkGLArea $area,
  gint      $major,
  gint      $minor
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gl_area_set_use_es (
  GtkGLArea $area,
  gboolean  $use_es
)
  is      native(gtk4)
  is      export
{ * }

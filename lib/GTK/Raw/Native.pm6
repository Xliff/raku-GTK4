use v6.c;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GSK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;

uint package GTK::Raw::Native:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtknative.h

sub gtk_native_get_for_surface (GdkSurface $surface)
  returns GtkNative
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_get_renderer (GtkNative $self)
  returns GskRenderer
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_get_surface (GtkNative $self)
  returns GdkSurface
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_get_surface_transform (
  GtkNative $self,
  gdouble   $x     is rw,
  gdouble   $y     is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_realize (GtkNative $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_unrealize (GtkNative $self)
  is      native(gtk4)
  is      export
{ * }

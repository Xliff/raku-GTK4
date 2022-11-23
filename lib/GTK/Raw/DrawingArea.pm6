use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::DrawingArea:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkdrawingarea.h

sub gtk_drawing_area_get_content_height (GtkDrawingArea $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_drawing_area_get_content_width (GtkDrawingArea $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_drawing_area_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_drawing_area_new
  returns GtkDrawingArea
  is      native(gtk4)
  is      export
{ * }

sub gtk_drawing_area_set_content_height (
  GtkDrawingArea $self,
  gint           $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drawing_area_set_content_width (
  GtkDrawingArea $self,
  gint           $width
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drawing_area_set_draw_func (
  GtkDrawingArea $self,
                 &draw_func (
                   GtkDrawingArea,
                   cairo_t,
                   gint,
                   gint,
                   gpointer
                 ),
  gpointer       $user_data,
                 &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

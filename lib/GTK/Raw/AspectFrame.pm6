use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;

unit package GTK::Raw::AspectFrame;

### /usr/src/gtk4/gtk/gtkaspectframe.h

sub gtk_aspect_frame_get_child (GtkAspectFrame $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_get_obey_child (GtkAspectFrame $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_get_ratio (GtkAspectFrame $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_get_xalign (GtkAspectFrame $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_get_yalign (GtkAspectFrame $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_new (
  gfloat   $xalign,
  gfloat   $yalign,
  gfloat   $ratio,
  gboolean $obey_child
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_set_child (
  GtkAspectFrame $self,
  GtkWidget      $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_set_obey_child (
  GtkAspectFrame $self,
  gboolean       $obey_child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_set_ratio (
  GtkAspectFrame $self,
  gfloat         $ratio
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_set_xalign (
  GtkAspectFrame $self,
  gfloat         $xalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_aspect_frame_set_yalign (
  GtkAspectFrame $self,
  gfloat         $yalign
)
  is      native(gtk4)
  is      export
{ * }

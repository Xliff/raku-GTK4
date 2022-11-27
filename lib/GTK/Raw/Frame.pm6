use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Frame:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkframe.h

sub gtk_frame_get_child (GtkFrame $frame)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_get_label (GtkFrame $frame)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_get_label_align (GtkFrame $frame)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_get_label_widget (GtkFrame $frame)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_new (Str $label)
  returns GtkFrame
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_set_child (
  GtkFrame  $frame,
  GtkWidget $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_set_label (
  GtkFrame $frame,
  Str      $label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_set_label_align (
  GtkFrame $frame,
  gfloat   $xalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_frame_set_label_widget (
  GtkFrame  $frame,
  GtkWidget $label_widget
)
  is      native(gtk4)
  is      export
{ * }

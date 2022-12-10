use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Window::Controls:ver<4>;

### /usr/src/gtk4/gtk/gtkwindowcontrols.h

sub gtk_window_controls_get_decoration_layout (GtkWindowControls $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_controls_get_empty (GtkWindowControls $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_controls_get_side (GtkWindowControls $self)
  returns GtkPackType
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_controls_new (GtkPackType $side)
  returns GtkWindowControls
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_controls_set_decoration_layout (
  GtkWindowControls $self,
  Str               $layout
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_window_controls_set_side (
  GtkWindowControls $self,
  GtkPackType       $side
)
  is      native(gtk4)
  is      export
{ * }

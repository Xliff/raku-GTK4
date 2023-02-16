use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Event::Controller::Key:ver<4>;

### /usr/src/gtk4/gtk/gtkeventcontrollerkey.h

sub gtk_event_controller_key_forward (
  GtkEventControllerKey $controller,
  GtkWidget             $widget
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_key_get_group (GtkEventControllerKey $controller)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_key_get_im_context (GtkEventControllerKey $controller)
  returns GtkIMContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_key_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_key_new
  returns GtkEventControllerKey
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_key_set_im_context (
  GtkEventControllerKey $controller,
  GtkIMContext          $im_context
)
  is      native(gtk4)
  is      export
{ * }

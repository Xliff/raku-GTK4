use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;


unit package GTK::Raw::Event::Controller:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkeventcontroller.h

sub gtk_event_controller_get_current_event (GtkEventController $controller)
  returns GdkEvent
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_current_event_device (
  GtkEventController $controller
)
  returns GdkDevice
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_current_event_state (
  GtkEventController $controller
)
  returns GdkModifierType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_current_event_time (
  GtkEventController $controller
)
  returns guint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_name (GtkEventController $controller)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_propagation_limit (
  GtkEventController $controller
)
  returns GtkPropagationLimit
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_propagation_phase (
  GtkEventController $controller
)
  returns GtkPropagationPhase
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_get_widget (GtkEventController $controller)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_reset (GtkEventController $controller)
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_set_name (
  GtkEventController $controller,
  Str                $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_set_propagation_limit (
  GtkEventController  $controller,
  GtkPropagationLimit $limit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_set_propagation_phase (
  GtkEventController  $controller,
  GtkPropagationPhase $phase
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_set_static_name (
  GtkEventController $controller,
  Str                $name
)
  is      native(gtk4)
  is      export
{ * }

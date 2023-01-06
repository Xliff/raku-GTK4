use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Gesture:ver<4>;

### /usr/src/gtk4/gtk/gtkgesture.h

sub gtk_gesture_get_bounding_box (
  GtkGesture   $gesture,
  GdkRectangle $rect
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_bounding_box_center (
  GtkGesture $gesture,
  gdouble    $x        is rw,
  gdouble    $y        is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_device (GtkGesture $gesture)
  returns GdkDevice
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_group (GtkGesture $gesture)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_last_event (
  GtkGesture       $gesture,
  GdkEventSequence $sequence
)
  returns GdkEvent
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_last_updated_sequence (GtkGesture $gesture)
  returns GdkEventSequence
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_point (
  GtkGesture       $gesture,
  GdkEventSequence $sequence,
  gdouble          $x         is rw,
  gdouble          $y         is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_sequence_state (
  GtkGesture       $gesture,
  GdkEventSequence $sequence
)
  returns GtkEventSequenceState
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_sequences (GtkGesture $gesture)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_group (
  GtkGesture $group_gesture,
  GtkGesture $gesture
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_handles_sequence (
  GtkGesture       $gesture,
  GdkEventSequence $sequence
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_is_active (GtkGesture $gesture)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_is_grouped_with (
  GtkGesture $gesture,
  GtkGesture $other
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_is_recognized (GtkGesture $gesture)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_set_sequence_state (
  GtkGesture            $gesture,
  GdkEventSequence      $sequence,
  GtkEventSequenceState $state
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_set_state (
  GtkGesture            $gesture,
  GtkEventSequenceState $state
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_ungroup (GtkGesture $gesture)
  is      native(gtk4)
  is      export
{ * }

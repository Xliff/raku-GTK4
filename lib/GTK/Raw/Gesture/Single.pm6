use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Gesture::Single:ver<4>;

### /usr/src/gtk4/gtk/gtkgesturesingle.h

sub gtk_gesture_single_get_button (GtkGestureSingle $gesture)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_get_current_button (GtkGestureSingle $gesture)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_get_current_sequence (GtkGestureSingle $gesture)
  returns GdkEventSequence
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_get_exclusive (GtkGestureSingle $gesture)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_get_touch_only (GtkGestureSingle $gesture)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_set_button (
  GtkGestureSingle $gesture,
  guint            $button
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_set_exclusive (
  GtkGestureSingle $gesture,
  gboolean         $exclusive
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_gesture_single_set_touch_only (
  GtkGestureSingle $gesture,
  gboolean         $touch_only
)
  is      native(gtk4)
  is      export
{ * }

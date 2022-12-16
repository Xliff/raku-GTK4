use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Revealer:ver<4>;

### /usr/src/gtk4/gtk/gtkrevealer.h

sub gtk_revealer_get_child (GtkRevealer $revealer)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_get_child_revealed (GtkRevealer $revealer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_get_reveal_child (GtkRevealer $revealer)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_get_transition_duration (GtkRevealer $revealer)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_get_transition_type (GtkRevealer $revealer)
  returns GtkRevealerTransitionType
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_new
  returns GtkRevealer
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_set_child (
  GtkRevealer $revealer,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_set_reveal_child (
  GtkRevealer $revealer,
  gboolean    $reveal_child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_set_transition_duration (
  GtkRevealer $revealer,
  guint       $duration
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_revealer_set_transition_type (
  GtkRevealer               $revealer,
  GtkRevealerTransitionType $transition
)
  is      native(gtk4)
  is      export
{ * }

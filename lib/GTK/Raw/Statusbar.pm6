use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::StatusBar:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkstatusbar.h

sub gtk_statusbar_get_context_id (
  GtkStatusbar $statusbar,
  Str          $context_description
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_statusbar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_statusbar_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_statusbar_pop (
  GtkStatusbar $statusbar,
  guint        $context_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_statusbar_push (
  GtkStatusbar $statusbar,
  guint        $context_id,
  Str          $text
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_statusbar_remove (
  GtkStatusbar $statusbar,
  guint        $context_id,
  guint        $message_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_statusbar_remove_all (
  GtkStatusbar $statusbar,
  guint        $context_id
)
  is      native(gtk4)
  is      export
{ * }

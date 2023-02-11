use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Shortcut::Action:ver<4>;

### /usr/src/gtk4/gtk/gtkshortcutaction.h

sub gtk_shortcut_action_activate (
  GtkShortcutAction      $self,
  GtkShortcutActionFlags $flags,
  GtkWidget              $widget,
  GVariant               $args
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_activate_action_get
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_callback_action_new (
           &callback (GtkWidget, GVariant, gpointer --> gboolean),
  gpointer $data,
           &destroy (gpointer)
)
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_mnemonic_action_get
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_named_action_get_action_name (GtkNamedAction $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_named_action_new (Str $name)
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_nothing_action_get
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_signal_action_get_signal_name (GtkSignalAction $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_signal_action_new (Str $signal_name)
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_action_parse_string (Str $string)
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_action_print (
  GtkShortcutAction $self,
  GString           $string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_action_to_string (GtkShortcutAction $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

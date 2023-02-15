use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Shortcut:ver<4>;

### /usr/src/gtk4/gtk/gtkshortcut.h

sub gtk_shortcut_get_action (GtkShortcut $self)
  returns GtkShortcutAction
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_get_arguments (GtkShortcut $self)
  returns GVariant
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_get_trigger (GtkShortcut $self)
  returns GtkShortcutTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_new (
  GtkShortcutTrigger $trigger,
  GtkShortcutAction  $action
)
  returns GtkShortcut
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_new_with_arguments (
  GtkShortcutTrigger $trigger,
  GtkShortcutAction  $action,
  Str                $format_string,
  Str
)
  returns GtkShortcut
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_set_action (
  GtkShortcut       $self,
  GtkShortcutAction $action
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_set_arguments (
  GtkShortcut $self,
  GVariant    $args
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_set_trigger (
  GtkShortcut        $self,
  GtkShortcutTrigger $trigger
)
  is      native(gtk4)
  is      export
{ * }

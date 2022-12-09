use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Actionable:ver<4>;

### /usr/src/gtk4/gtk/gtkactionable.h

sub gtk_actionable_get_action_name (GtkActionable $actionable)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_actionable_get_action_target_value (GtkActionable $actionable)
  returns GVariant
  is      native(gtk4)
  is      export
{ * }

sub gtk_actionable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_actionable_set_action_name (
  GtkActionable $actionable,
  Str           $action_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_actionable_set_action_target (
  GtkActionable $actionable,
  Str           $format_string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_actionable_set_action_target_value (
  GtkActionable $actionable,
  GVariant      $target_value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_actionable_set_detailed_action_name (
  GtkActionable $actionable,
  Str           $detailed_action_name
)
  is      native(gtk4)
  is      export
{ * }

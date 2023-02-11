use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Shortcut::Controller;

### /usr/src/gtk4/gtk/gtkshortcutcontroller.h

sub gtk_shortcut_controller_add_shortcut (
  GtkShortcutController $self,
  GtkShortcut           $shortcut
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_get_mnemonics_modifiers (
  GtkShortcutController $self
)
  returns GdkModifierType
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_get_scope (GtkShortcutController $self)
  returns GtkShortcutScope
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_new
  returns GtkEventController
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_new_for_model (GListModel $model)
  returns GtkEventController
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_remove_shortcut (
  GtkShortcutController $self,
  GtkShortcut           $shortcut
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_set_mnemonics_modifiers (
  GtkShortcutController $self,
  GdkModifierType       $modifiers
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_controller_set_scope (
  GtkShortcutController $self,
  GtkShortcutScope      $scope
)
  is      native(gtk4)
  is      export
{ * }

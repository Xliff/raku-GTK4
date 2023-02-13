use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Shortcut::Trigger;

### /usr/src/gtk4/gtk/gtkshortcuttrigger.h

sub gtk_shortcut_trigger_compare (
  GtkShortcutTrigger $trigger1,
  GtkShortcutTrigger $trigger2
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_equal (
  GtkShortcutTrigger $trigger1,
  GtkShortcutTrigger $trigger2
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_alternative_trigger_get_first (GtkAlternativeTrigger $self)
  returns GtkShortcutTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_alternative_trigger_get_second (GtkAlternativeTrigger $self)
  returns GtkShortcutTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_alternative_trigger_new (
  GtkShortcutTrigger $first,
  GtkShortcutTrigger $second
)
  returns GtkAlternativeTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_keyval_trigger_get_keyval (GtkKeyvalTrigger $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_keyval_trigger_get_modifiers (GtkKeyvalTrigger $self)
  returns GdkModifierType
  is      native(gtk4)
  is      export
{ * }

sub gtk_keyval_trigger_new (
  guint           $keyval,
  GdkModifierType $modifiers
)
  returns GtkKeyvalTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_mnemonic_trigger_get_keyval (GtkMnemonicTrigger $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_mnemonic_trigger_new (guint $keyval)
  returns GtkMnemonicTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_never_trigger_get
  returns GtkNeverTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_hash (GtkShortcutTrigger $trigger)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_parse_string (Str $string)
  returns GtkShortcutTrigger
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_print (
  GtkShortcutTrigger $self,
  GString            $string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_print_label (
  GtkShortcutTrigger $self,
  GdkDisplay         $display,
  GString            $string
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_to_label (
  GtkShortcutTrigger $self,
  GdkDisplay         $display
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_to_string (GtkShortcutTrigger $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_trigger_trigger (
  GtkShortcutTrigger $self,
  GdkEvent           $event,
  gboolean           $enable_mnemonics
)
  returns GdkKeyMatch
  is      native(gtk4)
  is      export
{ * }

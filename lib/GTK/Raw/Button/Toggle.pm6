use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Button::Toggle:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtktogglebutton.h

sub gtk_toggle_button_get_active (GtkToggleButton $toggle_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_new
  returns GtkToggleButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_new_with_label (Str $label)
  returns GtkToggleButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_new_with_mnemonic (Str $label)
  returns GtkToggleButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_set_active (
  GtkToggleButton $toggle_button,
  gboolean        $is_active
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_set_group (
  GtkToggleButton $toggle_button,
  GtkToggleButton $group
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_toggle_button_toggled (GtkToggleButton $toggle_button)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Button::Check:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkcheckbutton.h

sub gtk_check_button_get_active (GtkCheckButton $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_get_child (GtkCheckButton $button)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_get_inconsistent (GtkCheckButton $check_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_get_label (GtkCheckButton $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_get_use_underline (GtkCheckButton $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_new_with_label (Str $label)
  returns GtkCheckButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_new_with_mnemonic (Str $label)
  returns GtkCheckButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_set_active (
  GtkCheckButton $self,
  gboolean       $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_set_child (
  GtkCheckButton $button,
  GtkWidget      $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_set_group (
  GtkCheckButton $self,
  GtkCheckButton $group
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_set_inconsistent (
  GtkCheckButton $check_button,
  gboolean       $inconsistent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_set_label (
  GtkCheckButton $self,
  Str            $label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_check_button_set_use_underline (
  GtkCheckButton $self,
  gboolean       $setting
)
  is      native(gtk4)
  is      export
{ * }

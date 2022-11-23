use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Button:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkbutton.h

sub gtk_button_get_child (GtkButton $button)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_get_has_frame (GtkButton $button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_get_icon_name (GtkButton $button)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_get_label (GtkButton $button)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_get_use_underline (GtkButton $button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_new_from_icon_name (Str $icon_name)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_new_with_label (Str $label)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_new_with_mnemonic (Str $label)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_set_child (GtkButton $button, GtkWidget $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_set_has_frame (GtkButton $button, gboolean $has_frame)
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_set_icon_name (GtkButton $button, Str $icon_name)
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_set_label (GtkButton $button, Str $label)
  is      native(gtk4)
  is      export
{ * }

sub gtk_button_set_use_underline (GtkButton $button, gboolean $use_underline)
  is      native(gtk4)
  is      export
{ * }

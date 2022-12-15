use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Expander:ver<4>;

### /usr/src/gtk4/gtk/gtkexpander.h

sub gtk_expander_get_child (GtkExpander $expander)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_expanded (GtkExpander $expander)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_label (GtkExpander $expander)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_label_widget (GtkExpander $expander)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_resize_toplevel (GtkExpander $expander)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_use_markup (GtkExpander $expander)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_get_use_underline (GtkExpander $expander)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_new (Str $label)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_new_with_mnemonic (Str $label)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_child (
  GtkExpander $expander,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_expanded (
  GtkExpander $expander,
  gboolean    $expanded
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_label (
  GtkExpander $expander,
  Str         $label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_label_widget (
  GtkExpander $expander,
  GtkWidget   $label_widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_resize_toplevel (
  GtkExpander $expander,
  gboolean    $resize_toplevel
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_use_markup (
  GtkExpander $expander,
  gboolean    $use_markup
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expander_set_use_underline (
  GtkExpander $expander,
  gboolean    $use_underline
)
  is      native(gtk4)
  is      export
{ * }

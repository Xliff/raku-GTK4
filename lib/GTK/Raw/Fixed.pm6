use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GSK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Fixed:ver<4>;

### /usr/src/gtk4/gtk/gtkfixed.h

sub gtk_fixed_get_child_position (
  GtkFixed  $fixed,
  GtkWidget $widget,
  gdouble   $x is rw,
  gdouble   $y is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_get_child_transform (GtkFixed $fixed, GtkWidget $widget)
  returns GskTransform
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_move (
  GtkFixed  $fixed,
  GtkWidget $widget,
  gdouble   $x,
  gdouble   $y
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_new
  returns GtkFixed
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_put (
  GtkFixed  $fixed,
  GtkWidget $widget,
  gdouble   $x,
  gdouble   $y
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_remove (GtkFixed $fixed, GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_fixed_set_child_transform (
  GtkFixed     $fixed,
  GtkWidget    $widget,
  GskTransform $transform
)
  is      native(gtk4)
  is      export
{ * }

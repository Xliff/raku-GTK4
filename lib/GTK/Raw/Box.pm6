use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Box:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkbox.h

sub gtk_box_append (GtkBox $box, GtkWidget $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_get_baseline_position (GtkBox $box)
  returns GtkBaselinePosition
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_get_homogeneous (GtkBox $box)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_get_spacing (GtkBox $box)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_insert_child_after (
  GtkBox    $box,
  GtkWidget $child,
  GtkWidget $sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_new (GtkOrientation $orientation, gint $spacing)
  returns GtkBox
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_prepend (GtkBox $box, GtkWidget $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_remove (GtkBox $box, GtkWidget $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_reorder_child_after (
  GtkBox    $box,
  GtkWidget $child,
  GtkWidget $sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_set_baseline_position (
  GtkBox              $box,
  GtkBaselinePosition $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_set_homogeneous (GtkBox $box, gboolean $homogeneous)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_set_spacing (GtkBox $box, gint $spacing)
  is      native(gtk4)
  is      export
{ * }

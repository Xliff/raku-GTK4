use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::BoxLayout;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkboxlayout.h

sub gtk_box_layout_get_baseline_position (GtkBoxLayout $box_layout)
  returns GtkBaselinePosition
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_layout_get_homogeneous (GtkBoxLayout $box_layout)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_layout_get_spacing (GtkBoxLayout $box_layout)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_layout_new (GtkOrientation $orientation)
  returns GtkBoxLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_layout_set_baseline_position (
  GtkBoxLayout        $box_layout,
  GtkBaselinePosition $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_layout_set_homogeneous (
  GtkBoxLayout $box_layout,
  gboolean     $homogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_box_layout_set_spacing (
  GtkBoxLayout $box_layout,
  guint        $spacing
)
  is      native(gtk4)
  is      export
{ * }

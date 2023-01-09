use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Constraint::Guide:ver<4>;

### /usr/src/gtk4/gtk/gtkconstraintguide.h

sub gtk_constraint_guide_get_max_size (
  GtkConstraintGuide $guide,
  gint               $width  is rw,
  gint               $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_get_min_size (
  GtkConstraintGuide $guide,
  gint               $width  is rw,
  gint               $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_get_name (GtkConstraintGuide $guide)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_get_nat_size (
  GtkConstraintGuide $guide,
  gint               $width  is rw,
  gint               $height is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_get_strength (GtkConstraintGuide $guide)
  returns GtkConstraintStrength
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_new
  returns GtkConstraintGuide
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_set_max_size (
  GtkConstraintGuide $guide,
  gint               $width,
  gint               $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_set_min_size (
  GtkConstraintGuide $guide,
  gint               $width,
  gint               $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_set_name (
  GtkConstraintGuide $guide,
  Str                $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_set_nat_size (
  GtkConstraintGuide $guide,
  gint               $width,
  gint               $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_guide_set_strength (
  GtkConstraintGuide    $guide,
  GtkConstraintStrength $strength
)
  is      native(gtk4)
  is      export
{ * }

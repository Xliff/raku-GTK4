use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Constraint::Layout:ver<4>;

### /usr/src/gtk4/gtk/gtkconstraintlayout.h

sub gtk_constraint_layout_add_constraint (
  GtkConstraintLayout $layout,
  GtkConstraint       $constraint
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_add_constraints_from_description (
  GtkConstraintLayout     $layout,
  Str                     $lines,
  gsize                   $n_lines,
  gint                    $hspacing,
  gint                    $vspacing,
  CArray[Pointer[GError]] $error,
  Str                     $first_view
)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_add_constraints_from_descriptionv (
  GtkConstraintLayout     $layout,
  Str                     $lines,
  gsize                   $n_lines,
  gint                    $hspacing,
  gint                    $vspacing,
  GHashTable              $views,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_add_guide (
  GtkConstraintLayout $layout,
  GtkConstraintGuide  $guide
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_vfl_parser_error_quark
  returns GQuark
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_new
  returns GtkLayoutManager
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_observe_constraints (GtkConstraintLayout $layout)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_observe_guides (GtkConstraintLayout $layout)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_remove_all_constraints (GtkConstraintLayout $layout)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_remove_constraint (
  GtkConstraintLayout $layout,
  GtkConstraint       $constraint
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_layout_remove_guide (
  GtkConstraintLayout $layout,
  GtkConstraintGuide  $guide
)
  is      native(gtk4)
  is      export
{ * }

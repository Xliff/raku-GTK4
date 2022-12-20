use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Constraint:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkconstraint.h

sub gtk_constraint_get_constant (GtkConstraint $constraint)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_multiplier (GtkConstraint $constraint)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_relation (GtkConstraint $constraint)
  returns GtkConstraintRelation
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_source (GtkConstraint $constraint)
  returns GtkConstraintTarget
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_source_attribute (GtkConstraint $constraint)
  returns GtkConstraintAttribute
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_strength (GtkConstraint $constraint)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_target (GtkConstraint $constraint)
  returns GtkConstraintTarget
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_get_target_attribute (GtkConstraint $constraint)
  returns GtkConstraintAttribute
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_is_attached (GtkConstraint $constraint)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_is_constant (GtkConstraint $constraint)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_is_required (GtkConstraint $constraint)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_new (
  GtkConstraintTarget    $target,
  GtkConstraintAttribute $target_attribute,
  GtkConstraintRelation  $relation,
  GtkConstraintTarget    $source,
  GtkConstraintAttribute $source_attribute,
  gdouble                $multiplier,
  gdouble                $constant,
  gint                   $strength
)
  returns GtkConstraint
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_new_constant (
  GtkConstraintTarget    $target,
  GtkConstraintAttribute $target_attribute,
  GtkConstraintRelation  $relation,
  gdouble                $constant,
  gint                   $strength
)
  returns GtkConstraint
  is      native(gtk4)
  is      export
{ * }

sub gtk_constraint_target_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

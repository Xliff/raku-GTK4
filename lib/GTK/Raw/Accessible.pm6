use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Accessible:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkaccessible.h

sub gtk_accessible_get_accessible_role (GtkAccessible $self)
  returns GtkAccessibleRole
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_property_init_value (
  GtkAccessibleProperty $property,
  GValue                $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_relation_init_value (
  GtkAccessibleRelation $relation,
  GValue                $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_reset_property (
  GtkAccessible         $self,
  GtkAccessibleProperty $property
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_reset_relation (
  GtkAccessible         $self,
  GtkAccessibleRelation $relation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_reset_state (
  GtkAccessible      $self,
  GtkAccessibleState $state
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_state_init_value (
  GtkAccessibleState $state,
  GValue             $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_update_property (
  GtkAccessible         $self,
  GtkAccessibleProperty $first_property
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_update_property_value (
  GtkAccessible         $self,
  gint                  $n_properties,
  GtkAccessibleProperty $properties,
  GValue                $values
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_update_relation (
  GtkAccessible         $self,
  GtkAccessibleRelation $first_relation,
                        Str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_update_relation_value (
  GtkAccessible         $self,
  gint                  $n_relations,
  GtkAccessibleRelation $relations,
  GValue                $values
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_update_state (
  GtkAccessible      $self,
  GtkAccessibleState $first_state
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_accessible_update_state_value (
  GtkAccessible      $self,
  gint               $n_states,
  GtkAccessibleState $states,
  GValue             $values
)
  is      native(gtk4)
  is      export
{ * }

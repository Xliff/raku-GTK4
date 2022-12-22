use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Stack:ver<4>;

### /usr/src/gtk4/gtk/gtkstack.h

sub gtk_stack_add_child (
  GtkStack  $stack,
  GtkWidget $child
)
  returns GtkStackPage
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_add_named (
  GtkStack  $stack,
  GtkWidget $child,
  Str       $name
)
  returns GtkStackPage
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_add_titled (
  GtkStack  $stack,
  GtkWidget $child,
  Str       $name,
  Str       $title
)
  returns GtkStackPage
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_child_by_name (
  GtkStack $stack,
  Str      $name
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_hhomogeneous (GtkStack $stack)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_interpolate_size (GtkStack $stack)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_page (
  GtkStack  $stack,
  GtkWidget $child
)
  returns GtkStackPage
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_pages (GtkStack $stack)
  returns GtkSelectionModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_transition_duration (GtkStack $stack)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_transition_running (GtkStack $stack)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_transition_type (GtkStack $stack)
  returns GtkStackTransitionType
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_vhomogeneous (GtkStack $stack)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_visible_child (GtkStack $stack)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_get_visible_child_name (GtkStack $stack)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_child (GtkStackPage $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_icon_name (GtkStackPage $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_name (GtkStackPage $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_needs_attention (GtkStackPage $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_title (GtkStackPage $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_use_underline (GtkStackPage $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_get_visible (GtkStackPage $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_set_icon_name (
  GtkStackPage $self,
  Str          $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_set_name (
  GtkStackPage $self,
  Str          $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_set_needs_attention (
  GtkStackPage $self,
  gboolean     $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_set_title (
  GtkStackPage $self,
  Str          $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_set_use_underline (
  GtkStackPage $self,
  gboolean     $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_page_set_visible (
  GtkStackPage $self,
  gboolean     $visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_remove (
  GtkStack  $stack,
  GtkWidget $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_hhomogeneous (
  GtkStack $stack,
  gboolean $hhomogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_interpolate_size (
  GtkStack $stack,
  gboolean $interpolate_size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_transition_duration (
  GtkStack $stack,
  guint    $duration
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_transition_type (
  GtkStack               $stack,
  GtkStackTransitionType $transition
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_vhomogeneous (
  GtkStack $stack,
  gboolean $vhomogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_visible_child (
  GtkStack  $stack,
  GtkWidget $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_visible_child_full (
  GtkStack               $stack,
  Str                    $name,
  GtkStackTransitionType $transition
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_set_visible_child_name (
  GtkStack $stack,
  Str      $name
)
  is      native(gtk4)
  is      export
{ * }

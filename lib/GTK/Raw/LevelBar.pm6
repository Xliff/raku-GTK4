use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::LevelBar:ver<4>;

### /usr/src/gtk4/gtk/gtklevelbar.h

sub gtk_level_bar_add_offset_value (
  GtkLevelBar $self,
  Str         $name,
  gdouble     $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_inverted (GtkLevelBar $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_max_value (GtkLevelBar $self)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_min_value (GtkLevelBar $self)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_mode (GtkLevelBar $self)
  returns GtkLevelBarMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_offset_value (
  GtkLevelBar $self,
  Str         $name,
  gdouble     $value is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_get_value (GtkLevelBar $self)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_new
  returns GtkLevelBar
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_new_for_interval (
  gdouble $min_value,
  gdouble $max_value
)
  returns GtkLevelBar
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_remove_offset_value (
  GtkLevelBar $self,
  Str         $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_set_inverted (
  GtkLevelBar $self,
  gboolean    $inverted
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_set_max_value (
  GtkLevelBar $self,
  gdouble     $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_set_min_value (
  GtkLevelBar $self,
  gdouble     $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_set_mode (
  GtkLevelBar     $self,
  GtkLevelBarMode $mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_level_bar_set_value (
  GtkLevelBar $self,
  gdouble     $value
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GDK::Raw::Structs;
use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Popover:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkpopover.h

sub gtk_popover_get_autohide (GtkPopover $popover)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_cascade_popdown (GtkPopover $popover)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_child (GtkPopover $popover)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_has_arrow (GtkPopover $popover)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_mnemonics_visible (GtkPopover $popover)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_offset (
  GtkPopover $popover,
  gint       $x_offset is rw,
  gint       $y_offset is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_pointing_to (
  GtkPopover   $popover,
  GdkRectangle $rect
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_position (GtkPopover $popover)
  returns GtkPositionType
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_popdown (GtkPopover $popover)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_popup (GtkPopover $popover)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_present (GtkPopover $popover)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_autohide (
  GtkPopover $popover,
  gboolean   $autohide
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_cascade_popdown (
  GtkPopover $popover,
  gboolean   $cascade_popdown
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_child (
  GtkPopover $popover,
  GtkWidget  $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_default_widget (
  GtkPopover $popover,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_has_arrow (
  GtkPopover $popover,
  gboolean   $has_arrow
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_mnemonics_visible (
  GtkPopover $popover,
  gboolean   $mnemonics_visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_offset (
  GtkPopover $popover,
  gint       $x_offset,
  gint       $y_offset
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_pointing_to (
  GtkPopover   $popover,
  GdkRectangle $rect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_set_position (
  GtkPopover      $popover,
  GtkPositionType $position
)
  is      native(gtk4)
  is      export
{ * }

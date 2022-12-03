use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Scrollable;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkscrollable.h

sub gtk_scrollable_get_border (
  GtkScrollable $scrollable,
  GtkBorder     $border
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_get_hadjustment (GtkScrollable $scrollable)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_get_hscroll_policy (GtkScrollable $scrollable)
  returns GtkScrollablePolicy
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_get_vadjustment (GtkScrollable $scrollable)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_get_vscroll_policy (GtkScrollable $scrollable)
  returns GtkScrollablePolicy
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_set_hadjustment (
  GtkScrollable $scrollable,
  GtkAdjustment $hadjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_set_hscroll_policy (
  GtkScrollable       $scrollable,
  GtkScrollablePolicy $policy
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_set_vadjustment (
  GtkScrollable $scrollable,
  GtkAdjustment $vadjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollable_set_vscroll_policy (
  GtkScrollable       $scrollable,
  GtkScrollablePolicy $policy
)
  is      native(gtk4)
  is      export
{ * }

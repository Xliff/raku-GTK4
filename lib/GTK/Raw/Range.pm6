use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Range:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkrange.h

sub gtk_range_get_adjustment (GtkRange $range)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_fill_level (GtkRange $range)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_flippable (GtkRange $range)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_inverted (GtkRange $range)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_range_rect (
  GtkRange     $range,
  GdkRectangle $range_rect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_restrict_to_fill_level (GtkRange $range)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_round_digits (GtkRange $range)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_show_fill_level (GtkRange $range)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_slider_range (
  GtkRange $range,
  gint     $slider_start is rw,
  gint     $slider_end   is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_slider_size_fixed (GtkRange $range)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_get_value (GtkRange $range)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_adjustment (
  GtkRange      $range,
  GtkAdjustment $adjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_fill_level (
  GtkRange $range,
  gdouble  $fill_level
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_flippable (
  GtkRange $range,
  gboolean $flippable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_increments (
  GtkRange $range,
  gdouble  $step,
  gdouble  $page
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_inverted (
  GtkRange $range,
  gboolean $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_range (
  GtkRange $range,
  gdouble  $min,
  gdouble  $max
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_restrict_to_fill_level (
  GtkRange $range,
  gboolean $restrict_to_fill_level
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_round_digits (
  GtkRange $range,
  gint     $round_digits
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_show_fill_level (
  GtkRange $range,
  gboolean $show_fill_level
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_slider_size_fixed (
  GtkRange $range,
  gboolean $size_fixed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_range_set_value (
  GtkRange $range,
  gdouble  $value
)
  is      native(gtk4)
  is      export
{ * }

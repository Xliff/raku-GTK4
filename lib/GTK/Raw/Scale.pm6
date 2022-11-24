use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Scale:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkscale.h

sub gtk_scale_add_mark (
  GtkScale        $scale,
  gdouble         $value,
  GtkPositionType $position,
  Str             $markup
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_clear_marks (GtkScale $scale)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_digits (GtkScale $scale)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_draw_value (GtkScale $scale)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_has_origin (GtkScale $scale)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_layout (GtkScale $scale)
  returns PangoLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_layout_offsets (
  GtkScale $scale,
  gint     $x is rw,
  gint     $y is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_get_value_pos (GtkScale $scale)
  returns GtkPositionType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_new (
  GtkOrientation $orientation,
  GtkAdjustment  $adjustment
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_new_with_range (
  GtkOrientation $orientation,
  gdouble        $min,
  gdouble        $max,
  gdouble        $step
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_set_digits (
  GtkScale $scale,
  gint     $digits
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_set_draw_value (
  GtkScale $scale,
  gboolean $draw_value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_set_format_value_func (
  GtkScale $scale,
           &func (GtkScale, gdouble, gpointer --> Str),
  gpointer $user_data,
           &destroy_notify (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_set_has_origin (
  GtkScale $scale,
  gboolean $has_origin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_set_value_pos (
  GtkScale        $scale,
  GtkPositionType $pos
)
  is      native(gtk4)
  is      export
{ * }

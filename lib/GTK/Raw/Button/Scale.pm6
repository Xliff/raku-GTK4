use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Button::Scale;

### /usr/src/gtk4/gtk/gtkscalebutton.h

sub gtk_scale_button_get_adjustment (GtkScaleButton $button)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_get_minus_button (GtkScaleButton $button)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_get_plus_button (GtkScaleButton $button)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_get_popup (GtkScaleButton $button)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_get_value (GtkScaleButton $button)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_new (
  gdouble     $min,
  gdouble     $max,
  gdouble     $step,
  CArray[Str] $icons
)
  returns GtkScaleButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_set_adjustment (
  GtkScaleButton $button,
  GtkAdjustment  $adjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_set_icons (
  GtkScaleButton $button,
  CArray[Str]    $icons
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scale_button_set_value (
  GtkScaleButton $button,
  gdouble        $value
)
  is      native(gtk4)
  is      export
{ * }

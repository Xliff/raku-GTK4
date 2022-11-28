use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::SpinButton:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkspinbutton.h

sub gtk_spin_button_configure (
  GtkSpinButton $spin_button,
  GtkAdjustment $adjustment,
  gdouble       $climb_rate,
  guint         $digits
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_adjustment (GtkSpinButton $spin_button)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_climb_rate (GtkSpinButton $spin_button)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_digits (GtkSpinButton $spin_button)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_increments (
  GtkSpinButton $spin_button,
  gdouble       $step is rw,
  gdouble       $page is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_numeric (GtkSpinButton $spin_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_range (
  GtkSpinButton $spin_button,
  gdouble       $min is rw,
  gdouble       $max is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_snap_to_ticks (GtkSpinButton $spin_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_update_policy (GtkSpinButton $spin_button)
  returns GtkSpinButtonUpdatePolicy
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_value (GtkSpinButton $spin_button)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_value_as_int (GtkSpinButton $spin_button)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_get_wrap (GtkSpinButton $spin_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_new (
  GtkAdjustment $adjustment,
  gdouble       $climb_rate,
  guint         $digits
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_new_with_range (
  gdouble $min,
  gdouble $max,
  gdouble $step
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_adjustment (
  GtkSpinButton $spin_button,
  GtkAdjustment $adjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_climb_rate (
  GtkSpinButton $spin_button,
  gdouble       $climb_rate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_digits (
  GtkSpinButton $spin_button,
  guint         $digits
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_increments (
  GtkSpinButton $spin_button,
  gdouble       $step,
  gdouble       $page
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_numeric (
  GtkSpinButton $spin_button,
  gboolean      $numeric
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_range (
  GtkSpinButton $spin_button,
  gdouble       $min,
  gdouble       $max
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_snap_to_ticks (
  GtkSpinButton $spin_button,
  gboolean      $snap_to_ticks
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_update_policy (
  GtkSpinButton             $spin_button,
  GtkSpinButtonUpdatePolicy $policy
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_value (
  GtkSpinButton $spin_button,
  gdouble       $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_set_wrap (
  GtkSpinButton $spin_button,
  gboolean      $wrap
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_spin (
  GtkSpinButton $spin_button,
  GtkSpinType   $direction,
  gdouble       $increment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_spin_button_update (GtkSpinButton $spin_button)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Enums;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::ProgressBar:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkprogressbar.h

sub gtk_progress_bar_get_ellipsize (GtkProgressBar $pbar)
  returns PangoEllipsizeMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_get_fraction (GtkProgressBar $pbar)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_get_inverted (GtkProgressBar $pbar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_get_pulse_step (GtkProgressBar $pbar)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_get_show_text (GtkProgressBar $pbar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_get_text (GtkProgressBar $pbar)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_new
  returns GtkProgressBar
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_pulse (GtkProgressBar $pbar)
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_set_ellipsize (
  GtkProgressBar     $pbar,
  PangoEllipsizeMode $mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_set_fraction (
  GtkProgressBar $pbar,
  gdouble        $fraction
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_set_inverted (
  GtkProgressBar $pbar,
  gboolean       $inverted
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_set_pulse_step (
  GtkProgressBar $pbar,
  gdouble        $fraction
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_set_show_text (
  GtkProgressBar $pbar,
  gboolean       $show_text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_progress_bar_set_text (
  GtkProgressBar $pbar,
  Str            $text
)
  is      native(gtk4)
  is      export
{ * }

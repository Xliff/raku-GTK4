use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::ScrolledWindow:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkscrolledwindow.h

sub gtk_scrolled_window_get_child (GtkScrolledWindow $scrolled_window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_hadjustment (GtkScrolledWindow $scrolled_window)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_has_frame (GtkScrolledWindow $scrolled_window)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_hscrollbar (GtkScrolledWindow $scrolled_window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_kinetic_scrolling (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_max_content_height (
  GtkScrolledWindow $scrolled_window
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_max_content_width (
  GtkScrolledWindow $scrolled_window
 )
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_min_content_height (
  GtkScrolledWindow $scrolled_window
 )
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_min_content_width (
  GtkScrolledWindow $scrolled_window
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_overlay_scrolling (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_placement (GtkScrolledWindow $scrolled_window)
  returns GtkCornerType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_policy (
  GtkScrolledWindow $scrolled_window,
  GtkPolicyType     $hscrollbar_policy,
  GtkPolicyType     $vscrollbar_policy
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_propagate_natural_height (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_propagate_natural_width (
  GtkScrolledWindow $scrolled_window
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_vadjustment (
  GtkScrolledWindow $scrolled_window
)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_get_vscrollbar (GtkScrolledWindow $scrolled_window)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_new
  returns GtkScrolledWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_child (
  GtkScrolledWindow $scrolled_window,
  GtkWidget         $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_hadjustment (
  GtkScrolledWindow $scrolled_window,
  GtkAdjustment     $hadjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_has_frame (
  GtkScrolledWindow $scrolled_window,
  gboolean          $has_frame
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_kinetic_scrolling (
  GtkScrolledWindow $scrolled_window,
  gboolean          $kinetic_scrolling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_max_content_height (
  GtkScrolledWindow $scrolled_window,
  gint              $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_max_content_width (
  GtkScrolledWindow $scrolled_window,
  gint              $width
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_min_content_height (
  GtkScrolledWindow $scrolled_window,
  gint              $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_min_content_width (
  GtkScrolledWindow $scrolled_window,
  gint              $width
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_overlay_scrolling (
  GtkScrolledWindow $scrolled_window,
  gboolean          $overlay_scrolling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_placement (
  GtkScrolledWindow $scrolled_window,
  GtkCornerType     $window_placement
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_policy (
  GtkScrolledWindow $scrolled_window,
  GtkPolicyType     $hscrollbar_policy,
  GtkPolicyType     $vscrollbar_policy
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_propagate_natural_height (
  GtkScrolledWindow $scrolled_window,
  gboolean          $propagate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_propagate_natural_width (
  GtkScrolledWindow $scrolled_window,
  gboolean          $propagate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_set_vadjustment (
  GtkScrolledWindow $scrolled_window,
  GtkAdjustment     $vadjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrolled_window_unset_placement (GtkScrolledWindow $scrolled_window)
  is      native(gtk4)
  is      export
{ * }

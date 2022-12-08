use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Panes:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkpaned.h

sub gtk_paned_get_end_child (GtkPaned $paned)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_position (GtkPaned $paned)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_resize_end_child (GtkPaned $paned)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_resize_start_child (GtkPaned $paned)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_shrink_end_child (GtkPaned $paned)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_shrink_start_child (GtkPaned $paned)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_start_child (GtkPaned $paned)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_get_wide_handle (GtkPaned $paned)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_new (GtkOrientation $orientation)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_end_child (GtkPaned  $paned, GtkWidget $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_position (GtkPaned $paned, gint $position)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_resize_end_child  GtkPaned $paned, gboolean $resize
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_resize_start_child (GtkPaned $paned, gboolean $resize)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_shrink_end_child (GtkPaned $paned, gboolean $resize)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_shrink_start_child (GtkPaned $paned, gboolean $resize)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_start_child (GtkPaned  $paned, GtkWidget $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_paned_set_wide_handle (GtkPaned $paned, gboolean $wide)
  is      native(gtk4)
  is      export
{ * }

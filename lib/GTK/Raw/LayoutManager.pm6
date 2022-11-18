use v6.c;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::LayoutManager:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtklayoutmanager.h

sub gtk_layout_manager_allocate (
  GtkLayoutManager $manager,
  GtkWidget        $widget,
  gint             $width,
  gint             $height,
  gint             $baseline
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_layout_manager_get_layout_child (
  GtkLayoutManager $manager,
  GtkWidget        $child
)
  returns GtkLayoutChild
  is      native(gtk4)
  is      export
{ * }

sub gtk_layout_manager_get_request_mode (GtkLayoutManager $manager)
  returns GtkSizeRequestMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_layout_manager_get_widget (GtkLayoutManager $manager)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_layout_manager_layout_changed (GtkLayoutManager $manager)
  is      native(gtk4)
  is      export
{ * }

sub gtk_layout_manager_measure (
  GtkLayoutManager $manager,
  GtkWidget        $widget,
  GtkOrientation   $orientation,
  gint             $for_size,
  gint             $minimum          is rw,
  gint             $natural          is rw,
  gint             $minimum_baseline is rw,
  gint             $natural_baseline is rw
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::CenterLayout;

### /usr/src/gtk4/gtk/gtkcenterlayout.h

sub gtk_center_layout_get_baseline_position (GtkCenterLayout $self)
  returns GtkBaselinePosition
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_get_center_widget (GtkCenterLayout $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_get_end_widget (GtkCenterLayout $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_get_orientation (GtkCenterLayout $self)
  returns GtkOrientation
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_get_start_widget (GtkCenterLayout $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_new
  returns GtkCenterLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_set_baseline_position (
  GtkCenterLayout     $self,
  GtkBaselinePosition $baseline_position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_set_center_widget (
  GtkCenterLayout $self,
  GtkWidget       $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_set_end_widget (
  GtkCenterLayout $self,
  GtkWidget       $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_set_orientation (
  GtkCenterLayout $self,
  GtkOrientation  $orientation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_layout_set_start_widget (
  GtkCenterLayout $self,
  GtkWidget       $widget
)
  is      native(gtk4)
  is      export
{ * }

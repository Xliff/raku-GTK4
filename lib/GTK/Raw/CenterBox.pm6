use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::CenterBox:ver<4>;

### /usr/src/gtk4/gtk/gtkcenterbox.h

sub gtk_center_box_get_baseline_position (GtkCenterBox $self)
  returns GtkBaselinePosition
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_get_center_widget (GtkCenterBox $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_get_end_widget (GtkCenterBox $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_get_start_widget (GtkCenterBox $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_set_baseline_position (
  GtkCenterBox        $self,
  GtkBaselinePosition $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_set_center_widget (
  GtkCenterBox $self,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_set_end_widget (
  GtkCenterBox $self,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_center_box_set_start_widget (
  GtkCenterBox $self,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

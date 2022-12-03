use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::GridView;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkgridview.h

sub gtk_grid_view_get_enable_rubberband (GtkGridView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_get_factory (GtkGridView $self)
  returns GtkListItemFactory
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_get_max_columns (GtkGridView $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_get_min_columns (GtkGridView $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_get_model (GtkGridView $self)
  returns GtkSelectionModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_get_single_click_activate (GtkGridView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_new (
  GtkSelectionModel  $model,
  GtkListItemFactory $factory
)
  returns GtkGridView
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_set_enable_rubberband (
  GtkGridView $self,
  gboolean    $enable_rubberband
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_set_factory (
  GtkGridView        $self,
  GtkListItemFactory $factory
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_set_max_columns (
  GtkGridView $self,
  guint       $max_columns
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_set_min_columns (
  GtkGridView $self,
  guint       $min_columns
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_set_model (
  GtkGridView       $self,
  GtkSelectionModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_grid_view_set_single_click_activate (
  GtkGridView $self,
  gboolean    $single_click_activate
)
  is      native(gtk4)
  is      export
{ * }

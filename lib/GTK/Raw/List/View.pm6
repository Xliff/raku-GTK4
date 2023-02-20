use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::List::View:ver<4>;

### /usr/src/gtk4/gtk/gtklistview.h

sub gtk_list_view_get_enable_rubberband (GtkListView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_get_factory (GtkListView $self)
  returns GtkListItemFactory
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_get_model (GtkListView $self)
  returns GtkSelectionModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_get_show_separators (GtkListView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_get_single_click_activate (GtkListView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_new (
  GtkSelectionModel  $model,
  GtkListItemFactory $factory
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_set_enable_rubberband (
  GtkListView $self,
  gboolean    $enable_rubberband
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_set_factory (
  GtkListView        $self,
  GtkListItemFactory $factory
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_set_model (
  GtkListView       $self,
  GtkSelectionModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_set_show_separators (
  GtkListView $self,
  gboolean    $show_separators
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_view_set_single_click_activate (
  GtkListView $self,
  gboolean    $single_click_activate
)
  is      native(gtk4)
  is      export
{ * }

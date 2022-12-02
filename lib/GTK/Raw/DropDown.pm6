use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::DropDown:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkdropdown.h

sub gtk_drop_down_get_enable_search (GtkDropDown $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_expression (GtkDropDown $self)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_factory (GtkDropDown $self)
  returns GtkListItemFactory
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_list_factory (GtkDropDown $self)
  returns GtkListItemFactory
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_model (GtkDropDown $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_selected (GtkDropDown $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_selected_item (GtkDropDown $self)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_get_show_arrow (GtkDropDown $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_new (
  GListModel    $model,
  GtkExpression $expression
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_new_from_strings (CArray[Str] $strings)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_enable_search (
  GtkDropDown $self,
  gboolean    $enable_search
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_expression (
  GtkDropDown   $self,
  GtkExpression $expression
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_factory (
  GtkDropDown        $self,
  GtkListItemFactory $factory
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_list_factory (
  GtkDropDown        $self,
  GtkListItemFactory $factory
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_model (
  GtkDropDown $self,
  GListModel  $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_selected (
  GtkDropDown $self,
  guint       $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_down_set_show_arrow (
  GtkDropDown $self,
  gboolean    $show_arrow
)
  is      native(gtk4)
  is      export
{ * }

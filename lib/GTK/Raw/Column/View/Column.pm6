use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Column::View::Column:ver<4>;

### /usr/src/gtk4/gtk/gtkcolumnviewcolumn.h

sub gtk_column_view_column_get_column_view (GtkColumnViewColumn $self)
  returns GtkColumnView
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_expand (GtkColumnViewColumn $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_factory (GtkColumnViewColumn $self)
  returns GtkListItemFactory
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_fixed_width (GtkColumnViewColumn $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_header_menu (GtkColumnViewColumn $self)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_id (GtkColumnViewColumn $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_resizable (GtkColumnViewColumn $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_sorter (GtkColumnViewColumn $self)
  returns GtkSorter
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_title (GtkColumnViewColumn $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_get_visible (GtkColumnViewColumn $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_new (
  Str                $title,
  GtkListItemFactory $factory
)
  returns GtkColumnViewColumn
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_expand (
  GtkColumnViewColumn $self,
  gboolean            $expand
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_factory (
  GtkColumnViewColumn $self,
  GtkListItemFactory  $factory
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_fixed_width (
  GtkColumnViewColumn $self,
  gint                $fixed_width
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_header_menu (
  GtkColumnViewColumn $self,
  GMenuModel          $menu
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_id (
  GtkColumnViewColumn $self,
  Str                 $id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_resizable (
  GtkColumnViewColumn $self,
  gboolean            $resizable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_sorter (
  GtkColumnViewColumn $self,
  GtkSorter           $sorter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_title (
  GtkColumnViewColumn $self,
  Str                 $title
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_column_set_visible (
  GtkColumnViewColumn $self,
  gboolean            $visible
)
  is      native(gtk4)
  is      export
{ * }

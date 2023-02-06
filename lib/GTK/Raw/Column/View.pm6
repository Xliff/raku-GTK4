use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Column::View:ver<4>;

### /usr/src/gtk4/gtk/gtkcolumnview.h

sub gtk_column_view_append_column (
  GtkColumnView       $self,
  GtkColumnViewColumn $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_columns (GtkColumnView $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_enable_rubberband (GtkColumnView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_model (GtkColumnView $self)
  returns GtkSelectionModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_reorderable (GtkColumnView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_show_column_separators (GtkColumnView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_show_row_separators (GtkColumnView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_single_click_activate (GtkColumnView $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_sorter (GtkColumnView $self)
  returns GtkSorter
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_insert_column (
  GtkColumnView       $self,
  guint               $position,
  GtkColumnViewColumn $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_new (GtkSelectionModel $model)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_remove_column (
  GtkColumnView       $self,
  GtkColumnViewColumn $column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_set_enable_rubberband (
  GtkColumnView $self,
  gboolean      $enable_rubberband
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_set_model (
  GtkColumnView     $self,
  GtkSelectionModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_set_reorderable (
  GtkColumnView $self,
  gboolean      $reorderable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_set_show_column_separators (
  GtkColumnView $self,
  gboolean      $show_column_separators
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_set_show_row_separators (
  GtkColumnView $self,
  gboolean      $show_row_separators
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_set_single_click_activate (
  GtkColumnView $self,
  gboolean      $single_click_activate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_column_view_sort_by_column (
  GtkColumnView       $self,
  GtkColumnViewColumn $column,
  GtkSortType         $direction
)
  is      native(gtk4)
  is      export
{ * }

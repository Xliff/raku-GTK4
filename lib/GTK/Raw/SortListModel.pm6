use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::SortListModel;

### /usr/src/gtk4/gtk/gtksortlistmodel.h

sub gtk_sort_list_model_get_incremental (GtkSortListModel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_get_model (GtkSortListModel $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_get_pending (GtkSortListModel $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_get_sorter (GtkSortListModel $self)
  returns GtkSorter
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_new (
  GListModel $model,
  GtkSorter  $sorter
)
  returns GtkSortListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_set_incremental (
  GtkSortListModel $self,
  gboolean         $incremental
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_set_model (
  GtkSortListModel $self,
  GListModel       $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_sort_list_model_set_sorter (
  GtkSortListModel $self,
  GtkSorter        $sorter
)
  is      native(gtk4)
  is      export
{ * }

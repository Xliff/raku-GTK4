use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::FilterListModel;

### /usr/src/gtk4/gtk/gtkfilterlistmodel.h

sub gtk_filter_list_model_get_filter (GtkFilterListModel $self)
  returns GtkFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_get_incremental (GtkFilterListModel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_get_model (GtkFilterListModel $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_get_pending (GtkFilterListModel $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_new (
  GListModel $model,
  GtkFilter  $filter
)
  returns GtkFilterListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_set_filter (
  GtkFilterListModel $self,
  GtkFilter          $filter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_set_incremental (
  GtkFilterListModel $self,
  gboolean           $incremental
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_list_model_set_model (
  GtkFilterListModel $self,
  GListModel         $model
)
  is      native(gtk4)
  is      export
{ * }

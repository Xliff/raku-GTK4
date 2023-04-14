use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::SliceListModel:ver<4>;

### /usr/src/gtk4/gtk/gtkslicelistmodel.h

sub gtk_slice_list_model_get_model (GtkSliceListModel $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_slice_list_model_get_offset (GtkSliceListModel $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_slice_list_model_get_size (GtkSliceListModel $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_slice_list_model_new (
  GListModel $model,
  guint      $offset,
  guint      $size
)
  returns GtkSliceListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_slice_list_model_set_model (
  GtkSliceListModel $self,
  GListModel        $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_slice_list_model_set_offset (
  GtkSliceListModel $self,
  guint             $offset
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_slice_list_model_set_size (
  GtkSliceListModel $self,
  guint             $size
)
  is      native(gtk4)
  is      export
{ * }

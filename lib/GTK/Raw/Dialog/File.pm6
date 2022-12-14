use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog::File;

### /usr/src/gtk4/gtk/gtkfiledialog.h

sub gtk_file_dialog_get_current_filter (GtkFileDialog $self)
  returns GtkFileFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_get_current_folder (GtkFileDialog $self)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_get_filters (GtkFileDialog $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_get_modal (GtkFileDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_get_shortcut_folders (GtkFileDialog $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_get_title (GtkFileDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_new
  returns GtkFileDialog
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_open (
  GtkFileDialog       $self,
  GtkWindow           $parent,
  GFile               $current_file,
  GCancellable        $cancellable,
                      &callback (GtkFileDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_open_finish (
  GtkFileDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_open_multiple (
  GtkFileDialog       $self,
  GtkWindow           $parent,
  GCancellable        $cancellable,
                      &callback (GtkFileDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_open_multiple_finish (
  GtkFileDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_save (
  GtkFileDialog       $self,
  GtkWindow           $parent,
  GFile               $current_file,
  Str                 $current_name,
  GCancellable        $cancellable,
                      &callback (GtkFileDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_save_finish (
  GtkFileDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_select_folder (
  GtkFileDialog       $self,
  GtkWindow           $parent,
  GFile               $current_folder,
  GCancellable        $cancellable,
                      &callback (GtkFileDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_select_folder_finish (
  GtkFileDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_select_multiple_folders (
  GtkFileDialog       $self,
  GtkWindow           $parent,
  GCancellable        $cancellable,
                      &callback (GtkFileDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_select_multiple_folders_finish (
  GtkFileDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_set_current_filter (
  GtkFileDialog $self,
  GtkFileFilter $filter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_set_current_folder (
  GtkFileDialog $self,
  GFile         $folder
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_set_filters (
  GtkFileDialog $self,
  GListModel    $filters
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_set_modal (
  GtkFileDialog $self,
  gboolean      $modal
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_set_shortcut_folders (
  GtkFileDialog $self,
  GListModel    $shortcut_folders
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_dialog_set_title (
  GtkFileDialog $self,
  Str           $title
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::DirectoryList;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkdirectorylist.h

sub gtk_directory_list_get_attributes (GtkDirectoryList $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_get_error (GtkDirectoryList $self)
  returns GError
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_get_file (GtkDirectoryList $self)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_get_io_priority (GtkDirectoryList $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_get_monitored (GtkDirectoryList $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_is_loading (GtkDirectoryList $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_new (
  Str   $attributes,
  GFile $file
)
  returns GtkDirectoryList
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_set_attributes (
  GtkDirectoryList $self,
  Str              $attributes
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_set_file (
  GtkDirectoryList $self,
  GFile            $file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_set_io_priority (
  GtkDirectoryList $self,
  gint             $io_priority
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_directory_list_set_monitored (
  GtkDirectoryList $self,
  gboolean         $monitored
)
  is      native(gtk4)
  is      export
{ * }

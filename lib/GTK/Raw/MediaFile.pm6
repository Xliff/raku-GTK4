use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::MediaFile:ver<4>;

### /usr/src/gtk4/gtk/gtkmediafile.h

sub gtk_media_file_clear (GtkMediaFile $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_get_file (GtkMediaFile $self)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_get_input_stream (GtkMediaFile $self)
  returns GInputStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_new
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_new_for_file (GFile $file)
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_new_for_filename (Str $filename)
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_new_for_input_stream (GInputStream $stream)
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_new_for_resource (Str $resource_path)
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_set_file (
  GtkMediaFile $self,
  GFile        $file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_set_filename (
  GtkMediaFile $self,
  Str          $filename
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_set_input_stream (
  GtkMediaFile $self,
  GInputStream $stream
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_file_set_resource (
  GtkMediaFile $self,
  Str          $resource_path
)
  is      native(gtk4)
  is      export
{ * }

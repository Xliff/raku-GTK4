use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Video:ver<4>;

### /usr/src/gtk4/gtk/gtkvideo.h

sub gtk_video_get_autoplay (GtkVideo $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_get_file (GtkVideo $self)
  returns GFile
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_get_loop (GtkVideo $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_get_media_stream (GtkVideo $self)
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_new_for_file (GFile $file)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_new_for_filename (Str $filename)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_new_for_media_stream (GtkMediaStream $stream)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_new_for_resource (Str $resource_path)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_set_autoplay (
  GtkVideo $self,
  gboolean $autoplay
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_set_file (
  GtkVideo $self,
  GFile    $file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_set_filename (
  GtkVideo $self,
  Str      $filename
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_set_loop (
  GtkVideo $self,
  gboolean $loop
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_set_media_stream (
  GtkVideo       $self,
  GtkMediaStream $stream
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_video_set_resource (
  GtkVideo $self,
  Str      $resource_path
)
  is      native(gtk4)
  is      export
{ * }

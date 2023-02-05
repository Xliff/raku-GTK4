use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::MediaStream:ver<4>;

### /usr/src/gtk4/gtk/gtkmediastream.h

sub gtk_media_stream_ended (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_error (
  GtkMediaStream $self,
  GQuark         $domain,
  gint           $code,
  Str            $format,
  Str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_gerror (
  GtkMediaStream  $self,
  GError          $error
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_duration (GtkMediaStream $self)
  returns gint64
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_ended (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_error (GtkMediaStream $self)
  returns GError
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_loop (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_muted (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_playing (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_timestamp (GtkMediaStream $self)
  returns gint64
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_volume (GtkMediaStream $self)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_has_audio (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_has_video (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_is_prepared (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_is_seekable (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_is_seeking (GtkMediaStream $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_pause (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_play (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_prepared (
  GtkMediaStream $self,
  gboolean       $has_audio,
  gboolean       $has_video,
  gboolean       $seekable,
  gint64         $duration
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_realize (
  GtkMediaStream $self,
  GdkSurface     $surface
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_seek (
  GtkMediaStream $self,
  gint64         $timestamp
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_seek_failed (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_seek_success (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_set_loop (
  GtkMediaStream $self,
  gboolean       $loop
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_set_muted (
  GtkMediaStream $self,
  gboolean       $muted
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_set_playing (
  GtkMediaStream $self,
  gboolean       $playing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_set_volume (
  GtkMediaStream $self,
  gdouble        $volume
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_stream_ended (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_stream_prepared (
  GtkMediaStream $self,
  gboolean       $has_audio,
  gboolean       $has_video,
  gboolean       $seekable,
  gint64         $duration
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_stream_unprepared (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_unprepared (GtkMediaStream $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_unrealize (
  GtkMediaStream $self,
  GdkSurface     $surface
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_update (
  GtkMediaStream $self,
  gint64         $timestamp
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_stream_get_type ()
  returns GType
  is      native(gtk4)
  is      export
{ * }

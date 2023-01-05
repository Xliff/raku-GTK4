use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::MediaStream:ver<4>;

use GLib::Roles::Object;
use GDK::Roles::Paintable:ver<4>;

our subset GtkMediaStreamAncestry is export of Mu
  where GtkMediaStream | GdkPaintable | GObject;

class GTK::MediaStream:ver<4> {
  also does GLib::Roles::Object;
  also does GDK::Roles::Paintable;

  has GtkMediaStream $!gtk-ms is implementor;

  submethod BUILD ( :$gtk-media-stream ) {
    self.setGtkMediaStream($gtk-media-stream) if $gtk-media-stream
  }

  method setGtkMediaStream (GtkMediaStreamAncestry $_) {
    my $to-parent;

    $!gtk-ms = do {
      when GtkMediaStream {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GdkPaintable {
        $!gdk-p    = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkMediaStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkMediaStream, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GdkPaintable;
  }

  method GTK::Raw::Definitions::GtkMediaStream
    is also<GdkMediaStream>
  { $!gtk-ms }

  multi method new (
     $gtk-media-stream where * ~~ GtkMediaStreamAncestry,

    :$ref = True
  ) {
    return unless $gtk-media-stream;

    my $o = self.bless( :$gtk-media-stream );
    $o.ref if $ref;
    $o;
  }

  # Type: int64
  method duration is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('duration', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'duration does not allow writing'
      }
    );
  }

  # Type: boolean
  multi method ended is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ended', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'ended does not allow writing'
      }
    );
  }

  # Type: GtkError
  multi method error is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Error.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('error', $gv);
        cast(GError, $gv.pointer);
      },
      STORE => -> $,  $val is copy {
        warn 'error does not allow writing'
      }
    );
  }

  # Type: boolean
  proto method has_audio (|)
    is also<has-audio>
  { * }

  multi method has_audio is rw is g-property  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-audio', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-audio does not allow writing'
      }
    );
  }

  # Type: boolean
  proto method has_video
    is also<has-video>
  { * }

  multi method has_video is rw  is g-property  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-video', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-video does not allow writing'
      }
    );
  }

  # Type: boolean
  method loop is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('loop', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('loop', $gv);
      }
    );
  }

  # Type: boolean
  method muted is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('muted', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('muted', $gv);
      }
    );
  }

  # Type: boolean
  method playing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('playing', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('playing', $gv);
      }
    );
  }

  # Type: boolean
  multi method prepared is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('prepared', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('prepared', $gv);
      }
    );
  }

  # Type: boolean
  method seekable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('seekable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'seekable does not allow writing'
      }
    );
  }

  # Type: boolean
  method seeking is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('seeking', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'seeking does not allow writing'
      }
    );
  }

  # Type: int64
  method timestamp is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('timestamp', $gv);
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        warn 'timestamp does not allow writing'
      }
    );
  }

  # Type: double
  method volume is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('volume', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('volume', $gv);
      }
    );
  }


  multi method ended ( :$method is required ) {
    so gtk_media_stream_ended($!gtk-ms);
  }

  multi method error (GQuark() $domain, Int() $code, Str() $format) {
    my gint $c = $code;

    gtk_media_stream_error($!gtk-ms, $domain, $code, $format, Str);
  }

  method gerror (GError() $error) {
    gtk_media_stream_gerror($!gtk-ms, $error);
  }

  method get_duration is also<get-duration> {
    gtk_media_stream_get_duration($!gtk-ms);
  }

  method get_ended is also<get-ended> {
    so gtk_media_stream_get_ended($!gtk-ms);
  }

  method get_error is also<get-error> {
    gtk_media_stream_get_error($!gtk-ms);
  }

  method get_loop is also<get-loop> {
    so gtk_media_stream_get_loop($!gtk-ms);
  }

  method get_muted is also<get-muted> {
    so gtk_media_stream_get_muted($!gtk-ms);
  }

  method get_playing is also<get-playing> {
    so gtk_media_stream_get_playing($!gtk-ms);
  }

  method get_timestamp is also<get-timestamp> {
    gtk_media_stream_get_timestamp($!gtk-ms);
  }

  method get_volume is also<get-volume> {
    gtk_media_stream_get_volume($!gtk-ms);
  }

  multi method has_audio ( :$method is required ) {
    so gtk_media_stream_has_audio($!gtk-ms);
  }

  multi method has_video ( :$method is required ) {
    so gtk_media_stream_has_video($!gtk-ms);
  }

  method is_prepared is also<is-prepared> {
    so gtk_media_stream_is_prepared($!gtk-ms);
  }

  method is_seekable is also<is-seekable> {
    so gtk_media_stream_is_seekable($!gtk-ms);
  }

  method is_seeking is also<is-seeking> {
    so gtk_media_stream_is_seeking($!gtk-ms);
  }

  method pause {
    gtk_media_stream_pause($!gtk-ms);
  }

  method play {
    gtk_media_stream_play($!gtk-ms);
  }

  multi method prepared (
    Int() $has_audio,
    Int() $has_video,
    Int() $seekable,
    Int() $duration
  ) {
    my gboolean ($a, $v, $s) = ($has_audio, $has_video, $seekable)».so.Int;
    my gint64    $d          =  $duration;

    gtk_media_stream_prepared($!gtk-ms, $a, $v, $s, $d);
  }

  method realize (GdkSurface() $surface) {
    gtk_media_stream_realize($!gtk-ms, $surface);
  }

  method seek (Int() $timestamp) {
    my gint64 $t = $timestamp;

    gtk_media_stream_seek($!gtk-ms, $t);
  }

  method seek_failed is also<seek-failed> {
    gtk_media_stream_seek_failed($!gtk-ms);
  }

  method seek_success is also<seek-success> {
    gtk_media_stream_seek_success($!gtk-ms);
  }

  method set_loop (Int() $loop) is also<set-loop> {
    my gboolean $l = $loop.so.Int;

    gtk_media_stream_set_loop($!gtk-ms, $l);
  }

  method set_muted (Int() $muted) is also<set-muted> {
    my gboolean $m = $muted.so.Int;

    gtk_media_stream_set_muted($!gtk-ms, $m);
  }

  method set_playing (Int() $playing) is also<set-playing> {
    my gboolean $p = $playing.so.Int;

    gtk_media_stream_set_playing($!gtk-ms, $p);
  }

  method set_volume (Num() $volume) is also<set-volume> {
    my gdouble $v = $volume;

    gtk_media_stream_set_volume($!gtk-ms, $v);
  }

  method stream_ended is also<stream-ended> {
    gtk_media_stream_stream_ended($!gtk-ms);
  }

  method stream_prepared (
    Int() $has_audio,
    Int() $has_video,
    Int() $seekable,
    Int() $duration
  )
    is also<stream-prepared>
  {
    my gboolean ($a, $v, $s) = ($has_audio, $has_video, $seekable)».so.Int;
    my gint64    $d          =  $duration;

    gtk_media_stream_stream_prepared($!gtk-ms, $a, $v, $s, $d);
  }

  method stream_unprepared is also<stream-unprepared> {
    gtk_media_stream_stream_unprepared($!gtk-ms);
  }

  method unprepared {
    gtk_media_stream_unprepared($!gtk-ms);
  }

  method unrealize (GdkSurface() $surface) {
    gtk_media_stream_unrealize($!gtk-ms, $surface);
  }

  method update (Int() $timestamp) {
    my gint64 $t = $timestamp;

    gtk_media_stream_update($!gtk-ms, $t);
  }
}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Video:ver<4>;

use GTK::MediaStream:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GIO::Roles::GFile;

our subset GtkVideoAncestry is export of Mu
  where GtkVideo | GtkWidgetAncestry;

class GTK::Video:ver<4> is GTK::Widget:ver<4> {
  has GtkVideo $!gtk-vid is implementor;

  submethod BUILD ( :$gtk-video ) {
    self.setGtkVideo($gtk-video) if $gtk-video
  }

  method setGtkVideo (GtkVideoAncestry $_) {
    my $to-parent;

    $!gtk-vid = do {
      when GtkVideo {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkVideo, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkVideo
    is also<GtkVideo>
  { $!gtk-vid }

  multi method new ($gtk-video where * ~~ GtkVideoAncestry, :$ref = True) {
    return unless $gtk-video;

    my $o = self.bless( :$gtk-video );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-video = gtk_video_new();

    $gtk-video ?? self.bless( :$gtk-video ) !! Nil;
  }

  method new_for_file (GFile() $file) is also<new-for-file> {
    my $gtk-video = gtk_video_new_for_file($file);

    $gtk-video ?? self.bless( :$gtk-video ) !! Nil;
  }

  method new_for_filename (Str() $filename) is also<new-for-filename> {
    my $gtk-video = gtk_video_new_for_filename($filename);

    $gtk-video ?? self.bless( :$gtk-video ) !! Nil;
  }

  method new_for_media_stream (GtkMediaStream() $stream) {
    my $gtk-video = gtk_video_new_for_media_stream($$stream);

    $gtk-video ?? self.bless( :$gtk-video ) !! Nil;
  }

  method new_for_resource (Str() $resource_path)
    is also<new-for-media-stream>
  {
    my $gtk-video = gtk_video_new_for_resource($resource_path);

    $gtk-video ?? self.bless( :$gtk-video ) !! Nil;
  }

  # Type: boolean
  method autoplay is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('autoplay', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('autoplay', $gv);
      }
    );
  }

  # Type: GFile
  method file ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::File.getTypePair
        );
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
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

  # Type: GtkMediaStream
  method media-stream ( :$raw = False )
    is rw
    is g-property
    is also<media_stream>
  {
    my $gv = GLib::Value.new( GTK::MediaStream.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('media-stream', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::MediaStream.getTypePair
        )
      },
      STORE => -> $, GtkMediaStream() $val is copy {
        $gv.object = $val;
        self.prop_set('media-stream', $gv);
      }
    );
  }

  method get_autoplay is also<get-autoplay> {
    so gtk_video_get_autoplay($!gtk-vid);
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      gtk_video_get_file($!gtk-vid),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_loop is also<get-loop> {
    so gtk_video_get_loop($!gtk-vid);
  }

  method get_media_stream ( :$raw = False ) is also<get-media-stream> {
    propReturnObject(
      gtk_video_get_media_stream($!gtk-vid),
      $raw,
      |GTK::MediaStream.getTypePair
    );
  }

  method set_autoplay (Int() $autoplay) is also<set-autoplay> {
    my gboolean $a = $autoplay.so.Int;

    gtk_video_set_autoplay($!gtk-vid, $a);
  }

  method set_file (GFile() $file) is also<set-file> {
    gtk_video_set_file($!gtk-vid, $file);
  }

  method set_filename (Str() $filename) is also<set-filename> {
    gtk_video_set_filename($!gtk-vid, $filename);
  }

  method set_loop (Int() $loop) is also<set-loop> {
    my gboolean $l = $loop.so.Int;

    gtk_video_set_loop($!gtk-vid, $l);
  }

  method set_media_stream (GtkMediaStream() $stream)
    is also<set-media-stream>
  {
    gtk_video_set_media_stream($!gtk-vid, $stream);
  }

  method set_resource (Str() $resource_path) is also<set-resource> {
    gtk_video_set_resource($!gtk-vid, $resource_path);
  }

}

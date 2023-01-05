use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::MediaFile:ver<4>;

use GTK::MediaStream:ver<4>;

use GLib::Roles::Implementor;
use GIO::Roles::GFile;

class GTK::MediaFile:ver<4> is GTK::MediaStream:ver<4> {
  has GtkMediaFile $!gtk-mf is implementor;

  method new {
    my $gtk-media-file = gtk_media_file_new();

    $gtk-media-file ?? self.bless( :$gtk-media-file ) !! Nil;
  }

  method new_for_file (GFile() $file) {
    my $gtk-media-file = gtk_media_file_new_for_file($file);

    $gtk-media-file ?? self.bless( :$gtk-media-file ) !! Nil;
  }

  method new_for_filename (Str() $filename) {
    my $gtk-media-file = gtk_media_file_new_for_filename($filename);

    $gtk-media-file ?? self.bless( :$gtk-media-file ) !! Nil;
  }

  method new_for_input_stream (GInputStream() $stream) {
    my $gtk-media-file = gtk_media_file_new_for_input_stream($stream);

    $gtk-media-file ?? self.bless( :$gtk-media-file ) !! Nil;
  }

  method new_for_resource (Str() $resource_path) {
    my $gtk-media-file = gtk_media_file_new_for_resource($resource_path);

    $gtk-media-file ?? self.bless( :$gtk-media-file ) !! Nil;
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

  # Type: GtkInputStream
  method input-stream ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::InputStream.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-stream', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::InputStream.getTypePair
        );
      },
      STORE => -> $, GInputStream() $val is copy {
        $gv.object = $val;
        self.prop_set('input-stream', $gv);
      }
    );
  }

  method clear {
    gtk_media_file_clear($!gtk-mf);
  }

  method get_file ( :$raw = False ) {
    propReturnObject(
      gtk_media_file_get_file($!gtk-mf),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_input_stream ( :$raw = False ) {
    propReturnObject(
      gtk_media_file_get_input_stream($!gtk-mf),
      $raw,
      |GIO::InputStream.getTypePair
    );
  }

  method set_file (GFile() $file) {
    gtk_media_file_set_file($!gtk-mf, $file);
  }

  method set_filename (Str() $filename) {
    gtk_media_file_set_filename($!gtk-mf, $filename);
  }

  method set_input_stream (GInputStream() $stream) {
    gtk_media_file_set_input_stream($!gtk-mf, $stream);
  }

  method set_resource (Str() $resource_path) {
    gtk_media_file_set_resource($!gtk-mf, $resource_path);
  }

}

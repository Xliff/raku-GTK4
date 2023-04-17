use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkMediaControlsAncestry is export of Mu
  where GtkMediaControls | GtkWidgetAncestry;

class GTK::Media::Controls:ver<4> is GTK::Widget:ver<4> {
  has GtkMediaControls $!gtk-mc is implementor;

  submethod BUILD ( :$gtk-media-controls ) {
    self.setGtkMediaControls($gtk-media-controls) if $gtk-media-controls;
  }

  method setGtkMediaControls (GtkMediaControlsAncestry $_) {
    my $to-parent;

    $!gtk-mc = do {
      when GtkMediaControls {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMediaControls, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkMediaControls
    is also<GtkMediaControls>
  { $!gtk-mc }

  multi method new (
    $gtk-media-controls where * ~~ GtkMediaControlsAncestry,

    :$ref = True
  ) {
    return unless $gtk-media-controls;

    my $o = self.bless( :$gtk-media-controls );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkMediaStream() $stream) {
    my $gtk-media-controls = gtk_media_controls_new($stream);

    $gtk-media-controls ?? self.bless( :$gtk-media-controls ) !! Nil;
  }
  multi method new ( *%a ) {
    # cw: -YYY- Exception needs to be typed!
    die "Cannot specify <media-stream> and <media_stream> in the same {
         ''}call to Media::Controls.new"
    if %a<media-stream> && %a<media_stream>;

    my GtkMediaStream() $stream = ( %a<media-stream>:delete ) //
                                  ( %a<media_stream>:delete );

    my $o = samewith($stream);
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkMediaStream
  method media-stream ( :$raw = False )
    is rw
    is g-property
    is also<media_stream>
  {
    my $gv = GLib::Value.new( GTK::Media::Stream.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('media-stream', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Media::Controls.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        $gv.GtkMediaStream = $val;
        self.prop_set('media-stream', $gv);
      }
    );
  }

  method get_media_stream ( :$raw = False ) is also<get-media-stream> {
    propReturnObject(
      gtk_media_controls_get_media_stream($!gtk-mc),
      $raw,
      |GTK::Media::Stream.getTypePair
    );
  }

  method set_media_stream (GtkMediaStream() $stream)
    is also<set-media-stream>
  {
    gtk_media_controls_set_media_stream($!gtk-mc, $stream);
  }

}


### /usr/src/gtk4/gtk/gtkmediacontrols.h

sub gtk_media_controls_get_media_stream (GtkMediaControls $controls)
  returns GtkMediaStream
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_controls_new (GtkMediaStream $stream)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_media_controls_set_media_stream (
  GtkMediaControls $controls,
  GtkMediaStream   $stream
)
  is      native(gtk4)
  is      export
{ * }

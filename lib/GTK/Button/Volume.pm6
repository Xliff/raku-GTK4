use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Button::Scale:ver<4>;

our subset GtkVolumeButtonAncestry is export of Mu
  where GtkVolumeButton | GtkScaleButtonAncestry;

class GTK::VolumeButton:ver<4> is GTK::Button::Scale:ver<4> {
  has GtkVolumeButton $!gtk-vb is implementor;

  submethod BUILD ( :$gtk-volume-button ) {
    self.setGtkVolumeButton($gtk-volume-button) if $gtk-volume-button
  }

  method setGtkVolumeButton (GtkVolumeButtonAncestry $_) {
    my $to-parent;

    $!gtk-vb = do {
      when GtkVolumeButton {
        $to-parent = cast(GtkScaleButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkVolumeButton, $_);
      }
    }
    self.setGtkScaleButton($to-parent);
  }

  method GTK::Raw::Definitions::GtkVolumeButton
    is also<GtkVolumeButton>
  { $!gtk-vb }

  multi method new (
     $gtk-volume-button where * ~~ GtkVolumeButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-volume-button;

    my $o = self.bless( :$gtk-volume-button );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-volume-button = gtk_volume_button_new();

    $gtk-volume-button ?? self.bless( :$gtk-volume-button ) !! Nil;
  }

  # Type: boolean
  method use-symbolic is rw  is g-property is also<use_symbolic> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-symbolic', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-symbolic', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_volume_button_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gtk/gtkvolumebutton.h

sub gtk_volume_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_volume_button_new
  returns GtkVolumeButton
  is      native(gtk4)
  is      export
{ * }

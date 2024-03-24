use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;\

use GIO::Permission;
use GTK::Button:ver<4>;

our subset GtkLockButtonAncestry is export of Mu
  where GtkLockButton | GtkButtonAncestry;

class GTK::Button::Lock:ver<4> is GTK::Button:ver<4> {
  has GtkLockButton $!gtk-lb is implementor;

  submethod BUILD ( :$gtk-lock-button ) {
    self.setGtkLockButton($gtk-lock-button) if $gtk-lock-button
  }

  method setGtkLockButton (GtkLockButtonAncestry $_) {
    my $to-parent;

    $!gtk-lb = do {
      when GtkLockButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkLockButton, $_);
      }
    }
    self.setGtkButton($to-parent);
  }

  method GTK::Raw::Definitions::GtkLockButton
    is also<GtkLockButton>
  { $!gtk-lb }

  multi method new (
    $gtk-lock-button where * ~~ GtkLockButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-lock-button;

    my $o = self.bless( :$gtk-lock-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (GPermission() $perm) {
    my $gtk-lock-button = gtk_lock_button_new($perm);

    $gtk-lock-button ?? self.bless( :$gtk-lock-button ) !! Nil;
  }

  # Type: GtkPermission
  method permission ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Permission.get_types );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('permission', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Permission.getTypePair
        );
      },
      STORE => -> $, GPermission() $val is copy {
        $gv.object = $val;
        self.prop_set('permission', $gv);
      }
    );
  }

  # Type: string
  method text-lock is rw  is g-property is also<text_lock> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-lock', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text-lock', $gv);
      }
    );
  }

  # Type: string
  method text-unlock is rw  is g-property is also<text_unlock> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-unlock', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text-unlock', $gv);
      }
    );
  }

  # Type: string
  method tooltip-lock is rw  is g-property is also<tooltip_lock> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-lock', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tooltip-lock', $gv);
      }
    );
  }

  # Type: string
  method tooltip-not-authorized
    is rw
    is g-property
    is also<tooltip_not_authorized>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-not-authorized', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tooltip-not-authorized', $gv);
      }
    );
47  }

  # Type: string
  method tooltip-unlock is rw  is g-property is also<tooltip_unlock> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-unlock', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tooltip-unlock', $gv);
      }
    );
  }

  method get_permission ( :$raw = False ) is also<get-permission> {
    propReturnObject(
      gtk_lock_button_get_permission($!gtk-lb),
      $raw,
      |GIO::Permission.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_lock_button_get_type, $n, $t );
  }

  method set_permission (GPermission() $permission) is also<set-permission> {
    gtk_lock_button_set_permission($!gtk-lb, $permission);
  }

}

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Button::Lock;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     if .slurp -> $j {
#       %widgets = try from-json($j) if +$j.lines;
#     }
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::Button::Lock;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

### /usr/src/gtk4/gtk/gtklockbutton.h

sub gtk_lock_button_get_permission (GtkLockButton $button)
  returns GPermission
  is      native(gtk4)
  is      export
{ * }

sub gtk_lock_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_lock_button_new (GPermission $permission)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_lock_button_set_permission (
  GtkLockButton $button,
  GPermission   $permission
)
  is      native(gtk4)
  is      export
{ * }

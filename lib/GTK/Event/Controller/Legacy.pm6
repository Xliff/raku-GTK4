use v6.c;

use NativeCall;
use Method::Also;

use GTK::Raw::Types;

use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;
use GDK::Roles::Signals::Generic;

our subset GtkEventControllerLegacyAncestry is export of Mu
  where GtkEventControllerLegacy | GtkEventControllerAncestry;

class GTK::Event::Controller::Legacy:ver<4>
  is GTK::Event::Controller:ver<4>
{
  also does GDK::Roles::Signals::Generic;

  has GtkEventControllerLegacy $!gtk-ecl is implementor;

  submethod BUILD ( :$gtk-controller-legacy ) {
    self.setGtkEventControllerLegacy($gtk-controller-legacy)
      if $gtk-controller-legacy
  }

  method setGtkEventControllerLegacy (GtkEventControllerLegacyAncestry $_) {
    my $to-parent;

    $!gtk-ecl = do {
      when GtkEventControllerLegacy {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEventControllerLegacy, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkEventControllerLegacy
    is also<GtkEventContrrollerLegacy>
  { $!gtk-ecl }

  multi method new (
     $gtk-controller-legacy where * ~~ GtkEventControllerLegacyAncestry,

    :$ref = True
  ) {
    return unless $gtk-controller-legacy;

    my $o = self.bless( :$gtk-controller-legacy );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $event-controller-legacy = gtk_event_controller_legacy_new();

    $event-controller-legacy ?? self.bless( :$event-controller-legacy )
                             !! Nil;
  }

  method Event {
    self.connect-event($!gtk-ecl);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_event_controller_legacy_get_type,
      $n,
      $t
    );
  }

}



### /usr/src/gtk4/gtk/gtkeventcontrollerlegacy.h

sub gtk_event_controller_legacy_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_legacy_new
  returns GtkEventControllerLegacy
  is      native(gtk4)
  is      export
{ * }

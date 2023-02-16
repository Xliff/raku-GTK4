use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Event::Controller::Key:ver<4>;

use GTK::Input::Context:ver<4>;
use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Signals::Event::Controller::Key:ver<4>;

class GTK::Event::Controller::Key:ver<4> is GTK::Event::Controller:ver<4> {
  also does GTK::Roles::Signals::Event::Controller::Key;

  has GtkEventControllerKey $!gtk-eck is implementor;

  method new {
    my $gtk-event-key = gtk_event_controller_key_new();

    $gtk-event-key ?? self.bless( :$gtk-event-key ) !! Nil;
  }

  method IM-Update {
    self.connect($!gtk-eck, 'im-update');
  }

  method Key-Pressed {
    self.connect-key($!gtk-eck, 'key-pressed');
  }

  method Key-Released {
    self.connect-key($!gtk-eck, 'key-released');
  }

  method Modifiers {
    self.connect-guint($!gtk-eck, 'modifiers');
  }

  method forward (GtkWidget() $widget) {
    gtk_event_controller_key_forward($!gtk-eck, $widget);
  }

  method get_group {
    gtk_event_controller_key_get_group($!gtk-eck);
  }

  method get_im_context ( :$raw = False ) {
    propReturnObject(
      gtk_event_controller_key_get_im_context($!gtk-eck),
      $raw,
      |GTK::Input::Context.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_event_controller_key_get_type,
      $n,
      $t
    );
  }

  method set_im_context (GtkIMContext() $im_context) {
    gtk_event_controller_key_set_im_context($!gtk-eck, $im_context);
  }

}

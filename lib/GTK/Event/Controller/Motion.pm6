use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Signals::Generic;

our subset GtkEventControllerMotionAncestry is export of Mu
  where GtkEventControllerMotion | GtkEventControllerAncestry;

class GTK::Event::Controller::Motion:ver<4>
  is GTK::Event::Controller:ver<4>
{
  also does GTK::Roles::Signals::Generic;

  has GtkEventControllerMotion $!gtk-ecm is implementor;

  submethod BUILD ( :$gtk-event-motion ) {
    self.setGtkEventControllerMotion($gtk-event-motion) if $gtk-event-motion;
  }

  method setGtkEventControllerMotion (GtkEventControllerMotionAncestry $_) {
    my $to-parent;

    $!gtk-ecm = do {
      when GtkEventControllerMotion {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEventControllerMotion, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkEventControllerMotion
    is also<GtkEventControllerMotion>
  { $!gtk-ecm }

  multi method new (
     $gtk-event-motion where * ~~ GtkEventControllerMotionAncestry,

    :$ref = True
  ) {
    return unless $gtk-event-motion;

    my $o = self.bless( :$gtk-event-motion );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-event-motion = gtk_event_controller_motion_new();

    $gtk-event-motion ?? self.bless( :$gtk-event-motion ) !! Nil;
  }

  proto method contains_pointer (|)
    is also<contains-pointer>
  { * }

  # Type: boolean
  multi method contains_pointer
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('contains-pointer', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'contains-pointer does not allow writing'
      }
    );
  }

  proto method is_pointer (|)
    is also<is-pointer>
  { * }

  # Type: boolean
  multi method is_pointer
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-pointer', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-pointer does not allow writing'
      }
    );
  }

  method Enter {
    self.connect-double-double($!gtk-ecm, 'enter');
  }

  method Leave {
    self.connect($!gtk-ecm, 'leave');
  }

  method Motion {
    self.connect-double-double($!gtk-ecm, 'motion');
  }

  multi method contains_pointer ( :$method is required ) {
    so gtk_event_controller_motion_contains_pointer($!gtk-ecm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_event_controller_motion_get_type,
      $n,
      $t
    );
  }

  multi method is_pointer ( :$method is required ) {
    so gtk_event_controller_motion_is_pointer($!gtk-ecm);
  }

}

### /usr/src/gtk4/gtk/gtkeventcontrollermotion.h

sub gtk_event_controller_motion_contains_pointer (
  GtkEventControllerMotion $self
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_motion_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_motion_is_pointer (GtkEventControllerMotion $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_motion_new
  returns GtkEventControllerMotion
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Event::Controller;

our subset GtkEventControllerFocusAncestry is export of Mu
  where GtkEventControllerFocus | GtkEventControllerAncestry;

class GTK::Event::Controller::Focus:ver<4> is GTK::Event::Controller:ver<4> {
  has GtkEventControllerFocus $!gtk-ecf is implementor;

  submethod BUILD ( :$gtk-controller-focus ) {
    self.setGtkEventControllerFocus($gtk-controller-focus)
      if $gtk-controller-focus
  }

  method setGtkEventControllerFocus (GtkEventControllerFocusAncestry $_) {
    my $to-parent;

    $!gtk-ecf = do {
      when GtkEventControllerFocus {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEventControllerFocus, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkEventControllerFocus
    is also<GtkEventContrrollerFocus>
  { $!gtk-ecf }

  multi method new (
     $gtk-controller-focus where * ~~ GtkEventControllerFocusAncestry,

    :$ref = True
  ) {
    return unless $gtk-controller-focus;

    my $o = self.bless( :$gtk-controller-focus );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-controller-focus = gtk_event_controller_focus_new();

    $gtk-controller-focus ?? self.bless( :$gtk-controller-focus ) !! Nil;
  }

  # Type: boolean
  method contains-focus is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('contains-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'contains-focus does not allow writing'
      }
    );
  }

  # Type: boolean
  method is-focus is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-focus does not allow writing'
      }
    );
  }

  method Enter {
    self.connect($!gtk-ecf, 'enter');
  }

  method Leave {
    self.connect($!gtk-ecf, 'leave');
  }

  method contains_focus {
    gtk_event_controller_focus_contains_focus($!gtk-ecf);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_event_controller_focus_get_type,
      $n,
      $t
    );
  }

  method is_focus {
    so gtk_event_controller_focus_is_focus($!gtk-ecf);
  }

}


### /usr/src/gtk4/gtk/gtkeventcontrollerfocus.h

sub gtk_event_controller_focus_contains_focus (GtkEventControllerFocus $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_focus_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_focus_is_focus (GtkEventControllerFocus $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_focus_new
  returns GtkEventController
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GDK::Drop:ver<4>;

use GTK::Event::Controller;

our subset GtkDropControllerMotionAncestry is export of Mu
  where GtkDropControllerMotion | GtkEventControllerAncestry;

class GTK::Drop::Controller::Motion:ver<4> is GTK::Event::Controller:ver<4> {
  has GtkDropControllerMotion $!gtk-dcm is implementor;

  submethod BUILD ( :$gtk-drop-motion ) {
    self.setGtkDropControllerMotion($gtk-drop-motion) if $gtk-drop-motion
  }

  method setGtkDropControllerMotion (GtkDropControllerMotionAncestry $_) {
    my $to-parent;

    $!gtk-dcm = do {
      when GtkDropControllerMotion {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkDropControllerMotion, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkDropControllerMotion
    is also<GtkDropControllerMotion>
  { $!gtk-dcm }

  multi method new (
     $gtk-drop-motion where * ~~ GtkDropControllerMotionAncestry,

    :$ref = True
  ) {
    return unless $gtk-drop-motion;

    my $o = self.bless( :$gtk-drop-motion );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-drop-motion = gtk_drop_controller_motion_new();

    $gtk-drop-motion ?? self.bless( :$gtk-drop-motion ) !! Nil;
  }

  proto method contains-pointer (|)
    is also<contains_pointer>
  { * }

  # Type: boolean
  multi method contains-pointer is rw  is g-property  {
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

  # Type: GdkDrop
  method drop ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Drop.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('drop', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Drop.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'drop does not allow writing'
      }
    );
  }

  proto method is-pointer (|)
    is also<is_pointer>
  { * }

  # Type: boolean
  multi method is-pointer is rw  is g-property {
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
    self.connect-numnum($!gtk-dcm, 'Enter');
  }

  method Leave {
    self.connect($!gtk-dcm, 'Leave')
  }

  method Motion {
    self.connect-numnum($!gtk-dcm, 'Motion');
  }

  multi method contains-pointer ( :$method is required ) {
    so gtk_drop_controller_motion_contains_pointer($!gtk-dcm);
  }

  method get_drop ( :$raw = False ) is also<get-drop> {
    propReturnObject(
      gtk_drop_controller_motion_get_drop($!gtk-dcm),
      $raw,
      |GDK::Drop.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_drop_controller_motion_get_type,
      $n,
      $t
    );
  }

  # cw: Conficts with g-attribute so made multi with required named parameter
  multi method is-pointer ( :$method is required ) {
    so gtk_drop_controller_motion_is_pointer($!gtk-dcm);
  }

}

### /usr/src/gtk4/gtk/gtkdropcontrollermotion.h

sub gtk_drop_controller_motion_contains_pointer (GtkDropControllerMotion $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_controller_motion_get_drop (GtkDropControllerMotion $self)
  returns GdkDrop
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_controller_motion_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_controller_motion_is_pointer (GtkDropControllerMotion $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_drop_controller_motion_new
  returns GtkEventController
  is      native(gtk4)
  is      export
{ * }

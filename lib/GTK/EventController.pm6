use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::EventController:ver<4>;

use GDK::Device:ver<4>;
use GDK::Events:ver<4>;

use GLib::Roles::Implementor:ver<4>;
use GLib::Roles::Object:ver<4>;

our subset GtkEventControllerAncestry is export of Mu
  where GtkEventController | GObject;

class GTK::EventController:ver<4> {
  also does GLib::Roles::Object;

  has GtkEventController $!gtk-ec is implementor;

  submethod BUILD ( :$gtk-event-control ) {
    self.setGtkEventController($gtk-event-control)
      if $gtk-event-control
  }

  method setGtkEventController (GtkEventControllerAncestry $_) {
    my $to-parent;

    $!gtk-ec = do {
      when GtkEventController {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEventController, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkEventController
  { $!gtk-ec }

  multi method new (GtkEventControllerAncestry $gtk-event-control, :$ref = True) {
    return unless $gtk-event-control;

    my $o = self.bless( :$gtk-event-control );
    $o.ref if $ref;
    $o;
  }

  # Type: GTKWidget
  method widget ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GTK::Widget').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('widget', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          ::('GTK::Widget').getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'widget does not allow writing'
      }
    );
  }

  # Type: GTKPropagationPhase
  method propagation-phase ( :$enum = True )
    is rw
    is g-property
    is also<propagation_phase>
  {
    my $gv = GLib::Value.new(
      GLib::Value.typeFromEnum(GtkPropagationPhase) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('propagation-phase', $gv);
        my $pp = $gv.valueFromEnum(GtkPropagationPhase);
        return $pp unless $enum;
        GtkPropagationPhaseEnum( $gv.valueFromEnum(GtkPropagationPhase) );
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPropagationPhase) = $val;
        self.prop_set('propagation-phase', $gv);
      }
    );
  }

  # Type: GTKPropagationLimit
  method propagation-limit ( :$enum = True )
    is rw
    is g-property
    is also<propagation_limit>
  {
    my $gv = GLib::Value.new(
      GLib::Value.typeFromEnum(GtkPropagationLimit)
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('propagation-limit', $gv);
        my $pl = $gv.valueFromEnum(GtkPropagationLimit);
        return $pl unless $enum;
        GtkPropagationLimitEnum($pl);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPropagationLimit) = $val;
        self.prop_set('propagation-limit', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  method get_current_event ( :$raw = False )
    is also<
      get-current-event
      current_event
      current-event
      event
    >
  {
    propReturnObject(
      gtk_event_controller_get_current_event($!gtk-ec),
      $raw,
      |GDK::Event.getTypePair
    );
  }

  method get_current_event_device ( :$raw = False )
    is also<
      get-current-event-device
      current_event_device
      current-event-device
      event_device
      event-device
      device
    >
  {
    propReturnObject(
      gtk_event_controller_get_current_event_device($!gtk-ec),
      $raw,
      |GDK::Device.getTypePair
    )
  }

  method get_current_event_state ( :$enum = True )
    is also<
      get-current-event-state
      current_event_state
      current-event-state
      event_state
      event-state
      state
    >
  {
    gtk_event_controller_get_current_event_state($!gtk-ec);
  }

  method get_current_event_time
    is also<
      get-current-event-time
      current_event_time
      current-event-time
      event_time
      event-time
      time
    >
  {
    gtk_event_controller_get_current_event_time($!gtk-ec);
  }

  method get_name is also<get-name> {
    gtk_event_controller_get_name($!gtk-ec);
  }

  method get_propagation_limit ( :$enum = True )
    is also<get-propagation-limit>
  {
    my $p =  gtk_event_controller_get_propagation_limit($!gtk-ec);
    return $p unless $enum;
    GtkPropagationLimitEnum($p);
  }

  method get_propagation_phase ( :$enum = True )
    is also<get-propagation-phase>
  {
    my $p = gtk_event_controller_get_propagation_phase($!gtk-ec);
    return $p unless $enum;
    GtkPropagationPhaseEnum($p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_event_controller_get_type, $n, $t );
  }

  method get_widget (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-widget>
  {
    returnProperWidget(
      gtk_event_controller_get_widget($!gtk-ec),
      $raw,
      $proper
    );
  }

  method reset {
    gtk_event_controller_reset($!gtk-ec);
  }

  method set_name (Str() $name) is also<set-name> {
    gtk_event_controller_set_name($!gtk-ec, $name);
  }

  method set_propagation_limit (Int() $limit) is also<set-propagation-limit> {
    my GtkPropagationLimit $l = $limit;

    gtk_event_controller_set_propagation_limit($!gtk-ec, $l);
  }

  method set_propagation_phase (Int() $phase) is also<set-propagation-phase> {
    my GtkPropagationPhase $p = $phase;

    gtk_event_controller_set_propagation_phase($!gtk-ec, $p);
  }

  method set_static_name (Str() $name) is also<set-static-name> {
    gtk_event_controller_set_static_name($!gtk-ec, $name);
  }

}

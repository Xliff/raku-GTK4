use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

# Add GtkActionable

our subset GtkSwitchAncestry is export of Mu
  where GtkSwitch | GtkWidgetAncestry;

class GTK::Switch:ver<4> is GTK::Widget:ver<4> {
  has GtkSwitch $!gtk-sw is implementor;

  submethod BUILD ( :$gtk-switch ) {
    self.setGtkSwitch($gtk-switch)
      if $gtk-switch
  }

  method setGtkSwitch (GtkSwitchAncestry $_) {
    my $to-parent;

    $!gtk-sw = do {
      when GtkSwitch {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSwitch, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkSwitch
    is also<GtkSwitch>
  { $!gtk-sw }

  multi method new (GtkSwitchAncestry $gtk-switch, :$ref = True) {
    return unless $gtk-switch;

    my $o = self.bless( :$gtk-switch );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-switch = gtk_switch_new();

    $gtk-switch ?? self.bless( :$gtk-switch ) !! Nil;
  }

  # Type: boolean
  method active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: boolean
  method state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('state', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-sw, 'activate');
  }

  method State-Set is also<State_Set> {
    self.connect-uint-ruint($!gtk-sw, 'state-set');
  }

  method get_active is also<get-active> {
    so gtk_switch_get_active($!gtk-sw);
  }

  method get_state is also<get-state> {
    so gtk_switch_get_state($!gtk-sw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_switch_get_type, $n, $t );
  }

  method set_active (Int() $is_active) is also<set-active> {
    my gboolean $i = $is_active.so.Int;

    gtk_switch_set_active($!gtk-sw, $i);
  }

  method set_state (Int() $state) is also<set-state> {
    my gboolean $s = $state.so.Int;

    gtk_switch_set_state($!gtk-sw, $s);
  }

}

### /usr/src/gtk4-4.8.1+ds/gtk/gtkswitch.h

sub gtk_switch_get_active (GtkSwitch $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_switch_get_state (GtkSwitch $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_switch_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_switch_new
  returns GtkSwitch
  is      native(gtk4)
  is      export
{ * }

sub gtk_switch_set_active (
  GtkSwitch $self,
  gboolean  $is_active
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_switch_set_state (
  GtkSwitch $self,
  gboolean  $state
)
  is      native(gtk4)
  is      export
{ * }

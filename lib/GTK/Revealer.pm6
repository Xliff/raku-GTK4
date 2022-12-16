use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Revealer:ver<4>

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

class GTK::Revealer:ver<4> is GTK::Widget:ver<4> {
  has GtkRevealer $!gtk-r is implementor;

  method new {
    my $gtk-revealer = gtk_revealer_new();

    $gtk-revealer ?? self.bless( :$gtk-revealer ) !! Nil;
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method child-revealed is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child-revealed', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'child-revealed does not allow writing'
      }
    );
  }

  # Type: boolean
  method reveal-child is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('reveal-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reveal-child', $gv);
      }
    );
  }

  # Type: uint
  method transition-duration is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transition-duration', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('transition-duration', $gv);
      }
    );
  }

  # Type: GtkRevealerTransitionType
  method transition-type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkRevealerTransitionType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transition-type', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        GtkRevealerTransitionTypeEnum($e);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkRevealerTransitionType) = $val;
        self.prop_set('transition-type', $gv);
      }
    );
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_revealer_get_child($!gtk-r),
      $raw,
      $proper
    )
  }

  method get_child_revealed {
    so gtk_revealer_get_child_revealed($!gtk-r);
  }

  method get_reveal_child {
    so gtk_revealer_get_reveal_child($!gtk-r);
  }

  method get_transition_duration ( :$enum = True ) {
    gtk_revealer_get_transition_duration($!gtk-r);
  }

  method get_transition_type ( :$enum = True ) {
    my $e = gtk_revealer_get_transition_type($!gtk-r);
    return $e unless $enum;
    GtkRevealerTransitionTypeEnum($e);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_revealer_get_type, $n, $t );
  }

  method set_child (GtkWidget() $child) {
    gtk_revealer_set_child($!gtk-r, $child);
  }

  method set_reveal_child (Int() $reveal_child) {
    my gboolean $r = $reveal_child.so.Int;

    gtk_revealer_set_reveal_child($!gtk-r, $r);
  }

  method set_transition_duration (Int() $duration) {
    my guint $d = $duration;

    gtk_revealer_set_transition_duration($!gtk-r, $d);
  }

  method set_transition_type (Int() $transition) {
    my GtkRevealerTransitionType $t = $transition;

    gtk_revealer_set_transition_type($!gtk-r, $t);
  }

}

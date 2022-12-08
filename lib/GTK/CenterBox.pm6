use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::CenterBox:ver<4>;

use GLib::Roles::Implementor;

class GTK::CenterBox {
  has GtkCenterBox $!gtk-c is implementor;

  multi method new {
    my $gtk-center-box = gtk_center_box_new();

    $gtk-center-box ?? self.bless( :$gtk-center-box ) !! Nil;
  }

  # Type: GtkBaselinePosition
  method baseline-position ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkBaselinePosition );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('baseline-position', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GtkBaselinePositionEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkBaselinePosition) = $val;
        self.prop_set('baseline-position', $gv);
      }
    );
  }

  # Type: GtkWidget
  method center-widget (
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
        self.prop_get('center-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('center-widget', $gv);
      }
    );
  }

  # Type: GtkWidget
  method end-widget (
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
        self.prop_get('end-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('end-widget', $gv);
      }
    );
  }

  # Type: GtkWidget
  method start-widget (
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
        self.prop_get('start-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('start-widget', $gv);
      }
    );
  }

  method get_baseline_position ( :$enum = True ) {
    my $p = gtk_center_box_get_baseline_position($!gtk-c);
    return $p unless $enum;
    GtkBaselinePositionEnum($p);
  }

  method get_center_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_center_box_get_center_widget($!gtk-c),
      $raw,
      $proper
    );
  }

  method get_end_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_center_box_get_end_widget($!gtk-c),
      $raw,
      $proper
    );
  }

  method get_start_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_center_box_get_start_widget($!gtk-c),
      $raw,
      $proper
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_center_box_get_type, $n, $t );
  }

  method set_baseline_position (Int() $position) {
    my GtkBaselinePosition $p = $position;

    gtk_center_box_set_baseline_position($!gtk-c, $p);
  }

  method set_center_widget (GtkWidget() $child) {
    gtk_center_box_set_center_widget($!gtk-c, $child);
  }

  method set_end_widget (GtkWidget() $child) {
    gtk_center_box_set_end_widget($!gtk-c, $child);
  }

  method set_start_widget (GtkWidget() $child) {
    gtk_center_box_set_start_widget($!gtk-c, $child);
  }

}

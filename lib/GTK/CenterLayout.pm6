use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::CenterLayout:ver<4>;

use GTK::LayoutManager:ver<4>;

use GLib::Roles::Implementor;

our subset GtkCenterLayoutAncestry is export of Mu
  where GtkCenterLayout | GtkLayoutManagerAncestry;

class GTK::CenterLayout:ver<4> is GTK::LayoutManager:ver<4> {
  has GtkCenterLayout $!gtk-cl is implementor;

  submethod BUILD ( :$gtk-center-layout ) {
    self.setGtkCenterLayout($gtk-center-layout) if $gtk-center-layout
  }

  method setGtkCenterLayout (GtkCenterLayoutAncestry $_) {
    my $to-parent;

    $!gtk-cl = do {
      when GtkCenterLayout {
        $to-parent = cast(GtkLayoutManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCenterLayout, $_);
      }
    }
    self.setGtkLayoutManager($to-parent);
  }

  method GTK::Raw::Definitions::GtkCenterLayout
    is also<GtkCenterLayout>
  { $!gtk-cl }

  multi method new (
    $gtk-center-layout where * ~~ GtkCenterLayoutAncestry,

    :$ref = True
  ) {
    return unless $gtk-center-layout;

    my $o = self.bless( :$gtk-center-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-center-layout = gtk_center_layout_new();

    my $o = $gtk-center-layout ?? self.bless( :$gtk-center-layout ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method baseline_position ( :$enum = True ) is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_baseline_position( :$enum) },
      STORE => -> $, \v { self.set_baseline_position(v) }
  }

  method center_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_center_widget( :$raw, :$proper ) },
      STORE => -> $, \v { self.set_center_widget(v) }
  }

  method end_widget
  (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_end_widget( :$raw, :$proper ) },
      STORE => -> $, \v { self.set_end_widget(v) }
  }

  method orientation is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_orientation    },
      STORE => -> $, \v { self.set_orientation(v) }
  }

  method start_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_start_widget( :$raw, :$proper ) },
      STORE => -> $, \v { self.set_start_widget(v) }
  }

  method get_baseline_position ( :$enum = True )
    is also<get-baseline-position>
  {
    my $p = gtk_center_layout_get_baseline_position($!gtk-cl);
    return $p unless $enum;
    GtkBaselinePositionEnum($p);
  }

  method get_center_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-center-widget>
  {
    returnProperWidget(
      gtk_center_layout_get_center_widget($!gtk-cl),
      $raw,
      $proper
    );
  }

  method get_end_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-end-widget>
  {
    returnProperWidget(
      gtk_center_layout_get_end_widget($!gtk-cl),
      $raw,
      $proper
    )
  }

  method get_orientation ( :$enum = True ) is also<get-orientation> {
    my $o = gtk_center_layout_get_orientation($!gtk-cl);
    return $o unless $enum;
    GtkOrientationEnum($o);
  }

  method get_start_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-start-widget>
  {
    returnProperWidget(
      gtk_center_layout_get_start_widget($!gtk-cl),
      $raw,
      $proper
    );
  }

  method set_baseline_position (Int() $baseline_position)
    is also<set-baseline-position>
  {
    my GtkBaselinePosition $b = $baseline_position;

    gtk_center_layout_set_baseline_position($!gtk-cl, $b);
  }

  method set_center_widget (GtkWidget() $widget) is also<set-center-widget> {
    gtk_center_layout_set_center_widget($!gtk-cl, $widget);
  }

  method set_end_widget (GtkWidget() $widget) is also<set-end-widget> {
    gtk_center_layout_set_end_widget($!gtk-cl, $widget);
  }

  method set_orientation (Int() $orientation) is also<set-orientation> {
    my GtkOrientation $o = $orientation;

    gtk_center_layout_set_orientation($!gtk-cl, $o);
  }

  method set_start_widget (GtkWidget() $widget) is also<set-start-widget> {
    gtk_center_layout_set_start_widget($!gtk-cl, $widget);
  }

}

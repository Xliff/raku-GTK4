use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::CenterBox:ver<4>;

use GLib::Value;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable;

our subset GtkCenterBoxAncestry is export of Mu
  where GtkCenterBox | GtkOrientable | GtkWidgetAncestry;

class GTK::CenterBox is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;

  has GtkCenterBox $!gtk-c is implementor;

  submethod BUILD ( :$gtk-center-box ) {
    self.setGtkCenterBox($gtk-center-box) if $gtk-center-box
  }

  method setGtkCenterBox (GtkCenterBoxAncestry $_) {
    my $to-parent;

    $!gtk-c = do {
      when GtkCenterBox {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkOrientable {
        $to-parent = cast(GtkWidget, $_);
        $!gtk-o    = $_;
        cast(GtkCenterBox, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkCenterBox, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkOrientable;
  }

  method GTK::Raw::Definitions::GtkCenterBox
    is also<GtkCenterBox>
  { $!gtk-c }

  multi method new (
    $gtk-center-box where * ~~ GtkCenterBoxAncestry,

    :$ref = True
  ) {
    return unless $gtk-center-box;

    my $o = self.bless( :$gtk-center-box );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-center-box = gtk_center_box_new();

    my $o = $gtk-center-box ?? self.bless( :$gtk-center-box ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkBaselinePosition
  method baseline-position ( :$enum = True )
    is rw
    is g-property
    is also<baseline_position>
  {
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
    is also<
      center_widget
      center
    >
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('center-widget', $gv);
        my $o = $gv.object;
        return Nil unless $o;
        returnProperWidget($o, $raw, $proper);
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
    is also<
      end_widget
      end
    >
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('end-widget', $gv);
        my $o = $gv.object;
        return Nil unless $o;
        returnProperWidget($o, $raw, $proper);
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

    is also<
      start_widget
      start
    >
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('start-widget', $gv);
        my $o = $gv.object;
        return Nil unless $o;
        returnProperWidget($o, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('start-widget', $gv);
      }
    );
  }

  method widgets (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) is rw {
    Proxy.new:
      FETCH => -> $ {
        (
          self.start-widget(:$raw, :$proper),
          self.center-widget(:$raw, :$proper),
          self.end-widget(:$raw, :$proper)
        )
      },

      STORE => -> $, $widgets is copy {
        X::GLib::InvalidSize.new(
          message => "\$widgets can only have 3 elements (value has {
                      $widgets.elems })"
        ).throw unless $widgets.elems == 3;
        $widgets = ArrayToCArray(GtkWidget, $widgets);

        ( .start-widget, .center-widget, .end-widget) =
          $widgets.Array.map( *.deref ) given self;
      }
  }

  method get_baseline_position ( :$enum = True ) is also<get-baseline-position> {
    my $p = gtk_center_box_get_baseline_position($!gtk-c);
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
      gtk_center_box_get_center_widget($!gtk-c),
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
      gtk_center_box_get_end_widget($!gtk-c),
      $raw,
      $proper
    );
  }

  method get_start_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-start-widget>
  {
    returnProperWidget(
      gtk_center_box_get_start_widget($!gtk-c),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_center_box_get_type, $n, $t );
  }

  method set_baseline_position (Int() $position) is also<set-baseline-position> {
    my GtkBaselinePosition $p = $position;

    gtk_center_box_set_baseline_position($!gtk-c, $p);
  }

  method set_center_widget (GtkWidget() $child) is also<set-center-widget> {
    gtk_center_box_set_center_widget($!gtk-c, $child);
  }

  method set_end_widget (GtkWidget() $child) is also<set-end-widget> {
    gtk_center_box_set_end_widget($!gtk-c, $child);
  }

  method set_start_widget (GtkWidget() $child) is also<set-start-widget> {
    gtk_center_box_set_start_widget($!gtk-c, $child);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::CenterBox;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    if .slurp -> $j {
      %widgets = try from-json($j) if +$j.lines;
    }
    %widgets{ P.head.^shortname } = P.tail;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::CenterBox;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

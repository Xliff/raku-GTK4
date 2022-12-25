use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Popover:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Native;
use GTK::Roles::ShortcutManager;

our subset GtkPopoverAncestry is export of Mu
  where GtkPopover | GtkNative | GtkShortcutManager | GtkWidgetAncestry;

class GTK::Popover:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Native;
  also does GTK::Roles::ShortcutManager;

  has GtkPopover $!gtk-pop is implementor;

  submethod BUILD ( :$gtk-popover ) {
    self.setGtkPopover($gtk-popover) if $gtk-popover
  }

  method setGtkPopover (GtkPopoverAncestry $_) {
    my $to-parent;

    $!gtk-pop = do {
      when GtkPopover {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkNative {
        $!gtk-n = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkPopover, $_);
      }

      when GtkShortcutManager {
        $!gtk-sm = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkPopover, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkPopover, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkNative;
    self.roleInit-GtkShortcutManager;
  }

  method GTK::Raw::Structs::GtkPopover
    is also<GtkPopover>
  { $!gtk-pop }

  multi method new (
    $gtk-popover where * ~~ GtkPopoverAncestry,

    :$ref = True
  ) {
    return unless $gtk-popover;

    my $o = self.bless( :$gtk-popover );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-popover = gtk_popover_new();

    $gtk-popover ?? self.bless( :$gtk-popover ) !! Nil
  }

  # # Type: boolean
  method autohide is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new:
      FETCH => sub ($) {
        self.prop_get('autohide', $gv);
        $gv.boolean;
      },

      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('autohide', $gv);
      }
  }

  # Type: boolean
  method cascade-popdown is rw  is g-property is also<cascade_popdown> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cascade-popdown', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('cascade-popdown', $gv);
      }
    );
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
        )
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: GtkWidget
  method default-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
    is also<default_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        )
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv. object = $val;
        self.prop_set('default-widget', $gv);
      }
    );
  }

  # Type: boolean
  method has-arrow is rw  is g-property is also<has_arrow> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-arrow', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-arrow', $gv);
      }
    );
  }

  # Type: boolean
  method mnemonics-visible is rw  is g-property is also<mnemonics_visible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mnemonics-visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('mnemonics-visible', $gv);
      }
    );
  }

  # Type: GtkRectangle
  method pointing-to ( :$raw = False )
    is rw
    is g-property
    is also<pointing_to>
  {
    my $gv = GLib::Value.new( GDK::Rectangle.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pointing-to', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Rectangle.getTypePair
        );
      },
      STORE => -> $, GdkRectangle() $val is copy {
        $gv.object = $val;
        self.prop_set('pointing-to', $gv);
      }
    );
  }

  # Type: GtkPositionType
  method position ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkPositionType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GtkPositionTypeEnum($p);
      },
      STORE => -> $,  Int() $val is copy {
        $gv.valueFromEnum(GtkPositionType) = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  method get_autohide is also<get-autohide> {
    so gtk_popover_get_autohide($!gtk-pop);
  }

  method get_cascade_popdown is also<get-cascade-popdown> {
    so gtk_popover_get_cascade_popdown($!gtk-pop);
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_popover_get_child($!gtk-pop),
      $raw,
      $proper
    );
  }

  method get_has_arrow is also<get-has-arrow> {
    so gtk_popover_get_has_arrow($!gtk-pop);
  }

  method get_mnemonics_visible is also<get-mnemonics-visible> {
    so gtk_popover_get_mnemonics_visible($!gtk-pop);
  }

  proto method get_offset (|)
    is also<get-offset>
  { * }

  multi method get_offset {
    samewith($, $);
  }
  multi method get_offset ($x_offset is rw, $y_offset is rw) {
    my gint ($x, $y) = 0 xx 2;

    gtk_popover_get_offset($!gtk-pop, $x, $y);
    ($x_offset, $y_offset) = ($x, $y);
  }

  proto method get_pointing_to (|)
    is also<get-pointing-to>
  { * }

  multi method get_pointing_to {
    samewith(GdkRectangle.new);
  }
  multi method get_pointing_to (GdkRectangle() $rect, :$raw = False) {
    gtk_popover_get_pointing_to($!gtk-pop, $rect);

    propReturnObject($rect, $raw, |GDK::Rectangle.getTypePair);
  }

  method get_position ( :$enum = True ) is also<get-position> {
    my $p = gtk_popover_get_position($!gtk-pop);
    return $p unless $enum;
    GtkPositionTypeEnum($p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_popover_get_type, $n, $t );
  }

  method popdown {
    gtk_popover_popdown($!gtk-pop);
  }

  method popup {
    gtk_popover_popup($!gtk-pop);
  }

  method present {
    gtk_popover_present($!gtk-pop);
  }

  method set_autohide (Int() $autohide) is also<set-autohide> {
    my gboolean $a = $autohide.so.Int;

    gtk_popover_set_autohide($!gtk-pop, $a);
  }

  method set_cascade_popdown (Int() $cascade_popdown)
    is also<set-cascade-popdown>
  {
    my gboolean $c = $cascade_popdown.so.Int;

    gtk_popover_set_cascade_popdown($!gtk-pop, $c);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_popover_set_child($!gtk-pop, $child);
  }

  method set_default_widget (GtkWidget() $widget)
    is also<set-default-widget>
  {
    gtk_popover_set_default_widget($!gtk-pop, $widget);
  }

  method set_has_arrow (Int() $has_arrow) is also<set-has-arrow> {
    my gboolean $h = $has_arrow.so.Int;

    gtk_popover_set_has_arrow($!gtk-pop, $h);
  }

  method set_mnemonics_visible (Int() $mnemonics_visible)
    is also<set-mnemonics-visible>
  {
    my gboolean $m = $mnemonics_visible.so.Int;

    gtk_popover_set_mnemonics_visible($!gtk-pop, $m);
  }

  method set_offset (Int() $x_offset, Int() $y_offset) is also<set-offset> {
    my gint ($x, $y) = ($x_offset, $y_offset);

    gtk_popover_set_offset($!gtk-pop, $x, $y);
  }

  method set_pointing_to (GdkRectangle() $rect) is also<set-pointing-to> {
    gtk_popover_set_pointing_to($!gtk-pop, $rect);
  }

  method set_position (Int() $position) is also<set-position> {
    my GtkPositionType $p = $position;

    gtk_popover_set_position($!gtk-pop, $p);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Popover;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Popover;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

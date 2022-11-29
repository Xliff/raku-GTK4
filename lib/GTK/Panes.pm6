use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Panes:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;
use GTK::Roles::Signals::Panes:ver<4>;

our subset GtkPanedAncestry is export of Mu
  where GtkPaned | GtkWidgetAncestry;

class GTK::Panes:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Signals::Panes;

  has GtkPaned $!gtk-p is implementor;

  submethod BUILD ( :$gtk-panes ) {
    self.setGtkPaned($gtk-panes) if $gtk-panes
  }

  method setGtkPaned (GtkPanedAncestry $_) {
    my $to-parent;

    $!gtk-p = do {
      when GtkPaned {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPaned, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkPaned
    is also<
      GtkPaned
      GtkPanes
    >
  { $!gtk-p }

  multi method new (GtkPanedAncestry $gtk-panes, :$ref = True) {
    return unless $gtk-panes;

    my $o = self.bless( :$gtk-panes );
    $o.ref if $ref;
    $o;
  }

  multi method new (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    my $gtk-panes = gtk_paned_new($o);

    $gtk-panes ?? self.bless( :$gtk-panes ) !! Nil;
  }
  multi method new (
    :h(:$horizontal) = True,
    :v(:$vertical)   = $horizontal.not
  ) {
    ::?CLASS.new(
      $vertical ?? GTK_ORIENTATION_VERTICAL
                !! GTK_ORIENTATION_HORIZONTAL
    )
  }

  method new-hpane {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL)
  }

  method new-vpan {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL);
  }

  # Type: GtkWidget
  method end-child  (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
    is also<end_child>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('end-child', $gv);

        my $o = $gv.object;
        return Nil unless $o;

        returnProperWidget($o, :$raw, :$proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('end-child', $gv);
      }
    );
  }

  # Type: int
  method max-position is rw  is g-property is also<max_position> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-position', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'max-position does not allow writing'
      }
    );
  }

  # Type: int
  method min-position is rw  is g-property is also<min_position> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-position', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'min-position does not allow writing'
      }
    );
  }

  # Type: int
  method position is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  # Type: boolean
  method position-set is rw  is g-property is also<position_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('position-set', $gv);
      }
    );
  }

  # Type: boolean
  method resize-end-child is rw  is g-property is also<resize_end_child> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resize-end-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resize-end-child', $gv);
      }
    );
  }

  # Type: boolean
  method resize-start-child is rw  is g-property is also<resize_start_child> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resize-start-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resize-start-child', $gv);
      }
    );
  }

  # Type: boolean
  method shrink-end-child is rw  is g-property is also<shrink_end_child> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shrink-end-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('shrink-end-child', $gv);
      }
    );
  }

  # Type: boolean
  method shrink-start-child is rw  is g-property is also<shrink_start_child> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shrink-start-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('shrink-start-child', $gv);
      }
    );
  }

  # Type: GtkWidget
  method start-child (
    :$raw = False,
    :quick(:$fast) = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property

    is also<start_child>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('start-child', $gv);

        my $o = $gv.object;
        return Nil unless $o;

        returnProperWidget($o, :$raw, :$proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        say "Set-SC: { $val }";
        $gv.object = $val;
        self.prop_set('start-child', $gv);
      }
    );
  }

  # Type: boolean
  method wide-handle is rw  is g-property is also<wide_handle> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wide-handle', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('wide-handle', $gv);
      }
    );
  }

  method Accept-Position is also<Accept_Position> {
    self.connect($!gtk-p, 'accept-position');
  }

  method Cancel-Position is also<Cancel_Position> {
    self.connect($!gtk-p, 'cancel-position');
  }

  method Toggle-Handle-Focus is also<Toggle_Handle_Focus> {
    self.connect($!gtk-p, 'toggle-handle-focus');
  }

  method Cycle-Child-Focus is also<Cycle_Child_Focus> {
    self.connect-uint-ruint($!gtk-p, 'cycle-child-focus');
  }

  method Cycle-Handle-Focus is also<Cycle_Handle_Focus> {
    self.connect-uint-ruint($!gtk-p, 'cycle-handle-focus');
  }

  method Move-Handle is also<Move_Handle> {
    self.connect-move-handle($!gtk-p);
  }

  method get_end_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-end-child>
  {
    returnProperObject(
      gtk_paned_get_end_child($!gtk-p),
      :$raw,
      :$proper
    );
  }

  method get_position is also<get-position> {
    gtk_paned_get_position($!gtk-p);
  }

  method get_resize_end_child is also<get-resize-end-child> {
    so gtk_paned_get_resize_end_child($!gtk-p);
  }

  method get_resize_start_child is also<get-resize-start-child> {
    so gtk_paned_get_resize_start_child($!gtk-p);
  }

  method get_shrink_end_child is also<get-shrink-end-child> {
    so gtk_paned_get_shrink_end_child($!gtk-p);
  }

  method get_shrink_start_child is also<get-shrink-start-child> {
    so gtk_paned_get_shrink_start_child($!gtk-p);
  }

  method get_start_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-start-child>
  {
    returnProperObject(
      gtk_paned_get_start_child($!gtk-p),
      :$raw,
      :$proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_paned_get_type, $n, $t );
  }

  method get_wide_handle is also<get-wide-handle> {
    so gtk_paned_get_wide_handle($!gtk-p);
  }

  method set_end_child (GtkWidget() $child)
    is also<set-end-child>
  {
    gtk_paned_set_end_child($!gtk-p, $child);
  }

  method set_position (Int() $position) is also<set-position> {
    my gint $p = $position;

    gtk_paned_set_position($!gtk-p, $p);
  }

  method set_resize_end_child (Int() $resize) is also<set-resize-end-child> {
    my gboolean $r = $resize.so.Int;

    gtk_paned_set_resize_end_child($!gtk-p, $resize);
  }

  method set_resize_start_child (Int() $resize)
    is also<set-resize-start-child>
  {
    my gboolean $r = $resize.so.Int;

    gtk_paned_set_resize_start_child($!gtk-p, $r);
  }

  method set_shrink_end_child (Int() $resize) is also<set-shrink-end-child> {
    my gboolean $r = $resize.so.Int;

    gtk_paned_set_shrink_end_child($!gtk-p, $r);
  }

  method set_shrink_start_child (Int() $resize)
    is also<set-shrink-start-child>
  {
    my gboolean $r = $resize.so.Int;

    gtk_paned_set_shrink_start_child($!gtk-p, $r);
  }

  method set_start_child (GtkWidget() $child) is also<set-start-child> {
    gtk_paned_set_start_child($!gtk-p, $child);
  }

  method set_wide_handle (Int() $wide) is also<set-wide-handle> {
    my gboolean $w = $wide.so.Int;

    gtk_paned_set_wide_handle($!gtk-p, $w);
  }

}

INIT {
  my \O = GTK::Panes;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

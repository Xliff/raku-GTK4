use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::BoxLayout:ver<4>;

use GTK::LayoutManager:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;

our subset GtkBoxLayoutAncestry is export of Mu
  where GtkBoxLayout | GtkOrientable | GtkLayoutManagerAncestry;

class GTK::BoxLayout:ver<4> is GTK::LayoutManager:ver<4> {
  also does GTK::Roles::Orientable;

  has GtkBoxLayout $!gtk-bl is implementor;

  submethod BUILD ( :$gtk-box-layout ) {
    self.setGtkBoxLayout($gtk-box-layout)
      if $gtk-box-layout
  }

  method setGtkBoxLayout (GtkBoxLayoutAncestry $_) {
    my $to-parent;

    $!gtk-bl = do {
      when GtkBoxLayout {
        $to-parent = cast(GtkLayoutManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkBoxLayout, $_);
      }
    }
    self.setGtkLayoutManager($to-parent);
  }

  method GTK::Raw::Definitions::GtkBoxLayout
    is also<GtkBoxLayout>
  { $!gtk-bl }

  multi method new (GtkBoxLayoutAncestry $gtk-box-layout, :$ref = True) {
    return unless $gtk-box-layout;

    my $o = self.bless( :$gtk-box-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientation) {
    my GtkOrientation $o = $orientation;

    my $gtk-box-layout = gtk_box_layout_new($o);

    $gtk-box-layout ?? self.bless( :$gtk-box-layout ) !! Nil
  }

  # Type: GtkBaselinePosition
  method baseline-position ( :$enum = True )
    is rw
    is g-property
    is also<baseline_position>
  {
    my $gv = GLib::Value.new-enum(GtkBaselinePosition);
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

  # Type: boolean
  method homogeneous is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('homogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('homogeneous', $gv);
      }
    );
  }

  # Type: int
  method spacing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('spacing', $gv);
      }
    );
  }

  method get_baseline_position ( :$enum = True )
    is also<get-baseline-position>
  {
    my $p = gtk_box_layout_get_baseline_position($!gtk-bl);
    return $p unless $enum;
    GtkBaselinePositionEnum($p);
  }

  method get_homogeneous is also<get-homogeneous> {
    so gtk_box_layout_get_homogeneous($!gtk-bl);
  }

  method get_spacing is also<get-spacing> {
    gtk_box_layout_get_spacing($!gtk-bl);
  }

  method set_baseline_position (Int() $position)
    is also<set-baseline-position>
  {
    my GtkBaselinePosition $p = $position;

    gtk_box_layout_set_baseline_position($!gtk-bl, $p);
  }

  method set_homogeneous (Int() $homogeneous) is also<set-homogeneous> {
    my gboolean $h = $homogeneous.so.Int;

    gtk_box_layout_set_homogeneous($!gtk-bl, $h);
  }

  method set_spacing (Int() $spacing) is also<set-spacing> {
    my guint $s = $spacing;

    gtk_box_layout_set_spacing($!gtk-bl, $s);
  }

}

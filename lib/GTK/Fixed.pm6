use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Fixed:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkFixedAncestry is export of Mu
  where GtkFixed | GtkWidgetAncestry;

class GTK::Fixed:ver<4> is GTK::Widget:ver<4> {
  has GtkFixed $!gtk-f is implementor;

  submethod BUILD ( :$gtk-fixed ) {
    self.setGtkFixed($gtk-fixed) if $gtk-fixed
  }

  method setGtkFixed (GtkFixedAncestry $_) {
    my $to-parent;

    $!gtk-f = do {
      when GtkFixed {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFixed, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkFixed
    is also<GtkFixed>
  { $!gtk-f }

  multi method new (
    $gtk-fixed where * ~~ GtkFixedAncestry,

    :$ref = True
  ) {
    return unless $gtk-fixed;

    my $o = self.bless( :$gtk-fixed );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-fixed = gtk_fixed_new();

    $gtk-fixed ?? self.bless( :$gtk-fixed ) !! Nil;
  }

  proto method get_child_position (|)
    is also<get-child-position>
  { * }

  multi method get_child_position (GtkWidget() $widget) {
    samewith($widget, $, $);
  }
  multi method get_child_position (
    GtkWidget() $widget,
                $x is rw,
                $y is rw
  ) {
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gtk_fixed_get_child_position($!gtk-f, $widget, $xx, $yy);
  }

  method get_child_transform (GtkWidget() $widget)
    is also<get-child-transform>
  {
    gtk_fixed_get_child_transform($!gtk-f, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_fixed_get_type, $n, $t );
  }

  method move (
    GtkWidget() $widget,
    Num()       $x,
    Num()       $y
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gtk_fixed_move($!gtk-f, $widget, $xx, $yy);
  }

  method put (
    GtkWidget() $widget,
    Num()       $x,
    Num()       $y
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gtk_fixed_put($!gtk-f, $widget, $xx, $yy);
  }

  method remove (GtkWidget() $widget) {
    gtk_fixed_remove($!gtk-f, $widget);
  }

  method set_child_transform (
    GtkWidget()    $widget,
    GskTransform() $transform
  )
    is also<set-child-transform>
  {
    gtk_fixed_set_child_transform($!gtk-f, $widget, $transform);
  }

}

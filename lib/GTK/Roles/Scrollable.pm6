use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Scrollable:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Scrollable {
  has GtkScrollable $!gtk-scroll is implementor;

  method roleInit-GtkScrollable {
    return if $!gtk-scroll;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-scroll = cast( GtkScrollable, i.get_value(self) )
  }

  method GTK::Raw::Definitions::GtkScrollable
  { $!gtk-scroll }
  method GtkScrollable
  { $!gtk-scroll }

  proto method get_border (|)
  { * }

  multi method get_border {
    samewith( GtkBorder.new );
  }
  multi method get_border (GtkBorder() $border) {
    gtk_scrollable_get_border($!gtk-scroll, $border);
    $border;
  }

  method get_hadjustment (:$raw = False ) {
    propReturnObject(
      gtk_scrollable_get_hadjustment($!gtk-scroll),
      $raw,
      |GTK::Adjustment.getTypePair
    );
  }

  method get_hscroll_policy ( :$enum = True ) {
    my $p = gtk_scrollable_get_hscroll_policy($!gtk-scroll);
    return $p unless $enum;
    GtkScrollablePolicyEnum($p);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &gtk_scrollable_get_type, $n, $t);
  }

  method get_vadjustment (:$raw = False ) {
    propReturnObject(
      gtk_scrollable_get_vadjustment($!gtk-scroll),
      $raw,
      |GTK::Adjustment.getTypePair
    );
  }

  method get_vscroll_policy ( :$enum = True ) {
    my $p = gtk_scrollable_get_vscroll_policy($!gtk-scroll);
    return $p unless $enum;
    GtkScrollablePolicyEnum($p);
  }

  method set_hadjustment (GtkAdjustment() $hadjustment) {
    gtk_scrollable_set_hadjustment($!gtk-scroll, $hadjustment);
  }

  method set_hscroll_policy (Int() $policy) {
    my GtkScrollablePolicy $p = $policy;

    gtk_scrollable_set_hscroll_policy($!gtk-scroll, $p);
  }

  method set_vadjustment (GtkAdjustment() $vadjustment) {
    gtk_scrollable_set_vadjustment($!gtk-scroll, $vadjustment);
  }

  method set_vscroll_policy (Int() $policy) {
    my GtkScrollablePolicy $p = $policy;

    gtk_scrollable_set_vscroll_policy($!gtk-scroll, $p);
  }

}


our subset GtkScrollableAncestry is export of Mu
  where GtkScrollable | GObject;

class GTK::Scrollable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Scrollable;

  submethod BUILD ( :$gtk-scrollable ) {
    self.setGtkScrollable($gtk-scrollable) if $gtk-scrollable
  }

  method setGtkScrollable (GtkScrollableAncestry $_) {
    my $to-parent;

    $!gtk-scroll = do {
      when GtkScrollable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkScrollable, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkScrollable;
  }

  multi method new (
     $gtk-scrollable where * ~~ GtkScrollableAncestry,

    :$ref = True
  ) {
    return unless $gtk-scrollable;

    my $o = self.bless( :$gtk-scrollable );
    $o.ref if $ref;
    $o;
  }

}

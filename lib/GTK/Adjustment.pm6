use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Adjustment:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkAdjustmentAncestry is export of Mu
  where GtkAdjustment | GObject;

class GTK::Adjustment:ver<4> {
  also does GLib::Roles::Object;

  has GtkAdjustment $!gtk-adj is implementor;

  submethod BUILD ( :$gtk-adjustment ) {
    self.setGtkAdjustment($gtk-adjustment) if $gtk-adjustment
  }

  method setGtkAdjustment (GtkAdjustmentAncestry $_) {
    my $to-parent;

    $!gtk-adj = do {
      when GtkAdjustment {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAdjustment, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Structs::GtkAdjustment
    is also<GtkAdjustment>
  { $!gtk-adj }

  multi method new (GtkAdjustmentAncestry $gtk-adjustment, :$ref = True) {
    return unless $gtk-adjustment;

    my $o = self.bless( :$gtk-adjustment );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Num() $value,
    Num() $lower          = 0,
    Num() $upper          = 100,
    Num() $step_increment = 1,
    Num() $page_increment = 10,
    Num() $page_size      = 100
  ) {
    say "Adj: { $value } / { $lower } / { $upper } / { $step_increment }";
    my gdouble ($v, $l, $u, $s, $p, $sz) =
      ($value, $lower, $upper, $step_increment, $page_increment, $page_size);

    my $gtk-adjustment = gtk_adjustment_new($v, $l, $u, $s, $p, $sz);

    $gtk-adjustment ?? self.bless( :$gtk-adjustment ) !! Nil;
  }
  multi method new (
    Range() $range,
            :v(:$value)              =  $range.min,
            :step_increment(:$step)  = ($range.max - $range.min) / 100,
            :page_increment(:$page)  = ($range.max - $range.min) / 10
  ) {
    samewith($value, $range.min, $range.max, $step, $page)
  }

  method clamp_page (Num() $lower, Num() $upper) is also<clamp-page> {
    my gdouble ($l, $u) = ($lower, $upper);

    gtk_adjustment_clamp_page($!gtk-adj, $l, $u);
  }

  method configure (
    Num() $value,
    Num() $lower,
    Num() $upper,
    Num() $step_increment,
    Num() $page_increment,
    Num() $page_size
  ) {
    my ($v, $l, $u, $s, $p, $sz) =
      ($value, $lower, $upper, $step_increment, $page_increment, $page_size);

    gtk_adjustment_configure($!gtk-adj, $v, $l, $u, $s, $p, $sz);
  }

  method get_lower is also<get-lower> {
    gtk_adjustment_get_lower($!gtk-adj);
  }

  method get_minimum_increment is also<get-minimum-increment> {
    gtk_adjustment_get_minimum_increment($!gtk-adj);
  }

  method get_page_increment is also<get-page-increment> {
    gtk_adjustment_get_page_increment($!gtk-adj);
  }

  method get_page_size is also<get-page-size> {
    gtk_adjustment_get_page_size($!gtk-adj);
  }

  method get_step_increment is also<get-step-increment> {
    gtk_adjustment_get_step_increment($!gtk-adj);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_adjustment_get_type, $n, $t );
  }

  method get_upper is also<get-upper> {
    gtk_adjustment_get_upper($!gtk-adj);
  }

  method get_value is also<get-value> {
    gtk_adjustment_get_value($!gtk-adj);
  }

  method set_lower (Num() $lower) is also<set-lower> {
    my gdouble $l = $lower;

    gtk_adjustment_set_lower($!gtk-adj, $l);
  }

  method set_page_increment (Num() $page_increment)
    is also<set-page-increment>
  {
    my gdouble $i = $page_increment;

    gtk_adjustment_set_page_increment($!gtk-adj, $i);
  }

  method set_page_size (Num() $page_size) is also<set-page-size> {
    my gdouble $s = $page_size;

    gtk_adjustment_set_page_size($!gtk-adj, $s);
  }

  method set_step_increment (Num() $step_increment)
    is also<set-step-increment>
  {
    my gdouble $s = $step_increment;

    gtk_adjustment_set_step_increment($!gtk-adj, $s);
  }

  method set_upper (Num() $upper) is also<set-upper> {
    my gdouble $u = $upper;

    gtk_adjustment_set_upper($!gtk-adj, $u);
  }

  method set_value (Num() $value) is also<set-value> {
    my gdouble $v = $value;

    gtk_adjustment_set_value($!gtk-adj, $v);
  }

}

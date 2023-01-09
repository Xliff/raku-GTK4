use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Constraint::Guide:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkConstraintGuideAncestry is export of Mu
  where GtkConstraintGuide | GObject;

class GTK::Constraint::Guide:ver<4> {
  also does GLib::Roles::Object;

  has GtkConstraintGuide $!gtk-cg is implementor;

  submethod BUILD ( :$gtk-constraint-guide ) {
    self.setGtkConstraintGuide($gtk-constraint-guide)
      if $gtk-constraint-guide
  }

  method setGtkConstraintGuide (GtkConstraintGuideAncestry $_) {
    my $to-parent;

    $!gtk-cg = do {
      when GtkConstraintGuide {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkConstraintGuide, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkConstraintGuide
    is also<GtkConstraintGuide>
  { $!gtk-cg }

  multi method new (
     $gtk-constraint-guide where * ~~ GtkConstraintGuideAncestry,

    :$ref = True
  ) {
    return unless $gtk-constraint-guide;

    my $o = self.bless( :$gtk-constraint-guide );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-constraint-guide = gtk_constraint_guide_new();

    $gtk-constraint-guide ?? self.bless( :$gtk-constraint-guide ) !! Nil;
  }

  proto method get_max_size (|)
    is also<get-max-size>
  { * }

  multi method get_max_size {
    samewith($, $);
  }
  multi method get_max_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_constraint_guide_get_max_size($!gtk-cg, $w, $h);
    ($width, $height) = ($w, $h);
  }

  proto method get_min_size (|)
    is also<get-min-size>
  { * }

  multi method get_min_size {
    samewith($, $);
  }
  multi method get_min_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_constraint_guide_get_min_size($!gtk-cg, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_name is also<get-name> {
    gtk_constraint_guide_get_name($!gtk-cg);
  }

  proto method get_nat_size (|)
    is also<get-nat-size>
  { * }

  multi method get_nat_size {
    samewith($, $);
  }
  multi method get_nat_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_constraint_guide_get_nat_size($!gtk-cg, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_strength ( :$enum = True ) is also<get-strength> {
    my $s = gtk_constraint_guide_get_strength($!gtk-cg);
    return $s unless $enum;
    GtkConstraintStrengthEnum($s)
  }

  method set_max_size (Int() $width, Int() $height) is also<set-max-size> {
    my gint ($w, $h) = ($width, $height) xx 2;

    gtk_constraint_guide_set_max_size($!gtk-cg, $w, $h);
  }

  method set_min_size (Int() $width, Int() $height) is also<set-min-size> {
    my gint ($w, $h) = ($width, $height) xx 2;

    gtk_constraint_guide_set_min_size($!gtk-cg, $w, $h);
  }

  method set_name (Str() $name) is also<set-name> {
    gtk_constraint_guide_set_name($!gtk-cg, $name);
  }

  method set_nat_size (Int() $width, Int() $height) is also<set-nat-size> {
    my gint ($w, $h) = ($width, $height) xx 2;

    gtk_constraint_guide_set_nat_size($!gtk-cg, $w, $h);
  }

  method set_strength (Int() $strength) is also<set-strength> {
    my GtkConstraintStrength $s = $strength;

    gtk_constraint_guide_set_strength($!gtk-cg, $s);
  }

}

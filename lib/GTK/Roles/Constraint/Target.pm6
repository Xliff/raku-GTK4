use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Constraint::Target:ver<4> {
  has GtkConstraintTarget $!gtk-ct is implementor;

  method roleInit-GtkConstraintTarget {
    return if $!gtk-ct;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-ct = cast( GtkConstraintTarget, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkConstraintTarget
  { $!gtk-ct }
  method GtkConstraintTarget
  { $!gtk-ct }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_constraint_target_get_type, $n, $t );
  }

}


our subset GtkConstraintTargetAncestry is export of Mu
  where GtkConstraintTarget | GObjectAncestry;

class GTK::Constraint::Target:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Constraint::Target;

  submethod BUILD ( :$gtk-constraint-target ) {
    self.setGtkConstraintTarget($gtk-constraint-target)
      if $gtk-constraint-target
  }

  method setGtkConstraintTarget (GtkConstraintTargetAncestry $_) {
    my $to-parent;

    $!gtk-ct = do {
      when GtkConstraintTarget {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkConstraintTarget, $_);
      }
    }
    self!setGObject($to-parent);
  }

  multi method new (
    GtkConstraintTargetAncestry  $gtk-constraint-target,
                                :$ref                    = True
  ) {
    return unless $gtk-constraint-target;

    my $o = self.bless( :$gtk-constraint-target );
    $o.ref if $ref;
    $o;
  }

}

use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Constraint::Layout:ver<4>;

use GLib::GList;

use GTK::LayoutManager:ver<4>;

class GTK::Constraint::Layout:ver<4> is GTK::LayoutManager:ver<4> {
  has GtkConstraintLayout $!gtk-cl is implementor;

  method new {
    my $gtk-constraint-layout = gtk_constraint_layout_new();

    $gtk-constraint-layout ?? self.bless( :$gtk-constraint-layout ) !! Nil;
  }

  method add_constraint (GtkConstraint() $constraint) {
    gtk_constraint_layout_add_constraint($!gtk-cl, $constraint);
  }

  multi method add_constraints_from_description (
    Str                      $lines,
    Int()                    $n_lines,
    Int()                    $hspacing,
    Int()                    $vspacing,
    CArray[Pointer[GError]]  $error,
                            *@view-targets,
                            :$raw           = False,
                            :$glist         = False
  ) {
    self.add_constraints_from_descriptionv(
       $lines,
       $n_lines,
       $hspacing,
       $vspacing,
       GLib::Hashtable.new(@view-targets),
       $error,
      :$raw,
      :$glist
    )
  }
  multi method add_constraints_from_description (
    Str()                    $lines,
    Int()                    $n_lines,
    Int()                    $hspacing,
    Int()                    $vspacing,
                             %views,
    CArray[Pointer[GError]]  $error      = gerror,
                            :$raw        = False,
                            :$glist      = False
  ) {
    samewith(
       $lines,
       $n_lines,
       $hspacing,
       $vspacing,
       GLib::HashTable.new(%views),
       $error,
      :$raw,
      :$glist
    );
  }
  multi method add_constraints_from_descriptionv (
    Str()                    $lines,
    Int()                    $n_lines,
    Int()                    $hspacing,
    Int()                    $vspacing,
    GHashTable()             $views,
    CArray[Pointer[GError]]  $error      = gerror,
                            :$raw        = False,
                            :$glist      = False
  ) {
    my gsize  $n      =  $n_lines;
    my gint  ($h, $v) = ($hspacing, $vspacing);

    returnGList(
      gtk_constraint_layout_add_constraints_from_descriptionv(
        $!gtk-cl,
        $lines,
        $n,
        $h,
        $v,
        $views,
        $error
      ),
      $raw,
      $glist,
      |GTK::Constraint.getTypePair
    );
  }

  method add_guide (GtkConstraintGuide() $guide) {
    gtk_constraint_layout_add_guide($!gtk-cl, $guide);
  }

  # cw: Needs a returnListModel
  method observe_constraints ( :$raw = False, :$list = False ) {
    # List of GtkConstraint
    propReturnObject(
      gtk_constraint_layout_observe_constraints($!gtk-cl),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  # cw: Needs a returnListModel
  method observe_guides (:$raw = False, :$list = False ) {
    # List of GtkConstraintGuide
    propReturnObject(
      gtk_constraint_layout_observe_guides($!gtk-cl),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method remove_all_constraints {
    gtk_constraint_layout_remove_all_constraints($!gtk-cl);
  }

  method remove_constraint (GtkConstraint() $constraint) {
    gtk_constraint_layout_remove_constraint($!gtk-cl, $constraint);
  }

  method remove_guide (GtkConstraintGuide() $guide) {
    gtk_constraint_layout_remove_guide($!gtk-cl, $guide);
  }

}

class GTK::Constraint::VFLParser {
  also does GLib::Roles::StaticClass;

  method error_quark {
    gtk_constraint_vfl_parser_error_quark();
  }

}

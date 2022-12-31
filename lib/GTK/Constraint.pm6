

  method get_constant {
    gtk_constraint_get_constant($!gtk-c);
  }

  method get_multiplier {
    gtk_constraint_get_multiplier($!gtk-c);
  }

  method get_relation {
    gtk_constraint_get_relation($!gtk-c);
  }

  method get_source {
    gtk_constraint_get_source($!gtk-c);
  }

  method get_source_attribute {
    gtk_constraint_get_source_attribute($!gtk-c);
  }

  method get_strength {
    gtk_constraint_get_strength($!gtk-c);
  }

  method get_target {
    gtk_constraint_get_target($!gtk-c);
  }

  method get_target_attribute {
    gtk_constraint_get_target_attribute($!gtk-c);
  }

  method is_attached {
    gtk_constraint_is_attached($!gtk-c);
  }

  method is_constant {
    gtk_constraint_is_constant($!gtk-c);
  }

  method is_required {
    gtk_constraint_is_required($!gtk-c);
  }

  method new (
    GtkConstraintAttribute $target_attribute,
    GtkConstraintRelation  $relation,
    gpointer               $source,
    GtkConstraintAttribute $source_attribute,
    gdouble                $multiplier,
    gdouble                $constant,
    gint                   $strength
  ) {
    gtk_constraint_new($!gtk-c, $target_attribute, $relation, $source, $source_attribute, $multiplier, $constant, $strength);
  }

  method new_constant (
    GtkConstraintAttribute $target_attribute,
    GtkConstraintRelation  $relation,
    gdouble                $constant,
    gint                   $strength
  ) {
    gtk_constraint_new_constant($!gtk-c, $target, $target_attribute, $relation, $constant, $strength);
  }

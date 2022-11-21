use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Accessible;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Accessible:ver<4> {
  has GtkAccessible $!gtk-a is implementor;

  # Type: GTKAccessibleRole
  method accessible-role is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkAccessibleRole) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accessible-role', $gv);
        $gv.valueFromEnum(GtkAccessibleRole);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkAccessibleRole) = $val;
        self.prop_set('accessible-role', $gv);
      }
    );
  }


  method get_accessible_role is also<get-accessible-role> {
    gtk_accessible_get_accessible_role($!gtk-a);
  }

  proto method property_init_value (|)
    is also<property-init-value>
  { * }

  multi method property_init_value (Int() $property) {
    samewith(
      $property,
      GLib::Value.alloc( GLib::Value.ty peFromEnum(GtkAccessibleProperty) )
    );
  }
  multi method property_init_value (Int() $property, GValue() $value)
    is static
  {
    my GtkAccessibleProperty $p = $property;

    gtk_accessible_property_init_value($p, $value);
  }

  proto method relation_init_value (|)
    is also<relation-init-value>
  { * }

  multi method relation_init_value (Int() $relation) {
    samewith( $relation, GLib::Value.typeFromEnum(GtkAccessibleRelation) )
  }
  multi method relation_init_value (Int() $relation, GValue() $value) {
    my GtkAccessibleRelation $r = $relation;

    gtk_accessible_relation_init_value($!gtk-a, $value);
  }

  method reset_property (Int() $property) is also<reset-property> {
    my GtkAccessibleProperty $p = $property;

    gtk_accessible_reset_property($!gtk-a, $p);
  }

  method reset_relation (Int() $relation) is also<reset-relation> {
    my GtkAccessibleRelation $r = $relation;

    gtk_accessible_reset_relation($!gtk-a, $r);
  }

  method reset_state (Int() $state) is also<reset-state> {
    my GtkAccessibleState $s = $state;

    gtk_accessible_reset_state($!gtk-a, $s);
  }

  method state_init_value (GValue() $value) is also<state-init-value> {
    gtk_accessible_state_init_value($!gtk-a, $value);
  }

  method update_property (Int() $first_property) is also<update-property> {
    my GtkAccessibleProperty $f = $first_property;

    gtk_accessible_update_property($!gtk-a, $f);
  }

  proto method update_property_value (|)
    is also<update-property-value>
  { * }

  multi method update_property_value (@properties, :$raw = False) {
    samewith(
      @properties.elems,
      ArrayToCArray(GtkAccessibleProperty, @properties),
      GLib::Value.alloc( GLib::Value.typeFromEnum(GtkAccessibleProperty) ),
      :$raw
    );
  }
  multi method update_property_value (
    Int()                          $n_properties,
    CArray[GtkAccessibleProperty]  $properties,
    GValue()                       $values,
                                  :$raw            = False
  ) {
    my gint $n = $n_properties;

    propReturnObject(
      gtk_accessible_update_property_value($!gtk-a, $n, $properties, $values).
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method update_relation (Int() $first_relation) is also<update-relation> {
    my GtkAccessibleRelation $f = $first_relation;

    gtk_accessible_update_relation($!gtk-a, $f, Str);
  }
  method update_relations (*@relations where *.elems > 1);
    self.update_relation(@relations);
  }
  method update_relations (@relations)
    is also<update-relations>
  {
    self.update_relation($_) for @relations;
  }

  method update_relation_value (|)

    is also<update-relation-value>
  { * }

  multi method update_relation_value (@relations, :$raw = False) is also<update-relation-value> {
    samewith(
      @relations.elems,
      ArrayToCArray(GtkAccessibleRelations, @relations),
      :$raw
    );
  }
  multi method update_relation_value (
    Int()                         $n_relations,
    CArray[GtkAccessibleRelation] $relations,
    GValue()                      $values
  )
    is also<update-relation-value>
  {
    my gint $n = $n_relations;

    gtk_accessible_update_relation_value(
      $!gtk-a,
      $n,
      $relations,
      $values
    );
    propReturnObject($values, $raw, |GLib::Value.getTypePair);
  }

  method update_state (Int() $first_state) is also<update-state> {
    my GtkAccessibleState $f = $first_state;

    gtk_accessible_update_state($!gtk-a, $first_state, Str);
  }

  proto method update_state_value (|)
    is also<update-state-value>
  { * }

  multi method update_state_value (@states, :$raw = False) {
    samewith(
      @states.elems,
      ArrayToCArray(GtkAccessibleState, @states),
      :$raw
    );
  }
  multi method update_state_value (
    Int()                       $n_states,
    CArary[GtkAccessibleState]  $states,
    GValue()                    $values,
                               :$raw        = False
  ) {
    my gint $n = $n_states;

    gtk_accessible_update_state_value($!gtk-a, $n, $states, $values);
    propReturnObject(
      $values,
      $raw,
      |GLib::Value.getTypePair
    );
  }

}


our subset GtkAccessibleAncestry is export of Mu
  where GtkAccessible | GObject;

class GTK::Accessible:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Accessible;

  submethod BUILD ( :$gtk-accessible ) {
    self.setGtkAccessible($gtk-accessible) if $gtk-accessible
  }

  method setGtkAccessible (GtkAccessibleAncestry $_) {
    my $to-parent;

    $!gtk-a = do {
      when GtkAccessible {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAccessible, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkAccessible
    is also<GtkAccessible>
  { $!gtk-a }

  multi method new (GtkAccessibleAncestry $gtk-accessible, :$ref = True) {
    return unless $gtk-accessible;

    my $o = self.bless( :$gtk-accessible );
    $o.ref if $ref;
    $o;
  }

}

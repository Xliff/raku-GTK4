use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Actionable:ver<4>;

use GLib::Variant;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Actionable:ver<4> {
  has GtkActionable $!gtk-action is implementor;

  method GTK::Raw::Definitions::GtkActionable
    is also<GtkActionable>
  { $!gtk-action }

  method roleInit-GtkActionable is also<roleInit_GtkActionable> {
    return if $!gtk-action;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-action = cast( GtkActionable, i.get_value(self) )
  }

  # Type: string
  method action-name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('action-name', $gv);
      }
    );
  }

  # Type: GVariant
  method action-target ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Variant.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action-target', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |GLib::Variant.getTypePair
        );
      },
      STORE => -> $, GVariant() $val is copy {
        $gv.pointer = $val;
        self.prop_set('action-target', $gv);
      }
    );
  }

  method get_action_name is also<get-action-name> {
    gtk_actionable_get_action_name($!gtk-action);
  }

  method get_action_target_value ( :$raw = False )
    is also<get-action-target-value>
  {
    propReturnObject(
      gtk_actionable_get_action_target_value($!gtk-action),
      $raw,
      |GLib::Variant.getTypePair
    );
  }

  method gtkactionable_get_type is also<gtkactionable-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_actionable_get_type, $n, $t );

  }

  method set_action_name (Str() $action_name) is also<set-action-name> {
    gtk_actionable_set_action_name($!gtk-action, $action_name);
  }

  method set_action_target (Str() $format_string) is also<set-action-target> {
    gtk_actionable_set_action_target($!gtk-action, $format_string);
  }

  method set_action_target_value (GVariant() $target_value)
    is also<set-action-target-value>
  {
    gtk_actionable_set_action_target_value($!gtk-action, $target_value);
  }

  method set_detailed_action_name (Str() $detailed_action_name)
    is also<set-detailed-action-name>
  {
    gtk_actionable_set_detailed_action_name(
      $!gtk-action,
      $detailed_action_name
    );
  }

}


our subset GtkActionableAncestry is export of Mu
  where GtkActionable | GObject;

class GTK::Actionable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Actionable;

  submethod BUILD ( :$gtk-actionable ) {
    self.setGtkActionable($gtk-actionable) if $gtk-actionable;
  }

  method setGtkActionable (GtkActionableAncestry $_) {
    my $to-parent;

    $!gtk-action = do {
      when GtkActionable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkActionable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
     $gtk-actionable where * ~~ GtkActionableAncestry,

    :$ref = True
  ) {
    return unless $gtk-actionable;

    my $o = self.bless( :$gtk-actionable );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    self.gtk_actionable_get_type;
  }

}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Shortcut:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkShortcutAncestry is export of Mu
  where GtkShortcut | GObject;

class GTK::Shortcut:ver<4> {
  also does GLib::Roles::Object;

  has GtkShortcut $!gtk-s is implementor;

  submethod BUILD ( :$gtk-shortcut ) {
    self.setGtkShortcut($gtk-shortcut) if $gtk-shortcut
  }

  method setGtkShortcut (GtkShortcutAncestry $_) {
    my $to-parent;

    $!gtk-s = do {
      when GtkShortcut {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcut, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcut
    is also<GtkShortcut>
  { $!gtk-s }

  multi method new (
    $gtk-shortcut where * ~~ GtkShortcutAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcut;

    my $o = self.bless( :$gtk-shortcut );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkShortcutTrigger() $trigger,
    GtkShortcutAction()  $action
  ) {
    my $gtk-shortcut = gtk_shortcut_new($trigger, $action);

    $gtk-shortcut ?? self.bless( :$gtk-shortcut ) !! Nil;
  }

  method new_with_arguments (
    GtkShortcutTrigger() $trigger,
    GtkShortcutAction()  $action,
    Str()                $format_string
  )
    is also<new-with-arguments>
  {
    my $gtk-shortcut = gtk_shortcut_new_with_arguments(
      $trigger,
      $action,
      $format_string,
      Str
    );

    $gtk-shortcut ?? self.bless( :$gtk-shortcut ) !! Nil;
  }

  # Type: GtkShortcutAction
  method action ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Shortcut::Action.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Shortcut::Action.getTypePair
        );
      },
      STORE => -> $, GtkShortcutAction() $val is copy {
        $gv.object = $val;
        self.prop_set('action', $gv);
      }
    );
  }

  # Type: GVariant
  method arguments ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Variant.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('arguments', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Variant.getTypePair
        );
      },
      STORE => -> $, GVariant() $val is copy {
        $gv.object = $val;
        self.prop_set('arguments', $gv);
      }
    );
  }

  # Type: GtkShortcutTrigger
  method trigger ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Shortcut::Trigger.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('trigger', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Shortcut::Trigger.getTypePair
        );
      },
      STORE => -> $, GtkShortcutTrigger() $val is copy {
        $gv.object = $val;
        self.prop_set('trigger', $gv);
      }
    );
  }

  method get_action ( :$raw = False ) is also<get-action> {
    propReturnObject(
      gtk_shortcut_get_action($!gtk-s),
      $raw,
      |GTK::Shortcut::Action.getTypePair
    );
  }

  method get_arguments ( :$raw = False ) is also<get-arguments> {
    propReturnObject(
      gtk_shortcut_get_arguments($!gtk-s),
      $raw,
      |GLib::Variant.getTypePair
    );
  }

  method get_trigger ( :$raw = False ) is also<get-trigger> {
    propReturnObject(
      gtk_shortcut_get_trigger($!gtk-s),
      $raw,
      |GTK::Shortcut::Trigger.getTypePair
    );
  }

  method set_action (GtkShortcutAction() $action) is also<set-action> {
    gtk_shortcut_set_action($!gtk-s, $action);
  }

  method set_arguments (GVariant() $args) is also<set-arguments> {
    gtk_shortcut_set_arguments($!gtk-s, $args);
  }

  method set_trigger (GtkShortcutTrigger() $trigger) is also<set-trigger> {
    gtk_shortcut_set_trigger($!gtk-s, $trigger);
  }

}

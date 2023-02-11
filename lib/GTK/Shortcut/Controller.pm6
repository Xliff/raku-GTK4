use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Shortcut::Controller:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkShortcutControllerAncestry is export of Mu
  where GtkShortcutController | GObject;

class GTK::Shortcut::Controller:ver<4> {
  also does GLib::Roles::Object;

  has GtkShortcutController $!gtk-sc is implementor;

  submethod BUILD ( :$gtk-shortcut-controller ) {
    self.setGtkShortcutController($gtk-shortcut-controller)
      if $gtk-shortcut-controller
  }

  method setGtkShortcutController (GtkShortcutControllerAncestry $_) {
    my $to-parent;

    $!gtk-sc = do {
      when GtkShortcutController {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutController, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutController
    is also<GtkShortcutController>
  { $!gtk-sc }

  multi method new (
    $gtk-shortcut-controller where * ~~ GtkShortcutControllerAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcut-controller;

    my $o = self.bless( :$gtk-shortcut-controller );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-shortcut-controller = gtk_shortcut_controller_new();

    $gtk-shortcut-controller ?? self.bless( :$gtk-shortcut-controller ) !! Nil;
  }

  method new_for_model (GListModel() $model) is also<new-for-model> {
    my $gtk-shortcut-controller =
      gtk_shortcut_controller_new_for_model($model);

    $gtk-shortcut-controller ?? self.bless( :$gtk-shortcut-controller ) !! Nil;
  }

  # Type: GObject
  method item-type is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new( GTK::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        GLib::Object.new( $gv.object );
      },
      STORE => -> $,  $val is copy {
        warn 'item-type does not allow writing'
      }
    );
  }

  # Type: GdkModifierType
  method mnemonic-modifiers ( :set(:$flags) )
    is rw
    is g-property
    is also<mnemonic_modifiers>
  {
    my $gv = GLib::Value.new-enum( GdkModifierType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mnemonic-modifiers', $gv);
        my $m = $gv.enum;
        return $m unless $flags;
        getFlags(GdkModifierTypeEnum, $m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdkModifierType) = $val;
        self.prop_set('mnemonic-modifiers', $gv);
      }
    );
  }

  # Type: GListModel
  method model is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'model does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GListModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: uint
  method n-items is rw  is g-property is also<n_items> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-items', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-items does not allow writing'
      }
    );
  }

  # Type: GtkShortcutScope
  method scope ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Shortcut::Scope.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scope', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Shortcut::Scope.getTypePair
        )
      },
      STORE => -> $, GtkShortcutScope() $val is copy {
        $gv.object = $val;
        self.prop_set('scope', $gv);
      }
    );
  }

  method add_shortcut (GtkShortcut() $shortcut) is also<add-shortcut> {
    gtk_shortcut_controller_add_shortcut($!gtk-sc, $shortcut);
  }

  method get_mnemonics_modifiers ( :set(:$flags) )
    is also<get-mnemonics-modifiers>
  {
    my $m = gtk_shortcut_controller_get_mnemonics_modifiers($!gtk-sc);
    return $m unless $flags;
    getFlags(GdkModifierTypeEnum, $m);
  }

  method get_scope ( :$raw = False ) is also<get-scope> {
    propReturnObject(
      gtk_shortcut_controller_get_scope($!gtk-sc),
      $raw,
      |GTK::Shortcut::Scope.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_shortcut_controller_get_type,
      $n,
      $t
    );
  }

  method remove_shortcut (GtkShortcut() $shortcut) is also<remove-shortcut> {
    gtk_shortcut_controller_remove_shortcut($!gtk-sc, $shortcut);
  }

  method set_mnemonics_modifiers (Int() $modifiers)
    is also<set-mnemonics-modifiers>
  {
    my GdkModifierType $m = $modifiers;

    gtk_shortcut_controller_set_mnemonics_modifiers($!gtk-sc, $m);
  }

  method set_scope (GtkShortcutScope() $scope) is also<set-scope> {
    gtk_shortcut_controller_set_scope($!gtk-sc, $scope);
  }

}

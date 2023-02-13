use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Shortcut::Action:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GtkShortcutActionAncestry is export of Mu
  where GtkShortcutAction | GObject;

class GTK::Shortcut::Action {
  also does GLib::Roles::Object;

  has GtkShortcutAction $!gtk-sa is implementor;

  submethod BUILD ( :$gtk-shorcut-action ) {
    self.setGtkShortcutAction($gtk-shorcut-action) if $gtk-shorcut-action
  }

  method setGtkShortcutAction (GtkShortcutActionAncestry $_) {
    my $to-parent;

    $!gtk-sa = do {
      when GtkShortcutAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutAction
    is also<GtkShortcutAction>
  { $!gtk-sa }

  multi method new (
     $gtk-shorcut-action where * ~~ GtkShortcutActionAncestry,
    :$ref = True
  ) {
    return unless $gtk-shorcut-action;

    my $o = self.bless( :$gtk-shorcut-action );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $string) {
    self.parse_string($string);
  }

  method parse_string (Str() $string) is also<parse-string> {
    my $gtk-action = gtk_shortcut_action_parse_string($string);

    my token param { \s+ '(' \w+ ')' }

    (
      do given $string {
        when 'nothing'            { ::('GTK::Shortcut::Action::Nothing')  }
        when 'activate'           { ::('GTK::Shortcut::Action::Activate') }
        when 'mnemonic-activate'  { ::('GTK::Shortcut::Action::Mnemonic') }
        when / 'action' <param> / { ::('GTK::Shortcut::Action::Named')    }
        when / 'signal' <param> / { ::('GTK::Shortcut::Action::Signal')   }
      }
    ).new($gtk-action);
  }

  method print (GString() $string) {
    gtk_shortcut_action_print($!gtk-sa, $string);
  }

  method to_string is also<to-string> {
    gtk_shortcut_action_to_string($!gtk-sa);
  }

}


our subset GtkNothingActionAncestry is export of Mu
  where GtkNothingAction | GtkShortcutActionAncestry;

class GTK::Shortcut::Action::Nothing is GTK::Shortcut::Action {
  has GtkNothingAction $!gtk-na is implementor;

  submethod BUILD ( :$gtk-nothing-action ) {
    self.setGtkNothingAction($gtk-nothing-action) if $gtk-nothing-action
  }

  method setGtkNothingAction (GtkNothingActionAncestry $_) {
    my $to-parent;

    $!gtk-na = do {
      when GtkNothingAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNothingAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkNothingAction
    is also<GtkNothingAction>
  { $!gtk-na }

  multi method new (
     $gtk-nothing-action where * ~~ GtkNothingActionAncestry,

    :$ref = True
  ) {
    return unless $gtk-nothing-action;

    my $o = self.bless( :$gtk-nothing-action );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    self.get()
  }

  method get {
    my $gtk-nothing-action = gtk_nothing_action_get();

    $gtk-nothing-action ?? self.bless( :$gtk-nothing-action ) !! Nil;
  }

}


our subset GtkCallbackActionAncestry is export of Mu
  where GtkCallbackAction | GtkShortcutActionAncestry;

class GTK::Shortcut::Action::Callback is GTK::Shortcut::Action {
  has GtkCallbackAction $!gtk-ca is implementor;

  submethod BUILD ( :$gtk-nothing-action ) {
    self.setGtkCallbackAction($gtk-nothing-action)
      if $gtk-nothing-action
  }

  method setGtkCallbackAction (GtkCallbackActionAncestry $_) {
    my $to-parent;

    $!gtk-ca = do {
      when GtkCallbackAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCallbackAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkCallbackAction
    is also<GtkCallbackAction>
  { $!gtk-ca }

  multi method new (
    $gtk-nothing-action where * ~~ GtkCallbackActionAncestry,

    :$ref = True
  ) {
    return unless $gtk-nothing-action;

    my $o = self.bless( :$gtk-nothing-action );
    $o.ref if $ref;
    $o;
  }
  multi method new (
             &callback,
    gpointer $data      = gpointer,
             &destroy   = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    my $gtk-callback-action = gtk_callback_action_new(
      &callback,
      $data,
      &destroy
    );

    $gtk-callback-action ?? self.bless( :$gtk-callback-action ) !! Nil
  }

}


our subset GtkNamedActionAncestry is export of Mu
  where GtkNamedAction | GtkShortcutActionAncestry;

class GTK::Shortcut::Action::Named is GTK::Shortcut::Action {
  has GtkNamedAction $!gtk-na is implementor;

  submethod BUILD ( :$gtk-named-action ) {
    self.setGtkNamedAction($gtk-named-action)
      if $gtk-named-action
  }

  method setGtkNamedAction (GtkNamedActionAncestry $_) {
    my $to-parent;

    $!gtk-na = do {
      when GtkNamedAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNamedAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkNamedAction
    is also<GtkNamedAction>
  { $!gtk-na }

  multi method new (
    $gtk-named-action where * ~~ GtkNamedActionAncestry,

    :$ref = True
  ) {
    return unless $gtk-named-action;

    my $o = self.bless( :$gtk-named-action );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name) {
    my $gtk-named-action = gtk_named_action_new($name);

    $gtk-named-action ?? self.bless( :$gtk-named-action ) !! Nil;
  }

  method get_action_name is also<get-action-name> {
    gtk_named_action_get_action_name($!gtk-na);
  }

}


our subset GtkSignalActionAncestry is export of Mu
  where GtkSignalAction | GtkShortcutActionAncestry;

class GTK::Shortcut::Action::Signal is GTK::Shortcut::Action {
  has GtkSignalAction $!gtk-ssa is implementor;

  submethod BUILD ( :$gtk-s-action ) {
    self.setGtkSignalAction($gtk-s-action) if $gtk-s-action
  }

  method setGtkSignalAction (GtkSignalActionAncestry $_) {
    my $to-parent;

    $!gtk-ssa = do {
      when GtkSignalAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSignalAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkSignalAction
    is also<GtkSignalAction>
  { $!gtk-ssa }

  multi method new ($gtk-s-action where * ~~ GtkSignalActionAncestry, :$ref = True) {
    return unless $gtk-s-action;

    my $o = self.bless( :$gtk-s-action );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $signal-name) {
    my $gtk-signal-action = gtk_signal_action_new($signal-name);

    $gtk-signal-action ?? self.bless( :$gtk-signal-action ) !! Nil;
  }

  method get_signal_name is also<get-signal-name> {
    gtk_signal_action_get_signal_name($!gtk-ssa);
  }

}


our subset GtkActivateActionAncestry is export of Mu
  where GtkActivateAction | GtkShortcutActionAncestry;

class GTK::Shortcut::Action::Activate is GTK::Shortcut::Action {
  has GtkActivateAction $!gtk-aa is implementor;

  submethod BUILD ( :$gtk-s-action ) {
    self.setGtkActivateAction($gtk-s-action)
      if $gtk-s-action
  }

  method setGtkActivateAction (GtkActivateActionAncestry $_) {
    my $to-parent;

    $!gtk-aa = do {
      when GtkActivateAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkActivateAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkActivateAction
    is also<GtkActivateAction>
  { $!gtk-aa }

  multi method new ($gtk-s-action where * ~~ GtkActivateActionAncestry, :$ref = True) {
    return unless $gtk-s-action;

    my $o = self.bless( :$gtk-s-action );
    $o.ref if $ref;
    $o;
  }

  method activate (Int() $flags, GtkWidget() $widget, GVariant() $args) {
    my GtkShortcutActionFlags $f = $flags,

    gtk_shortcut_action_activate($!gtk-aa, $f, $widget, $args);
  }

  method get {
    my $gtk-activate-action = gtk_activate_action_get();

    $gtk-activate-action ?? self.bless( :$gtk-activate-action ) !! Nil
  }

}


our subset GtkMnemonicActionAncestry is export of Mu
  where GtkMnemonicAction | GtkShortcutActionAncestry;

class GTK::Shortcut::Action::Mnemonic is GTK::Shortcut::Action {
  has GtkMnemonicAction $!gtk-ma is implementor;

  submethod BUILD ( :$gtk-s-action ) {
    self.setGtkMnemonicAction($gtk-s-action) if $gtk-s-action
  }

  method setGtkMnemonicAction (GtkMnemonicActionAncestry $_) {
    my $to-parent;

    $!gtk-ma = do {
      when GtkMnemonicAction {
        $to-parent = cast(GtkShortcutAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMnemonicAction, $_);
      }
    }
    self.setGtkShortcutAction($to-parent);
  }

  method GTK::Raw::Definitions::GtkMnemonicAction
    is also<GtkMnemonicAction>
  { $!gtk-ma }

  multi method new ($gtk-s-action where * ~~ GtkMnemonicActionAncestry, :$ref = True) {
    return unless $gtk-s-action;

    my $o = self.bless( :$gtk-s-action );
    $o.ref if $ref;
    $o;
  }

  method get {
    my $gtk-mnemonic-action = gtk_mnemonic_action_get();

    $gtk-mnemonic-action ?? self.bless( :$gtk-mnemonic-action ) !! Nil
  }

}

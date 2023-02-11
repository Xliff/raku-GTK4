use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Shortcut::Action:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Shortcut::Action {
  also does GLib::Roles::Object;

  has GtkShortcutAction $!gtk-sa is implementor;

  method parse_string (Str() $string) {
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

  method to_string {
    gtk_shortcut_action_to_string($!gtk-sa);
  }

}

class GTK::Shortcut::Action::Nothing is GTK::Shortcut::Action {
  has GtkNothingAction $!gtk-na is implementor;

  method get {
    my $gtk-nothing-action = gtk_nothing_action_get();

    $gtk-nothing-action ?? self.bless( :$gtk-nothing-action ) !! Nil;
  }

}

class GTK::Shortcut::Action::Callback is GTK::Shortcut::Action {
  has GtkCallbackAction $!gtk-ca is implementor;

  method new (
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

class GTK::Shortcut::Action::Named is GTK::Shortcut::Action {
  has GtkNamedAction $!gtk-na is implementor;

  method new (Str() $name) {
    my $gtk-named-action = gtk_named_action_new($name);

    $gtk-named-action ?? self.bless( :$gtk-named-action ) !! Nil;
  }

  method get_action_name {
    gtk_named_action_get_action_name($!gtk-na);
  }

}

class GTK::Shortcut::Action::Signal is GTK::Shortcut::Action {
  has GtkSignalAction $!gtk-ssa is implementor;

  method new (Str() $signal-name) {
    my $gtk-signal-action = gtk_signal_action_new($signal-name);

    $gtk-signal-action ?? self.bless( :$gtk-signal-action ) !! Nil;
  }

  method get_signal_name {
    gtk_signal_action_get_signal_name($!gtk-ssa);
  }

}

class GTK::Shortcut::Action::Activate is GTK::Shortcut::Action {
  has GtkActivateAction $!gtk-aa is implementor;

  method activate (Int() $flags, GtkWidget() $widget, GVariant() $args) {
    my GtkShortcutActionFlags $f = $flags,

    gtk_shortcut_action_activate($!gtk-aa, $f, $widget, $args);
  }

  method get {
    my $gtk-activate-action = gtk_activate_action_get();

    $gtk-activate-action ?? self.bless( :$gtk-activate-action ) !! Nil
  }

}

class GTK::Shortcut::Action::Mnemonic is GTK::Shortcut::Action {
  has GtkMnemonicAction $!gtk-ma is implementor;

  method get {
    my $gtk-mnemonic-action = gtk_mnemonic_action_get();

    $gtk-mnemonic-action ?? self.bless( :$gtk-mnemonic-action ) !! Nil
  }

}

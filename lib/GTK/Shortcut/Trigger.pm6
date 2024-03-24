use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Shortcut::Trigger:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkShortcutTriggerAncestry is export of Mu
  where GtkShortcutTrigger | GObject;

class GTK::Shortcut::Trigger:ver<4> {
  also does GLib::Roles::Object;

  has GtkShortcutTrigger $!gtk-st is implementor;

  submethod BUILD ( :$gtk-shortcut-trigger ) {
    self.setGtkShortcutTrigger($gtk-shortcut-trigger) if $gtk-shortcut-trigger
  }

  method setGtkShortcutTrigger (GtkShortcutTriggerAncestry $_) {
    my $to-parent;

    $!gtk-st = do {
      when GtkShortcutTrigger {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutTrigger, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutTrigger
    is also<GtkShortcutTrigger>
  { $!gtk-st }

  multi method new (
    $gtk-shortcut-trigger where * ~~ GtkShortcutTrigger,

    :$ref = True
  ) {
    return unless $gtk-shortcut-trigger;

    my $o = self.bless( :$gtk-shortcut-trigger );
    $o.ref if $ref;
    $o;
  }

  method parse_string (Str() $string) is also<parse-string> {
    (
      do given $string {
        when 'never'        { ::('GTK::Shortcut::Trigger::Never')       }
        when .contains('_') { ::('GTK::Shortcut::Trigger::Mnemonic')    }
        when .contains('|') { ::('GTK::Shortcut::Trigger::Alternative') }
        default             { ::('GTK::Shortcut::Trigger::Keyval')      }
      }
    ).new( gtk_shortcut_trigger_parse_string($string) )
  }

  method compare (GtkShortcutTrigger() $trigger) {
    so gtk_shortcut_trigger_compare($!gtk-st, $trigger);
  }

  method equal (GtkShortcutTrigger() $trigger) {
    gtk_shortcut_trigger_equal($!gtk-st, $trigger);
  }

  method hash {
    gtk_shortcut_trigger_hash($!gtk-st);
  }

  method print (GString() $string) {
    gtk_shortcut_trigger_print($!gtk-st, $string);
  }

  method print_label (GdkDisplay() $display, GString() $string) is also<print-label> {
    gtk_shortcut_trigger_print_label($!gtk-st, $display, $string);
  }

  method to_label (GdkDisplay() $display) is also<to-label> {
    gtk_shortcut_trigger_to_label($!gtk-st, $display);
  }

  method to_string is also<to-string> {
    gtk_shortcut_trigger_to_string($!gtk-st);
  }

  method trigger (GdkEvent() $event, Int() $enable_mnemonics) {
    my gboolean $e = $enable_mnemonics.so.Int;

    gtk_shortcut_trigger_trigger($!gtk-st, $event, $e);
  }

}


our subset GtkAlternativeTriggerAncestry is export of Mu
  where GtkAlternativeTrigger | GtkShortcutTriggerAncestry;

class GTK::Shortcut::Trigger::Alternative is GTK::Shortcut::Trigger {
  has GtkAlternativeTrigger $!gtk-at is implementor;

  submethod BUILD ( :$gtk-alternative-trigger ) {
    self.setGtkAlternativeTrigger($gtk-alternative-trigger)
      if $gtk-alternative-trigger
  }

  method setGtkAlternativeTrigger (GtkAlternativeTriggerAncestry $_) {
    my $to-parent;

    $!gtk-at = do {
      when GtkAlternativeTrigger {
        $to-parent = cast(GtkShortcutTrigger, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAlternativeTrigger, $_);
      }
    }
    self.setGtkShortcutTrigger($to-parent);
  }

  method GTK::Raw::Definitions::GtkAlternativeTrigger
    is also<GtkAlternativeTrigger>
  { $!gtk-at }

  multi method new (
    $gtk-alternative-trigger where * ~~ GtkAlternativeTriggerAncestry,

    :$ref = True
 ) {
    return unless $gtk-alternative-trigger;

    my $o = self.bless( :$gtk-alternative-trigger );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkShortcutTrigger() $first,
    GtkShortcutTrigger() $second
  ) {
    my $gtk-alternative-trigger = gtk_alternative_trigger_new($first, $second);

    $gtk-alternative-trigger ?? self.bless( :$gtk-alternative-trigger ) !! Nil;
  }

  method get_first ( :$raw = False ) is also<get-first> {
    propReturnObject(
      gtk_alternative_trigger_get_first($!gtk-at),
      $raw,
      |GTK::Shortcut::Trigger.getTypePair
    );
  }

  method get_second ( :$raw = False ) is also<get-second> {
    propReturnObject(
      gtk_alternative_trigger_get_second($!gtk-at),
      $raw,
      |GTK::Shortcut::Trigger.getTypePair
    );
  }
}


our subset GtkKeyvalTriggerAncestry is export of Mu
  where GtkKeyvalTrigger | GtkShortcutTriggerAncestry;

class GTK::Shortcut::Trigger::Keyval is GTK::Shortcut::Trigger:ver<4> {
  has GtkKeyvalTrigger $!gtk-kt is implementor;

  submethod BUILD ( :$gtk-keyval-trigger ) {
    self.setGtkKeyvalTrigger($gtk-keyval-trigger) if $gtk-keyval-trigger
  }

  method setGtkKeyvalTrigger (GtkKeyvalTriggerAncestry $_) {
    my $to-parent;

    $!gtk-kt = do {
      when GtkKeyvalTrigger {
        $to-parent = cast(GtkShortcutTrigger, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkKeyvalTrigger, $_);
      }
    }
    self.setGtkShortcutTrigger($to-parent);
  }

  method GTK::Raw::Definitions::GtkKeyvalTrigger
    is also<GtkKeyvalTrigger>
  { $!gtk-kt }

  multi method new (
    $gtk-keyval-trigger where * ~~ GtkKeyvalTriggerAncestry,

    :$ref = True
  ) {
    return unless $gtk-keyval-trigger;

    my $o = self.bless( :$gtk-keyval-trigger );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $keyval, Int() $modifiers) {
    my guint           $k = $keyval;
    my GdkModifierType $m = $modifiers;

    my $gtk-keyval-trigger = gtk_keyval_trigger_new($k, $m);

    $gtk-keyval-trigger ?? self.bless( :$gtk-keyval-trigger ) !! Nil;
  }

  method get_keyval is also<get-keyval> {
    gtk_keyval_trigger_get_keyval($!gtk-kt);
  }

  method get_modifiers ( :set(:$flags) ) is also<get-modifiers> {
    my $m = gtk_keyval_trigger_get_modifiers($!gtk-kt);
    return $m unless $flags;
    getFlags(GdkModifierTypeEnum, $m);
  }

}

our subset GtkNeverTriggerAncestry is export of Mu
  where GtkNeverTrigger | GtkShortcutTriggerAncestry;

class GTK::Shortcut::Trigger::Never is GTK::Shortcut::Trigger {
  has GtkNeverTrigger $!gtk-kt is implementor;

  method setGtkNeverTrigger (GtkKeyvalTriggerAncestry $_) {
    my $to-parent;

    $!gtk-kt = do {
      when GtkNeverTrigger {
        $to-parent = cast(GtkShortcutTrigger, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNeverTrigger, $_);
      }
    }
    self.setGtkShortcutTrigger($to-parent);
  }

  method GTK::Raw::Definitions::GtkNeverTrigger
    is also<GtkNeverTrigger>
  { $!gtk-kt }

  method new {
    ::?CLASS.get;
  }
  method get {
    my $gtk-never-trigger = gtk_never_trigger_get();

    $gtk-never-trigger ?? self.bless( :$gtk-never-trigger ) !! Nil;
  }

}

our subset GtkMnemonicTriggerAncestry is export of Mu
  where GtkMnemonicTrigger | GtkShortcutTriggerAncestry;

class GTK::Shortcut::Trigger::Mnemnonic is GTK::Shortcut::Trigger {
  has GtkMnemonicTrigger $!gtk-mt is implementor;

  method setGtkMnemonicTrigger (GtkKeyvalTriggerAncestry $_) {
    my $to-parent;
    $!gtk-mt = do {
      when GtkMnemonicTrigger {
        $to-parent = cast(GtkShortcutTrigger, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMnemonicTrigger, $_);
      }
    }
    self.setGtkShortcutTrigger($to-parent);
  }

  method GTK::Raw::Definitions::GtkMnemonicTrigger
    is also<GtkMnemonicTrigger>
  { $!gtk-mt }

  method new (Int() $keyval) {
    my guint $k = $keyval;

    my $gtk-mnemonic-trigger = gtk_mnemonic_trigger_new($k);

    $gtk-mnemonic-trigger ?? self.bless( :$gtk-mnemonic-trigger ) !! Nil;
  }

  method get_keyval is also<get-keyval> {
    gtk_mnemonic_trigger_get_keyval($!gtk-mt);
  }

}

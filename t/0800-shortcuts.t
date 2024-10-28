use v6.c;

use GTK::Raw::Types:ver<4>;

use GTK::Application;
use GTK::Shortcut;
use GTK::Shortcut::Action;
use GTK::Shortcut::Group;
use GTK::Shortcut::Section;
use GTK::Shortcut::Trigger;
use GTK::Shortcut::Window;

my @letters = 'a'..'z';

my enum KeyMods <None Shift Ctrl Alt>;

my $app = GTK::Application.new( title => 'org.genex.shortcut.demo' );

$app.Activate.tap( -> *@a {
  my @shortcuts = @letters.map({
    my $nr =(1 ..^$n).eager;
    my $r = $nr.pick;
    my @a = KeyMods.enums.pairs.sort( *.value );
    my $m = Bool.pick ?? @a.pick($r).gist !! None;
    $m.gist.say;

    # Generate and return Shortcut
    my $ts = do {
      my $m = '';
      when    Ctrl  == @a.any { $m ~= '<Ctrl>';  proceed }
      when    Alt   == @a.any { $m ~= '<Alt>';   proceed }
      when    Shift == @a.any { $m ~= '<Shift>'; proceed }

      default {
        $m ~ .uc;
      }
    }
    my $t = GTK::Shortcut::Trigger.parse-string($ts);
    my $a = GTK::Shortcut::Action::Callback.new( -> *@a {
      say "$ts clicked!"
    });

    GTK::Shortcut.new($t, $a);

    # TODO: 
    #
    # cw: There seems to be no programmatic way to create a GtkShortcutsWindow
    #     that doesn't go through GtkBuilder, so why not add an interface to
    #     all GtkShortcut objects that will emit builder code.
    #     GtkShortcutWindow can then have a method called .toBuilder which
    #     will emit the proper section in UI markup. This markup can then be
    #     consumed by GtkBuilder for display in a proper GtkWindow.
  });

});

$app.run;

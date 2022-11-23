use v6.c;

use Test;

use NativeCall;

use GTK::Application:ver<4>;
use GTK::Button:ver<4>;
use GTK::Box:ver<4>;
use GTK::ApplicationWindow:ver<4>;

my $a = GTK::Application.new('org.genex.test.widget');

$a.Activate.tap( -> *@a {
  my $win = GTK::ApplicationWindow.new($a, width => 300, height => 200);
  $win.set-title('Test Buttons');

  my $box = GTK::Box.new-vbox(6);
  my ($b1, $b2, $b3) = (
    GTK::Button.new_with_label('Click Me'),
    GTK::Button.new_with_mnemonic('_Open'),
    GTK::Button.new_with_mnemonic('_Close')
  );

  $win.add($box);

  $b1.Clicked.^name.say;

  say "Button 1 CLICKED status: { $b1.is-connected('clicked') }";
  $b1.Clicked.tap(-> *@a { say 'Click me button was clicked'; });
  say "Button 1 CLICKED status: { $b1.is-connected('clicked') }";
  say "Button 2 CLICKED status: { $b2.is-connected('clicked') }";
  $b2.Clicked.tap(-> *@ { say 'Open button was clicked'; });
  say "Button 2 CLICKED status: { $b2.is-connected('clicked') }";
  say "Button 3 CLICKED status: { $b3.is-connected('clicked') }";
  $b3.Clicked.tap(-> *@ { say 'Closing application.'; $a.exit; });
  say "Button 3 CLICKED status: { $b3.is-connected('clicked') }";
  $box.pack_start($b1, True, True, 0);
  $box.pack_start($b2, True, True, 0);
  $box.pack_start($b3, True, True, 0);
  $win.present;
});

$a.run;

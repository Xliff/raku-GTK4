use v6.c;

use Test;

use NativeCall;

use GTK::Raw::Types;

use GTK::Application;;
use GTK::Button;
use GTK::Box;
use GTK::CssProvider;

my $a = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400,
);

$a.Activate.tap( -> *@a {
  my $box = GTK::Box.new-vbox(6);
  my ($b1, $b2, $b3) = (
    GTK::Button.new_with_label('Click Me'),
    GTK::Button.new_with_mnemonic('_Open'),
    GTK::Button.new_with_mnemonic('_Close')
  );
  ($b1.name, $b2.name, $b3.name) = ('button1', 'button2', 'button3');
  # Not as self-documenting, but does the same thing as ↑↑↑↑:
  #    ('button' xx 3) Z~ (1..3).list

  $b1.Clicked.tap(-> *@a { say 'Click me button was clicked'; });
  $b2.Clicked.tap(-> *@a { say 'Open button was clicked'; });
  $b3.Clicked.tap(-> *@a { say 'Closing application.'; $a.exit; });
  $box.pack_start($b1, True, True, 0);
  $box.pack_start($b2, True, True, 0);
  $box.pack_start($b3, True, True, 0);

  $a.window.add($box);
  my $css = GTK::CssProvider.new( pod => $=pod );
  $a.present;
});

$a.run;

=begin css
button {
  border-width: 5px;
  border-color: #333333;
  border-radius: 10px;
  background: #11ccff;
  margin: 10px;
}

button:hover {
  background: #1166ff;
}

#button1 {
  font-family: Times New Roman;
}

#button2 {
  font-weight: bold;
}

#button3 {
  font-family: FreeSans;
  font-style: italic;
}
=end css

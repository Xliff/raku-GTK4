use v6.c;

# Ported from the GTK demo suite. Source code found here:
# https://github.com/GNOME/gtk/blob/master/demos/gtk-demo/expander.c

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Expander;

my $a = GTK::Application.new(
  title  => 'org.genex.expander.textview',
  width  => 400,
  height => 200
);

$a.Activate.tap(-> | {
  my $e  = GTK::Expander.new('Buttons: ');
  my $vb = GTK::Box.new-vbox;
  my $cb = GTK::Button.new_with_label('Close');

  $cb.Clicked.tap(-> | { $a.exit; });

  $vb.margins = 20;
  $e.margin_bottom = 20;

  my $box = GTK::Box.new-vbox(6);
  my ($b1, $b2, $b3) = (
    GTK::Button.new_with_label('Click Me'),
    GTK::Button.new_with_mnemonic('_Open'),
    GTK::Button.new_with_mnemonic('_Close')
  );
  $box.pack_start($_, True, True, 0) for $b1, $b2, $b3;

  $e.set-child($box);
  $vb.pack_start($e,  True, True);
  $vb.pack_start($cb, True, True);

  $e.notify('expanded').tap(-> | { $a.window.resizable = $e.expanded });
  $a.window.add($vb);
  $a.window.Destroy.tap(-> | { say "Exited"; $a.exit });
  $a.window.present;
});

$a.run;

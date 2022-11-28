use v6.c;

use GTK::Application;
use GTK::ApplicationWindow;
use GTK::Box;
use GTK::ToggleButton;

my $a = GTK::Application.new( 'org.genex.button.toggle' );

$a.Activate.tap(-> *@a {
  my @group = do for 1..3 {
    GTK::ToggleButton.new-with-label("Toggle Button $_");
  };

  for @group -> $r is copy {
    # It's better to use LEXICAL variable, not a loop varianle, in closures!
    $r.Toggled.tap(-> *@a {
      say "{ $r.label } {
             $r.active ?? 'selected' !! 'deselected' }."
    })
  }

  # This will cause a MoarVM panic in current rakudo.
  # die 'Will this crash?';

  my $box = GTK::Box.new-vbox;
  for @group {
    ( .margin_left,  .margin_right) = 20 xx 2;
    $box.pack_start($_, False, False, 4);
  }

  my $win = GTK::ApplicationWindow.new($a);
  $win.add($box);
  $win.show_all;
});

$a.run;

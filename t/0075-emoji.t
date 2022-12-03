use v6.c;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::EmojiChooser:ver<4>;
use GTK::MenuButton:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.emojis' );

$a.Activate.tap( -> *@a {
  my $vbox  = GTK::Box.new-vbox(10);
  my $mb    = GTK::MenuButton.new;
  my $ec    = GTK::EmojiChooser.new;

  my @emojis;

  $mb.label   = 'Emojis:';
  $mb.popover = $ec;
  $ec.Emoji-Picked.tap( -> *@a {
     @emojis.splice(0, 1) if @emojis.elems >= 4;
     @emojis.push: @a[1];
     $mb.label = "Emojis: { @emojis.join(' ') }";
  });

  $vbox.append($_) for $ec, $mb;
  $a.window.set-child($vbox);
  $a.window.present;
});

$a.run;

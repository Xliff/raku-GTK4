use v6.c;

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Separator:ver<4>;
use GTK::SpinButton:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.spinbutton' );

$a.Activate.connect(-> *@a {
  my $hs = GTK::Separator.new;
  my $s1 = GTK::SpinButton.new(0..10, :h, s => 1, p => 4);
  my $s2 = GTK::SpinButton.new_with_range(0, 20, 1, :v);
  my $b  = GTK::Box.new-vbox(10);

  $b.append($s1);
  $b.append($hs);
  $b.append($s2);
  .numeric = True for $s1, $s2;

  $a.window.set-child($b);
  $a.window.present;
});

$a.run;

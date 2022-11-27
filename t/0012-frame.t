use v6.c;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Label:ver<4>;
use GTK::Frame:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.frame' );

$a.Activate.tap( -> *@a {
  my $l = GTK::Label.new("Label in Frame");
  my $f = GTK::Frame.new("Frame");
  my $b = GTK::Box.new-vbox(10);

  $f.set-child($l);
  $f.margins = 20;

  $b.append($f);
  $a.window.set-child($b);
  $a.window.present;
});

$a.run;

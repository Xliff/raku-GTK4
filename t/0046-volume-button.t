use v6.c;

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button::Volume:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.button.volume' );

$a.Activate.connect(-> *@a {
  my $b = GTK::Box.new-hbox(10);
  my $v = GTK::Button::Volume.new( :v );

  $v.orientation = GTK_ORIENTATION_VERTICAL given $v;

  $b.margins = 20;
  $b.append($v);

  $a.window.set-size-request(100, 200);
  $a.window.set-child($b);
  $a.window.present;
});

$a.run;

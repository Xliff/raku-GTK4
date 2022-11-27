use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Button;
use GTK::Grid;

my $app = GTK::Application.new( title => 'org.genex.grid' );

# Ported from the Python example found in section 6.2.1 from:
# https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html

$app.Activate.tap( -> *@a {
  my @b = gather for 'Button ' «~« (1...6) {
    take GTK::Button.new-with-label($_);
  }

  given (my $g = GTK::Grid.new) {
    .attach(@b[0], 1,  1, 1, 1);
    .attach(@b[1], 2,  2, 2, 1);
    .attach(@b[2], 3,  3, 1, 3);
    .attach(@b[3], 6,  4, 1, 4);
    .attach(@b[4], 10, 5, 2, 2);
    .attach(@b[5], 12, 8, 3, 3);
  }

  $app.window.add($g);
  $app.window.show_all;
});

$app.run;

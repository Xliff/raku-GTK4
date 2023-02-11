use v6.c;

use GTK::Application:ver<4>;
use GTK::Inscription:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.gtk.inscription' );

$a.activate.tap( -> *@a {
  my $i = GTK::Inscription.new;

  $i.markup = q:to/INSCRIPTION/;
    The raku-GTK Project

    Inception: June 18, 2018

    <b>Coming soon...</b>
    INSCRIPTION

  $a.window.add($i);
  $a.present;
});

$a.run;

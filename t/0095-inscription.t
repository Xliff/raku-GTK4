use v6.c;

use GTK::Application:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::Inscription:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.gtk.inscription' );

$a.activate.tap( -> *@a {
  my $c = GTK::CssProvider.new( pod => $=pod );
  my $i = GTK::Inscription.new;
  $i.name = 'inscription';

  $i.markup = q:to/INSCRIPTION/;
    The raku-GTK Project

    Inception: June 18, 2018

    <b>Coming soon...</b>
    INSCRIPTION

  $a.window.add($i);
  $a.window.set-size-request(400,200);
  $a.present;
});

$a.run;

=begin css
#inscription {
  margin: 4px;
  color: #666;
  font-size:24px;
  text-shadow: 0px 2px 0px rgba(255,255,255,.3), 0px -2px 0px rgba(0,0,0,.7);
}
=end css

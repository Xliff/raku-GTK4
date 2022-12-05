use v6.c;

use GTK::Raw::Types:ver<4>;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Dialog::About;
use GDK::Texture;
use GTK::Image;

use GIO::Roles::GFile;

my $a = GTK::Application.new( title => 'org.genex.dialog.about1' );

$a.Activate.tap(-> *@a {
  CATCH { default { .message.say } }

  my $logo = './camelia-gtk.png';
  $logo = 't/camelia-gtk.png' unless $logo.IO.e;
  warn "Can't find proper logo" unless $logo.IO.e;
  my $i = GTK::Image.new_from_file($logo);
  my $t = GDK::Texture.new_from_file( GIO::File.new_for_path($logo) );

  ( .hexpand, .vexpand ) = True xx 2 given $i;
  say "Image: { $i }";
  say "Paintable: { $i.GdkPaintable }";
  say "Texture size: { $t.width } x { $t.height }";

  my $button = GTK::Button.new-with-label('About');

  $button.Clicked.tap( -> *@a {
    my $d       = GTK::Dialog::About.new;
    my @credits = <Xliff>;
    my @docs    = «"We don't need no steeking docuwentation!"»;

    $d.transient-for = $a.window;
    $d.modal = True;
    $d.logo = $t;
    $d.set-artists(@credits);
    $d.set-authors(@credits);
    $d.set-documenters(@docs);
    $d.program_name = '0230-about.t';
  	$d.comments = 'We are testers... dun da dun dun dun dun dun...';
  	$d.copyright = 'Copyright © 2022 by Xliff';
  	$d.version = 'Version π';

  	$d.license = ( <😐 😦 🤮 🚽 💩>.pick xx 99 ).join;

    say "Logo Paintable: { $d.logo.width } x { $d.logo.height }";

  	$d.wrap_license = True;
  	$d.website = "http://github.com/Xliff/p6-GtkPlus/";
  	$d.website_label = "Perl6 GtkPlus";
    $d.show;
  });

  my $box = GTK::Box.new-vbox(10);
  $box.append($_) for $i, $button;

  $a.window.set-child($box);
  $a.window.set-size-request($i.paintable.width, $i.paintable.height);
  $a.window.present;

});

$a.run;

use v6.c;

use GTK::Application;
use GTK::ActionBar;
use GTK::Button;
use GTK::Box;

my $a = GTK::Application.new( title => 'org.genex.actionbar' );

$a.Activate.tap( -> *@a {
  my $b  = GTK::Box.new-vbox(10);
  my $ab = GTK::ActionBar.new;
  $b.append($ab);

  my @buttons;

  # Icon Names are a FreeDesktop standard. We are using these:
  # https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html
  for <
    call-start
    call-stop
    contact-new
    document-print
    go-home
    applications-system
  > {
    @buttons.push: GTK::Button.new_from_icon_name($_);

    @buttons.tail.Clicked.tap( -> *@a {
      say .split('-').map( *.tc ).join(" ") ~ ' pressed'
    });

    $ab.pack_start( @buttons.tail );
  }

  $a.window.set-child($b);
  $a.present;
});

$a.run;

use v6.c;

use GIO::Permission;
use GTK::Application;
use GTK::Box;
use GTK::Button::Link;
use GTK::Button::Lock;
use GTK::Entry::Password;

my $a = GTK::Application.new( title => 'org.genex.buttons.link-and-lock' );

$a.Activate.tap( -> *@a {
  # cw: GIO::Permission is abstract, so we need a sub
  my $link-perm = GIO::Permission.new;

  my $box       = GTK::Box.new-vbox;
  my $link      = GTK::Button::Link.new-with-label(
                    'https://slashdot.org',
                    'View Site'
                  );

  #$link-perm.impl-update(False, True, True);

  my $lock      = GTK::Button::Lock.new($link-perm);
  $lock.label   = 'Set Permissions';
  $box.append($_) for $lock, $link;
  $box.margins = 20;
  ( .text-lock, .text-unlock ) = ('Locked', 'Unlocked') given $lock;

  $a.window.child = $box;
  $a.window.present;
});

$a.run;

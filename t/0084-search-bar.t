use v6.c;

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::MenuButton:ver<4>;
use GTK::SearchBar:ver<4>;
use GTK::SearchEntry:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.bar.search' );

$a.Activate.tap( -> | {
  my $search-bar = GTK::SearchBar.new;
  my $box        = GTK::Box.new-hbox(6);
  my $entry      = GTK::SearchEntry.new;
  my $menu-b     = GTK::MenuButton.new;

  $box.append($_) for $entry, $menu-b;
  $search-bar.connect-entry($entry);
  $search-bar.set-key-capture-widget($a.window);

  $search-bar.valign = GTK_ALIGN_START;
  $entry.hexpand     = True;
  $search-bar.child  = $box;
  $a.window.child    = $search-bar;

  $a.window.present;
});

$a.run;

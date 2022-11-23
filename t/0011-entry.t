use v6.c;

use GTK::Application:ver<4>;
use GTK::ApplicationWindow:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::Entry:ver<4>;
use GTK::Label:ver<4>;

my $a = GTK::Application.new('org.genex.entry_example');

sub exit-app($e) {
  say "Text in entry is '{ $e.text }'";
  $a.exit;
}

$a.Activate.tap( -> *@a {
  my $title  = GTK::Label.new;
  my $vbox1  = GTK::Box.new-vbox;
  my $hbox   = GTK::Box.new-hbox;
  my $clear  = GTK::Button.new_with_label('Clear');
  my $quit   = GTK::Button.new_with_label('Quit');
  my $entry  = GTK::Entry.new;
  my $win    = GTK::ApplicationWindow.new($a);

  ($title.margin-top, $title.margin-bottom) = 20 xx 2;
  ($title.margin-left, $title.margin-right) = 15 xx 2;
  $title.set_markup(do { (my $mark = qq:to/MARK/) ~~ s:g/\n//; $mark });
<span font="Microgramma Bold 18" color="#224488">ENTRY EXAMPLE</span>
MARK

  $clear.Clicked.tap(-> *@a { $entry.text = '' });
  $quit.Clicked.tap(-> *@a { exit-app($entry) });

  $hbox.pack_start($_)  for $entry, $clear, $quit;
  $vbox1.pack_start($_) for $title, $hbox;

  $win.add($vbox1);
  $win.show-all;
});

$a.run;

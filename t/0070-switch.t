use v6.c;

use GTK::Application;
use GTK::ApplicationWindow;
use GTK::Box;
use GTK::Label;
use GTK::Switch;

my $a = GTK::Application.new('org.genex.switch_example');

$a.Activate.tap(-> *@a {
  my $vbox   = GTK::Box.new-vbox(4);
  my $hbox   = GTK::Box.new-hbox(6);
  my $title  = GTK::Label.new;
  my $slabel = GTK::Label.new;
  my $switch = GTK::Switch.new;

  $slabel.margin_left = 40;
  $slabel.margin_right = 20;
  $switch.State-Set.tap(-> *@a {
    @a.tail.r = 0;
    $slabel.label = @a[1].so.Str.uc;
  });

  $title.label = 'GTK::Switch Example';
  $hbox.pack_start($slabel, False, False, 0);
  $hbox.pack_start($switch, False, False, 0);
  $vbox.pack_start($title, False, False, 0);
  $vbox.pack_start($hbox, False, False, 0);

  my $win = GTK::ApplicationWindow.new($a);
  $win.set_size_request(150, 40);
  $win.Destroy.tap(-> *@a { $a.exit });
  $win.add($vbox);
  $win.show_all;
});

$a.run;

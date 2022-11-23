use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::ApplicationWindow;
use GTK::Box;
use GTK::Calendar;
use GTK::Entry;
use GTK::Image;
use GTK::Label;

my $a = GTK::Application.new( 'org.genex.calendar_example' );

$a.Activate.tap( -> *@a {
  my $vbox     = GTK::Box.new-vbox();
  my $hbox     = GTK::Box.new-hbox();
  my $label    = GTK::Label.new();
  my $image    = GTK::Image.new_from_file('resources/Calendar-icon.png');
  my $calendar = GTK::Calendar.new();
  my $entry    = GTK::Entry.new();

  $image.set_size_request(200, 200);
  #($entry.margin_left, $entry.margin_right) = (10, 10);
  $entry.set-margin-left(10);
  $entry.set-margin-right(10);

  sub format-date {
    $calendar.get_date.ymd.map( *.fmt('%02d') ).join(' / ');
  };

  $calendar.Day-Selected.tap( -> *@a {
    $entry.text = "Day selected: { format-date() }";
  });

  $label.set-markup(qq:to/MARK/);
  <span font="Liberation Sans Narrow 24" weight="bold" color="#0066ff">
    Calendar/Image/Label Example
  </span>
  MARK

  #($calendar.hexpand, $image.hexpand) = True xx 2;
  $calendar.set-hexpand(True);
  $image.set-hexpand(True);

  $hbox.pack_start($image, True);
  $hbox.pack_start($calendar, True);
  $vbox.pack_start($label);
  $vbox.pack_start($hbox, False, True, 10);
  $vbox.pack_start($entry, False, True, 10);

  my $win = GTK::ApplicationWindow.new($a);
  $win.Destroy.tap( -> *@a { $a.exit });
  $win.set_size_request(500, 250);
  $win.add($vbox);
  $win.show_all;
});

$a.run;

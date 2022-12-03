use v6.c;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::DropDown:ver<4>;
use GTK::Label:ver<4>;
use GTK::String::List:ver<4>;

my $a = GTK::Application.new(
  title  => 'org.genex.dropdown',
  width  => 200,
  height => 300
);

$a.Activate.tap(-> *@a {
    my ($hbox, $vbox) = ( .new-hbox(5), .new-vbox(5) ) given GTK::Box;

    my @labels = GTK::Label.new xx 2;
    @labels.head.label = 'Item selected: ';
    $hbox.append($_) for @labels;

    my $dropdown = GTK::DropDown.new-from-strings(<1 2 3 Harry Box Richard>);

    $dropdown.notify('selected').tap(-> *@a {
      CATCH { default { .message.say } }

      my $selected = GTK::String::Object.new(
        $dropdown.selected-item( :raw )
      );
      @labels.tail.label = $selected.string;
    });

    $vbox.append($_) for $dropdown, $hbox;
    $a.window.set-child($vbox);
    $a.window.present;
});

$a.run;

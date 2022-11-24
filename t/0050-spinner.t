use v6.c;

use GTK::Application;
use GTK::ApplicationWindow;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::Spinner;

my $a = GTK::Application.new('org.genex.spinner_example');

$a.Activate.tap(-> *@a {
  my $title  = GTK::Label.new;
  my $button = GTK::Button.new_with_label('Start');
  my $vbox   = GTK::Box.new-vbox(6);
  my $spin   = GTK::Spinner.new;

  $title.set_markup(do { (my $mark = qq:to/MARK/) ~~ s:g/\n//; $mark });
<span font="URW Gothic 24" color="#22cc11">Spinner Example</span>
MARK

  given $title {
    ( .margin_left, .margin_right  ) = 20 xx 2;
    ( .margin-top,  .margin_bottom ) = 20 xx 2;
  }

  given $button {
    ( .margin_left, .margin_right ) = 20 xx 2;
    ( .margin_top,  .margin_bottom) = 15 xx 2;
  }

  $spin.set_size_request(64, 64);
  $vbox.pack_start($title, True, True, 0);
  $vbox.pack_start($spin, True, False, 0);
  $vbox.pack_start($button, True, True, 0);

  $button.Clicked.tap(-> *@a {
    given $button.label {
      when 'Start' {
        $spin.start;
        $button.label = 'Stop';
      }

      when 'Stop' {
        $spin.stop;
        $button.label = 'Start';
      }
    }
  });

  my $win = GTK::ApplicationWindow.new($a);
  $win.Destroy.tap(-> *@a { $a.exit });
  $win.add($vbox);
  $win.show_all;
});

$a.run

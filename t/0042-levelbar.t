use v6.c;

use GTK::Application;
use GTK::ApplicationWindow;
use GTK::Box;
use GTK::Button;
use GTK::CheckButton;
use GTK::Entry;
use GTK::Label;
use GTK::LevelBar;

# Arrange to update the progress bar every second once button is clicked:
my $a = GTK::Application.new( 'org.genex.bar.level' );

$a.Activate.tap(-> *@a {
  my $title    = GTK::Label.new;
  my $label    = GTK::Label.new('Set step value: ');
  my $entry    = GTK::Entry.new;
  my $button   = GTK::Button.new_with_label('Start Count');
  my $bar      = GTK::LevelBar.new;
  my $hbox     = GTK::Box.new-hbox(2);
  my $vbox     = GTK::Box.new-vbox(2);

  ($button.margin_left, $button.margin_right) = (20, 20);
  ($button.margin_top, $button.margin_bottom) = (15, 15);
  ($label.margin_left, $label.margin_right) = (20, 10);
  $label.set_size_request(-1, 40);
  ($bar.margin_left, $bar.margin_right) = (20, 20);
  $bar.set_size_request(30, 30);
  $entry.margin_right = 20;
  $entry.text = "1";
  $title.margin_bottom = 10;
  $title.set_markup(qq:to/MARK/.chomp);
<span font="Sawasdee 20" weight="bold" color="#660044">LevelBar Example</span>
MARK

  $hbox.pack_start($label);
  $hbox.pack_start($entry);
  $vbox.pack_start($title, False, False, 0);
  $vbox.pack_start($hbox, True, False, 0);
  $vbox.pack_start($bar, True, True, 0);
  $vbox.pack_start($button, True, True, 0);

  my $ticks;
  my $count = 0;
  my $c;

  $button.Clicked.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }

    given $button.label {
      when 'Start Count' {
        my $num;
        try {
           $num = $entry.text.Numeric;
           $ticks = $num / 100;
           CATCH { }
        }
        with $ticks {
          $c = $*SCHEDULER.cue({
            $count += $ticks;
            $bar.value = $count > 1 ?? 1 !! $count;
            if $count >= 1 {
              $c.cancel;
              $button.label = 'Start Count';
              $count = 0;
              $ticks = Nil;
            }
          }, :every(1));

          $button.label = 'Cancel';
        }
      }

      when 'Cancel' {
        $c.cancel;
        $button.label = 'Start Count';
      }
    }
  });

  my $win = GTK::ApplicationWindow.new($a);
  $win.Destroy.tap(-> *@a { $a.exit; });
  $win.add($vbox);
  $win.show_all;
});

$a.run;

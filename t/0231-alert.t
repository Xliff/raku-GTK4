use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::Dialog::Alert;

my $a = GTK::Application.new( title => 'org.genex.dialog.alert' );

$a.Activate.tap( -> *@a {
  my $box    = GTK::Box.new-vbox(15);
  my $button = GTK::Button.new-with-label("Show Alert");
  my $label  = GTK::Label.new("Dialog Result:");
  my $num    = 1;

  $box.margins = 50;
  $box.append($_) for $button, $label;

  my $alert = GTK::Dialog::Alert.new;
  $button.Clicked.tap( -> *@a {
    $alert.set-message("This alert dialog has been called { $num } times");
    $alert.set-buttons( <A B C D> );
    $alert.choose(
      -> *@b {
        CATCH { default { .message.say } }
        $label.label = "Dialog Result: { $alert.choose-finish( @b[1] ) }"
      }
    );
  });
  $a.window.child = $box;
  $a.window.present;
});

$a.run;

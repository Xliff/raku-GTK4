use v6.c;

use Cairo;
use RandomColor;
use GDK::RGBA;
use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Dialog::Color;
use GTK::DrawingArea;

sub new-color-chooser-button ($color) {
  role ColoredButton { has $.color is rw }

  my $button = GTK::Button.new but ColoredButton;
  $button.color = $color;

  sub getButton { $button }

  sub set-draw-func ($area) {
    $area.set-draw-func( -> *@a {
      CATCH { default { .message.say } }

      my $cr = Cairo::Context.new( @a[1] );
      $cr.rgba( .red, .green, .blue, .alpha) given getButton().color;
      $cr.paint;
    });
  }

  given (my $area = GTK::DrawingArea.new) {
    ( .content-width, .content-height ) = 24 xx 2;
    set-draw-func($area);
  }
  $button.set-child($area);
  $button.Clicked.tap( -> *@a {
    CATCH { default { .message.say } }

    my $d = GTK::Dialog::Color.new;
    $d.choose-rgba(
      initial-color => $button.color,
      -> *@a {
        CATCH { default { .message.say } }
        my $c = $d.choose-rgba-finish( @a[1] );
        $button.color = $c;

        set-draw-func($area);
      },
    );
  });
  $button;
}

my $a = GTK::Application.new( title => 'org.genex.color.chooser' );

$a.Activate.tap( -> *@a {
  my $b = GTK::Box.new-vbox(20);
  for RandomColor.new( format => 'color', count => 3 ).list {
    $b.append( new-color-chooser-button( GDK::RGBA.new( |.rgbad ) ) );
  }
  $a.window.set-child($b);
  $a.window.present;
});

$a.run;

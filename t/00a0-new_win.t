use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Application:ver<4>;
use GTK::ApplicationWindow:ver<4>;
use GTK::Window:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;

my $app = GTK::Application.new( 'org.genex.test.widget' );

sub new-win () {
	my $window = GTK::Window.new( title => 'NewWin' );
  $window.decorated = True;
	$window.show;
	$app.add_window: $window;
}

$app.Activate.tap(-> *@a {
  my $box = GTK::Box.new-vbox(6);
  my GTK::Button $new-win .= new_with_label('new-win');

  $new-win.Clicked.tap: -> *@a { new-win };
  $box.pack_start($new-win, False, True, 0);

  my $win = GTK::ApplicationWindow.new($app);
  $win.set_size_request(400, 400);
  $win.Destroy.tap: -> *@a { $app.exit };
  $win.add: $box;
  $win.show_all;
});

$app.run;

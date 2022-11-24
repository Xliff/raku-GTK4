use v6.c;

use GTK::Raw::Enums:ver<4>;

use GTK::Application:ver<4>;
use GTK::ApplicationWindow:ver<4>;
use GTK::Box:ver<4>;
use GTK::Label:ver<4>;
use GTK::InfoBar:ver<4>;

my $a = GTK::Application.new( 'org.genex.infobars' );

$a.Activate.tap( -> *@a {
  my $vbox = GTK::Box.new-vbox(10);
  for GtkMessageTypeEnum.enums.pairs -> $ep {
    my $bar   = GTK::InfoBar.new;
    my $label = GTK::Label.new( $ep.key.split('_').tail.lc.tc );
    $bar.show-close-button = True;
    $bar.add-child($label);
    $bar.message-type = $ep.value;
    $vbox.pack_start($bar);

    $bar.Close.tap( -> *@a {
      say "{ $label.label } Escape pressed";
      $bar.revealed = False
    });

    $bar.Response.tap( -> *@a {
      say "{ $label.label } Response triggered";
    });
  }

  my $win = GTK::ApplicationWindow.new($a);
  $win.add($vbox);
  $win.set-size-request(400, 400);
  $win.Destroy.tap( -> *@a { $a.exit });
  $win.present;
});

$a.run;

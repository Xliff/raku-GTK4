use v6.c;

use GTK::Raw::Enums:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::Label:ver<4>;
use GTK::InfoBar:ver<4>;

my $a = GTK::Application.new(
  title  => 'org.genex.infobars.css',
  width  => 300,
  height => 400
);

$a.Activate.tap( -> *@a {
  my $vbox = GTK::Box.new-vbox(10);
  my $css = GTK::CssProvider.new( pod => $=pod );
  for GtkMessageTypeEnum.enums.pairs.sort( *.key ) -> $ep {
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

  $a.window.add($vbox);
  $a.window.set-size-request(400, 400);
  $a.window.Destroy.tap( -> *@a { $a.exit });
  $a.window.present;
});

$a.run;

=begin css
infobar { border-width: 1px; }

infobar.info {
  color: #004085;
  background-color: #cce5ff;
  border-color: #bee5eb;
}

infobar.info .close {
  background-color: #cce5ff;
}

infobar.warning {
  color: #856404;
  background-color: #fff3cd;
  border-color: #ffeeba;
}

infobar.warning .close {
  background-color: #fff3cd;
}

infobar.error {
  color: #721c24;
  background-color: #f8d7da;
  border-color: #f5c6cb;
}

infobar.error .close {
  background-color: #f8d7da;
}

infobar.other {
  color: #383d41;
  background-color: #e2e3e5;
  border-color: #d6d8db;
}

infobar.other .close {
  background-color: #e2e3e5;
}

infobar.question {
  color: #818182;
  background-color: #fefefe;
  border-color: #fdfdfe;
}

infobar.question .close {
  background-color: #fefefe;
}
=end css

use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::MainContext;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::Main:ver<4>;
use GTK::Window:ver<4>;

sub new-button ($c) {
  GTK::Button.new(
    valign    => GTK_ALIGN_CENTER,
    css-class => $c
  );
}


sub MAIN {
  my $done = False;

  GTK::Main.init;

  my $css = GTK::CssProvider.new( pod => $=pod );
  my $b   = GTK::Box.new-vbox(120, margins => 120);
  my $w   = GTK::Window.new( child => $b, decorated => False );
  my $top = GTK::Box.new-hbox(120);
  my $bot = GTK::Box.new-hbox(120);

  $b.  append($_)               for $top, $bot;
  $top.append( new-button($_) ) for <one two three four five>;
  $bot.append( new-button($_) ) for <b1>;
  $w.Destroy.tap: SUB { GLib::MainContext.wakeup; $done = True }
  $w.present;

  repeat { GLib::MainContext.iteration } until $done;
}

=begin css
 window { background-color: white; }
.one {
  all: unset;
  min-width: 100px;
  min-height:100px;
  box-shadow: -10px -20px 5px 40px red;
}
.two {
  all: unset;
  min-width: 100px;
  min-height:100px;
  box-shadow: -10px -20px 0px 40px red;
}
.three {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border-radius: 0px;
  box-shadow: 0px 0px 10px 20px red;
}
.four {
  all: unset;
  min-width: 100px;
  min-height: 100px;
  box-shadow: 10px 20px 5px 40px red;
  border-radius: 30px;
  margin-right: 50px;
}
.five {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border-radius: 30px;
  box-shadow: 10px 20px 0px 40px red;
}
.b1 {
  all: unset;
  min-width: 100px;
  min-height: 100px;
  border-radius: 7px 7px 0px 0px;
  box-shadow: 0px 0px 9px 0px rgba(0, 0, 0, 0.5);
}
=end css

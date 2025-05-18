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
  my $b   = GTK::Box.new-vbox(40, margins => 40);
  my $w   = GTK::Window.new( child => $b );
  my $top = GTK::Box.new-hbox(40);
  my $bot = GTK::Box.new-hbox(40);

  $b.  append($_)               for $top, $bot;
  $top.append( new-button($_) ) for <one two three four five>;
  $bot.append( new-button($_) ) for <b1 b2 b3 b4>;

  $w.Destroy.tap: SUB { GLib::MainContext.wakeup; $done = True }
  $w.present;

  repeat { GLib::MainContext.iteration } until $done;
}

=begin css
.one {
  all: unset;
  min-width: 100px;
  min-height:100px;
   border-left:   50px solid #0f0;
   border-top:    10px solid red;
   border-bottom: 50px solid teal;
   border-right:  100px solid pink;
   border-radius: 100px;
}
.two {
  all: unset;
  min-width: 100px;
  min-height:100px;
   border-left:   50px solid #0f0;
   border-top:    10px solid red;
   border-bottom: 50px solid teal;
   border-right:  100px solid pink;
   border-radius: 50%;
}
.three {
  all: unset;
  min-width: 100px;
  min-height:100px;
   border-left:   50px solid #0f0;
   border-top:    10px solid red;
   border-bottom: 50px solid teal;
   border-right:  100px solid pink;
   border-radius: 0px;
}
.four {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border: 10px solid black;
  border-radius: 999px;
}
.five {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border: 30px solid black;
  border-radius: 0px;
}
.b1 {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border-top: 30px solid black;
  border-radius: 0px;
}
.b2 {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border-bottom: 30px solid black;
  border-radius: 0px;
}
.b3 {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border-right: 30px solid blue;
  border-radius: 40px;
}
.b4 {
  all: unset;
  min-width: 100px;
  min-height:100px;
  border-bottom: 30px solid blue;
  border-radius: 40px;
}
=end css

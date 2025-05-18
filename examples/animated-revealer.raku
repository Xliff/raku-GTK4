use v6.c;

use GLib::Raw::Subs;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Enums::Class:ver<4>;

use GLib:MainContex;
use GTK::Box:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::Grid:ver<4>;
use GTK::Label:ver<4>;
use GTK::Main:ver<4>;
use GTK::Revealer:ver<4>;
use GTK::Window:ver<4>;

sub MAIN ( :t(:$time) = 5 ) {
  GTK::Main.init;

  my $done = False;

  my $g = GTK::Grid.new;

  my $r = GTK::Revealer.new(
    valign              => ALIGN<start>,
    transition-type     => REVEALER<slide-down>,
    transition-duration => $time * 1000,
    reveal-child        => True,
    child               => $g
  );

  my $w = GTK::Window.new( child => $r );
  $w.Destroy.tap: SUB { $done = True; GLib::MainContext.wakeup };
  $r.Map.tap:     SUB { $r.reveal-child .= not };

  =begin css
  * { padding: 2px; text-shadow: 5px 5px 2px grey; }
  =end css

  GTK::CssProvider.new( pod => $=pod );

  for ^10 X ^20 -> ($x, $y) {
    my $l = GTK::Label.new('Hello World');
    $g.attach($l, $x, $y )
  }

  $w.present;

  repeat { GLib::MainContext.iteration } until $done;
}

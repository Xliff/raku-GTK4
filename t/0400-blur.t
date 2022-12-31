use v6.c;

use Test;

use GTK::Raw::Types:ver<4>;

use GLib::Timeout;
use Graphene::Point;
use Graphene::Rect;
use GDK::RGBA:ver<4>;
use GDK::Display:ver<4>;
use GSK::Node::Color:ver<4>;
use GTK::Application:ver<4>;
use GTK::ApplicationWindow:ver<4>;
use GTK::Button:ver<4>;
use GTK::Box:ver<4>;
use GTK::DrawingArea:ver<4>;
use GTK::Label:ver<4>;
use GTK::Picture:ver<4>;
use GTK::Scale:ver<4>;
use GTK::Snapshot:ver<4>;

use GTK::Roles::Native:ver<4>;

my $a = GTK::Application.new('org.genex.test.widget');

$a.Activate.tap( -> *@a {
  my $display = GDK::Display.get-default;
  say "Display: { $display.get-name }";

  my $win = GTK::ApplicationWindow.new($a, width => 640, height => 480);
  $win.set-title('GSK Blur Buttons');

  $win.set_display($display);
  $win.realize( :widget );

  my $box      = GTK::Box.new-vbox(6);
  my @hboxes   = GTK::Box.new-hbox xx 2;
  my @scales   = GTK::Scale.new_with_range(0, 100, :h) xx 2;
  my @labels   = ( GTK::Label.new('Scale'), GTK::Label.new('Blur') );
  my $area     = GTK::Picture.new;
  my $color    = GSK::Node::Color.new(
    GDK::RGBA.new( r => 200, a => 1 ),
    my $bounds = Graphene::Rect.new(0, 0, 320, 240)
  );
  my $snapshot = GTK::Snapshot.new;
  $snapshot.translate( Graphene::Point.new(-320, -240) );
  $snapshot.append-node($color);
  my $paintable = $snapshot.free-to-paintable($bounds.size);
  $area.set-paintable($paintable);

  .head.append( |.skip(1) ) for [Z](@hboxes, @labels, @scales);
  .set_hexpand(True) for @scales;
  $box.append( |@hboxes );
  $win.add($box);

  $win.present;
});

$a.run;

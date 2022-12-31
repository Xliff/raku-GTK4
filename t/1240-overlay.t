use v6.c;

# Example ported from:
# https://github.com/sweckhoff/GTK-Cairo-Sinusoids/blob/master/gtk_cairo_sinusoid_plot.c

#use lib <t .>;

# Needs porting to the Cairo module

use Cairo;

use GLib::Timeout;
use GTK::Raw::Types:ver<4>;
#use overlay_example;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::CheckButton:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::DrawingArea:ver<4>;
use GTK::Image:ver<4>;
use GTK::Label:ver<4>;
use GTK::Overlay:ver<4>;
use GTK::ToggleButton:ver<4>;
use GTK::Window:ver<4>;

my $packet = {
  width            => 400,
  height           => 200,
  rad_step         => 0.05,
  scale_factor     => 75,
  y0               => 100,
  x_step           => 1,
  rads             => 0.0,
  last_x           => 0,
  last_y           => 0,
  current_x        => 0,
  current_y        => 0,
  current_eraser_x => 150,
};

$packet<func> = &sin;
my $a = GTK::Application.new( title => 'org.genex.overlay' );

sub do-graph($p) {
  CATCH { default { .message.say; .backtrace.concise.say } }

  my ($pi_rads, $label);

  $p<rads>              = 0 if $p<rads> >= 2.0;
  $pi_rads              = π * $p<rads>;
  $p<label>.label       = "Radians: { $p<rads>.round(0.1) }π";
  $p<rads>             += $p<rad_step>;
  $p<current_x>         = 0 if $p<current_x> > $p<width>;
  $p<last_x last_y>     = $p<current_x current_y>;
  $p<current_x>        += $p<x_step>;
  $p<current_y>         = $p<y0> - ( $p<scale_factor> * $p<func>($pi_rads) );

  $p<current_eraser_x> += $packet<x_step>;
  $p<current_eraser_x>  = 0 if $packet<current_eraser_x> > $packet<width>;
  $a.window.queue_draw;
  1;
}

sub draw-callback($drawable, $packet) {
  CATCH { default { .message.say; .backtrace.concise.say } }

  # Erase Old
  # move_to($packet<eraser>, $packet<current_eraser_x>, 0);
  # line_to($packet<eraser>, $packet<current_eraser_x>, $packet<height>);
  # cairo_stroke($packet<eraser>);

  $packet<eraser>.move_to($packet<current_eraser_x>, 0);
  $packet<eraser>.line_to($packet<current_eraser_x>, $packet<height>);
  $packet<eraser>.stroke;

  # Plot New
  # move_to($packet<plot>, $packet<last_x>, $packet<last_y>);
  # line_to($packet<plot>, $packet<current_x>, $packet<current_y>);
  # cairo_stroke($packet<plot>);

  $packet<plot>.move_to($packet<last_x>, $packet<last_y>);
  $packet<plot>.line_to($packet<current_x>, $packet<current_y>);
  $packet<plot>.stroke;

  # set_source_surface($drawable, $packet<plot_surface>, 0, 0);
  # cairo_paint($drawable);

  my $dc = Cairo::Context.new( cast(Cairo::cairo_t, $drawable) );
  $dc.set_source_surface($packet<plot_surface>);
  $dc.paint;

  1;
}

$a.Activate.tap(-> *@a {
  # $packet<plot_surface> = image_surface_create(
  #   CAIRO_FORMAT_ARGB32,
  #   400,
  #   200
  # );
  $packet<plot_surface> = Cairo::Image.create(
    Cairo::Format::FORMAT_ARGB32,
    400,
    200
  );
  die 'Could not create plot surface' unless $packet<plot_surface>;

  # $packet<plot> = cairo_create($packet<plot_surface>) or die;
  $packet<plot> = Cairo::Context.new($packet<plot_surface>) or die;
  #set_source_rgb($packet<plot>, 1, 0, 0);
  $packet<plot>.rgb(1, 0, 0);
  #$packet<eraser> = cairo_create($packet<plot_surface>) or die;
  $packet<eraser> = Cairo::Context.new($packet<plot_surface>) or die;
  #set_source_rgba($packet<eraser>, 0, 0, 0, 0);
  #set_operator($packet<eraser>, CAIRO_OPERATOR_CLEAR);
  $packet<eraser>.rgba(0, 0, 0, 0);
  $packet<eraser>.operator = CAIRO_OPERATOR_CLEAR;
  $a.window.set-size-request(480, 200);
  $packet<window> = $a.window;

  my $drawing-area      = GTK::DrawingArea.new;
  my $overlay           = GTK::Overlay.new        or die;
  my ($i, $bg)          = ('t/plot_background.png', 't/pi_background.png');
  $i                    = './plot_background.png' unless $i.IO.e;
  $bg                   = './pi_background.png'   unless $bg.IO.e;

  say "I:  { $i.IO.r }";
  say "BG: { $bg.IO.r }";

  my $image             = GTK::Image.new-from-file($i);
  my $background        = GTK::Image.new-from-file($bg);
  $packet<label>        = GTK::Label.new('Radians: 0.0pi');
  $packet<label>.halign = GTK_ALIGN_START;
  $packet<label>.valign = GTK_ALIGN_END;
  $packet<label>.name   = 'radlabel';

  $drawing-area.set_size_request(400, 200);
  # XXX - Problem here... it stops dead after a while. GC issue?
  $drawing-area.set-draw-func(
    -> *@a {
      CATCH { default { .message.say; .backtrace.concice.say } }

      draw-callback( @a[1], $packet )
    }
  );

  $overlay.set-child($background);
  $overlay.add-overlay($image);
  $overlay.add-overlay($drawing-area);
  $overlay.add-overlay($packet<label>);

  my $hbox  = GTK::Box.new-hbox(10);
  my $vbox  = GTK::Box.new-vbox(5);
  my @group = GTK::CheckButton.new-group('SIN', 'COS');
  for @group {
    my $b = $_;
    $b.Activate.tap(-> *@a {
      given $b.label {
        when 'SIN' { $packet<func> = &sin if $b.active; }
        when 'COS' { $packet<func> = &cos if $b.active; }
      }
    });
    $vbox.pack-start($b, True, False);
  }

  $hbox.pack-start($overlay);
  $hbox.pack-start($vbox);

  $a.window.add($hbox);

  @group[0].active    = True;
  $a.window.resizable = False;

  my $c = GTK::CssProvider.new( pod => $=pod );

  $a.window.present;

  # set_timeout equivalent.
  GLib::Timeout.add(100, -> *@a { do-graph($packet) });
});

$a.run;

=begin css
#radlabel { color: #ffffff; }
=end css

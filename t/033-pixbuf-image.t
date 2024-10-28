use v6.c;

use GTK::Raw::Types;
use GDK::Pixbuf::Raw::Enums;

use Color;
use GLib::Timeout;
use GDK::Pixbuf;
use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Image:ver<4>;
use GTK::Grid:ver<4>;

sub create-colors ($n) {
  CATCH { default { .message.say; .backtrace.concise.say } }

  my @pics;

  my @hues   = (0...359).rotor( 360 / $n );
  my $offset = ( ^@hues.head.elems ).pick;
  my @colors = @hues.map( *[$offset] );

  for @colors {
    my $pixbuf = GDK::Pixbuf.new(
      GDK_COLORSPACE_RGB,
      False,
      8,
      1280,
      720
    );

    $pixbuf.fill(
      Color.new(
        hsl => ( $_, 50, 50 )
      ).to-string.substr(1).fmt("0x%s80").Int
    );

    say "Pixbuf: { .width } x { .height }" given $pixbuf;

    @pics.push: $pixbuf;
  }

  @pics;
}

sub MAIN {
  my $a = GTK::Application.new(
    title => 'org.genex.gtk4.pixbuf-image',
    width  => 300,
    height => 200
  );

  $a.Activate.tap: SUB {
    #my $b = GTK::Box.new-vbox(0);
    my $g = GTK::Grid.new;
    my $i = ( GTK::Image.new xx 16 ).Array;

    #$g.set-size-request(3000, 2000);

    constant N-COLORS = 16;

    my $s = N-COLORS.sqrt;

    my $n = 0;
    $g.attach($_, $n % $s, $n++ / $s) for $i[];
    (.column-spacing, .row-spacing) = 0 xx 2 given $g;
    (.row-homogeneous, .column-homogeneous) = False xx 2 given $g;

    say "G: { $g.column-spacing }, { $g.row-spacing }";

    my ($line-colors, $img) = ( create-colors(N-COLORS), 0 );

    sub increment-image {
      return if $img > N-COLORS;
      say "{ $img // 'NIL' }";
      given $i[$img % N-COLORS] {
        .set-from-pixbuf( $line-colors[$img++ % N-COLORS] );
        #.set-size-request(720, 500);
      }
    }

    increment-image;

    GLib::Timeout.add(100, SUB {
      CATCH { default { .message.say } };

      increment-image;
      $img < N-COLORS ?? G_SOURCE_CONTINUE !! G_SOURCE_REMOVE;
    });

    $a.window.resizable = True;
    $a.window.child = $g;
    $a.window.present;
  }

  $a.run;
}

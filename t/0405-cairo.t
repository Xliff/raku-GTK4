use v6.c;

use Cairo;
use GTK::Raw::Types:ver<4>;
use GTK::Application:ver<4>;
use GTK::DrawingArea:ver<4>;

sub MAIN {
  my $a = GTK::Application.new(
    title  => 'org.genex.gtk4.cairo1',
    width  => 800,
    height => 600
  );


  $a.Activate.tap: SUB {
    my $d = GTK::DrawingArea.new;

    $d.set-draw-func(
      sub (*@a) {
        CONTROL {
          when CX::Warn { .message.say; .backtrace.concise.say }
        }

        my  $c        = @a[1];
        my ($w,  $h)  = @a[2, 3];
        my ($xc, $yc) = ($w, $h)  »div» 2;
        my  $l        = ($w, $h).min;

        $c.rgba(1, 1, 1, 1);
        $c.operator = OPERATOR_OVER;
        $c.paint;

        $c.rgba(0, 0, 0, 1);
        $c.line_width = $l * 0.02;

        $c.save;
        $c.arc($w / 3, $h / 4, $l / 4, -(π / 5), π);
        $c.close_path;
        $c.rgb(0, 0.8, 0);
        $c.fill( :preserve );
        $c.restore;
        $c.stroke;

        $c.save;
        $c.arc($xc, $yc,  $l / 4, 0, 2 * π);
        $c.rgba(0, 0, 0.8, 0.6);
        $c.fill( :preserve );
        $c.restore;
        $c.stroke;

        $c.save;
        my ($ex, $ey, $ew, $eh) = ($xc, 3 * $h / 4, 3 * $w / 4, $h / 3);
        $c.translate($ex, $ey);
        $c.scale($ew / 2, $eh / 2);
        $c.arc(0, 0, 1, 0, 2 * π);
        $c.rgba(0.8, 0, 0, 0.7);
        $c.fill( :preserve );
        $c.restore;
        $c.stroke;
      }
    );

    $a.window.add($d);
    $a.window.present
  }

  $a.run;
}

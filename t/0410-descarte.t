use v6.c;

use Cairo;
use GTK::Raw::Types:ver<4>;
use GTK::Application:ver<4>;
use GTK::DrawingArea:ver<4>;

use GTK::Event::Controller::Motion;

use Cairo::Simple;

# Source: https://www.youtube.com/watch?v=6UlGLB_jiCs&t=373s
# Thanks, man! Your content was inspiring. I hope you find this implementation
# worthy!

class Circle {
  has $.x      is rw               is built;
  has $.y      is rw               is built;
  has $.bend   is rw is default(0) is built;
  has $.radius is rw is default(0) is built;

  submethod BUILD (
    :$!x,
    :$!y,
    :$!bend,
    :$!radius,
    :$exterior
  ) {
    say "Bend:   { $!bend   // 'NOBEND' }";
    say "Radius: { $!radius // 'NORAD' }";

    $!radius = 1 / $!bend   if $!bend   && $!radius.not;
    $!bend   = 1 / $!radius if $!radius && $!bend.not;

    die "Radius and Bend do not agree!" if $!radius != 1 / $!bend;

    $!bend *= -1 if $exterior;
  }

  method center {
    $!x + $!y * i
  }

  method show ($c) {
    $c.circle($!x, $!y, $!radius, False);
  }

  multi method new (
     $x,
     $y,
     $radius,
    :$exterior = False,
    *%named where { not .<bend>:exists }
  ) {
    self.bless( :$x, :$y, :$radius, :$exterior );
  }
  multi method new ($x, $y, $b, :$bend is required) {
    say "New with bend!";
    self.bless( :$x, :$y, bend => $b);
  }

  method eqv (::?CLASS $b) {
    [&&](
      $!x    == $b.x,
      $!y    == $b.y,
      $!bend == $b.bend
    );
  }

}

sub complexDescartes ( $k4, @circles ) {
  my @k  := @circles.map( *.bend ).Array;
  my @z  := @circles.map( *.center ).Array;

  my @zk := ( @z Z @k ).map({ .head * .tail }).Array;

  my $sum = @zk.sum;

  say "K4: { $k4.gist }";

  my $root  = [+]( @zk[0] * @zk[1], @zk[1] * @zk[2], @zk[0] * @zk[2] );
  my @roots = $k4.map({ $root.sqrt * 2 / $_ });

  say "Roots: { @roots.join(', ') }";

  my @return = (
    $sum + @roots.head,
    $sum - @roots.head
  );

  say "Return0: { @return.join(', ') }";

  @return.append: $sum + @roots.tail, $sum - @roots.tail
    if @roots.head != @roots.tail;

  say "Return1: { @return.join(', ') }";

  @return.map({
    my @c = Circle.new( .re, .im, $k4.head, :bend );
    say "C0-{ $++ }: { @c.gist }";
    @c.push: Circle.new( .re, .im, $k4.tail, :bend) if $k4.head != $k4.tail;
    say "C1-{ $++ }: { @c.gist }";
    |@c;
  })
}

sub descartes ( @circles ) {
  my ($k1, $k2, $k3) := @circles;
  my $sum  = @circles.map( *.bend ).sum;
  my $root = 2 * (
    $k1.bend * $k2.bend,
    $k2.bend * $k3.bend,
    $k1.bend * $k3.bend
  ).sum.sqrt;

  [ $sum + $root, $sum - $root ]
}

sub MAIN {
  my $a = GTK::Application.new(
    title  => 'org.genex.gtk4.cairo1',
    width  => 800,
    height => 600
  );

  $a.Activate.tap: SUB {
    my $d = GTK::DrawingArea.new;

    my @circles = [
      Circle.new(200, 200, 200, :exterior),
      Circle.new(100, 200, 100),
      Circle.new(300, 200, 100)
    ];

    my @mousePos;
    my $motion-controller = GTK::Event::Controller::Motion.new;

    $motion-controller.Motion.tap: -> *@a {
      @mousePos = @a[1, 2];
      say "Mouse Position: { @mousePos.gist }";
      $d.queue-draw;
    }

    $a.window.add-controller($motion-controller);

    $d.set-draw-func(
      sub (*@a) {
        CONTROL {
          when CX::Warn { .message.say; .backtrace.concise.say }
        }

        my  $c        = @a[1] but Cairo::Simple::Context;
        my ($w,  $h)  = @a[2, 3];
        my ($xc, $yc) = ($w, $h)  »div» 2;
        my  $l        = ($w, $h).min;

        $c.rgba(1, 1, 1, 1);
        $c.operator = OPERATOR_OVER;
        $c.paint;

        @circles».show($c);

        say "MP: { @mousePos.gist }";

        my $mc = Circle.new( |@mousePos, 67 );
        $mc.show($c);

        my $k4 = descartes( @circles );
        # my @new-circles;

        # Dedupe
        # for complexDescartes( $k4, @circles )[] -> $nc {
        #   @new-circles.push: $_
        #     unless @new-circles.first( *.eqv($nc), :k ).defined.not
        # }
        #
        # once {
        #   say "NC: { @new-circles.gist }";
        # }
        #
        # @new-circles».show($c);
      }
    );

    $a.window.add($d);
    $a.window.present
  }

  $a.run;
}

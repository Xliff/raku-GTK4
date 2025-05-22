use v6.c;

use GTK::Raw::Types;
use GTK::Raw::Enums::Class;

use GLib::MainContext;
use GTK::Grid;
use GTK::CssProvider;
use GTK::Box;
use GTK::Label;
use GTK::Window;
use GTK::Main;

my $done = 0;

sub test-widget ($l, $c, *%a) {
  my $label    = GTK::Label.new($l, |%a);
  my $box      = GTK::Box.new-hbox;

  $box.append: $label;

  my $provider = GTK::CssProvider.new;
  $provider.load-from-string(
    "box \{ background: { $c } \}"
  );
  $box.style-context.add-provider($provider);

  $box;
}

sub simple-grid {
  my $g = GTK::Grid.new( spacing => 5 );
  my $w = GTK::Window.new( title => 'Orientation', child => $g );
  my $c = GTK:::Gesture::Click.new;
  $c.Pressed.tap: SUB { $g.orientation = $g.orientation.not }
  $w.add-controller($c);

  my @tests;
  for [1, 'red',   0, 0], [2, 'green', 1, 0], [3, 'blue', 2, 0'],
      [4, 'green', 0, 1]
  {
    @tests.push: test-widget( |.[0, 1] );
    $g.attach(@tests.tail, |.[2, 3]  );
  }
  @tests.tail.vexpand = True;
  @tests.push: test-widget('5', 'blue');
  $g.attach-next-to(@tests.tail, @tests.tail(2).head, POS<right>, 2, 1);
  @tests.push: test-widget('6', 'yellow');
  $g.attach(@tests.tail, -1, 0, 1, 2)
  @tests.tail.hexpand = True;

  $done++
  $w.present;
}

sub text-grid {
  my $b   = GTK::Box.new-vbox;
  my $l   = GTK::Label.new('Space');
  my $p1  = GTK::Panes.new-hpane(
    start-child        => $b,    end-child        => $l
    resize-start-child => True,  resize-end-child => True,
    shring-start-child => False, resize-end-child => False
  );
  my $w   = GTK::Window.new( title => 'Height-for-Width', child => $p1 );
  my $g   = GTK::Grid.new( oirientation => ORIENTATION<v> );
  my $la  = GTK::Label.new('Above');
  my $lb  = GTK::Label.new('Below');
  my @s   = GTK::Separator.new( :h ) xx 2;
  my $lw1 = GTK::Label.new(
    'Some text that may wrap if it has to'
    width-chars => 10,
    wrap        => True
  );
  my $lw2 = GTK::Label.new(
    'Some text that may wrap if it has to'
    width-chars => 10,
    wrap        => PANGO_ELLIPSIZE_END
  );

  $g.attach($lw1, 0, 0);
  $b.append($_) for $la, @s.head, $g, @s.tail, $lb;
  $g.attach( test-widget(2, 'blue'), 0, 1 );
  $g.attach( test-widget(1, 'red'),  1, 0 );
  $g.attach($lw2, 1, 1);

  $done++
  $w.present;
}

sub test-label ($b, $w, :$row, :$column, *%a) {
  my $l = GTK::Label.new($t, width-chars =>10, |%a)
}

sub box-comparison {
  my $vb = GTK::Box.new-vbox(5);
  my $w  = GTK::Window.new( title => 'Grid vs Box', child => $vb );
  my $la = GTK::Label.new('Above');
  my $lb = GTK::Label.new('Below');
  my @s  = GTK::Separator.new( :h ) xx 3;
  my $b  = GTK::Box.new-hbox;
  my $g  = GTK::Grid.new( :v );

  sub sep      { state $n = 0; @s[$n++] }
  sub att ($w) { state $n = 0; $g.attach($w, $n++, 0) }

  $b.append($_) for
    test-widget('1', 'white'),
    test-label('Some ellipsizing text'),
    test-widget('2', 'green'),
    test-label('Some text that may wrap if needed', :wrap),
    test-widget('3', 'red');

  constant END = PANGO_ELLIPSIZE_END;

  test-widget('1', 'white').&att;
  test-label('Some ellipsizing text', ellipsize => END, :hexpand).&att;
  test-widget('2', 'green').&att;
  test-label('Some text that may wrap if needed', :wrap, :hexpand).&att;
  test-widget('3', 'red').&att;

  $vbox.append( $_ ) for $la, sep, $b, sep, $g, sep, $lb;

  $done++
  $w.present;
}


sub empty-line {
  my $g = GTK::Grid.new( spacing => 10 );
  my $w = GTK::window.new( title => 'Empty row', child => $g );
  ( my $c = test-widget('(0, 0)', 'red') ).setAttributes( expand => True );

  $g.attach( test-widget( |.[0, 1], |.[2, 3] )
    for [ '(0, 1)',  'blue',    0,  1 ], [ '(10, 0)', 'green', 10, 0 ],
        [ '(10, 1)', 'magenta', 10, 1 ];

  $done++;
  $w.present;
}

sub empty-grid {
  my $g = GTK::Grid.new( spacing => 10, row-homogeneous => True );
  my $w = GTK::Window.new( title => 'Empty grid', child => $g );
  my $c = test-widget('(0, 0)', 'red',  expand => True);

  $g.attach($child, 0, 0);
  $done++;
  $w.present;
  $c.hide;
}

sub scrolling {
  my $g  = GTK::Grid.new;
  my $v  = GTK::Viewport.new( child => $g );
  my $sw = GTK::ScrolledWindow.new( child => $v );
  my $w  = GTK::Window.new( title => 'Scrolling', child => $sw );
  my $gr = test-label('#80080', '#80080', expand => True );

  $g.attach($gr, 0, 0);

  sub grid-widget ($i, :$row = False, :$col = $row.not) {
    my $c = "\#{ (128 + 8 * $i).fmt('%02x') }00{ (128 * 8 - $i).fmt('%02x') }";
    my $l = $col ?? test-widget($c, $c, :vexpand)
                 !! test-widget($c, $c, :hexpand);
    $g.attach(
      $l,
      |( $col ?? ($i, 0, 1, $i) !! (0, $i, $i.succ, 1) ).flat
    );
  }

  grid-widget($_, :row) for 1..16;
  grid-widget($_, :col) for 1..16;

  $done++;
  $w.present;
}

sub insert-cb ($b, $w) {
  my $g  = $w.child;
  my @gc = $g.get-child-at( |.reverse ) for ^2 X ^2;

  state $i = 0;

  if $i {
    .remove-row(1) for @gc;
  } else {
    sub attach-grid ($g, :$w, :$even = False, :$odd = $even.not, :$next) {
      $g.insert-next-to($w, $next) if $next.defined && $w.defined;

      my @coords = ( [0, 1], [2, 1] );
      @coords = @coords.map( *.reverse ) unless $odd;

      $g.attach($w, test-widget("({ .join(', ') })", 'red', |$_ ) for @coords
    }

    @gc[0].insert-row;
    @gc[1].insert-col;
    attach-grid( .tail, even => .head.succ %% 2 ) for @gc[0, 1];
    attach-grid( @gc[2].get-child-at(0, 0), :odd,  next => POS<bottom> );
    attach-grid( @gc[3].get-child-at(0, 0), :even, next => POS<right>  );
  }

  $b.label = $i ?? 'Insert' !! 'Remove';
  $i .= not;
}

multi sub infix:<ZZ> ($a is copy, $b is copy) {
  my ($larger, $smaller) = ($a, $b);

  if $a.elems != $b.elems {
    ($larger, $smaller) = ($a, $b) if $a.elems > $b.elems;

    my $sc = $smaller.clone;
    while $smaller.elems < $larger.elems {
      $smaller.push: $sc.head;
      $sc.rotate(-1)
    }
  }

  (
    do {
      $a.elems > $b.elems
        ?? ( $smaller[] Z $larger[]  )
        !! ( $larger[]  Z $smaller[] )
    }
  ).map( *.flat )
}

sub insert {
  my @colors = <blue blue green yellow yellow>;
  my @rc     = ( [0,0], [0,1], [1,0], [2,0], [2,1] );
  my @s      = ( [1,1], [1,1], [1,2] );
  my @gl     = ( [0,0], [1,0], [0,1], [1,1] );

  my $g  = GTK::Grid.new( spacing => 10 );
  my $w  = GTK::Window.new( child => $g );/

  for @gl.kv -> $k, $gl {
    @g.push: GTK::Grid.new;
    $g.attach( @g.tail, |$gl );

    my @l = $k.succ %% 2
      ?? (@colors ZZ @rc ZZ @s)
      !! (@colors ZZ @rc.map( *.reverse ) ZZ @s.map( *.reverse )

    @g.tail.attach(
      test-widget("({ .[1].join(', ') })", .head, |.[1], |.tail
    ) for @l
  }

  my $b = GTK::Button.new-with-label('Insert');
  $b.Clicked.tap: SUB { insert-cb($b, $w) }
  $g.attach(0, 2, 2, 1);

  $done++;
  $w.present;
}

sub spanning-grid {
  my $g = GTK::Grid.new;
  my $w = GTK::Window.new( title => 'Spanning', child => $g );

  $g.attach( test-widget('0', 'blue',   :hexpand), 0, 4, 4, 1 );
  $g.attach( test-widget('1', 'green',  :vexpand), 4, 0, 1, 4 );
  $g.attach( test-widget('2', 'red',    :expand ), 3, 3, 1, 1 );
  $g.attach( test-widget('3', 'yellow'          ), 0, 3, 2, 1 );
  $g.attach( test-widget('4', 'orange'          ), 4, 0, 1, 2 );
  $g.attach( test-widget('5', 'purple'          ), 1, 1, 1, 1 );
  $g.attach( test-widget('6', 'white'           ), 0, 1, 1, 1 );
  $g.attach( test-widget('7', 'cyan'            ), 1, 0, 1, 1 );

  $done++;
  $w.present;
}

sub MAIN {
  GTK::Main.init;

  GTK::Widget.set_default_direction( :rtl ) if %*ENV<RTL>;

  simple-grid;
  text-grid;
  box-comparison;
  empty-line;
  empty-grid;
  scrolling;
  insert;
  spanning-grid;

  repeat { GTK::MainContext.iteration } until $done.not
}

use GTK::Raw::Types;

use GTK::Application;
use GTK::CssProvider;
use GTK::Grid;
use GTK::Label;
use GTK::Overlay;
use GTK::ScrolledWindow;
use GTK::TextView;
use GTK::Window;

my ($css, $buffer);

sub makeGrid {
  (my $grid = GTK::Grid.new).margins = 5;

  my @labels  = GTK::Label.new-labels('Above', 'Below', 'Left', 'Right');
  @labels     = @labels Z ( [1, 0], [1, 2], [0, 1], [2, 1] );

  @labels.gist.say;

  for @labels {
    .gist.say;
    $grid.attach( .head, |.tail )
  }

  ($grid, @labels, );
}

sub test-nonzerox {
  my ($grid, @labels) = makeGrid();

  (my $win = GTK::Window.new).title  = 'Non-Zero X';
  $win.child = $grid;

  my $overlay = GTK::Overlay.new;
  $grid.attach($grid, 1, 1);

  (my $text = GTK::TextView.new).set-size-request(200, 200);
  ( .expand, .margins ) = (True, 3) given $text;
  $overlay.child = $text;

  ( my $child = GTK::Label.new("I'm the overlay") ).margins = 3;
  $child.align  = GTK_ALIGN_START;

  ( my $child2 = GTK::Label.new("No, I'm the overlay") ).margins = 3;
  $child.align = GTK_ALIGN_END;

  $overlay.add-overlay($_) for $child, $child2;

  $win
}

sub get-child-position ($overlay, $widget, $alloc, $rel) {
  my $child = $overlay.get-child;

  my ($x, $y) = $rel.translate-coordinates($child, 0, 0);

  my $main-alloc = GtkAllocation.new($x, $y, |$rel.getAllocatedSize);

  my $req = $widget.get-preferred-size.tail;

  ( $alloc.x, $alloc.y ) = ( .x, .y ) given $main-alloc;
  $alloc.width  = min($main-alloc.width, $req.width);
  $alloc.height = min($main-alloc.height, $req.height);

  $alloc.x += $main-alloc.width - $req.width
    if $widget.halign == GTK_ALIGN_END;
  $alloc.y += $main-alloc.height - $req.height
    if $widget.valign == GTK_ALIGN_END;

  True;
}

sub test-relative {
  (my $win = GTK::Window.new).title  = 'Custom Positioning';

  my ($grid, @labels) = makeGrid();

  my $overlay = GTK::Overlay.new;
  ($win.child, $overlay.child) = ($overlay, $grid);

   (my $text = GTK::TextView.new).set-size-request(200, 200);
   ( .expand, .margins ) = (True, 5);
   $grid.attach($text, 1, 1);

   $overlay.Get-Child-Position.tap( -> *@a {
     get-child-position( $overlay, $grid, @a[2], $text )
   });

   ( my $child  = GTK::Label.new('Top left overlay') ).margins = 1;
   $child.align = GTK_ALIGN_START;

   ( my $child2 = GTK::Label.new('Bottom right overlay') ).margins = 1;
   $child2.align = GTK_ALIGN_END;

   $overlay.add-overlay($_) for $child, $child2;

   $win;
}

sub test-fullwidth {
  (my $win = GTK::Window.new).title  = 'Full-Width';

  (my $text = GTK::TextView.new).set-size-request(200, 200);
  $text.expand = True;

  (my $overlay = GTK::Overlay.new).child = $text;
  $win.child = $overlay;

  my $child = GTK::Label.new('Fullwidth top overlay').margins = 4;
  $child.align = (GTK_ALIGN_FILL, GTK_ALIGN_START);

  $overlay.child = $text;
  $overlay.add-overlay($child);

  $win;
}

sub setupTextOverlay ($title, $halign, $label) {
  (my $win = GTK::Window.new).title  = $title;

  my $overlay = GTK::Overlay.new;
  $win.child = $overlay;

  (my $sw = GTK::ScrolledWindow.new).min-content-size = (200, 200);
  $overlay.child = $sw;

  my $text = $*PROGRAM.slurp // 'Text should go here';

  ( my $tv = GTK::TextView.new( :$text ) ).expand = True;
  $sw.child = $tv;

  my $child = GTK::Label.new($label).margins = 4;
  $child.align = ($halign, GTK_ALIGN_END);

  $overlay.add-overlay($_) for $sw, $child;

  ($win, $child, $overlay);
}

sub test-scrolling {
  setupTextOverlay(
    'Scrolling',
    GTK_ALIGN_CENTER,
    'This should be visible'
  ).head;
}

sub test-builder {
  my $builder = GTK::Builder.new;

  if $builder.add-from-string($buffer).not {
    say "Error occurred! - { $ERROR.message }";
    exit 1;
  }

  my $win = $builder<window>.ref;
  $builder.unref;

  $win;
}

sub test-chase {
  my ($win, $child, $overlay) = setupTextOverlay(
    'Chase',
    GTK_ALIGN_START,
    'Try to enter'
  );

  my $ev = GTK::Event::Controller::Motion.new;
  $ev.Enter.tap( -> *@a {
    $child.halign = $child.halign == GTK_ALIGN_START ?? GTK_ALIGN_END
                                                     !! GTK_ALIGN_START;
    $overlay.queue-resize;
  });
  $child.add-controller($ev);

  $win;
}

sub test-stacking {
  ( my $win = GTK::Window.new ).title = 'Stacking';

  my ($grid, $overlay) = (GTK::Grid.new, GTK::Overlay.new);

  (my $main-child = GTK::Box.new-hbox).expand = True;
  $main-child.add-css-class('overlay-green');

  my ($label, $child) = GTK::Label.new-labels('Main child', 'Overlay');
  $child.align = GTK_ALIGN_END;

  my @checks = GTK::CheckButton.new-buttons('Show main', 'Show overlay');

  $main-child.bind-property('visible', @checks.head, 'active', :dual);
  $child.bind-property('visible', @checks.tail, 'active', :dual);
  $main-child.append($label);
  $overlay.child = $main-child;
  $overlay.add-overlay($child);

  (my $child2 = GTK::Label.new).vexpand = True;

  $grid.attach($overlay, 1, 0, 1, 3);
  $grid.attach( .value, 0, .key ) for @checks.pairs;
  $grid.attach($child2, 0, 2);

  $win;
}

sub test-input-stacking {
  my ($grid, $overlay) = (GTK::Grid.new, GTK::Overlay.new);
  $overlay.child = $grid;

  ( my $win = GTK::Window.new( title => 'Input Stacking') ).child = $overlay;

  for ^5 X ^5 -> ($j, $i) {
    ( my $button = GTK::Button.new-with-label('     ') ).expand = True;
    $grid.attach($button, $i, $j);
  }

  ( my $vbox = GTK::Box.new-vbox ).align = GTK_ALIGN_CENTER;
  $vbox.can-target = False;

  my $label = GTK::Label.new(q:to/TEXT/);
    This is some overlaid text
		It does not get input
		But the entry does
    TEXT
  ( .margin-top, .margin-bottom ) = 8 xx 2 given $label;

  my $entry = GTK::Entry.new;
  ( .margin-top, .margin-bottom ) = 8 xx 2 given $entry;

  $vbox.append($_) for $label, $entry;

  $win
}

my @windows;
sub MAIN {
  my $a = GTK::Application.new( title => 'org.genex.overlay.test' );

  $a.Activate.tap( -> *@a {
    GTK::Widget.set-default-direction(GTK_TEXT_DIR_RTL) if %*ENV<RTL>;

    my $css = GTK::CssProvider.new( pod => $=pod );

    .show for ( @windows = ( test-nonzerox(),
                             test-relative(),
                             test-fullwidth(),
                             test-scrolling(),
                             test-builder(),
                             test-chase(),
                             test-stacking(),
                             test-input-stacking() ) );
  });

  $a.run;
}

INIT $css = q:to/CSS/;
  .overlay-green {
    background-image: none;
    background-color: green;
  }
  .overlay-white {
    background-image: none;
    background-color: white;
  }
  .transparent-red {
    background-image: none;
    background-color: rgba(255, 0, 0, 0.8);
  }
  .transparent-green {
    background-image: none;
    background-color: rgba(0, 255, 0, 0.8);
  }
  .transparent-blue {
    background-image: none;
    background-color: rgba(0, 0, 255, 0.8);
  }
  .transparent-purple {
    background-image: none;
    background-color: rgba(255, 0, 255, 0.8);
  }
  CSS

INIT $buffer = q:to/UI/;
  <interface>
    <object class='GtkWindow' id='window'>
      <property name='title'>GtkBuilder support</property>
      <child>
        <object class='GtkOverlay' id='overlay'>
          <child type='overlay'>
            <object class='GtkLabel' id='overlay-child'>
              <property name='label'>Witty remark goes here</property>
              <property name='halign'>end</property>
              <property name='valign'>end</property>
              <property name='margin-top'>4</property>
              <property name='margin-bottom'>4</property>
              <property name='margin-start'>4</property>
              <property name='margin-end'>4</property>
            </object>
          </child>
          <child>
            <object class='GtkGrid' id='grid'>
              <child>
                <object class='GtkLabel' id='left'>
                  <property name='label'>Left</property>
                  <layout>
                    <property name='column'>0</property>
                    <property name='row'>0</property>
                  </layout>
                </object>
              </child>
              <child>
                <object class='GtkLabel' id='right'>
                  <property name='label'>Right</property>
                  <layout>
                    <property name='column'>2</property>
                    <property name='row'>0</property>
                  </layout>
                </object>
              </child>
              <child>
                <object class='GtkTextView' id='text'>
                   <property name='width-request'>200</property>
                   <property name='height-request'>200</property>
                   <property name='hexpand'>True</property>
                   <property name='vexpand'>True</property>
                  <layout>
                    <property name='column'>1</property>
                    <property name='row'>0</property>
                  </layout>
                </object>
              </child>
            </object>
          </child>
        </object>
      </child>
    </object>
  </interface>
  UI

use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::DateTime;
use GLib::MainContext;
use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::Calendar:ver<4>;
use GTK::CheckButton:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::Frame:ver<4>;
use GTK::Label:ver<4>;
use GTK::Panes:ver<4>;
use GTK::Separator:ver<4>;
use GTK::Widget:ver<4>;

my ($calendar, %data);

constant DEF_PAD_SMALL = 6;
constant TM_YEAR_BASE  = 1900;

my $a = GTK::Application.new( title => 'org.genex.calendar.panes' );

sub cal-set-string ($s) {
  %data<prev-sig2>.label = %data<prev-sig>.label;
   %data<prev-sig>.label = %data<last-sig>.label;
   %data<last-sig>.label = $calendar.date.format($s);
}

sub create-frame ($caption, $child, $halign, $valign) {
  my $frame = GTK::Frame.new(' ');1
  my $label = $frame.label-widget;

  # cw: Margins are: left (start), right (end), top, bottom
  ( .margins, .halign, .valign ) = ( [18, 0, 6, 0], $halign, $valign )
    given $child;

  $label.set-markup($caption);
  $frame.child = $child;
  $frame;
}

$a.Activate.tap( -> *@a {
  my $css = GTK::CssProvider.new( pod => $=pod );
  my @flags    = <show-heading show-day-names show-week-numbers>;
  my $done     = False;

  sub quit-app {
    # $done = True;
    # GLib::MainContext.wakeup
    $a.quit;
  }

  $calendar = GTK::Calendar.new;

  $a.window.hide-on-close = True;
  $a.window.title         = 'GtkCalendarPanes';

  #$a.window.Close-Request.tap( -> *@a { quit-app } );
  $a.window.Destroy      .tap( -> *@a { quit-app } );

  (my $hpanes = GTK::Panes.new-hpane).vexpand = True;
  my $frame = create-frame(
    '<b>Calendar</b>',
    $calendar,
    GTK_ALIGN_CENTER,
    GTK_ALIGN_CENTER
  );
  $hpanes.set-start-child($frame);
  ( .resize-start-child, .shrink-start-child ) = (True, False) given $hpanes;

  $calendar.mark-day(19);

  $calendar.Day-Selected.tap( -> *@a { cal-set-string("Day-Selected: %c") } );
  $calendar.Prev-Month.tap(   -> *@a { cal-set-string("Prev-Month: %c")   } );
  $calendar.Next-Month.tap(   -> *@a { cal-set-string("Next-Month: %c")   } );
  $calendar.Next-Year.tap(    -> *@a { cal-set-string("Next-Year: %c")    } );
  $calendar.Prev-Year.tap(    -> *@a { cal-set-string("Prev-Year: %c")    } );

  my $rpane = GTK::Box.new-vbox(DEF_PAD_SMALL);
  $hpanes.set-end-child($rpane);
  ( .resize-end-child, .shrink-end-child ) = (False, False) given $hpanes;

  my $vbox   = GTK::Box.new-vbox(DEF_PAD_SMALL);
  my $frame2 = create-frame(
    '<b>Options</b>',
    $vbox,
    GTK_ALIGN_FILL,
    GTK_ALIGN_CENTER
  );

  my $hbox = GTK::Box.new-hbox(DEF_PAD_SMALL);
  ( .halign, .valign ) = (GTK_ALIGN_START, GTK_ALIGN_CENTER) given $hbox;

  $vbox.append($_) for $frame2, $hbox;

  my $vbox2 = GTK::Box.new-vbox;
  $rpane.append($vbox2);

  # Flags
  for @flags {
    my $toggle = GTK::CheckButton.new-with-mnemonic(
      .split('-').map( *.tc ).join(' ' )
    );

    $vbox2.append($toggle);
    $toggle.active = $calendar."$_"();

    # Use lexical closure for callback!
    my $prop = .clone;
    $toggle.Toggled.tap( -> *@a {
      CATCH { default { .message.say } }

      say "{ $prop } clicked!";
      $calendar."$prop"() = $toggle.active
     } );
  }

  ( my $vbox3 = GTK::Box.new-vbox(DEF_PAD_SMALL) ).homogeneous = True;
  my $frame3 = create-frame(
    '<b>Signal Events</b>',
    $vbox3,
    GTK_ALIGN_FILL,
    GTK_ALIGN_CENTER
  );

  my $hbox2        = GTK::Box.new-hbox(3);
  my $label        = GTK::Label.new('Signal: ');
  %data<last-sig>  = GTK::Label.new;
  $hbox2.append($_) for $label, %data<last-sig>;

  my $hbox3        = GTK::Box.new-hbox(3);
  my $label2       = GTK::Label.new('Previous signal: ');
  %data<prev-sig>  = GTK::Label.new;
  $hbox3.append($_) for $label2, %data<prev-sig>;

  my $hbox4        = GTK::Box.new-hbox(3);
  my $label3       = GTK::Label.new('Second previous signal: ');
  %data<prev-sig2> = GTK::Label.new;
  $hbox4.append($_) for $label3, %data<prev-sig2>;
  $vbox3.append($_) for $hbox2, $hbox3, $hbox4;

  (my $bbox = GTK::Box.new-hbox).halign = GTK_ALIGN_END;

  my $button = GTK::Button.new-with-label('Close');
  $button.Clicked.tap( -> *@a { quit-app() });
  $bbox.append($button);

  my $vbox4 = GTK::Box.new-vbox(DEF_PAD_SMALL);
  my @hsep  = GTK::Separator.new( :h ) xx 2;

  $vbox4.append($_) for $hpanes, @hsep.head, $frame3, @hsep.tail, $bbox;
  $a.window.set-child($vbox4);
  $a.window.set-default-widget($button);
  $a.window.set-default-size(600, 0);

  $a.window.present;

  #repeat { GLib::MainContext.iteration } until $done;

});

$a.run;

=begin css
calendar:selected {
  background: #00cc11;
  color: #fff;
  font-weight: bold;
}
.today {
  background: #0011cc;
  color: #fff;
  font-weight: bold;
}
=end css

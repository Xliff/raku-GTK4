use v6.c;

use GTK::Application:ver<4>;
use GTK::Builder:ver<4>;
use GTK::CssProvider:ver<4>;

use GTK::Adjustment:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::Button::Check:ver<4>;
use GTK::Button::Link:ver<4>;
use GTK::Button::Lock:ver<4>;
use GTK::Button::Spin:ver<4>;
use GTK::Button::Toggle:ver<4>;
use GTK::Entry:ver<4>;
use GTK::Event::Controller::Motion:ver<4>;
use GTK::Grid:ver<4>;
use GTK::Scale:ver<4>;
use GTK::Statusbar:ver<4>;
use GTK::Switch:ver<4>;

use GDK::RGBA;
use GIO::Permission;

# HOPEFULLY FOR NOW!
# Use of GTK::Builder requires a whole new paradigm for
# writing applications.
my %cids;
my $a = GTK::Application.new( title => 'org.genex.gtk.builder' );

$a.Activate.tap( -> *@a {
  my $c = GTK::CssProvider.new( pod => $=pod );
  my $b = GTK::Builder.new(     pod => $=pod );

  my $numClicks = 0;
  # Can't add a statusbar in glade, so have to do it here!
  my $status = GTK::Statusbar.new;

  # Set statusbar events.
  for $b.keys {
    next unless $b{$_} ~~ GTK::Widget;

    my $text = "Control: { $_ } ( { $b{$_}.^name } )";
    say $text;

    %cids{$_} = $status.get_context_id($text);

    my $focus-events = GTK::Event::Controller::Motion.new;

    # Note that if the next two event handlers do NOT return 0, then the
    # hover coloration will not be performed.
    my $wn = $_;
    $focus-events.Enter.tap(-> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }
      $status.push( %cids{$wn}, $text);
    });
    $focus-events.Leave.tap(-> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }

      $status.pop( %cids{$wn} );
    });

    $b{$_}.add-controller($focus-events);
  }

  # say "Contexts:\n{ %cids.pairs
  #                        .sort( *.value )
  #                        .map({ "\t{ .key } => { .value }" })
  #                        .join("\n") }";
  #
  # say "Keys: { $b.keys.join(', ') }";
  # say "Controls:\n{ $b.pairs
  #                     .map({ "\t{ .key } => { .value.^name }"  })
  #                     .join("\n") }";

  $status.show;
  $b<application>.Destroy.tap(  -> *@a { $a.exit });
  $b<cancelbutton>.Clicked.tap( -> *@a { $a.exit });
  $b<link1>.Clicked.tap({ $numClicks++ });
  $b<okbutton>.Clicked.tap( -> *@a {
    say '-' x 30;
    say "Entry control contains: " ~ $b<entry1>.text;
    say "Link control was { $b<link1>.visited ?? '' !! 'not ' }visited.";
    say "Link control clicked: { $numClicks } times";
    say "Toggle button current status: " ~ $b<toggle1>.active.Str;
    say "Check button current status: " ~ $b<check1>.active.Str;
    say "Switch current status: " ~ $b<switch1>.active.Str;
    #say "Color button current color: " ~ $b<color1>.rgba.Str;
    say "Spin current value: " ~ $b<spin1>.value;
    say "Scale control current value: " ~ $b<scale1>.value;
  });
  $b<box1>.pack_start($status, True, True);
});

$a.run;

=begin css
button:hover
{ background: #ff3333; }
=end css
=begin ui
<interface>
  <requires lib="gtk+" version="3.20"/>
  <object class="GtkAdjustment" id="adjustment1">
    <property name="lower">25</property>
    <property name="upper">100</property>
    <property name="step_increment">2</property>
    <property name="page_increment">5</property>
  </object>
  <object class="GtkAdjustment" id="adjustment2">
    <property name="upper">100</property>
    <property name="step_increment">5</property>
    <property name="page_increment">10</property>
  </object>
  <object class="GtkWindow" id="application">
    <property name="visible">True</property>
    <property name="can_focus">True</property>
    <property name="has_focus">True</property>
    <child>
      <object class="GtkBox" id="box1">
        <property name="visible">True</property>
        <property name="can_focus">False</property>
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkGrid" id="grid1">
            <property name="visible">True</property>
            <property name="can_focus">False</property>
            <property name="column_homogeneous">True</property>
            <child>
              <object class="GtkEntry" id="entry1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
              </object>
            </child>
            <child>
              <object class="GtkLinkButton" id="link1">
                <property name="label" translatable="yes">Xliff</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">True</property>
                <property name="margin_start">2</property>
                <property name="margin_end">2</property>
                <property name="margin_top">2</property>
                <property name="margin_bottom">2</property>
                <property name="uri">https://github.com/Xliff</property>
              </object>
            </child>
            <child>
              <object class="GtkToggleButton" id="toggle1">
                <property name="label" translatable="yes">Toggle</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">True</property>
              </object>
            </child>
            <child>
              <object class="GtkCheckButton" id="check1">
                <property name="label" translatable="yes">Checked</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">False</property>
              </object>
            </child>
            <child>
              <object class="GtkSwitch" id="switch1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
              </object>
            </child>
            <child>
              <object class="GtkSpinButton" id="spin1">
                <property name="visible">True</property>
                <property name="adjustment">adjustment1</property>
                <property name="can_focus">False</property>
                <property name="max_width_chars">2</property>
                <property name="snap_to_ticks">False</property>
                <property name="numeric">True</property>
                <property name="value">25</property>
              </object>
            </child>
            <child>
              <object class="GtkLockButton" id="lock1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
              </object>
            </child>
            <child>
              <object class="GtkScale" id="scale1">
                <property name="name">scale1</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="margin_start">10</property>
                <property name="margin_end">10</property>
                <property name="margin_top">10</property>
                <property name="margin_bottom">10</property>
                <property name="round_digits">1</property>
                <property name="adjustment">adjustment2</property>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkButton" id="okbutton">
            <property name="label" translatable="yes">Ok</property>
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="receives_default">True</property>
            <property name="margin_start">15</property>
            <property name="margin_end">15</property>
          </object>
        </child>
        <child>
          <object class="GtkButton" id="cancelbutton">
            <property name="label" translatable="yes">Cancel</property>
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="receives_default">True</property>
            <property name="margin_start">10</property>
            <property name="margin_end">10</property>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
=end ui

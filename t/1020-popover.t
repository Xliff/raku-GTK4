use v6.c;

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::CheckButton:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::DropDown:ver<4>;
use GTK::Label:ver<4>;
use GTK::MenuButton:ver<4>;
use GTK::Popover:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.popover' );

$a.Activate.tap( -> *@a {
  my $c = GTK::CssProvider.new( pod => $=pod );

  .margins = 20 given ( my $b = GTK::Box.new-hbox(10) );

  ( .halign, .valign ) = GTK_ALIGN_CENTER xx 2
    given (my $button = GTK::MenuButton.new);
  $b.append($button);

  my $popover = GTK::Popover.new;
  my $box2    = GTK::Box.new-vbox(10);

  my @labels = do for «"First item" "Second item" "Third item"» {
    my $l = GTK::Label.new($_);
    $box2.append($l);
    $l;
  }
  $popover.set-child($box2);
  $button.set-popover($popover);

  my $box3           = GTK::Box.new-vbox(10);
  my $dropdown       = GTK::DropDown.new-from-strings(<Left Right Top Bottom>);
  $dropdown.selected = 3;

  my @checks = do for <Arrow Offset> {
    GTK::CheckButton.new-with-label($_)
  }

  my $dropdown2 = GTK::DropDown.new-from-strings(«
    'No Shadow'
    'Shadow 1'
    'Shadow 2'
    'Shadow 3'
    'Shadow 4'
  »);
  $box3.append($_) for |@checks, $dropdown, $dropdown2;
  $b.append($box3);

  @checks.head.bind('active',  $popover, 'has-arrow');

  $dropdown.bind('selected', $popover, 'position');

  @checks.tail.notify('selected').tap( -> *@a {
    @checks.tail.active ?? $popover.set-offset(12, 12)
                        !! $popover.set-offset(0, 0);
  });

  $dropdown2.notify('selected').tap( -> *@a {
    my @classes = <no-shadow shadow1 shadow2 shadow3 shadow4>;
    $popover.removeCssClasses(@classes);
    $popover.add-css-class( @classes[$dropdown.selected] );
  });

  $a.window.set-child($b);
  $a.window.present;
});

$a.run;

=begin css
popover.no-shadow > contents { box-shadow: none; }
popover.shadow1 > contents { box-shadow: 6px 6px rgba(128,0,255,0.5); }
popover.shadow2 > contents {
  box-shadow: -6px -6px rgba(255,0,0,0.5), 6px 6px rgba(128,0,255,0.5);
}
popover.shadow3 > contents {
  box-shadow: -6px -6px rgba(255,0,0,0.5), 18px 18px rgba(128,0,255,0.5);
}
popover.shadow4 > contents {
  box-shadow: -18px -18px rgba(255,0,0,0.5), 18px 18px rgba(128,0,255,0.5);
}
=end css

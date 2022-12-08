use v6;

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::CenterBox:ver<4>;
use GTK::Label:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.box.center' );

$a.Activate.tap( -> *@a {
  CATCH { default { .message.say; .backtrace.concise.say; .rethrow } }
  my $box    = GTK::CenterBox.new;
  (my @widgets = (
    GTK::Label.new('Start Start Start Start Start'),
    GTK::Label.new('Center'),
    GTK::Label.new('End')
  ))».ellipsize = PANGO_ELLIPSIZE_END;
  $box.widgets = @widgets;

  $a.window.child = $box;
  $a.window.present;
});

$a.run;

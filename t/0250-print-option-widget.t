use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Application:ver<4>;
use GTK::Print::UnixDialog:ver<4>;

my $app = GTK::Application.new( title => 'org.genex.widget.printer.option' );

$app.Activate.tap( -> *@a {
  CATCH { default { .message.say; .backtrace.concise.say } }

  my $option = GTK::Print::UnixDialog.new('Test Print', $app.window);
  $option.run;
});

$app.run;

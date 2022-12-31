use v6.c;

# Ported from the GTK demo suite. Source code found here:
# https://github.com/GNOME/gtk/blob/master/demos/gtk-demo/expander.c

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Expander;
use GTK::ScrolledWindow;
use GTK::TextView;

my $a = GTK::Application.new(
  title  => 'org.genex.expander.textview',
  width  => 400,
  height => 200
);

$a.Activate.tap(-> | {
  my $e  = GTK::Expander.new('Details: ');
  my $sw = GTK::ScrolledWindow.new;
  my $tv = GTK::TextView.new;
  my $vb = GTK::Box.new-vbox;
  my $cb = GTK::Button.new_with_label('Close');

  $cb.licked.tap(-> | { $a.exit; });

  $vb.margins = 20;
  $e.margin_bottom = 20;
  $sw.set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
  ( .shadow_type, min_content_height) = (GTK_SHADOW_IN, 100) given $sw;

  ( .editable, .wrap_mode) = (GTK_WRAP_WORD, False) given $tv;
  $tv.text = qq:to/TEXT/;
Finally, the full story with all details. And all the inside information, including error codes, etc etc. Pages of information, you might have to scroll down to read it all, or even resize the window - it works !
A second paragraph will contain even more innuendo, just to make you scroll down or resize the window. Do it already !
TEXT

  $sw.add($tv);
  $e.add($sw);
  $vb.pack_end($cb, True, True);
  $vb.pack_end($e, True, True);

  $e.notify-expanded.tap(-> | { $a.window.resizable = $e.expanded });
  $a.window.add($vb);
  $a.window.destroy-signal.tap(-> | { say "Exited"; $a.exit });
  $a.present;
});

$a.run;

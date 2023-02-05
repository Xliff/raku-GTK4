use v6.c;

# Ported from the GTK demo suite. Source code found here:
# https://github.com/GNOME/gtk/blob/master/demos/gtk-demo/expander.c

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::Expander:ver<4>;
use GTK::ScrolledWindow:ver<4>;
use GTK::Text::View:ver<4>;

my $a = GTK::Application.new(
  title  => 'org.genex.expander.textview',
  width  => 400,
  height => 200
);

$a.Activate.tap(-> *@a {
  my $e  = GTK::Expander.new('Details: ');
  my $sw = GTK::ScrolledWindow.new;
  my $tv = GTK::Text::View.new;
  my $vb = GTK::Box.new-vbox;
  my $cb = GTK::Button.new_with_label('Close');

  $cb.Clicked.tap(-> *@a { $a.exit; });

  $vb.margins = 20;
  $e.margin_bottom = 20;
  $sw.set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
  # cw: .shadow-type not in GTK4
  #( .shadow_type, .min_content_height) = (GTK_SHADOW_IN, 100) given $sw;
  $sw.min-content-height = 100;

  ( .editable, .wrap_mode) = (GTK_WRAP_WORD, False) given $tv;
  $tv.text = qq:to/TEXT/;
Finally, the full story with all details. And all the inside information, {
'' }including error codes, etc etc. Pages of information, you might have to {
'' }scroll down to read it all, or even resize the window - it works !
A second paragraph will contain even more innuendo, just to make you scroll {
'' }down or resize the window. Do it already !
TEXT

  $sw.child = $tv;
  $e.child  = $sw;
  $vb.pack_end($e, True, True);
  $vb.pack_end($cb, True, True);

  # cw: Srsly?
  $e.Activate.tap(-> *@a { $a.window.resizable = $e.expanded.not });
  
  $a.window.add($vb);
  $a.window.Destroy.tap(-> *@a { say "Exited"; $a.exit });
  $a.window.present;
});

$a.run;

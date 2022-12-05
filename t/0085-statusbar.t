use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::Timeout;
use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Statusbar:ver<4>;

my $a = GTK::Application.new( title => 'org.genex.statusbar' );

$a.Activate.tap(-> *@a {
  my $b = GTK::Box.new-vbox(4);
  my $s = GTK::Statusbar.new;

  my @items = <How Now Brown Cow>;

  $b.append($s);
  $a.window.set-size-request(300, 300);
  $a.window.add($b);
  $a.window.Destroy.tap(-> *@a { $a.quit });
  $a.present;

  $s.push(1, @items.head);

  GLib::Timeout.add(2000, -> *@a {
     $s.pop(1);
     @items .= rotate(1);
     my $new-text = @items.head;
     $s.push(1, $new-text);
     G_SOURCE_CONTINUE;
  });
});

$a.run;

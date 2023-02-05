use v6.c;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::Button::Check:ver<4>;
use GTK::Stack:ver<4>;
use GTK::Stack::Sidebar:ver<4>;
use GTK::Text::View:ver<4>;

# Converted from:
# https://github.com/gotk3/gotk3-examples/blob/master/gtk-examples/stack/stack.go

my $a = GTK::Application.new(
  title  => 'org.genex.stack',
  width  => 400,
  height => 300
);

$a.Activate.tap(-> *@a {
  CATCH { default { .message.say; .backtrace.concise.say; $a.exit } }

  sub newBoxText($string) {
    my $box = GTK::Box.new-vbox;
    my $tv = GTK::Text::View.new( text => $string );
    my $b = GTK::Button.new_with_label('Submit');
    $b.Clicked.tap( -> *@a { $tv.text.say });
    $box.pack_start($tv, True, True, 0);
    $box.append($b);
    $box;
  }

  # All positionals in one place with @group
  sub newBoxRadio(*@group) {
    my $vbox = GTK::Box.new-vbox;
    my @radios = GTK::Button::Check.new-group(@group);
    my $c = 0;
    for @radios -> $r {
      # Must have closure var in loop.
      my $i = $c;
      $r.Toggled.tap(-> *@a {
        say "{ $i }: { $r.label } is active" if $r.active
      });
      $vbox.pack_start($r, False, False, 0);
      $c++;
    }
    $vbox;
  }

  # Top-level widgets
  my $stack = GTK::Stack.new;
  my $sidebar = GTK::Stack::Sidebar.new;
  my $box = GTK::Box.new-hbox;

  # Page 1
  $stack.add_titled( newBoxText('Hello there!'), 'key1', 'First Page' );

  # Page 2
  $stack.add_titled(
    newBoxRadio('choice 1', 'choice 2', 'choice 3', 'choice 42'),
    'key2',
    'Second Page'
  );

  # Page 3
  $stack.add_titled( newBoxText('third page'), 'key3', 'Third Page' );
  $stack.add_titled(
    newBoxRadio('This', 'That', 'The other thing'),
    'key3',
    'Third Page'
  );

  # Now the controls.
  $sidebar.stack = $stack;
  $box.pack_start($sidebar, True, False, 0);
  $box.pack_start($stack, True, True, 0);

  $a.window.add($box);
  $a.window.show_all;
});

$a.run;

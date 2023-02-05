use v6.c;

use GTK::Raw::Types;
use GLib::Timeout;
use GLib::Source;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button::Check:ver<4>;
use GTK::Button::Spin:ver<4>;
use GTK::Button::Toggle:ver<4>;
use GTK::Label:ver<4>;
use GTK::ScrolledWindow:ver<4>;
use GTK::Text::Mark:ver<4>;
use GTK::Text::View:ver<4>;

my $text = q:to/TEXT/;
This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with this library. If not, see <http://www.gnu.org/licenses/>.
TEXT

my (@marks, $tv, $marks-timeout, $cursor-timeout);

sub toggle-marks ($b) {
  CATCH { default { .message.say; .backtrace.consice.say } }

  unless +@marks {
    @marks.push = GTK::Text::Mark.new(g => True) xx $text.chars;
    @marks.kv.rotor(2).map({
      .tail.visible = True unless .head % 2
    });
  }

  if $b.active {
    for @marks.kv -> $i, $m {
      $tv.buffer.add-mark( $m, $tv.buffer.get-iter-at-offset($i) );
    }

    $marks-timeout = GLib::Timeout.add(16, -> *@a {
      CATCH { default { .message.say; .backtrace.consice.say } }

      my $m = @marks[ (^$text.chars).pick ];
      $m.visible = $m.visible.not;
      G_SOURCE_CONTINUE
    });
  } else {
    GLib::Source.remove($marks-timeout)if $marks-timeout;

    for @marks {
      .visible = False;
      $tv.buffer.delete-mark($_);
    }
  }
}

sub toggle-cursor ($b) {
  if $b.active {
    $cursor-timeout = GLib::Timeout.add(16, -> *@a {
      CATCH { default { .message.say; .backtrace.consice.say } }

      my  $mark   = $tv.buffer.get-insert;
      my  $iter   = $tv.buffer.get-iter-at-mark($mark);
      my ($s, $e) = $tv.buffer.get-bounds;

      $iter.equal($e) ?? $iter.assign($s)
                      !! $iter.forward-cursor-position;

      $tv.buffer.place-cursor($iter);
      G_SOURCE_CONTINUE
    });
  } else {
    GLib::Source.remove($cursor-timeout) if $cursor-timeout;
  }
}

my $a = GTK::Application.new(
  title => 'org.genex.textview.marks'
);

$a.Activate.tap( -> *@a {
  $a.window.set-default-size(600, 400);
  $a.window.Destroy.tap( -> *@a { $a.quit });

  my $box = GTK::Box.new-vbox(10);
  (my $sw  = GTK::ScrolledWindow.new).expand = True;
  $a.window.child = $box;
  $box.append($sw);

  $tv       = GTK::Text::View.new( :$text );
  $sw.child = $tv;

  my $box2 = GTK::Box.new-hbox(10);
  ( .margin-start, .margin-end ) = 10 xx 2 given $box2;

  my $the-mark = GTK::Text::Mark.new('my mark', True);
  my $box3 = GTK::Box.new-hbox(10);

  my $mark-visible = GTK::Button::Check.new-with-label('Visible');
  $mark-visible.notify('active').tap( -> *@a {
    $the-mark.visible = $mark-visible.active;
  });
  my $pos-label = GTK::Label.new('Position:');
  my $position-spin = GTK::Button::Spin.new-with-range(0, $text.chars, 1);
  $position-spin.Value-Changed.tap( -> *@a {
    $tv.buffer.move-mark(
      $the-mark,
      $tv.buffer.get-iter-at-offset( $position-spin.get-value-as-int )
    );
  });
  my $mark-check = GTK::Button::Check.new-with-label('Mark');
  $mark-check.notify('active').tap( -> *@a {
    my $iter = $tv.buffer.get-iter-at-offset( $position-spin.get-value-as-int );

    $mark-check.active ?? $tv.buffer.add-mark($the-mark, $iter)
                       !! $tv.buffer.delete-mark($the-mark);
  });

  $box3.append($_) for $mark-check, $mark-visible, $pos-label, $position-spin;

  my $box4 = GTK::Box.new-hbox(10);
  ( .margin-start, .margin-end ) = 10 xx 2 given $box4;
  $box.append($box4);

  my $toggle-button = GTK::Button::Toggle.new-with-label('Random marks');
  $toggle-button.notify('active').tap( -> *@a {
    toggle-marks($toggle-button);
  });

  my $wander-button = GTK::Button::Toggle.new-with-label('Wandering cursor');
  $wander-button.notify('active').tap( -> *@a {
    toggle-cursor($wander-button);
  });

  $box4.append($_) for $toggle-button, $wander-button;
  $box.append($_)  for $box2, $box3, $box4;

  $a.window.present
});

$a.run;

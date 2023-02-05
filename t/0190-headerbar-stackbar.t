use v6.c;

# Ported from:
# https://github.com/GNOME/gtk/blob/master/demos/gtk-demo/sidebar.c

use GTK::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::HeaderBar:ver<4>;
use GTK::Image:ver<4>;
use GTK::Label:ver<4>;
use GTK::Separator:ver<4>;
use GTK::Stack:ver<4>;
use GTK::Stack::Sidebar:ver<4>;

my @titles = (
  'Welcome to GTK+',
  'GtkStackSidebar Widget',
  'Automatic navigation',
  'Consistent appearance',
  'Scrolling',
  'Page 6',
  'Page 7',
  'Page 8',
  'Page 9'
);

my $a = GTK::Application.new(
  title  => 'org.genex.headerbar_sidebar',
  width  => 500,
  height => 350
);

$a.Activate.tap( -> *@a {
  CATCH { default { .message.say; $a.exit } }

  my ($h, $sb, $s, $b, $sp) = (
    GTK::HeaderBar.new,
    GTK::Stack::Sidebar.new,
    GTK::Stack.new,
    GTK::Box.new-hbox,
    GTK::Separator.new( :vertical )
  );

  # In the example, but not in GTK::HeaderBar
  #$h.show_title_buttons = True;
  ($h.show-title-buttons, $sb.stack) = (True, $s);
  $s.transition_type = GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN;
  $a.window.title = 'Stack Sidebar';
  $b.pack_start($sb, True, False, 0);
  $b.pack_start($sp, False, False, 0);
  $b.pack_start($s, True, True, 0);

  my $e;
  my @pages;
  for @titles.kv -> $k, $v {
    my $w;

    if !$k {
      $w = GTK::Image.new_from_icon_name('help-about');
      $w.pixel_size = 256;
    } else {
      $w = GTK::Label.new($v);
    }
    # This:
    $s.add_titled($w, $v, $v);
    # Seems to be equivalent to this:
    #$s.add_named($w, $v)
    #$s.child_set($w, 'title', $v, Nil); # May be problematic.
  }

  $a.window.add($b);
  $a.window.show_all;
});

$a.run;

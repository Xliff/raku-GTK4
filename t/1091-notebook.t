use v6.c;

use GTK::Raw::Types;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::CheckButton:ver<4>;
use GTK::CssProvider:ver<4>;
use GTK::Frame:ver<4>;
use GTK::Grid:ver<4>;
use GTK::Label:ver<4>;
use GTK::Notebook:ver<4>;


# Ported from https://developer.gnome.org/gtk-tutorial/stable/x1450.html

my $a = GTK::Application.new( title => 'org.genex.notebook' );

$a.Activate.tap( -> *@a {
  my $g = GTK::Grid.new;
  my $n = GTK::Notebook.new;
  my $bx = GTK::Box.new-hbox;

  $g.attach($n, 1, 1, 6, 1);
  $a.window.add($g);
  $n.tab_pos = GTK_POS_TOP;

  my $l;
  for (1..5) {
    my $bf = "Append Frame $_";
    my $f = GTK::Frame.new($bf);

    $l = GTK::Label.new($bf);
    $f.add($l);
    $f.set_size_request(100, 75);

    $l = GTK::Label.new("Page $_");
    $n.append_page($f, $l);
  }

  my $cb = GTK::CheckButton.new_with_label("Check me please!");
  $cb.set_size_request(100, 75);
  $l = GTK::Label.new("Add Page");
  $n.insert_page($cb, $l, 2);

  for (1..5) {
    my $bf = "Prepend Frame $_";
    my $f = GTK::Frame.new($bf);

    $l = GTK::Label.new($bf);
    $f.add($l);
    $f.set_size_request(100, 75);

    $l = GTK::Label.new("PPage $_");
    $n.prepend_page($f, $l)
  }

  # Sets current page to Page 4
  $n.page = 3;

  my $b = GTK::Button.new_with_label("close");
  $b.Clicked.tap( -> *@a { $a.exit; });
  $g.attach($b, 1, 2, 1, 1);

  $b = GTK::Button.new_with_label("next page");
  $b.Clicked.tap( -> *@a { $n.next_page; });
  $g.attach($b, 2, 2, 1, 1);

  $b = GTK::Button.new_with_label("prev page");
  $b.Clicked.tap( -> *@a { $n.prev_page; });
  $g.attach($b, 3, 2, 1, 1);

  $b = GTK::Button.new_with_label("tab position");
  $b.Clicked.tap( -> *@a {
    $n.tab_pos = $n.tab_pos == GTK_POS_BOTTOM ??
      GTK_POS_LEFT !! $n.tab_pos.succ;
  });
  $g.attach($b, 4, 2, 1, 1);

  $b = GTK::Button.new_with_label("tabs/borders on/off");
  $b.Clicked.tap( -> *@a {
     $n.show_tabs   = !$n.show_tabs;
     $n.show_border = !$n.show_border;
  });
  $g.attach($b, 5, 2, 1, 1);

  $b = GTK::Button.new_with_label("remove page");
  $b.Clicked.tap( -> *@a {
    my $p = $n.page;
    say "Removing page $p";
    $n.remove_page($p);
    $n.queue_draw;
  });
  $g.attach($b, 6, 2, 1, 1);

  # my $css = GTK::CssProvider.new( pod => $=pod );
  $a.window.present;
});

$a.run;

=begin css
GtkWindow, GtkFrame { border-width:10px; }
=end css

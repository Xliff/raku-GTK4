use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::ListBox;
use GTK::Revealer;
use GTK::Separator;
use GTK::ScrolledWindow;

sub remove-this-row ($child) {
  # cw: Needs more scruitiny!

  my $row = $child.parent;

  my $revealer = GTK::Revealer.new;
  $revealer.set-reveal-child(True);

  say "RtR-P: { $row.^name }";
  $row.remove( $child.ref );

  $revealer.child = $child;
  $child.unref;
  $row.append($revealer);

  $revealer.notify('child-revealed').tap( -> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }

    my $row = @a.head.parent;
    $row.parent.remove($row);
  });
  $revealer.set-reveal-child(False);
}

sub create-row ($l) { ... }

sub add-row-below ($child) {
  my $row      = $child.parent;
  my $index    = $row.index;
  my $list     = $row.parent;
  my $row2     = create-row("Extra row");
  my $revealer = GTK::Revealer.new;

  $revealer.notify('chiled-revealed').tap( -> *@a {
    my ($row, $child) = ( .parent, .child ) given $revealer;

    $child.ref;
    $revealer.unsetChild;
    $revealer.unparent;
    $row.append($child);
    $child.unref;
  });

  $list.insert($revealer, $index);
  $revealer.reveal-child = True;
}

sub create-row ($l) {
  my $row    = GTK::Box.new-hbox(10);
  my $label  = GTK::Label.new($l);
  my $button = GTK::Button.new_with_label('x');

  ( .hexpand, .halign, .valign ) = (True, GTK_ALIGN_END, GTK_ALIGN_CENTER)
    given $button;

  $button.Clicked.tap( -> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }

    say "R: { $row } / { $l }";

    remove-this-row($row)
  });

  my $button2 = GTK::Button.new_with_label('+');
  $button2.valign = GTK_ALIGN_CENTER;
  $button2.Clicked.tap( -> *@a { add-row-below($row) });

  $row.append($_) for $label, $button, $button2;

  $row;
}

sub MAIN {
  my $a = GTK::Application.new(
    title  => 'org.genex.listbox',
    width  => 300,
    height => 300
  );

  $a.Activate.tap( -> | {
    my $list = GTK::ListBox.new;
    $list.selection-mode = GTK_SELECTION_NONE;
    $list.set-header-func( -> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }

      if @a.head {
        GTK::ListBox::Row.new( @a.head ).set-header( GTK::Separator.new( :h ) )
          if @a[1]
      }
    });

    $a.window.child = (my $sw = GTK::ScrolledWindow.new);
    $sw.child       = $list;

    for ^20 {
      my $r = create-row("Row { .succ }");
      say "R: { $r }";
      $list.insert($r, -1)
    }

    $a.window.Destroy.tap( -> | { $a.quit });
    $a.window.present;
  });

  $a.run;
}

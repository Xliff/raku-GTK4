use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::MainContext;
use GTK::Box:ver<4>;
use GTK::Button::Check:ver<4>;
use GTK::Button::Spin:ver<4>;
use GTK::Cell::Renderer::Pixbuf:ver<4>;
use GTK::Cell::Renderer::Text:ver<4>;
use GTK::Cell::Renderer::Toggle:ver<4>;
use GTK::ComboBox::Text:ver<4>;
use GTK::Frame:ver<4>;
use GTK::Icon::View:ver<4>;
use GTK::Label:ver<4>;
use GTK::List::Store:ver<4>;
use GTK::Main:ver<4>;
use GTK::Window:ver<4>;

my $done = 0;

enum SimpleColumns <
  SIMPLE_COLUMN_NAME
  SIMPLE_COLUMN_ICON
  SIMPLE_COLUMN_DESCRIPTION
>;

enum FocusColumns <
  FOCUS_COLUMN_NAME
  FOCUS_COLUMN_CHECK
  FOCUS_COLUMN_STATIC_TEXT
>;

sub simple-list-model {
  my $store = GTK::List::Store.new(G_TYPE_STRING xx 3);
  my $i     = GtkTreeIter.new;

  $store.set(
    append => $i,
    :values,
		[
      'Alice in wonderland',
		  'system-run',
  		[~](
        'Twas brillig, and the slithy toves ',
        'did gyre and gimble in the wabe; ',
        'all mimsy were the borogoves, ',
        'and the mome raths outgrabe'
      )
    ]
    # )
  );

  $store.set(
    append => $i,
    :values,
    [
      'Marry Poppins',
      'dialog-information',
      'Supercalifragilisticexpialidocious',
    ]
  );

  $store.set(
    append => $i,
    :values,
    [
      'George Bush',
      'dialog-warning',
      [~](
        "It's a very good question, very direct, ",
        "and I'm not going to answer it"
      )
    ]
  );

  $store.set(
    append => $i,
    :values,
    [
      'Whinnie the pooh',
      'process-stop',
       [~](
        'The most wonderful thing about tiggers, ',
        'is tiggers are wonderful things'
      )
    ]
  );

  $store.set(
    append => $i,
    :values,
    [
      'Aleister Crowley',
      'help-about',
      'Thou shalt do what thou wilt shall be the whole of the law',
    ]
  );
;
  $store.set(
    append => $i,
    :values,
    [
      'Mark Twain',
      'application-exit',
      [~](
        'Giving up smoking is the easiest thing in the world. ',
        "I know because I've done it thousands of times."
  		)
    ]
  );

  $store;
}

my @cells;
sub simple-icon-view {
  my $iv    = GTK::Icon::View.new(
    model            => simple-list-model,
    item-orientation => GTK_ORIENTATION_HORIZONTAL
  );

  my $a = $iv.get_area;

  @cells.push: GTK::Cell::Renderer::Text.new;
  $a.push: @cells.tail;
  $a.attribute-connect(@cells.tail, 'text', SIMPLE_COLUMN_NAME);

  @cells.push: GTK::Cell::Renderer::Pixbuf.new( xalign => 0 );
  $a.push: @cells.tail, :expand;
  $a.attribute-connect(@cells.tail, 'icon-name', SIMPLE_COLUMN_ICON);

  @cells.push: GTK::Cell::Renderer::Text.new(
    wrap-mode  => PANGO_WRAP_WORD,
    wrap-width => 215
  );
  $a.push: @cells.tail, :align;
  $a.attribute-connect(@cells.tail, 'text', SIMPLE_COLUMN_DESCRIPTION);

  $iv
}

sub simple-cell-area {
  my $h  = GTK::Box.new-hbox(4);
  my $iv = simple-icon-view;
  my $v  = GTK::Box.new-vbox(4);

  my $w  = GTK::Window.new(
    title  => 'CellArea expand and alignments',
    child  => $h,
    width  => 640,
    height => 480,
  );

  my $f  = GTK::Frame.new(
    hexpand => True,
    child   => $iv,
    valign  => GTK_ALIGN_CENTER,
    halign  => GTK_ALIGN_FILL
  );
  $f.child = $iv;

  $h.append($_) for $v, $f;

  my $cbt = GTK::ComboBox::Text.new( |<Horizontal Vertical>, active => 0 );
  $cbt.Changed.tap: SUB { $iv.item-orientation = $cbt.active }

  my $cb1 = GTK::Button::Check.new-with-label('Align 2nd Cell', active => False);
  $cb1.Toggled.tap: SUB {
    $iv.area.cell-set-property( @cells[1], 'align', $cb1.active )
  }

  my $cb2 = GTK::Button::Check.new-with-label('Align 3rd Cell', active => True);
  $cb2.Toggled.tap: SUB {
    $iv.area.cell-set-property( @cells[2], 'align', $cb2.active )
  }

  my $cb3 = GTK::Button::Check.new-with-label(
    'Expand 1st Cell',
    active => False
  );
  $cb3.Toggled.tap: SUB {
    $iv.area.cell-set-property( @cells.head, 'expand', $cb3.active );
  }

  my $cb4 = GTK::Button::Check.new-with-label(
    'Expand 2nd Cell',
    active => False
  );
  $cb4.Toggled.tap: SUB {
    $iv.area.cell-set-property( @cells[1], 'expand', $cb4.active );
  }

  my $cb5 = GTK::Button::Check.new-with-label(
    'Expand 2nd Cell',
    active => False
  );
  $cb5.Toggled.tap: SUB {
    $iv.area.cell-set-property( @cells.tail, 'expand', $cb5.active );
  }

  $v.append($_) for $cbt, $cb1, $cb2, $cb3, $cb4, $cb5;

  $done++;
  $w.Destroy.tap: SUB { $done-- }
  $w.present;
}

sub focus-list-model {
  my $store = GTK::List::Store.new(
    G_TYPE_STRING,
    G_TYPE_BOOLEAN,
    G_TYPE_STRING
  );

  $store.set(
    :append, :values,
    [
      'Enter a string',
  		True,
  		'Does it fly ?',
    ]
  );

  $store.set(
    :append, :values,
    [
  		'Enter a string',
  		False,
  		'Would you put it in a toaster ?'
    ]
  );

  $store.set(
    :append, :values,
    [
  		'Type something',
  		False,
  		'Does it feed on cute kittens ?'
    ]
  );

  $store;
}

multi sub focus-iconview ($c = True) {
  my $iv = GTK::Icon::View.new(
    model            => (my $m = focus-list-model),
    item-orientation => GTK_ORIENTATION_HORIZONTAL
  );

  my $a  = $iv.area;
  my $r1 = GTK::Cell::Renderer::Text.new( editable => True );
  $a.push: $r1, :expand;
  $a.attribute-connect($r1, 'text', 0);
  $r1.cell-background = 'red' if $c;

  $r1.Edited.tap: SUB {
    my ($p, $nt) = @*A[1, 2];
    my  $ls      = GTK::List::Store.new( $iv.model( :raw ) );

    say "Cell edited with new text '{ $nt }'";

    return unless ( my $i = $m.get-iter-from-string($p) );

    $m.set-value($i, FOCUS_COLUMN_NAME, $nt);
  }

  my $r2 = GTK::Cell::Renderer::Toggle.new( xalign => 0 );
  $a.push: $r2, :align;
  $a.attribute-connect($r2, 'active', FOCUS_COLUMN_CHECK);
  $r2.cell-background = 'green' if $c;
  $r2.Toggled.tap: SUB {
    my $i = $m.get-iter-from-string( $*A[1] );
    return unless $i;

    my $v0 = $m.get-value($i, 0);

    my $v1 = $m.get($i, 1);
    say "Cell toggled ({ $v1 })!";

    $m.set-value(
      :!double,
      $i,
      FOCUS_COLUMN_CHECK,
      $v1.not
    );
  }

  my $r3 = GTK::Cell::Renderer::Text.new(
    wrap-mode  => PANGO_WRAP_WORD,
    wrap-width => 150
  );
  $r3.cell-background = 'blue' if $c;
  $a.push: $r3, :align;
  $a.attribute-connect($r3, 'text', FOCUS_COLUMN_STATIC_TEXT);
  $a.add-focus-sibling($r2, $r3);

  ($iv, $r2, $r3);
}

sub focus-cell-area {
  my $h = GTK::Box.new-hbox(4);
  my $w = GTK::Window.new( title => 'Focus and editable cells', child => $h );
  my $v = GTK::Box.new-vbox(4);

  my ($iv, $f, $s) = focus-iconview(False);

  my $fr = GTK::Frame.new(
    hexpand => True,
    valign  => GTK_ALIGN_CENTER,
    halign  => GTK_ALIGN_FILL,
    child   => $iv
  );

  $h.append($_) for $v, $fr;

  my $cbt = GTK::ComboBox::Text.new( |<Horizontal Vertical>, active => 0 );
  $cbt.Changed.tap: SUB { $iv.item-orientation = $cbt.active }

  my $cb = GTK::Button::Check.new-with-label('Focus Sibling', active => True);
  $cb.Toggled.tap: SUB {
    $cb.active
      ?? .add-focus-sibling($f, $s)
      !! .remove-focus-sibling($f, $s)
    given $iv.area;

    $iv.queue-draw;
  }
  $v.append($_) for $cbt, $cb;

  $done++;
  $w.Destroy.tap: SUB { $done-- }
  $w.present;
}

sub background-area {
  my ($mv, $v) = GTK::Box.new-vbox(4) xx 2;
  my  $h       = GTK::Box.new-hbox(4);
  my  $w       = GTK::Window.new( title => 'Background Area', child => $mv );
  my  $iv      = focus-iconview.head;
  my  $l       = GTK::Label.new( q:to/LABEL/.subst("\n", ' ', :g) );
    In this example, row spacing gets divided into the background area,
		column spacing is added between each background area, item_padding is
		prepended space distributed to the background area.
    LABEL

  $l.setAttributes( wrap => True, width-chars => 40 );

  my $f  = GTK::Frame.new(
    hexpand => True,
    align   => (GTK_ALIGN_FILL, GTK_ALIGN_CENTER),
    child   => $iv
  );
  $h.append($_) for $v, $f;
  $mv.append($h);

  my $cbt = GTK::ComboBox::Text.new( |<Horizontal Vertical>, active => 0 );
  $cbt.Changed.tap: SUB { $iv.item-orientation = $cbt.active }

  my $sb = GTK::Button::Spin.new-with-range( ^10 );
  my $l2 = GTK::Label.new('Cell Spacing', hexpand => True);
  my $h2 = GTK::Box.new-hbox(4);
  $h2.append($_) for $l2, $sb;
  $sb.Value-Changed.tap: SUB {
    $iv.area.spacing = $sb.value;
    $iv.queue-draw;
  }

  my $sb2 = GTK::Button::Spin.new-with-range( ^10 );
  my $l3  = GTK::Label.new('Row Spacing', hexpand => True);
  my $h3  = GTK::Box.new-hbox(4);
  $h3.append($_) for $l3, $sb2;
  $sb.Value-Changed.tap: SUB {
    $iv.row-spacing = $sb2.value;
    $iv.queue-draw;
  }

  my $sb3 = GTK::Button::Spin.new-with-range( ^30 );
  my $l4  = GTK::Label.new('Item Padding', hexpand => True);
  my $h4  = GTK::Box.new-hbox(4);
  $h4.append($_) for $l4, $sb3;
  $sb3.value = $iv.item-padding;
  $sb3.Value-Changed.tap: SUB { $iv.item-padding = $sb3.value }

  $v.append($_) for $cbt, $h2, $h3, $h4;

  $done++;
  $w.Destroy.tap: SUB { $done-- }
  $w.present;
}

sub MAIN {
  GTK::Main.init;

  simple-cell-area;
  focus-cell-area;
  background-area;

  repeat { GLib::MainContext.iteration } while $done;
}

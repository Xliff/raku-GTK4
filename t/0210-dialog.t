use v6.c;

use GTK::Raw::Types;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::Button:ver<4>;
use GTK::Dialog:ver<4>;
use GTK::Dialog::Message:ver<4>;
use GTK::Frame:ver<4>;
use GTK::Entry:ver<4>;
use GTK::Grid:ver<4>;
use GTK::Image:ver<4>;
use GTK::Label:ver<4>;
use GTK::Separator:ver<4>;

my ($*entry1, $*entry2, $*md);

my $a = GTK::Application.new(
  title => 'org.genex.dialog'
);

sub message_dialog_clicked {
  state $mdo = 1;

  my $md = GTK::Dialog::Message.new(
    $a.window,
    GTK_DIALOG_MODAL +| GTK_DIALOG_DESTROY_WITH_PARENT,
    GTK_MESSAGE_INFO,
    GTK_BUTTONS_OK_CANCEL,
    'This message box has been used:'
  );

  $md.Response.tap( -> *@a { $md.hide });

  $md.format_secondary_text("{ $mdo++ } times");
  $md.show;
}

sub interactive_dialog_clicked {
  # Will need GTK::Dialog.new_with_buttons
  my $d1 = GTK::Dialog.new_with_buttons(
    $a.window,
    'Interactive Dialog',
    GTK_DIALOG_MODAL +| GTK_DIALOG_DESTROY_WITH_PARENT,
    '_OK',     GTK_RESPONSE_OK,
    '_Cancel', GTK_RESPONSE_CANCEL
  );

  my $ca = $d1.get_content_area;
  my $hbox = GTK::Box.new-hbox;
  $ca.pack_start($hbox);

  my $i = GTK::Image.new_from_icon_name('dialog-question');
  my $g = GTK::Grid.new;
  ($g.row_spacing, $g.column_spacing) = (4 xx 2);
  $hbox.pack_start($i);
  $hbox.pack_start($g);

  my $l1 = GTK::Label.new_with_mnemonic('_Entry1');
  $g.attach($l1, 0, 0, 1, 1);

  my $e1 = GTK::Entry.new;
  $e1.text = $*entry1.text;
  $g.attach($e1, 1, 0, 1, 1);
  $l1.mnemonic_widget = $e1;

  my $l2 = GTK::Label.new_with_mnemonic('E_ntry2');
  $g.attach($l2, 0, 1, 1, 1);

  my $e2 = GTK::Entry.new;
  $e2.text = $*entry2.text;
  $g.attach($e2, 1, 1, 1, 1);
  $l2.mnemonic_widget = $e2;

  $d1.Response.tap( -> *@a {
    if @a[1] == GTK_RESPONSE_OK.Int {
      $*entry1.text = $e1.text;
      $*entry2.text = $e2.text;
    }
    $d1.hide;
  });
  $d1.run;
}

$a.Activate.tap( -> *@a {
  my $f = GTK::Frame.new('Dialogs');
  $f.margins = 8;

  $a.window.title = 'Dialogs and Message Boxes';
  $a.window.set-child($f);

  my $vbox = GTK::Box.new-vbox(8);
  $vbox.margins = 8;
  $f.add($vbox);
  my $hbox = GTK::Box.new-hbox(8);
  $vbox.pack_start($hbox);
  my $button1 = GTK::Button.new_with_mnemonic('_Message Dialog');
  $button1.Clicked.tap( -> *@a { message_dialog_clicked() });
  $hbox.pack_start($button1);
  # Works because reference is kept by GTK::Box
  $vbox.pack_start( GTK::Separator.new-h-separator );

  my $hbox2 = GTK::Box.new-hbox(8);
  $vbox.pack_start($hbox2);
  my $vbox2 = GTK::Box.new-vbox(0);

  my $button2 = GTK::Button.new_with_mnemonic('_Interactive Dialog');
  $button2.Clicked.tap( -> *@a { interactive_dialog_clicked() });
  $hbox2.pack_start($vbox2);
  $vbox2.pack_start($button2);

  my $grid = GTK::Grid.new;
  ($grid.row_spacing, $grid.column_spacing) = (4 xx 2);
  $hbox2.pack_start($grid);

  my $label1 = GTK::Label.new_with_mnemonic('_Entry 1');
  $grid.attach($label1, 0, 0, 1, 1);

  $*entry1 = GTK::Entry.new;
  $grid.attach($*entry1, 1, 0, 1, 1);
  $label1.mnemonic_widget = $*entry1;

  my $label2 = GTK::Label.new_with_mnemonic('E_ntry 2');
  $grid.attach($label2, 0, 1, 1, 1);

  $*entry2 = GTK::Entry.new;
  $grid.attach($*entry2, 1, 1, 1, 1);

  $a.window.present;
});

$a.run;

use v6.c;

use GTK::Raw::Types:ver<4>;

use GLib::MainContext;
use GLib::Timeout;
use GTK::Box:ver<4>;
use GTK::Cell::Renderer::Pixbuf:ver<4>;
use GTK::Cell::Renderer::Text:ver<4>;
use GTK::Cell::View:ver<4>;
use GTK::ComboBox:ver<4>;
use GTK::ComboBox::Text:ver<4>;
use GTK::Frame:ver<4>;
use GTK::List::Store:ver<4>;
use GTK::Main:ver<4>;
use GTK::Tree::Iter:ver<4>;
use GTK::Tree::Path:ver<4>;
use GTK::Tree::Store:ver<4>;
use GTK::Window:ver<4>;

use GLib::Roles::Object;

sub create-tree-blaat {
  my $ts = GTK::Tree::Store.new(Str, Str, Bool);
  my $i  = GtkTreeIter.new;

  $*ERR.say: "{ &?ROUTINE.name.uc } start";
  $ts.set( a => $i, [ 'dialog-warning', 'dialog-warning', False ], :v, :!d );
  $ts.set( a => $i, [ 'process-stop',   'process-stop',   False ], :v, :!d );
  $ts.set( a => $i, [ 'document-new',   'document-new',   False ], :v, :!d );
  $ts.set( a => $i, [ 'edit-clear',     'edit-clear',     False ], :v, :!d );
  $ts.set( a => $i, [ '',               'separator',      False ], :v, :!d );
  $ts.set( a => $i, [ 'document-open',  'document-open',  False ], :v, :!d );
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ts;
}

sub create-empty-list-blaat {
  my $ls = GTK::List::Store.new(Str, Str);

  $*ERR.say: "{ &?ROUTINE.name.uc } start";
  $ls.set( :append, 'dialog-warning' xx 2, :v);
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ls;
}

sub populate-list-blaat ($cb) {
  my $ls = GTK::List::Store.new( $cb.model( :raw ) );
  my $i  = $ls.first.next;

  $*ERR.say: "{ &?ROUTINE.name.uc } start ";
  $ls.set( append => $i, [ 'process-stop',   'process-stop', ], :v, :!double );
  $ls.set( append => $i, [ 'document-new',   'document-new', ], :v, :!double );
  $ls.set( append => $i, [ 'edit-clear',     'edit-clear',   ], :v, :!double );
  $ls.set( append => $i, [ '',               'separator',    ], :v, :!double );
  $ls.set( append => $i, [ 'document-open',  'document-open' ], :v, :!double );
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ls;
}

sub create-list-blaat {
  my $ls = GTK::List::Store.new(Str, Str, Bool);
  my $i  = GtkTreeIter.new;

  $*ERR.say: "{ &?ROUTINE.name.uc } start";
  $ls.set( append => $i, [ 'dialog-warning', 'dialog-warning', False ], :v, :!double );
  $ls.set( append => $i, [ 'process-stop',   'process-stop',   False ], :v, :!double );
  $ls.set( append => $i, [ 'document-new',   'document-new',   False ], :v, :!double );
  $ls.set( append => $i, [ 'edit-clear',     'edit-clear',     False ], :v, :!double );
  $ls.set( append => $i, [ '',              'separator',      False ], :v, :!double );
  $ls.set( append => $i, [ 'document-open',  'document-open',  False ], :v, :!double );
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ls;
}

sub create-list-long {
  my $ls = GTK::List::Store.new([Str]);
  my $i  = GtkTreeIter.new;

  $*ERR.say: "{ &?ROUTINE.name.uc } start";
  $ls.set(
    append => $i, :values,
    [ q<here is some long long text that grows out of the combo's allocation> ]
  );

  $ls.set( a => $i, :v, [ 'with at least a few of these rows' ]);
  $ls.set( a => $i, :v, [ 'so that we can get some ellipsized text here' ]);

  $ls.set(
    append => $i, :values,
    [ 'and see the combo box menu being allocated without any constraints' ]
  );
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ls
}

sub create-food-list {
  my $ls = GTK::List::Store.new(Str, Str);
  my $i  = GtkTreeIter.new;

  $*ERR.say: "{ &?ROUTINE.name.uc } start";
  $ls.set( append => $i, <Pepperoni Pizza>     , :v);
  $ls.set( append => $i, <Cheese Burger>       , :v);
  $ls.set( append => $i, <Pineapple Milkshake> , :v);
  $ls.set( append => $i, <Orange Soda>         , :v);
  $ls.set( append => $i, <Club Sandwich>       , :v);
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ls
}

sub create_phylogenetic_tree {
  my $ts = GTK::Tree::Store.new([Str]);

  my ($i1, $i2);

  $*ERR.say: "{ &?ROUTINE.name.uc } start";
  $i1 = $ts.set( :append,                [ 'Eubacteria'  ], :v);
  $i2 = $ts.set( :append, parent => $i1, [ 'Aquifecales' ], :v);

  $ts.set( append => $i2, parent => $i1, [ 'Thermotogales'                   ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Thermus-Deinococcus group'       ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Chloroflecales'                  ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Cyanobacteria'                   ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Firmicutes'                      ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Leptospirillium Group'           ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Chlorobium-Flavobacteria group'  ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Chlamydia-Verrucomicrobia group' ], :v);

  my $i3 = $ts.set( append => True, parent => $i2, [ 'Verrucomicrobia' ], :v);

  $ts.set( append => $i3, parent => $i2, [ 'Chlamydia'       ], :v);

  $ts.set( append => $i2, parent => $i1, [ 'Flexistipes'       ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Fibrobacter group' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'spirocheteus'      ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Proteobacteria'    ], :v);

  $ts.set( append => $i3, parent => $i2, [ 'alpha'   ], :v);
  $ts.set( append => $i3, parent => $i2, [ 'beta'    ], :v);
  $ts.set( append => $i3, parent => $i2, [ 'delta'   ], :v);
  $ts.set( append => $i3, parent => $i2, [ 'epsilon' ], :v);
  $ts.set( append => $i3, parent => $i2, [ 'gamma'   ], :v);

  $ts.set( append => $i1, [ 'Eukaryotes' ], :v);

  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Bilateria        Myxozoa         Cnidari             Ctenophora
    Placozoa         Porifera        choanoflagellates   Fungi
    Aleveolates      Stramenopiles   Rhodophyta
    Viridaeplantae   Microsporidia
  >;

  $ts.set( append => $i2, parent => $i1, [ 'crytomonads et al' ], :v);

  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Archaea   Korarchaeota   Crenarchaeota   Buryarchaeota
  >;
  $*ERR.say: "{ &?ROUTINE.name.uc } end";

  $ts;
}

sub create-capital-tree {
  my $ts = GTK::Tree::Store.new([Str]);

  my ($i1, $i2) = GtkTreeIter.new xx 2;

  $ts.set( append => $i1, [ 'A - B' ], :v);
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Albany    Annapolis   Atlanta   Augusta    Austin
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Baton Rogue' ], :v);

  # cw: -XXX- Why is there already a blank entry?
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Bismarck  Boise  Boston
  >;

  $ts.set( append => $i1, [ 'C - D' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Carson City' ], :v);
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Charleston   Cheyenne   Columbia   Columbus   Concord   Denver
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Des Moines' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Dover' ], :v);

  $ts.set( append => $i1, [ 'E - J' ], :v);
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Frankfort   Harrisburg     Hartford   Helena
    Honolulu    Indianapolis   Jackson
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Jefferson City' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Juneau' ], :v);

  $ts.set( append => $i1, [ 'K - O' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Lansing' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Lincoln' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Little Rock' ], :v);
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Madison   Montgomery   Montpelier   Nashville
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Oklahoma City' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Olympia' ], :v);

  $ts.set( append => $i1, [ 'P - S' ], :v);
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Pierre     Providence   Raleigh
    Richmond   Sacamento   Salem
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Salt Lake City' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Santa Fe' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'Springfield' ], :v);
  $ts.set( append => $i2, parent => $i1, [ 'St. Paul' ], :v);

  $ts.set( append => $i1, [ 'T - Z' ], :v);
  $ts.set( append => $i2, parent => $i1, [ $_ ], :v) for <
    Tallahassee  Topeka  Trenton
  >;

  $ts;
}

sub capital-animation ($m) {
  CATCH { default { .message.say; .backtrace.concise.say } }

  constant GTP = GTK::Tree::Path;

  state $c = 0;

  say "C: { $c }";

  given $c % 8 {
    when 0 { $m.set( :insert, [ 'Europe' ], :v ) }
    when 1 { $m.set( i => $m.get-iter( GTP.new-from-indices(0) ), 0, [ 'Berlin' ], :v ) }
    when 2 { $m.set( i => $m.get-iter( GTP.new-from-indices(0) ), 1, [ 'London' ], :v ) }
    when 3 { $m.set( i => $m.get-iter( GTP.new-from-indices(0) ), 2, [ 'Paris'  ], :v ) }
    # when 4 { $m.remove( $m.get-iter( GTP.new-from-indices(0, 2) ) ) }
    # when 5 { $m.remove( $m.get-iter( GTP.new-from-indices(0, 1) ) ) }
    # when 6 { $m.remove( $m.get-iter( GTP.new-from-indices(0, 0) ) ) }
    # when 7 { $m.remove( $m.get-iter( GTP.new-from-indices(0)    ) ) }
  }

  $c++;
  G_SOURCE_CONTINUE;
}

sub setup-combo-box-entry ($cb) {
  $cb.append-text($_) for «
    'dum de dum'
    'la la la'
    'la la la dum de dum la la la la la la boom de da la la'
  »;

  my @at = <bloop bleep klaas>;
  @at.append: |( 'klass' «~« (0..9, 'a'..'f', 10..12) ).flat;

  $cb.append-text($_) for @at;
}

sub MAIN {
  GTK::Main.init;

  GTK::Widget.set-default-direction( :rtl ) if %*ENV<RTL>;

  my ($b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $b10, $b11, $b12) =
    GTK::Box.new-vbox(0) xx 12;

  my $done  = False;
  my $mb    = GTK::Box.new-vbox(2);
  my $w     = GTK::Window.new( child => $mb );
  my $f1    = GTK::Frame.new('GtkCellView', child => $b1);
  my $cv    = GTK::Cell::View.new;
  my $crp1  = GTK::Cell::Renderer::Pixbuf.new( icon-name => 'dialog-warning' );
  my $crt   = GTK::Cell::Renderer::Text.new( text => 'la la la' );
  my $f2    = GTK::Frame.new('GtkComboBox (list)', child => $b2);
  my $cb1   = GTK::ComboBox.new-with-model( create-list-blaat );
  my $crp2  = GTK::Cell::Renderer::Pixbuf.new;
  my $crt2  = GTK::Cell::Renderer::Text.new;
  my $f3    = GTK::Frame.new('GtkComboBox (dynamic list)', child => $b3);
  my $cb2   = GTK::ComboBox.new-with-model( create-empty-list-blaat );
  my $crp3  = GTK::Cell::Renderer::Pixbuf.new;
  my $crt3  = GTK::Cell::Renderer::Text.new;
  my $f4    = GTK::Frame.new('GtkComboBox (custom)', child => $b4);
  my $m1    = create-list-blaat;
  my $crp4  = GTK::Cell::Renderer::Pixbuf.new;
  my $crt4  = GTK::Cell::Renderer::Text.new;
  my $cv2   = GTK::Cell::View.new( model => $m1 );
  my $crt4b = GTK::Cell::Renderer::Text.new;
  my $cb3   = GTK::ComboBox.new-with-model($m1, child => $cv2);
  my $f5    = GTK::Frame.new('GtkComboBox (tree)', child => $b5);
  my $cb4   = GTK::ComboBox.new-with-model( create-tree-blaat );
  my $crp5  = GTK::Cell::Renderer::Pixbuf.new;
  my $crt5  = GTK::Cell::Renderer::Text.new;
  my $f6    = GTK::Frame.new('GtkComboBox (grid)', child => $b6);
  my $f7    = GTK::Frame.new('GtkComboBox with Entry', child => $b7);
  my $cb5   = GTK::ComboBox::Text.new-with-entry();
  my $f8    = GTK::Frame.new('What are you?', child => $b8);
  my $cb6   = GTK::ComboBox.new-with-model( create_phylogenetic_tree );
  my $crt6  = GTK::Cell::Renderer::Text.new;
  my $f9    = GTK::Frame.new('Where are you?', child => $b9);
  my $m2    = create-capital-tree;
  my $cb7   = GTK::ComboBox.new-with-model($m2.model);
  my $crt7  = GTK::Cell::Renderer::Text.new;
  my $f10   = GTK::Frame.new('Hungry?');
  my $cb8   = GTK::ComboBox.new-with-model( create-food-list, active => 0 );
  my $crt8  = GTK::Cell::Renderer::Text.new;
  my $crt9  = GTK::Cell::Renderer::Text.new;
  my $f11   = GTK::Frame.new('Unconstrained Menu');
  my $cb9   = GTK::ComboBox.new-with-model(
    create-list-long,
    active            => 0,
    popup-fixed-width => False
  );
  my $crt10 = GTK::Cell::Renderer::Text.new( ellipsize => PANGO_ELLIPSIZE_END );
  my $cb10  = GTK::ComboBox::Text.new( active => 53 );
  my $f12   = GTK::Frame.new('Looong', child => $cb10 );

  sub set-sensitive ($cl, $c, $tm, $i) {
    $c.sensitive = $tm.get_path($i).get-indices.head.not
  }

  sub is-sensitive ($m, $i) {
    $m.model.get-path($i).indices.head == 4;
  }

  sub displayed-row-changed ($cb, $c) {
    $c.set-displayed-row( GTK::Tree::Path.new-from-indices($cb.active) );
  }

  sub setup-combo-and-cells ($cb, $crp, $crt) {
    $cb.push: $_ for $crp, $crt;

    $cb.set-attributes($crp, 'icon-name', 0);
    # $cb.set-cell-data-func(
    #   $crp,
    #   SUB { set-sensitive( |@*A ) }
    # );
    $cb.active = 0;
    $cb.set-attributes($crt, 'text', 1);
    # $cb.set-cell-data-func(
    #   $crt,
    #   SUB { set-sensitive( |@*A ) }
    # );
    # $cb.set-row-separator-func(
    #   SUB { is-sensitive( |@*A[^2] ) }
    # );
  }

  $cv.push: $_ for $crp1, $crt;

  setup-combo-and-cells($cb1, $crp2, $crt2);
  setup-combo-and-cells($cb2, $crp3, $crt3);
  setup-combo-and-cells($cb3, $crp4, $crt4); # cw: Check to ensure this one is valid
  setup-combo-and-cells($cb4, $crp5, $crt5);

  $cb2.notify('popup-shown').tap: SUB {
    CATCH { default { .message.say; .backtrace.concise.say } }
    populate-list-blaat($cb2);
  }

  $cv2.push: $crt5, :expand;
  $cv2.set-attributes($crt5, 'text', 1);
  $cb1.&displayed-row-changed($cv2);
  $cb3.Changed.tap: SUB { displayed-row-changed($cb1, $cv2) }

  $cb5.&setup-combo-box-entry;

  $cb6.active = 0;
  $cb6.push: $crt6;
  $cb6.set-attributes($crt6, 'text', 0);

  $cb7.push: $crt8;
  $cb7.set-attributes($crt8, 'text', 0);
  # $cb7.set-cell-data-func(
  #   $crt8,
  #   SUB {
  #     my ($cl, $c, $tm, $i) = @*A;
  #
  #     $c.sensitive = $tm.iter.has-child($i).not
  #   }
  # );
  $cb7.set-active-iter(
    $m2.model.get-iter( GTK::Tree::Path.new-from-indices(0, 8) )
  );
  GLib::Timeout.add( 1000, SUB { capital-animation($m2) } );

  my $a = $cb8.area;
  $a.add-with-properties($crt8, :align, :expand);
  $a.set-attributes($crt8, 'text', 0);
  $a.add-with-properties($crt9, :align, :expand);
  $a.set-attributes($crt9, 'text', 1);

  $cb9.push: $crt10, :expand;
  $cb9.set-attributes($crt10, 'text', 0);

  $cb10.append-text("Item { $_ }") for ^200;

  $mb. append: $_
    for $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $f10, $f11, $f12;

  .head.append: .tail for (
    $b1,  $cv,    $b2,  $cb1,   $b3,  $cb2,    $b4, $cb3,
    $b5,  $cb4,   $b7,  $cb5,   $b8,  $cb6,    $b9, $cb7,
    $b10, $cb8,   $b11, $cb9,   $b12, $cb10
  ).rotor(2);

  $w.Destroy.tap: SUB {  GLib::MainContext.wakeup; $done = True }
  $w.present;

  GLib::MainContext.iteration while $done.not;
}

use v6.c;

use GLib::MainContext;
use GTK::Box:ver<4>;
use GTK::Cell::Renderer::Pixbuf:ver<4>;
use GTK::Cell::Renderer::Text:ver<4>;
use GTK::Cell::View:ver<4>;
use GTK::ComboBox:ver<4>;
use GTK::Frame:ver<4>;
use GTK::List::Store:ver<4>;
use GTK::Tree::Iter:ver<4>;
use GTK::Tree::Path:ver<4>;
use GTK::Tree::Store:ver<4>;
use GTK::Window:ver<4>;

sub create-tree-blaat {
  my $ts = GTK::Tree::Store.new(Str, Str, Bool);

  $ts.set( :append, ['dialog-warning', 'dialog-warning', False ], :!double);
  $ts.set( :append, ['process-stop',   'process-stop',   False ], :!double);
  $ts.set( :append, ['document-new',   'document-new',   False ], :!double);
  $ts.set( :append, ['edit-clear',     'edit-clear',     False ], :!double);
  $ts.set( :append, [Str,              'separator',      False ], :!double);
  $ts.set( :append, ['document-open',  'document-open',  False ], :!double);

  $ts;
}

sub create-empty-list-blaat {
  my $ls = GTK::List::Store.new(Str, Str);

  $ls.set( :append, 'dialog-warning' xx 2);

  $ts;
}

sub populate-list-blaat ($cb) {
  my $ls = $cb.model;
  my $i  = $ts.first.next;

  $ts.set( append => $i, [ 'process-stop',   'process-stop', ], :!double);
  $ts.set( append => $i, [ 'document-new',   'document-new', ], :!double);
  $ts.set( append => $i, [ 'edit-clear',     'edit-clear',   ], :!double);
  $ts.set( append => $i, [ Str,              'separator',    ], :!double);
  $ts.set( append => $i, [ 'document-open',  'document-open' ], :!double);

  $ts;
}

sub create-list-blaat {
  my $ls = GTK::List::Store.new(Str, Str);

  $ls.set( :append, [ 'dialog-warning', 'dialog-warning', False ], :!double);
  $ls.set( :append, [ 'process-stop',   'process-stop',   False ], :!double);
  $ls.set( :append, [ 'document-new',   'document-new',   False ], :!double);
  $ls.set( :append, [ 'edit-clear',     'edit-clear',     False ], :!double);
  $ls.set( :append, [ Str,              'separator',      False ], :!double);
  $ls.set( :append, [ 'document-open',  'document-open',  False ], :!double);

  $ls;
}

sub create-list-long {
  my $ls = GTK::List::Store.new(Str);

  $ls.set(
    :append,
    [ q<here is some long long text that grows out of the combo's allocation> ]
  );

  $ls.set( :append, [ 'with at least a few of these rows' ]);
  $ls.set( :append, [ 'so that we can get some ellipsized text here' ]);

  $ls.set(
    :append,
    [ 'and see the combo box menu being allocated without any constraints' ]
  );

  $ls
}

sub create-food-list {
  my $ls = GTK::List::Store.new(Str, Str);

  $ls.set( :append, <Pepperoni Pizza>     );
  $ls.set( :append, <Cheese Burger>       );
  $ls.set( :append, <Pineapple Milkshake> );
  $ls.set( :append, <Orange Soda>         );
  $ls.set( :append, <Club Sandwich>       );

  $ls
}

sub create_phylogenetic_tree {
  my $ls = GTK::Tree::Store.new(Str);

  my ($i1, $i2, $i3) = GTK::Tree::Iter.new;

  my @i  = $ls.set( append => $i1, [ 'Eubacteria' ]);

  $ls.set( append => $i2, parent => $i1, [ 'Aquifecales'                     ]);
  $ls.set( append => $i2, parent => $i1, [ 'Thermotogales'                   ]);
  $ls.set( append => $i2, parent => $i1, [ 'Thermus-Deinococcus group'       ]);
  $ls.set( append => $i2, parent => $i1, [ 'Chloroflecales'                  ]);
  $ls.set( append => $i2, parent => $i1, [ 'Cyanobacteria'                   ]);
  $ls.set( append => $i2, parent => $i1, [ 'Firmicutes'                      ]);
  $ls.set( append => $i2, parent => $i1, [ 'Leptospirillium Group'           ]);
  $ls.set( append => $i2, parent => $i1, [ 'Chlorobium-Flavobacteria group'  ]);
  $ls.set( append => $i2, parent => $i1, [ 'Chlamydia-Verrucomicrobia group' ]);

  $ls.set( append => $i3, parent => $i2, [ 'Verrucomicrobia' ]);
  $ls.set( append => $i3, parent => $i2, [ 'Chlamydia'       ]);

  $ls.set( append => $i2, parent => $i1, [ 'Flexistipes'       ]);
  $ls.set( append => $i2, parent => $i1, [ 'Fibrobacter group' ]);
  $ls.set( append => $i2, parent => $i1, [ 'spirocheteus'      ]);
  $ls.set( append => $i2, parent => $i1, [ 'Proteobacteria'    ]);

  $ls.set( append => $i3, parent => $i2, [ 'alpha'   ]);
  $ls.set( append => $i3, parent => $i2, [ 'beta'    ]);
  $ls.set( append => $i3, parent => $i2, [ 'delta'   ]);
  $ls.set( append => $i3, parent => $i2, [ 'epsilon' ]);
  $ls.set( append => $i3, parent => $i2, [ 'gamma'   ]);

  $ls.set( append => $i1, [ 'Eukaryotes' ]);

  $ls.set( append => $i2, parent => $i1, [ $_ ]) for <
    Bilateria        Myxozoa         Cnidari             Ctenophora
    Placozoa         Porifera        choanoflagellates   Fungi
    Aleveolates      Stramenopiles   Rhodophyta
    Viridaeplantae   Microsporidia
  >;

  $ls.set( append => $i2, parent => $i1, [ 'crytomonads et al' ]);

  $ls.set( append => $i2, parent => $i1, [ $_ ]) for <
    Archaea   Korarchaeota   Crenarchaeota   Buryarchaeota
  >;

  $ls;
}

sub create-capital-tree {
  my $ts = GTK::Tree::Store.new(Str);

  my ($i1, $i2) = GTK::Tree::Iter.new xx 2;

  $ts.set( append => $i1, [ 'A - B' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Albany    Annapolis   Atlanta   Augusta    Austin
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Baton Rogue' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Bismarck  Boise  Boston
  >;

  $ts.set( append => $i1, [ 'C - D' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Carson City' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Charleston   Cheyenne   Columbia   Columbus   Concord   Denver
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Des Moines' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Dover' ]);

  $ts.set( append => $i1, [ 'E - J' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Frankfort   Harrisburg     Hartford   Helena
    Honolulu    Indianapolis   Jackson
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Jefferson City' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Juneau' ]);

  $ts.set( append => $i1, [ 'K - O' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Lansing' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Lincoln' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Little Rock' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Madison   Montgomery   Montpelier   Nashville
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Oklahoma City' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Olympia' ]);

  $ts.set( append => $i1, [ 'P - S' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Pierre     Providence   Raleigh
    Richmond   Sacramento   Salem
  >;
  $ts.set( append => $i2, parent => $i1, [ 'Salt Lake City' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Santa Fe' ]);
  $ts.set( append => $i2, parent => $i1, [ 'Springfield' ]);
  $ts.set( append => $i2, parent => $i1, [ 'St. Paul' ]);

  $ts.set( append => $i1, [ 'T - Z' ]);
  $ts.set( append => $i2, parent => $i1, [ $_ ]) for <
    Tallahassee  Topeka  Trenton
  >;

  $ts;
}

sub capital-animation ($m) {
  constant GTP = GTK::Tree::Path;

  state $c = 0;

  given $c % 8 {
    when 0 { $m.set( :insert, [ 'Europe' ] ) }
    when 1 { $m.set( insert => $m.get-iter( GTP.new-from-indices(0) ), [ 'Berlin' ] ) }
    when 2 { $m.set( insert => $m.get-iter( GTP.new-from-indices(0) ), [ 'London' ] ) }
    when 3 { $m.set( insert => $m.get-iter( GTP.new-from-indices(0) ), [ 'Paris'  ] ) }
    when 4 { $m.remove( $m.get-iter( GTP.new-from-indices(0, 2) ) }
    when 5 { $m.remove( $m.get-iter( GTP.new-from-indices(0, 1) ) }
    when 6 { $m.remove( $m.get-iter( GTP.new-from-indices(0, 0) ) }
    when 7 { $m.remove( $m.get-iter( GTP.new-from-indices(0)    ) }
  }

  $c++;
}

sub setup-combo-box-entry ($cb) {
  $cb.append-text($_) for «
    'dum de dum'
    'la la la'
    'la la la dum de dum la la la la la la boom de da la la'
  »;

  my @at = <bloop bleep klaas>;
  @at.append: |( 'klass' «~« (0..9, 'a'..'f', 10..12) ).flat

  $cb.append-text($_) for @at;
}

sub MAIN {
  GTK::Main.init;

  GTK::Widget.set-default-direction( :rtl ) if %*ENV<RTL>;

  my $w = GTK::Window.new;
  $w.Destroy.tap: SUB {  GLib::MainContext.wakeup }

  my ($b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $b10, $b11, $b12) =
    GTK::Box.new-vbox(0) xx 12;

  my $done  = False;
  my $mb    = GTK::Box.new-vbox(2);
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
  my $cv2   = GTK::Cell::View.new( model => $m );
  my $crt5  = GTK::Cell::Renderer::Text.new;
  my $cb3   = GTK::ComboBox.new-with-model($m, child => $cv2);
  my $f5    = GTK::Frame.new('GtkComboBox (tree)', child => $b5);
  my $cb4   = GTK::ComboBox.new-with-model( create-tree-blaat );
  my $crp5  = GTK::Cell::Renderer::Pixbuf.new;
  my $crt5  = GTK::Cell::Renderer::Text.new;
  my $f5    = GTK::Frame.new('GtkComboBox (grid)', child => $b6);
  my $f6    = GTK::Frame.new('GtkComboBox with Entry', child => $b7);
  my $cb5   = GTK::ComboBox.new-with-entry();
  my $f7    = GTK::Frame.new('What are you?', child => $b8);
  my $cb6   = GTK::ComboBox.new-with-model( create_phylogenetic_tree );
  my $crt6  = GTK::Cell::Renderer::Text.new;
  my $f8    = GTK::Frame.new('Where are you?', child => $b9);
  my $m2    = create-capital-tree;
  my $cb7   = GTK::ComboBox.new-with-model($m2);
  my $crt7  = GTK::Cell::Renderer::Text.new;
  my $f9    = GTK::Frame.new('Hungry?');
  my $cb8   = GTK::ComboBox.new-with-model( create-food-list, active => 0 );
  my $crt8  = GTK::Cell::Renderer::Text.new;
  my $crt9  = GTK::Cell::Renderer::Text.new;
  my $f10   = GTK::Frame.new('Unconstrained Menu');
  my $cb9   = GTK::ComboBox.new-with-model(
    create-list-long,
    active            => 0,
    popup-fixed-width => False
  );
  my $crt10 = GTK::Cell::Renderer::Text.new( ellipsize => PANGO_ELLIPSIZE_END );
  my $cb10  = GTK::ComboBox::Text.new( active => 53 );
  my $f11   = GTK::Frame.new('Looong', child => $cb10 );

  sub set-sensitive ($cl, $c, $tm, $i) {
    $c.sensitive = $tm.get_path($i).get-indices.head.not
  }

  sub is-sensitive ($m, $i) {
    $m.get-path($i).indicies.head == 4;
  }

  sub displayed-row-changed ($cb, $c) {
    $c.set-displayed-row( GTK::Tree::Path.new-from-indicies($cb.active) );
  }

  sub setup-combo-and-cells ($cb, $crp, $crt) {
    $cb.set-attributes($crp, 'icon-name', Str);
    $cb.set-cell-data-func(
      $crp,
      SUB { set-sensitive( |@*A ) }
    );
    $cb.active = 0;
    $cb.set-attributes($crt, 'text', 1);
    $cb.set-cell-data-func(
      $crt,
      SUB { set-sensitive( |@*A ) }
    );
    $cb.set-row-separator-func(
      SUB { is-sensitive( |@*A[^2] ) }
    );
    $cb.push: $_ for $crp, $crt;
  }

  $cv.push: $_ for $crp1, $crt;

  setup-combo-and-cells($cb,  $crp2, $crt2);
  setup-combo-and-cells($cb2, $crp3, $crt3);
  setup-combo-and-cells($cb3, $crp4, $crt4); # cw: Check to ensure this one is valid
  setup-combo-and-cells($cb4, $crp5, $crt5);

  $cb2.notify('popup-shown').tap: SUB {
    populate-list-blaat($cb2);
  }

  $cv2.push: $crt5, :expand;
  $cv2.set-attributes($crt5, 'text', 1);
  $cb.&display-row-changed($cv2);
  $cb3.Changed.tap: SUB { display-row-changed( |@*A[^2] );

  $cb5.&setup-combo-box-entry;

  $cb6.active = 0;
  $cb6.push: $crt6;
  $cb6.set-attributes($crt6, 'text', 0);

  $cb7.push: $crt8;
  $cb7.set-attributes($crt7, 'text', 0);
  $cb7.set-cell-data-func(
    $crt7,
    SUB {
      my ($cl, $c, $tm, $i) = @*A;

      $c.sensitive = $tm.iter.has-child($i).not
    }
  );
  $cb7.set-active-iter(
    $tm.get-iter( GTK::Tree::Path.new-from-indicies(0, 8) )
  );
  GLib::Timeout.add( 100, SUB { capital-animation($m2) } );

  my $a = $cb8.area;
  $a.add-with-properties($crt8, :align, :expand);
  $a.set-attributes($crt8, 'text', 0);
  $a.add-with-properties($crt9, :align, :expand);
  $a.set-attributes($crt8, 'text', 1);

  $cb9.set-attributes($crt10, 'text', 0);
  $cb9.push: $crt10, :expand;

  $cb10.append-text("Item { $_ }") for ^200;

  $mb. append: $_ for $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $f10, $f11;

  .head.append: .tail for (
    $b1,  $cv,    $b2,  $cb1,   $b3,  $cb2,    $b4, $cb3
    $b5,  $cb4,   $b7,  $cb5,   $b8,  $cb6,    $b9, $cb7
    $b10, $cb8,   $b11, $cb9,   $b12, $cb10
  ).rotor(2);

  $w.present;

  GLib::MainContext.iteration while $done.not;
}

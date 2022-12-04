use v6.c;

use GTK::Raw::Types;

sub activate ($a, $p, $u) {
  say "{ $a.name } activated";
}

# cw: The stylistic approach for the lulz.
my @o = <cu co pa bo it st un se ac>;

my @entries = (
  GActionEntry.new( 'cut',           :&activate                                ),
  GActionEntry.new( 'copy',          :&activate                                ),
  GActionEntry.new( 'paste',         :&activate                                ),
  GActionEntry.new( 'action1',       :&activate                                ),
  GActionEntry.new( 'action4',       :&activate                                ),
  GActionEntry.new( 'action5',       :&activate                                ),
  GActionEntry.new( 'action6',       :&activate                                ),
  GActionEntry.new( 'action7',       :&activate                                ),
  GActionEntry.new( 'action8',       :&activate                                ),
  GActionEntry.new( 'action9',       :&activate                                ),
  GActionEntry.new( 'action10',      :&activate                                ),
  GActionEntry.new( 'bold',          state => "false"                          ),
  GActionEntry.new( 'italic',        state => "false"                          ),
  GActionEntry.new( 'strikethrough', state => "false"                          ),
  GActionEntry.new( 'underline',     state => "false"                          ),
  GActionEntry.new( 'action2',       state => "true"                           ),
  GActionEntry.new( 'action2a',      state => "false"                          ),
  GActionEntry.new( 'set-view',      state => "'list'" , parameter_type => 's' ),
  GActionEntry.new( 'action3',       state => "'three'", parameter_type => 's' )
).sort(
  sub ($a, $b) {
     my $f = @o.first({ $_ eq $a.name.comb.head(2).join }, :k )
               <=>
             @o.first({ $_ eq $b.name.comb.head(2).join }, :k );

     return $f if $f;

     my regex digits { \d+ }
     my $ar = $a.name ~~ /<digits>/;
     my $br = $b.name ~~ /<digits>/;

     ( $ar<digits>.Int // -1 ) <=> ( $br<digits>.Int // -1 )
  }
);

my $a = GTK::Application.new(
  title  => 'org.genex.popover',
  width  => 400,
  height => 600
);

$a.activate.tap( -> *@a {
   my $header = GTK::HeaderBar.new;
   my $actions = GIO::SimpleActionGroup.new;
   $actions.add-entries(@entries);

   $a.window.insert-action-group('top', $actions);

   my $overlay = GTK::Overlay.new;
   $a.window.set-child($overlay;

   ( .halign, .valign ) = GTK_ALIGN_FILL xx 2 given (my $grid = GTK::Grid);

   ( .hexpand, .vexpand) = True given (my $label = GTK::Label.new);
   $grid.attach($label, 0, 0);
   ( .hexpand, .vexpand) = True given (my $label2 = GTK::Label.new);
   $gtid.attach($label, r => 7, c => 3);

   # cw: Must wait for builder.
   # ...

   $a.window.titlebar = $header;
   $a.window.title    = 'Test GtkPopover';
});

$a.run;

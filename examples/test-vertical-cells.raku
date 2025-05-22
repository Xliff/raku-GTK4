use v6.c;

use GTK::Raw::Types:ver<4>;

  icon =>
  info =>
  description =>
  fine_print =>
  fine_print_color =>
  progress =>
  entries =>

my %entries;

%entries<info> = [
  {
    icon             => "system-run",
    info             => "Will you\nrun this ?",
    description      => "Currently executing that thing... you might want to abort",
    fine_print       => "and every day he went fishing for pigs in the sky",
    fine_print_color => "green",
    progress         => 83
  },
  {
    icon             => "dialog-password",
    info             => "This is the\nrealest of the real",
    description      => "We are about to authenticate the actual realness, this could take some time",
    fine_print       => "one day he caught a giant ogre who barked and barked and barked",
    fine_print_color => "purple",
    progress         => 4
  }
];

%entry<directory> = [
  {
    icon             => "document-open",
    info             => "We can edit\nthings in here",
    description      => "Time to edit your directory, almost finished now",
    fine_print       => "she thought the best remedy for daydreams was going to be sleep",
    fine_print_color => "dark sea green",
    progress         => 99,
  },
  {
    icon             => "text-x-generic",
    info             => "You have a\nfile here",
    description      => "Who would of thought there would be a file in the directory ?",
    fine_print       => "after taking loads of sleeping pills he could still hear the pigs barking",
    fine_print_color => "green yellow",
    progress         => 33,
  },
  {
    icon             => "dialog-question",
    info             => "Any questions ?",
    description      => "This file would like to ask you a question",
    fine_print       => "so he decided that the fine print underneath the progress bar probably made no sense at all",
    fine_print_color => "lavender",
    progress         => 73,
  }
];

%entries<other> = [
  {
    icon             => "zoom-fit-best",
    info             => "That's the\nperfect fit",
    description      => "Now fitting foo into bar using frobnicator",
    fine_print       => "using his nifty wide angle lense, he was able to catch a 'dark salmon', it was no flying pig however it was definitely a keeper",
    fine_print_color => "dark salmon",
    progress         => 59,
  },
  {
    icon             => "format-text-underline",
    info             => "Under the\nline",
    description      => "Now underlining that this demo would look a lot niftier with some real content",
    fine_print       => "it was indeed strange to catch a red salmon while fishing for pigs in the deep sky blue.",
    fine_print_color => "deep sky blue",
    progress         => 99,
  }
]

%entries<add>  = [
  {
    icon             => "help-about",
    info             => "its about\nto start",
    description      => "This is what it's all about",
    fine_print       => "so he went ahead and added the 'help-about' icon to his story, thinking 'mint cream' would be the right color for something like that",
    fine_print_color => "dark violet",
    progress         => 1
  },
  {
    icon             => "zoom-in",
    info             => "Watch it\nZoom !",
    description      => "Now zooming into something",
    fine_print       => "while fishing for pigs in the sky, maybe he would have caught something faster if only he had zoomed in",
    fine_print_color => "orchid",
    progress         => 6,
  },
  {
    icon             => "zoom-out",
    info             => "Zoom Zoom\nZoom !",
    description      => "Now zooming out of something else",
    fine_print       => "the daydream had a much prettier picture over all once he had zoomed out for the wide angle, jill agreed",
    fine_print_color => "dark magenta",
    progress         => 46,
    entries          => %entries<other>
  }
];


%entries<main> = [
  {
    icon             => "dialog-information",
    info             => "This is all\nthe info",
    description      => "We are currently informing you",
    fine_print       => "once upon a time in a land far far away there was a guy named buba",
    fine_print_color => "red",
    progress         => 64,
    entries          => %entries<info>
  },
  {
    icon             => "dialog-warning",
    info             => "This is a\nwarning",
    description      => "We would like to warn you that your laptop might explode after we're done",
    fine_print       => "so he decided that he must be stark raving mad",
    fine_print_color => "orange",
    progress         => 43,
  },
  {
    icon             => "dialog-error",
    info             => "An error will\noccur",
    description      => "Once we're done here, dont worry... an error will surely occur.",
    fine_print       => "and went to a see a yellow physiotherapist who's name was jill",
    fine_print_color => "yellow",
    progress         => 98
  },
  {
    icon             => "folder",
    info             => "The directory",
    description      => "Currently scanning your directories.",
    fine_print       => "jill didn't know what to make of the barking pigs either so she fed him sleeping pills",
    fine_print_color => "brown",
    progress         => 20,
    entries          => %entry<directory>
  },
  {
    icon             => "edit-delete",
    info             => "Now deleting\nthe whole thing",
    description      => "Time to delete the sucker",
    fine_print       => "and he decided to just delete the whole conversation since it didn't make sense to him",
    fine_print_color => "dark orange",
    progress         => 26
  },
  {
    icon             => "list-add",
    info             => "Anything\nto add ?",
    description      => "Now adding stuff... please be patient",
    fine_print       => "but on second thought, maybe he had something to add so that things could make a little less sense.",
    fine_print_color => "maroon",
    progress         => 72,
    entries          => %entries<add>
  },
  {
    icon              => "edit-redo",
    info              => "Time to\ndo it again",
    description       => "For the hell of it, lets add the content to the treeview over and over again !",
    fine_print        => "buba likes telling his story, so maybe he's going to tell it 20 times more.",
    fine_print_color  => "deep pink",
    progress          => 100
  }
];

multi sub populate-model ($m, $e is copy) {
  samewith($m, GtkTreeIter, $e);
}
multi sub populate-model ($m, $p, $e is copy) {
  for $e[] -> $ee is copy {
    my $eee = $ee<entries>:delete;
    my $i   = $m.set( :append, parent => $p, :v, $ee )
    populate-model($m, $i, $_) with $eee;
  }
}

method create-model {
  my $m = GTK::Tree::Store.new(Str, Str, Str, Str, Str, int32);
  populate-model($m, %entries<main>) for ^20;
}

sub MAIN {
  my $done = False;

  GTK::Main.init;

  GTK::Widget.set-default-direction( :rtl ) if %*ENV<RTL>;

  my $tv = GTK::Tree::view.new-with-model( create-model, headers-visible => True );
  my $sw = GTK::ScrolledWindow.new(
    has-frame => True,
    policy    => POLICY<auto>,
    child     => $tv
  );
  my $w  = GTK::Window.new(
    title  => 'Vertical cells in GtkTreeViewColumn example',
    width  => 800,
    height => 400,
    child  => $sw
  );

  my $c = GTK::Tree::View::Column.new;
  my $crp1 = GTK::Cell::Renderer::Pixbuf.new( icon-size => ICON.SIZE<large> );
  $c.push: $crp1, :expand;
  $c.set-attributes($c, $crp1, 'icon-name', 0);

  my $crt1 = GTK::Cell::Renderer::Text.new( scale => 1.2, weight => PANGO_WEIGHT_BOLD );
  $c.push: $crt1, :expand;
  $c.set-attributes($c, $crt1, 'text', 1);

  my $c2 = GTK::Tree::View::Column.new;
  my $a  = $c2.area;
  $a.orientation = ORIENTATION<v>;

  my $crt2 = GTK::Cell::Renderer::Text.new(
    ellipsize => PANGO_ELLIPSIZE_END,
    editable  => True
  );
  $c.pack: $crt2, :expand;
  $c2.set-attributes($crt2, 'text', 2);

  my $crp2 = GTK::Cell::Renderer::Progress.new;
  $c2.pack: $crp2, :expand;
  $c2.set-attributes($crp2, 'value', 3);

  my $crt3 = GTK::Cell::Renderer::Text.new(
    scale     => 0.6,
    ellipsize => PANGO_ELLIPSIZE_END
  );
  $c2.push: $crt3, :expand;
  $c2.set-attributes($crt3, 'text', 4, 'foreground', 5);

  $tv.append-column($_) for $c, $c2;
  $tv.expand-all;
  $w.present;

  repeat { GLib::MainContext.iteration } until $done;
}

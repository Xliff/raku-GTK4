use v6.c;

use GTK::Adjustment;
use GTK::List::Item::Factory::Signal;
use GTK::MultiSelection;

sub adjustment-to-fraction ($adj, $frac) {
  my ($upper, $lower) = $adj.range;
  my  $size           = $adj.page-size;

  $adj.value = (1 - $frac) * $lower + $frac * ($upper - $size);
}

enum WidgetType <NONE LABEL TEXT INSCRIPTION>;

my ($widget-type, $no-scroll, $n-columns);

my %type-to-enum = (
  none        => NONE,
  label       => LABEL,
  text        => TEXT,
  inscription => INSCRIPTION
);

sub MAIN (
  Str  :w(:$widget)         = 'inscription', #= Cell item widget to use, can be one of: none, label, text, inscription
  Bool :n(:$no-auto-scroll) = False,         #= Disable automatic scrolling
  Int  :c(:$columns)        = 20             #= Column count
) {
  ($widget-type, $no-scroll, $n-columns) =
    ($widget, $no-auto-scroll, $columns);

  my $a = GTK::Application.new(
    title  => 'org.genex.table.data',
    width  => 1700,
    height => 900
  );

  $a.activate.tap( -> *@a {

  });

  $a.run;
}

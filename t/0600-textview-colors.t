use v6.c;

use GDK::RGBA;
use GTK::Application;
use GTK::CssProvider;
use GTK::Box;
use GTK::ScrolledWindow;
use GTK::Text::View;
use GTK::Text::Tag;
use GTK::Text::Tag::Table;

my $content;

role TagNotApplied { }

multi sub trait_mod:<is> (Routine $m, :$not-applied is required) {
  $m does TagNotApplied;
}

my token word         { \w+                               }
my token dc           { '::'                              }
my token cs           { <.ws> ',' <.ws>?                  }
my token class-name   { <word> ** 2..* % <dc>             }
my token string       { "'" .+? "'" | '"' .+? '"'         }
my token int          { <digit>+                          }
my token num          { <digit> '.' <digit>+              }
my token value        { <num> | <int> | <string>          }
my token key          { \w+                               }
my token pair         { <key> <.ws> '=>' <.ws> <value>    }
my token argument     { <num> | <int> | <string> | <pair> }

my regex method-call  {
 '.' <[\w_-]>+ '('
    [
      <.ws>              |
      <argument>+ % <cs> |
      <argument> <.ws>
    ]
  ')'
}

my @top-rules = <class-name method-call pair>;

multi sub apply-color-tag ($n, $m) {
  for $m[] {
    if $*tv.buffer.tag-table.lookup($n) {
      say "Applying { $n } from { .from } - { .to }";
      $*tv.buffer.applyTagAtIndexes($n, .from, .to, :tag);
    }
    say "P: { .keys }";
    apply-color-tag(.key, .value) for .pairs;
  }
}

sub colorize-initially ($*tv) {
  my %colors = (
    dc          => GDK::RGBA.new(b => 200),
    word        => GDK::RGBA.new(b => 128, g => 156),
    pair        => GDK::RGBA.new(b => 90),
    key         => GDK::RGBA.new(g => 190),
    string      => GDK::RGBA.new(g => 190),
    int         => GDK::RGBA.new(g => 190),
    num         => GDK::RGBA.new(g => 190),
    method-call => GDK::RGBA.new(r => 128, b => 128)
  );

  for %colors.keys {
    my $tag = GTK::Text::Tag.new($_);
    $tag.weight = 800;
    $tag.foreground-rgba = %colors{$_} if %colors{$_};
    $*tv.buffer.tag-table.add($tag);
  }

  for @top-rules {
    if $content.match( ::('&' ~ $_), :g) -> $m is copy {
      apply-color-tag($_, $m);
    }
  }
}

sub MAIN (
  :$font,
  :$file  is copy = $*PROGRAM
) {
  unless $file ~~ IO::Path {
    die "File '$file' does not exist!" unless $file.IO.r;
    $file .= IO;
  }
  $content = $file.slurp;

  my $a = GTK::Application.new(
    title  => 'org.genex.textview.colors',
  );

  $a.Activate.tap( -> *@a {
    my $css = GTK::CssProvider.new( pod => $=pod );

    my $box = GTK::Box.new-vbox(4);
    $a.window.child = $box;

    my $sw = GTK::ScrolledWindow.new;
    $sw.min-content-size = (800, 400);

    my $t = GTK::Text::View.new( text => $content );
    ($sw.child, $t.expand, $t.name) = ($t, True, 'prog');

    $box.append($sw);
    $t.margins = 15;

    $t.font-description = Pango::FontDescription.new-from-string($font)
      if $font;

    colorize-initially($t);

    $a.window.present;
  });

  $a.run;
}

=begin css
#prog text {
  color: #999;
}
=end css

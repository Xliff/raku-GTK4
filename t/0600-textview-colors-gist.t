my $content;

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

my %colors = (
  dc          => { b => 200},
  word        => { b => 128, g => 156},
  pair        => { b => 90},
  key         => { g => 190},
  string      => { g => 190},
  int         => { g => 190},
  num         => { g => 190},
  method-call => { r => 128, b => 128}
);

multi sub apply-color-tag ($n, $m) {
  for $m[] {
    if %colors{$n}:exists {
      say "Applying { $n } from { .from } - { .to }";
    }
    say "P: { .keys }";
    apply-color-tag(.key, .value) for .pairs;
  }
}

sub colorize-initially ($*tv) {
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
  colorize-initially($t);
}

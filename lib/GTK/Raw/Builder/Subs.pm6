use LibXML;

use GLib::Object::Type;

unit package GTK::Raw::Builder::Subs:ver<4>;

sub prepTemplate ($template, *%opts) is export {

  given $template {
    when IO::Path              { %opts<location> = $template.absolute }
    when IO::Handle            { %opts<io>       = $template }

    when Str {
      %opts{ %opts<url> ?? 'location' !! 'string' } = $template
    }
  }

  # Delete all non-LibXML options from hash
  my &dom-callback = %opts<dom-callback> if %opts<dom-callback>;
  my $serial = %opts<serial>;

  %opts<serial dom-callback>:delete;

  my $dom = LibXML.parse(|%opts);
  # For parsing, we first change all <template> to <object>
  # For now... should only be one.
  if $dom.find('//template')[0] -> $t {
    # Rename the node from 'template' to 'object';
    $t.name = 'object';
    # It's id will become its class will appended serial.
    $t.setAttribute('id', $t.getAttribute('class') ~ '01');
    # It's class will then become its parent.
    $t.setAttribute( 'class', $t.getAttribute('parent') );
    # Remove parent
    $t.removeAttribute('parent');
  }

  my %signals;

  for $dom.find('//signal | //packing')[] {
    %signals{ .parent<id> // "OBJECT" } = %(
      handler => .<handler>,
      name    => .<name>
    );
    .unbindNode unless %opts<signals> // False;
  }

  if %opts<generate> {
    my %o;

    %o{ .<id> } = .<Class> for $dom.find('//object')[];

    my $attrs   = %o.pairs.map({ qq:to/ATTR/.join("\n") });
        has { TYPE-TO-OBJECT(.value) } \$!{ .key }"  });
        ATTR

    my $attrs-set = %o.pairs.map({ qq:to/ATTRSET/.join("\n") });
      \$!\{ .key } = \$b\{{ .key }\};
      ATTRSET

    my $signals = %signals.pairs.map({ qq:to/CALL/.join("\n") });
      \$b\{{ .key }\}.{ .value.name.tc }.tap: sub (*\@a) \{
        { .value.handler }( |@a );
      \}
      CALL

    say qq:to/CLASS/;
      class :: \{
        { $attrs }

        submethod BUILD \{
          \$b = GTK::Builder.new;
          { $attrs-set }
          { $signals }
        \}
      \}
      CLASS
  }

  &dom-callback($dom) if &dom-callback;

  my $s = $dom.Str.trim;
  $s .= chop if $s.comp.tail.ord = 0;
  $s .= chomp;
  $s;
}

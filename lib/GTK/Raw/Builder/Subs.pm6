use LibXML;

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
  &dom-callback($dom) if &dom-callback;

  $dom;
}

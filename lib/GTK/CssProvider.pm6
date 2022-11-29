use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::CssProvider:ver<4>;

use GTK::StyleContext;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::CssProvider:ver<4>;

our subset GtkCssProviderAncestry is export of Mu
  where GtkCssProvider | GObject;

class GTK::CssProvider:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::CssProvider;

  has GtkCssProvider $!gtk-css is implementor;

  submethod BUILD ( :$gtk-css-provider ) {
    self.setGtkCssProvider($gtk-css-provider) if $gtk-css-provider
  }

  method setGtkCssProvider (GtkCssProviderAncestry $_) {
    my $to-parent;

    $!gtk-css = do {
      when GtkCssProvider {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCssProvider, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkCssProvider
    is also<GtkCssProvider>
  { $!gtk-css }

  method GTK::Raw::Definitions::GtkStyleProvider
  { cast(GtkStyleProvider, $!gtk-css) }

  multi method new (GtkCssProviderAncestry $gtk-css-provider, :$ref = True) {
    return unless $gtk-css-provider;

    my $o = self.bless( :$gtk-css-provider );
    $o.ref if $ref;
    $o;
  }
  multi method new ( :$pod, :$style is copy) {
    $style //= '';
    
    my $gtk-css-provider = gtk_css_provider_new();

    return Nil unless $gtk-css-provider;
    my $o = self.bless( :$gtk-css-provider );
    if $pod {
      my %sections;
      for $pod.grep( *.name eq 'css' ).Array {
        # This may not always be true. Keep up with POD spec!
        %sections{ .name } = .contents.map( *.contents[0] ).join("\n");
        last when %sections<css>.defined;
      }
      $style ~= %sections<css>;
      say "{'-' x 40}\nUsing the following styles:{'-' x 40}\n$style"
        if $DEBUG;
      $o.load_from_data($style);
      GTK::StyleContext.addProviderForCurrentDisplay($o);
    }
    $o
  }

  method Parsing-Error is also<Parsing_Error> {
    self.connect-parsing-error($!gtk-css);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_css_provider_get_type, $n, $t );
  }

  proto method load_from_data (|)
    is also<load-from-data>
  { * }

  multi method load_from_data (Str $data, :$encoding = 'utf8') {
    samewith( $data.encode($encoding) );
  }
  multi method load_from_data (Blob $data) {
     samewith( CArray[uint8].new($data), $data.bytes );
  }
  multi method load_from_data (CArray[uint8] $data, Int() $length) {
    my gssize $l = $length;

    gtk_css_provider_load_from_data($!gtk-css, $data, $l);
  }

  method load_from_file (GFile() $file) is also<load-from-file> {
    gtk_css_provider_load_from_file($!gtk-css, $file);
  }

  method load_from_path (Str() $path) is also<load-from-path> {
    gtk_css_provider_load_from_path($!gtk-css, $path);
  }

  method load_from_resource (Str() $resource_path)
    is also<load-from-resource>
  {
    gtk_css_provider_load_from_resource($!gtk-css, $resource_path);
  }

  method load_named (Str() $name, Str() $variant) is also<load-named> {
    gtk_css_provider_load_named($!gtk-css, $name, $variant);
  }

  method to_string is also<to-string> {
    gtk_css_provider_to_string($!gtk-css);
  }

}

use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::CssProvider:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::CssProvider:ver<4>;

class GTK::CssProvider:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::CssProvider;

  has GtkCssProvider $!gtk-css is implementor;

  method new {
    my $gtk-css-provider = gtk_css_provider_new();

    $gtk-css-provider ?? self.bless( :$gtk-css-provider ) !! Nil
  }

  method Parsing-Error {
    self.connect-parsing-error($!gtk-css);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_css_provider_get_type, $n, $t );
  }

  proto method load_from_data (|)
  { * }

  multi method load_from_data (Str() $data, :$encoding = 'utf8') {
    samewith( $data.encode($encoding) );
  }
  multi method load_from_data (Buf() $data) {
     samewith( $data, $data.bytes );
  }
  multi method load_from_data (CArray[uint8] $data, Int() $length) {
    my gssize $l = $length;

    gtk_css_provider_load_from_data($!gtk-css, $data, $l);
  }

  method load_from_file (GFile() $file) {
    gtk_css_provider_load_from_file($!gtk-css, $file);
  }

  method load_from_path (Str() $path) {
    gtk_css_provider_load_from_path($!gtk-css, $path);
  }

  method load_from_resource (Str() $resource_path) {
    gtk_css_provider_load_from_resource($!gtk-css, $resource_path);
  }

  method load_named (Str() $name, Str() $variant) {
    gtk_css_provider_load_named($!gtk-css, $name, $variant);
  }

  method to_string {
    gtk_css_provider_to_string($!gtk-css);
  }

}

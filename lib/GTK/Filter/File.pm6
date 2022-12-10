use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Filter::File:ver<4>;

use GTK::Filter:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkFileFilterAncestry is export of Mu
  where GtkFileFilter | GtkFilterAncestry;

class GTK::Filter::File:ver<4> is GTK::Filter:ver<4> {
  has GtkFileFilter $!gtk-ff is implementor;

  submethod BUILD ( :$gtk-file-filter ) {
    self.setGtkFileFilter($gtk-file-filter) if $gtk-file-filter
  }

  method setGtkFileFilter (GtkFileFilterAncestry $_) {
    my $to-parent;

    $!gtk-ff = do {
      when GtkFileFilter {
        $to-parent = cast(GtkFilter, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFileFilter, $_);
      }
    }
    self.setGtkFilter($to-parent);
  }

  method GTK::Raw::Definitions::GtkFileFilter
    is also<GtkFileFilter>
  { $!gtk-ff }

  multi method new (
    $gtk-file-filter where * ~~ GtkFileFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-file-filter;

    my $o = self.bless( :$gtk-file-filter );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-file-filter = gtk_file_filter_new();

    $gtk-file-filter ?? self.bless( :$gtk-file-filter ) !! Nil;
  }

  method new_from_gvariant (GVariant() $variant) is also<new-from-gvariant> {
    my $gtk-file-filter = gtk_file_filter_new_from_gvariant($variant);

    $gtk-file-filter ?? self.bless( :$gtk-file-filter ) !! Nil;
  }

  # Type: GStrv
  method mime-types is rw  is g-property is also<mime_types> {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        warn 'mime-types does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('mime-types', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: GtkStrv
  method patterns ( :$array = True ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        warn 'patterns does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('patterns', $gv);
      }
    );
  }

  # Type: GtkStrv
  method suffixes is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        warn 'suffixes does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('suffixes', $gv);
      }
    );
  }

  method add_mime_type (Str() $mime_type) is also<add-mime-type> {
    gtk_file_filter_add_mime_type($!gtk-ff, $mime_type);
  }

  method add_pattern (Str() $pattern) is also<add-pattern> {
    gtk_file_filter_add_pattern($!gtk-ff, $pattern);
  }

  method add_pixbuf_formats is also<add-pixbuf-formats> {
    gtk_file_filter_add_pixbuf_formats($!gtk-ff);
  }

  method add_suffix (Str() $suffix) is also<add-suffix> {
    gtk_file_filter_add_suffix($!gtk-ff, $suffix);
  }

  method get_attributes ( :$array = True ) is also<get-attributes> {
    my $fa = gtk_file_filter_get_attributes($!gtk-ff);
    return $fa unless $array;
    CArrayToArray($fa);
  }

  method get_name is also<get-name> {
    gtk_file_filter_get_name($!gtk-ff);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_file_filter_get_type, $n, $t );
  }

  method set_name (Str() $name) is also<set-name> {
    gtk_file_filter_set_name($!gtk-ff, $name);
  }

  method to_gvariant ( :$raw = False ) is also<to-gvariant> {
    propReturnObject(
      gtk_file_filter_to_gvariant($!gtk-ff),
      $raw,
      |GLib::Variant.getTypePair
    )
  }

}

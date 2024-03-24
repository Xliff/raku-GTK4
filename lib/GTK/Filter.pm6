use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkFilterAncestry is export of Mu
  where GtkFilter | GObject;

class GTK::Filter:ver<4> {
  also does GLib::Roles::Object;

  has GtkFilter $!gtk-f is implementor;

  submethod BUILD ( :$gtk-filter ) {
    self.setGtkFilter($gtk-filter) if $gtk-filter
  }

  method setGtkFilter (GtkFilterAncestry $_) {
    my $to-parent;

    $!gtk-f = do {
      when GtkFilter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFilter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkFilter
    is also<GtkFilter>
  { $!gtk-f }

  multi method new (
    $gtk-filter where * ~~ GtkFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-filter;

    my $o = self.bless( :$gtk-filter );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkStrv
  method mime-types is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        warn 'mime-types does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.boxed = $val;
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
  method patterns is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        warn 'patterns does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.boxed = $val;
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
      STORE => -> $,  $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('suffixes', $gv);
      }
    );
  }

  method Changed {
    self.connect-uint($!gtk-f, 'changed');
  }

  method changed (Int() $change) {
    my GtkFilterChange $c = $change;

    gtk_filter_changed($!gtk-f, $change);
  }

  method get_strictness ( :$enum = True ) is also<get-strictness> {
    my $s = gtk_filter_get_strictness($!gtk-f);
    return $s unless $enum;
    GtkFilterMatchEnum($s);
  }

  method match (GObject() $item) {
    so gtk_filter_match($!gtk-f, $item);
  }

}

### /usr/src/gtk4/gtk/gtkfilter.h

sub gtk_filter_changed (
  GtkFilter       $self,
  GtkFilterChange $change
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_get_strictness (GtkFilter $self)
  returns GtkFilterMatch
  is      native(gtk4)
  is      export
{ * }

sub gtk_filter_match (GtkFilter $self, GObject $item)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

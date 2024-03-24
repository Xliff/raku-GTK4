use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Filter:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;
use GIO::Roles::ListModel;

our subset GtkMultiFilterAncestry is export of Mu
  where GtkMultiFilter | GObject;

class GTK::MultiFilter:ver<4> is GTK::Filter:ver<4> {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has GtkMultiFilter $!gtk-mf is implementor;

  submethod BUILD ( :$gtk-multi-filter ) {
    self.setGtkMultiFilter($gtk-multi-filter) if $gtk-multi-filter
  }

  method setGtkMultiFilter (GtkMultiFilterAncestry $_) {
    my $to-parent;

    $!gtk-mf = do {
      when GtkMultiFilter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMultiFilter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkMultiFilter
    is also<GtkMultiFilter>
  { $!gtk-mf }

  multi method new (
    $gtk-multi-filter where * ~~ GtkMultiFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-multi-filter;

    my $o = self.bless( :$gtk-multi-filter );
    $o.ref if $ref;
    $o;
  }

  # Type: GType
  method item-type is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new( G_TYPE_UINT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        $gv.uint64;
      },
      STORE => -> $,  $val is copy {
        warn 'item-type does not allow writing'
      }
    );
  }

  # Type: uint
  method n-items is rw  is g-property is also<n_items> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-items', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-items does not allow writing'
      }
    );
  }

  method append (GtkFilter() $filter) {
    gtk_multi_filter_append($!gtk-mf, $filter);
  }

  method remove (Int() $position) {
    my guint $p = $position;

    gtk_multi_filter_remove($!gtk-mf, $p);
  }

}

our subset GtkAnyFilterAncestry is export of Mu
  where GtkAnyFilter | GtkMultiFilterAncestry;

class GTK::MultiFilter::Any:ver<4> is GTK::MultiFilter:ver<4> {
  has GtkAnyFilter $!gtk-af is implementor;

  submethod BUILD ( :$gtk-any-filter ) {
    self.setGtkAnyFilter($gtk-any-filter) if $gtk-any-filter
  }

  method setGtkAnyFilter (GtkAnyFilterAncestry $_) {
    my $to-parent;

    $!gtk-af = do {
      when GtkMultiFilter {
        $to-parent = cast(GtkMultiFilter, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAnyFilter, $_);
      }
    }
    self.setGtkMultiFilter($to-parent);
  }

  method GTK::Raw::Definitions::GtkAnyFilter
    is also<GtkAnyFilter>
  { $!gtk-af }

  multi method new (
    $gtk-any-filter where * ~~ GtkAnyFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-any-filter;

    my $o = self.bless( :$gtk-any-filter );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-any-filter = gtk_any_filter_new();

    $gtk-any-filter ?? self.bless( :$gtk-any-filter ) !! Nil;
  }

}

our subset GtkEveryFilterAncestry is export of Mu
  where GtkEveryFilter | GtkMultiFilterAncestry;

class GTK::MultiFilter::Every:ver<4> is GTK::MultiFilter:ver<4> {
  has GtkEveryFilter $!gtk-ef is implementor;

  submethod BUILD ( :$gtk-every-filter ) {
    self.setGtkAnyFilter($gtk-every-filter) if $gtk-every-filter
  }

  method setGtkAnyFilter (GtkEveryFilterAncestry $_) {
    my $to-parent;

    $!gtk-ef = do {
      when GtkMultiFilter {
        $to-parent = cast(GtkMultiFilter, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEveryFilter, $_);
      }
    }
    self.setGtkMultiFilter($to-parent);
  }

  method GTK::Raw::Definitions::GtkEveryFilter
    is also<GtkEveryFilter>
  { $!gtk-ef }

  multi method new (
    $gtk-every-filter where * ~~ GtkEveryFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-every-filter;

    my $o = self.bless( :$gtk-every-filter );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-every-filter = gtk_every_filter_new();

    $gtk-every-filter  ?? self.bless( :$gtk-every-filter  ) !! Nil;
  }

}


### /usr/src/gtk4/gtk/gtkmultifilter.h

sub gtk_multi_filter_append (
  GtkMultiFilter $self,
  GtkFilter      $filter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_any_filter_new
  returns GtkAnyFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_every_filter_new
  returns GtkEveryFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_multi_filter_remove (
  GtkMultiFilter $self,
  guint          $position
)
  is      native(gtk4)
  is      export
{ * }

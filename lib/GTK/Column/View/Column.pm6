use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Column::View::Column:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkColumnViewColumnAncestry is export of Mu
  where GtkColumnViewColumn | GObject;

class GTK::Column::View::Column:ver<4> {
  also does GLib::Roles::Object;

  has GtkColumnViewColumn $!gtk-cvc is implementor;

  submethod BUILD ( :$gtk-cv-column ) {
    self.setGtkColumnViewColumn($gtk-cv-column) if $gtk-cv-column
  }

  method setGtkColumnViewColumn (GtkColumnViewColumnAncestry $_) {
    my $to-parent;

    $!gtk-cvc = do {
      when GtkColumnViewColumn {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkColumnViewColumn, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkColumnViewColumn
    is also<GtkColumnViewColumn>
  { $!gtk-cvc }

  multi method new (
    $gtk-cv-column where * ~~ GtkColumnViewColumnAncestry,

    :$ref = True
  ) {
    return unless $gtk-cv-column;

    my $o = self.bless( :$gtk-cv-column );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $title, GtkListItemFactory() $factory) {
    my $gtk-cv-column = gtk_column_view_column_new($title, $factory);

    $gtk-cv-column ?? self.bless( :$gtk-cv-column ) !! Nil;
  }

  # Type: GtkColumnView
  method column-view ( :$raw = False )
    is rw
    is g-property
    is also<column_view>
  {
    my $gv = GLib::Value.new( ::('GTK::Column::View').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-view', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GTK::Column::View').getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'column-view does not allow writing'
      }
    );
  }

  # Type: boolean
  method expand is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('expand', $gv);
      }
    );
  }

  # Type: GtkListItemFactory
  method factory ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::List::Item::Factory.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('factory', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::List::Item::Factory.getTypePair
        );
      },
      STORE => -> $, GtkListItemFactory() $val is copy {
        $gv.object = $val;
        self.prop_set('factory', $gv);
      }
    );
  }

  # Type: int
  method fixed-width is rw  is g-property is also<fixed_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fixed-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('fixed-width', $gv);
      }
    );
  }

  # Type: GtkMenuModel
  method header-menu ( :$raw = False )
    is rw
    is g-property
    is also<header_menu>
  {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('header-menu', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        )
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('header-menu', $gv);
      }
    );
  }

  # Type: string
  method id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: boolean
  method resizable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resizable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resizable', $gv);
      }
    );
  }

  # Type: GtkSorter
  method sorter ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Sorter.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sorter', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Sorter.getTypePair
        );
      },
      STORE => -> $, GtkSorter() $val is copy {
        $gv.object = $val;
        self.prop_set('sorter', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: boolean
  method visible is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible', $gv);
      }
    );
  }

  method get_column_view ( :$raw = False ) is also<get-column-view> {
    propReturnObject(
      gtk_column_view_column_get_column_view($!gtk-cvc),
      $raw,
      |GTK::Column::View.getTypePair
    );
  }

  method get_expand is also<get-expand> {
    gtk_column_view_column_get_expand($!gtk-cvc);
  }

  method get_factory ( :$raw = False ) is also<get-factory> {
    propReturnObject(
      gtk_column_view_column_get_factory($!gtk-cvc),
      $raw,
      |GTK::List::Item::Factory.getTypePair
    );
  }

  method get_fixed_width is also<get-fixed-width> {
    gtk_column_view_column_get_fixed_width($!gtk-cvc);
  }

  method get_header_menu ( :$raw = False ) is also<get-header-menu> {
    propReturnObject(
      gtk_column_view_column_get_header_menu($!gtk-cvc),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_id is also<get-id> {
    gtk_column_view_column_get_id($!gtk-cvc);
  }

  method get_resizable is also<get-resizable> {
    so gtk_column_view_column_get_resizable($!gtk-cvc);
  }

  method get_sorter ( :$raw = False ) is also<get-sorter> {
    propReturnObject(
      gtk_column_view_column_get_sorter($!gtk-cvc),
      $raw,
      |GTK::Sorter.getTypePair
    );
  }

  method get_title is also<get-title> {
    gtk_column_view_column_get_title($!gtk-cvc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_column_view_column_get_type, $n, $t );
  }

  method get_visible is also<get-visible> {
    so gtk_column_view_column_get_visible($!gtk-cvc);
  }

  method set_expand (Int() $expand) is also<set-expand> {
    my gboolean $e = $expand.so.Int;

    gtk_column_view_column_set_expand($!gtk-cvc, $e);
  }

  method set_factory (GtkListItemFactory() $factory) is also<set-factory> {
    gtk_column_view_column_set_factory($!gtk-cvc, $factory);
  }

  method set_fixed_width (Int() $fixed_width) is also<set-fixed-width> {
    my gint $f = $fixed_width;

    gtk_column_view_column_set_fixed_width($!gtk-cvc, $f);
  }

  method set_header_menu (GMenuModel() $menu) is also<set-header-menu> {
    gtk_column_view_column_set_header_menu($!gtk-cvc, $menu);
  }

  method set_id (Str() $id) is also<set-id> {
    gtk_column_view_column_set_id($!gtk-cvc, $id);
  }

  method set_resizable (Int() $resizable) is also<set-resizable> {
    my gboolean $r = $resizable.so.Int;

    gtk_column_view_column_set_resizable($!gtk-cvc, $r);
  }

  method set_sorter (GtkSorter() $sorter) is also<set-sorter> {
    gtk_column_view_column_set_sorter($!gtk-cvc, $sorter);
  }

  method set_title (Str() $title) is also<set-title> {
    gtk_column_view_column_set_title($!gtk-cvc, $title);
  }

  method set_visible (Int() $visible) is also<set-visible> {
    my gboolean $v = $visible.so.Int;

    gtk_column_view_column_set_visible($!gtk-cvc, $v);
  }

}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Expander:ver<4>;

use GTK::Tree::ListModel:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkTreeExpanderAncestry is export of Mu
  where GtkTreeExpander | GtkWidgetAncestry;

class GTK::Tree::Expander:ver<4> is GTK::Widget:ver<4> {
  has GtkTreeExpander $!gtk-te is implementor;

  submethod BUILD ( :$gtk-tree-expander ) {
    self.setGtkTreeExpander($gtk-tree-expander)
      if $gtk-tree-expander
  }

  method setGtkTreeExpander (GtkTreeExpanderAncestry $_) {
    my $to-parent;

    $!gtk-te = do {
      when GtkTreeExpander {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeExpander, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeExpander
    is also<GtkTreeExpander>
  { $!gtk-te }

  multi method new (
    $gtk-tree-expander where * ~~ GtkTreeExpanderAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-expander;

    my $o = self.bless( :$gtk-tree-expander );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-tree-expander = gtk_tree_expander_new();

    my $o = $gtk-tree-expander ?? self.bless( :$gtk-tree-expander ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );GtkTreeListRow
  }

  # Type: boolean
  method hide-expander is rw  is g-property is also<hide_expander> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hide-expander', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hide-expander', $gv);
      }
    );
  }

  # Type: boolean
  method indent-for-depth is rw  is g-property is also<indent_for_depth> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indent-for-depth', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('indent-for-depth', $gv);
      }
    );
  }

  # Type: boolean
  method indent-for-icon is rw  is g-property is also<indent_for_icon> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indent-for-icon', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('indent-for-icon', $gv);
      }
    );
  }

  # Type: GtkObject
  method item ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        warn 'item does not allow writing'
      }
    );
  }

  # Type: GtkTreeListRow
  method list-row ( :$raw = False) is rw  is g-property is also<list_row> {
    my $gv = GLib::Value.new( GTK::Tree::List::Row.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('list-row', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Tree::List::Row.getTypePair
        );
      },
      STORE => -> $, GtkTreeListRow() $val is copy {
        $gv.object = $val;
        self.prop_set('list-row', $gv);
      }
    );
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_tree_expander_get_child($!gtk-te),
      $raw,
      $proper
    );
  }

  method get_hide_expander is also<get-hide-expander> {
    so gtk_tree_expander_get_hide_expander($!gtk-te);
  }

  method get_indent_for_depth is also<get-indent-for-depth> {
    gtk_tree_expander_get_indent_for_depth($!gtk-te);
  }

  method get_indent_for_icon is also<get-indent-for-icon> {
    gtk_tree_expander_get_indent_for_icon($!gtk-te);
  }

  method get_item ( :$raw = False ) is also<get-item> {
    propReturnObject(
      gtk_tree_expander_get_item($!gtk-te),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_list_row is also<get-list-row> {
    gtk_tree_expander_get_list_row($!gtk-te);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_tree_expander_set_child($!gtk-te, $child);
  }

  method set_hide_expander (Int() $hide_expander)
    is also<set-hide-expander>
  {
    my gboolean $h = $hide_expander.so.Int;

    gtk_tree_expander_set_hide_expander($!gtk-te, $h);
  }

  method set_indent_for_depth (Int() $indent_for_depth)
    is also<set-indent-for-depth>
  {
    my gboolean $i = $indent_for_depth.so.Int;

    gtk_tree_expander_set_indent_for_depth($!gtk-te, $i);
  }

  method set_indent_for_icon (Int() $indent_for_icon)
    is also<set-indent-for-icon>
  {
    my gboolean $i = $indent_for_icon.so.Int;

    gtk_tree_expander_set_indent_for_icon($!gtk-te, $i);
  }

  method set_list_row (GtkTreeListRow() $list_row) is also<set-list-row> {
    gtk_tree_expander_set_list_row($!gtk-te, $list_row);
  }

}

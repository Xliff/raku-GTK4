use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::List::Item:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

class GTK::List::Item:ver<4> {
  has GtkListItem $!gtk-li is implementor;

  # Type: boolean
  method activatable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activatable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activatable', $gv);
      }
    );
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
    );
  }

  # Type: GtkObject
  method item ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item', $gv);
        returnProperObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'item does not allow writing'
      }
    );
  }

  # Type: uint
  method position is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'position does not allow writing'
      }
    );
  }

  # Type: boolean
  method selectable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selectable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('selectable', $gv);
      }
    );
  }

  # Type: boolean
  method selected is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'selected does not allow writing'
      }
    );
  }

  method get_activatable {
    so gtk_list_item_get_activatable($!gtk-li);
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_list_item_get_child($!gtk-li),
      $raw,
      $proper
    );
  }

  method get_item ( :$raw = False ) {
    propReturnObject(
      gtk_list_item_get_item($!gtk-li),
      $raw,
      |GLib::Object.getTypePair
    )
  }

  method get_position {
    gtk_list_item_get_position($!gtk-li);
  }

  method get_selectable {
    so gtk_list_item_get_selectable($!gtk-li);
  }

  method get_selected {
    so gtk_list_item_get_selected($!gtk-li);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_item_get_type, $n, $t );
  }

  method set_activatable (Int() $activatable) {
    my gboolean $a = $activatable.so.Int;

    gtk_list_item_set_activatable($!gtk-li, $a);
  }

  method set_child (GtkWidget   $child) {
    gtk_list_item_set_child($!gtk-li, $child);
  }

  method set_selectable (Int() $selectable) {
    my gboolean $s = $selectable.so.Int;

    gtk_list_item_set_selectable($!gtk-li, $s);
  }

}

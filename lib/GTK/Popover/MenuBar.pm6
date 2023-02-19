use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Popover::MenuBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkPopoverMenuBarAncestry is export of Mu
  where GtkPopoverMenuBar | GtkWidgetAncestry;

class GTK::Popover::MenuBar:ver<4> is GTK::Widget:ver<4> {
  has GtkPopoverMenuBar $!gtk-pmb is implementor;

  submethod BUILD ( :$gtk-popover-model ) {
    self.setGtkPopoverMenuBar($gtk-popover-model) if $gtk-popover-model
  }

  method setGtkPopoverMenuBar (GtkPopoverMenuBarAncestry $_) {
    my $to-parent;

    $!gtk-pmb = do {
      when GtkPopoverMenuBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPopoverMenuBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkPopoverMenuBar
    is also<GtkPopoverMenuBar>
  { $!gtk-pmb }

  multi method new (
    $gtk-popover-model where * ~~ GtkPopoverMenuBarAncestry,

    :$ref = True
  ) {
    return unless $gtk-popover-model;

    my $o = self.bless( :$gtk-popover-model );
    $o.ref if $ref;
    $o;
  }

  method new_from_model (GMenuModel() $model) {
     my $gtk-popover-menubar = gtk_popover_menu_bar_new_from_model($model);

    $gtk-popover-menubar ?? self.bless( :$gtk-popover-menubar ) !! Nil
  }

  # Type: GMenuModel
  method menu-model is rw  is g-property {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('menu-model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        );
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('menu-model', $gv);
      }
    );
  }

  # Type: string
  method visible-submenu is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible-submenu', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('visible-submenu', $gv);
      }
    );
  }

  method add_child (GtkWidget() $child, Str() $id) {
    gtk_popover_menu_bar_add_child($!gtk-pmb, $child, $id);
  }

  method get_menu_model ( :$raw = False ) {
    propReturnObject(
      gtk_popover_menu_bar_get_menu_model($!gtk-pmb),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_popover_menu_bar_get_type, $n, $t );
  }

  method remove_child (GtkWidget() $child) {
    gtk_popover_menu_bar_remove_child($!gtk-pmb, $child);
  }

  method set_menu_model (GMenuModel() $model) {
    gtk_popover_menu_bar_set_menu_model($!gtk-pmb, $model);
  }

}

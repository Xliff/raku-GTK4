use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::PopoverMenu:ver<4>;

use GIO::MenuModel;
use GTK::Popover:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Accessible:ver<4>;

our subset GtkPopoverMenuAncestry is export of Mu
  where GtkPopoverMenu | GtkAccessible | GtkPopoverAncestry;

class GTK::PopoverMenu:ver<4> is GTK::Popover:ver<4> {
  also does GTK::Roles::Accessible;

  has GtkPopoverMenu $!gtk-pom is implementor;

  submethod BUILD ( :$gtk-popover-menu ) {
    self.setGtkPopoverMenu($gtk-popover-menu) if $gtk-popover-menu
  }

  method setGtkPopoverMenu (GtkPopoverMenuAncestry $_) {
    my $to-parent;

    $!gtk-pom = do {
      when GtkPopoverMenu {
        $to-parent = cast(GtkPopover, $_);
        $_;
      }

      when GtkAccessible {
        $to-parent = cast(GtkPopover, $_);
        $!gtk-a    = $_;
        cast(GtkPopoverMenu, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkPopoverMenu, $_);
      }
    }
    self.setGtkPopover($to-parent);
    self.roleInit-GtkAccessible;
  }

  method GTK::Raw::Definitions::GtkPopoverMenu
    is also<GtkPopoverMenu>
  { $!gtk-pom }

  multi method new (
    $gtk-popover-menu where * ~~ GtkPopoverMenuAncestry,

    :$ref = True
  ) {
    return unless $gtk-popover-menu;

    my $o = self.bless( :$gtk-popover-menu );
    $o.ref if $ref;
    $o;
  }

  method new_from_model (GMenuModel() $model) is also<new-from-model> {
    my $gtk-popover-menu = gtk_popover_menu_new_from_model($model);

    $gtk-popover-menu ?? self.bless( :$gtk-popover-menu ) !! Nil;
  }

  method new_from_model_full (GMenuModel() $model, Int() $flags)
    is also<new-from-model-full>
  {
    my GtkPopoverMenuFlags $f = $flags;

    my $gtk-popover-menu = gtk_popover_menu_new_from_model_full(
      $model,
      $flags
    );

    $gtk-popover-menu ?? self.bless( :$gtk-popover-menu ) !! Nil;
  }

  # Type: GMenuModel
  method menu-model ( :$raw = False )
    is rw
    is g-property
    is also<menu_model>
  {
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
  method visible-submenu is rw  is g-property is also<visible_submenu> {
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

  method add_child (GtkWidget() $child, Str() $id) is also<add-child> {
    gtk_popover_menu_add_child($!gtk-pom, $child, $id);
  }

  method get_menu_model ( :$raw = False ) is also<get-menu-model> {
    propReturnObject(
      gtk_popover_menu_get_menu_model($!gtk-pom),
      $raw,
      |GLib::MenuModel.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_popover_menu_get_type, $n, $t );
  }

  method remove_child (GtkWidget() $child) is also<remove-child> {
    gtk_popover_menu_remove_child($!gtk-pom, $child);
  }

  method set_menu_model (GMenuModel() $model) is also<set-menu-model> {
    gtk_popover_menu_set_menu_model($!gtk-pom, $model);
  }

}

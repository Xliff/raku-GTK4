use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::MenuButton:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkMenuButtonAncestry is export of Mu
  where GtkMenuButton | GtkWidgetAncestry;

class GTK::MenuButton is GTK::Widget:ver<4> {
  has GtkMenuButton $!gtk-mb is implementor;

  submethod BUILD ( :$gtk-menu-button ) {
    self.setGtkMenuButton($gtk-menu-button) if $gtk-menu-button
  }

  method setGtkMenuButton (GtkMenuButtonAncestry $_) {
    my $to-parent;

    $!gtk-mb = do {
      when GtkMenuButton {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMenuButton, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkMenuButton
    is also<GtkMenuButton>
  { $!gtk-mb }

  multi method new (
    $gtk-menu-button where * ~~ GtkMenuButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-menu-button;

    my $o = self.bless( :$gtk-menu-button );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-menu-button = gtk_menu_button_new();

    $gtk-menu-button ?? self.bless( :$gtk-menu-button ) !! Nil;
  }

  # Type: boolean
  method always-show-arrow is rw  is g-property is also<always_show_arrow> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('always-show-arrow', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('always-show-arrow', $gv);
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

  # Type: GtkArrowType
  method direction ( :$enum = True ) is rw is g-property {
    my $gv = GLib::Value.new-enum(GtkArrowType);
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('direction', $gv);
        my $d = $gv.enum;
        return $d unless $enum;
        GtkArrowType($d);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkArrowType) = $val;
        self.prop_set('direction', $gv);
      }
    );
  }

  # Type: boolean
  method has-frame is rw  is g-property is also<has_frame> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-frame', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-frame', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: GtkMenuModel
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

  # Type: GtkPopover
  method popover (:$raw = False )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Popover.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('popover', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Popover.getTypePair
        );
      },
      STORE => -> $, GtkPopover() $val is copy {
        $gv.object = $val;
        self.prop_set('popover', $gv);
      }
    );
  }

  # Type: boolean
  method primary is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('primary', $gv);
      }
    );
  }

  # Type: boolean
  method use-underline is rw  is g-property is also<use_underline> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-underline', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-underline', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-mb, 'activate');
  }

  method get_always_show_arrow is also<get-always-show-arrow> {
    so gtk_menu_button_get_always_show_arrow($!gtk-mb);
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_menu_button_get_child($!gtk-mb),
      $raw,
      $proper
    );
  }

  method get_direction ( :$enum = True ) is also<get-direction> {
    my $d = gtk_menu_button_get_direction($!gtk-mb);
    return $d unless $enum;
    GtkArrowTypeEnum($d);
  }

  method get_has_frame is also<get-has-frame> {
    so gtk_menu_button_get_has_frame($!gtk-mb);
  }

  method get_icon_name is also<get-icon-name> {
    gtk_menu_button_get_icon_name($!gtk-mb);
  }

  method get_label is also<get-label> {
    gtk_menu_button_get_label($!gtk-mb);
  }

  method get_menu_model ( :$raw = False ) is also<get-menu-model> {
    propReturnObject(
      gtk_menu_button_get_menu_model($!gtk-mb),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_popover ( :$raw = False ) is also<get-popover> {
    propReturnObject(
      gtk_menu_button_get_popover($!gtk-mb),
      $raw,
      |GTK::Popover.getTypePair
    );
  }

  method get_primary is also<get-primary> {
    so gtk_menu_button_get_primary($!gtk-mb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &gtk_menu_button_get_type, $n, $t );
  }

  method get_use_underline is also<get-use-underline> {
    so gtk_menu_button_get_use_underline($!gtk-mb);
  }

  method popdown {
    gtk_menu_button_popdown($!gtk-mb);
  }

  method popup {
    gtk_menu_button_popup($!gtk-mb);
  }

  method set_always_show_arrow (Int() $always_show_arrow)
    is also<set-always-show-arrow>
  {
    my gboolean $a = $always_show_arrow.so.Int;

    gtk_menu_button_set_always_show_arrow($!gtk-mb, $a);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_menu_button_set_child($!gtk-mb, $child);
  }

  method set_create_popup_func (
             &func,
    gpointer $user_data      = gpointer,
             &destroy_notify = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-create-popup-func>
  {
    gtk_menu_button_set_create_popup_func(
      $!gtk-mb,
      &func,
      $user_data,
      &destroy_notify
    );
  }

  method set_direction (Int() $direction) is also<set-direction> {
    my GtkArrowType $d = $direction.so.Int;

    gtk_menu_button_set_direction($!gtk-mb, $d);
  }

  method set_has_frame (Int() $has_frame) is also<set-has-frame> {
    my gboolean $h = $has_frame.so.Int;

    gtk_menu_button_set_has_frame($!gtk-mb, $h);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gtk_menu_button_set_icon_name($!gtk-mb, $icon_name);
  }

  method set_label (Str() $label) is also<set-label> {
    gtk_menu_button_set_label($!gtk-mb, $label);
  }

  method set_menu_model (GMenuModel() $menu_model) is also<set-menu-model> {
    gtk_menu_button_set_menu_model($!gtk-mb, $menu_model);
  }

  method set_popover (GtkWidget() $popover) is also<set-popover> {
    gtk_menu_button_set_popover($!gtk-mb, $popover);
  }

  method set_primary (Int() $primary) is also<set-primary> {
    my gboolean $p = $primary.so.Int;

    gtk_menu_button_set_primary($!gtk-mb, $p);
  }

  method set_use_underline (Int() $use_underline) is also<set-use-underline> {
    my gboolean $u = $use_underline.so.Int;

    gtk_menu_button_set_use_underline($!gtk-mb, $u);
  }

}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

our subset GtkShortcutsShortcutAncestry is export of Mu
  where GtkShortcutsShortcut | GtkWidgetAncestry;

class GTK::Shortcut::Shortcut:ver<4> is GTK::Widget:ver<4> {
  has GtkShortcutsShortcut $!gtk-ss is implementor;

  submethod BUILD ( :$gtk-shortcuts-shortcut ) {
    self.setGtkShortcutsShortcut($gtk-shortcuts-shortcut)
      if $gtk-shortcuts-shortcut
  }

  method setGtkShortcutsShortcut (GtkShortcutsShortcutAncestry $_) {
    my $to-parent;

    $!gtk-ss = do {
      when GtkShortcutsShortcut {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutsShortcut, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutsShortcut
    is also<GtkShortcutsShortcut>
  { $!gtk-ss }

  multi method new (
    $gtk-shortcuts-shortcut where * ~~ GtkShortcutsShortcutAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcuts-shortcut;

    my $o = self.bless( :$gtk-shortcuts-shortcut );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-shortcuts-shortcut = ::?CLASS.new-object-ptr(self.get_type);

    $gtk-shortcuts-shortcut ?? self.bless( :$gtk-shortcuts-shortcut )
                            !! Nil;
  }

  # Type: GtkSizeGroup
  method accel-size-group is rw  is g-property is also<accel_size_group> {
    my $gv = GLib::Value.new( GTK::SizeGroup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'accel-size-group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.object = $val;
        self.prop_set('accel-size-group', $gv);
      }
    );
  }

  # Type: string
  method accelerator is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accelerator', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accelerator', $gv);
      }
    );
  }

  # Type: string
  method action-name is rw  is g-property is also<action_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('action-name', $gv);
      }
    );
  }

  # Type: GtkTextDirection
  method direction ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkTextDirection );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('direction', $gv);
        my $d = $gv.enum;
        return $d unless $enum;
        GtkTextDirectionEnum($d);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkTextDirection) = $val;
        self.prop_set('direction', $gv);
      }
    );
  }

  # Type: GIcon
  method icon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
        );
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: boolean
  method icon-set is rw  is g-property is also<icon_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('icon-set', $gv);
      }
    );
  }

  # Type: GtkShortcutType
  method shortcut-type ( :$enum = True )
    is rw
    is g-property
    is also<shortcut_type>
  {
    my $gv = GLib::Value.new-enum( GtkShortcutType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shortcut-type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkShortcutTypeEnum($t)
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(GtkShortcutType) = $val;
        self.prop_set('shortcut-type', $gv);
      }
    );
  }

  # Type: string
  method subtitle is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('subtitle', $gv);
      }
    );
  }

  # Type: boolean
  method subtitle-set is rw  is g-property is also<subtitle_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('subtitle-set', $gv);
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

  # Type: GtkSizeGroup
  method title-size-group is rw  is g-property is also<title_size_group> {
    my $gv = GLib::Value.new( GTK::SizeGroup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'title-size-group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.object = $val;
        self.prop_set('title-size-group', $gv);
      }
    );
  }

}

# No raws, so source tag goes here.
### /usr/src/gtk4/gtk/gtkshortcutsshortcut.h

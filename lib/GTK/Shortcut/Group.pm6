use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Box:ver<4>;

use GLib::Roles::Implementor;

our subset GtkShortcutsGroupAncestry is export of Mu
  where GtkShortcutsGroup | GtkBoxAncestry;

class GTK::Shortcuts::Group:ver<4> is GTK::Box:ver<4> {
  has GtkShortcutsGroup $!gtk-sg is implementor;

  submethod BUILD ( :$gtk-shortcuts-group ) {
    self.setGtkShortcutsGroup($gtk-shortcuts-group)
      if $gtk-shortcuts-group
  }

  method setGtkShortcutsGroup (GtkShortcutsGroupAncestry $_) {
    my $to-parent;

    $!gtk-sg = do {
      when GtkShortcutsGroup {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutsGroup, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutsGroup
    is also<GtkShortcutsGroup>
  { $!gtk-sg }

  multi method new (
    $gtk-shortcuts-group where * ~~ GtkShortcutsGroupAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcuts-group;

    my $o = self.bless( :$gtk-shortcuts-group );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-shortcuts-group = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    $gtk-shortfcuts-group ?? self.bless( :$gtk-shortfcuts-group ) !! Nil;
  }

  # Type: GtkSizeGroup
  method accel-size-group is rw  is g-property is also<accel_size_group> {
    my $gv = GLib::Value.new-enum( GtkSizeGroup );
    Proxy.new(
      FETCH => sub ($) {
        warn 'accel-size-group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSizeGroup) = $val;
        self.prop_set('accel-size-group', $gv);
      }
    );
  }

  # Type: uint
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'height does not allow writing'
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
    my $gv = GLib::Value.new-enum( GtkSizeGroup );
    Proxy.new(
      FETCH => sub ($) {
        warn 'title-size-group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSizeGroup) = $val;
        self.prop_set('title-size-group', $gv);
      }
    );
  }

  # Type: string
  method view is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_shortcuts_group_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gtk/gtkshortcutsgroup.h

sub gtk_shortcuts_group_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

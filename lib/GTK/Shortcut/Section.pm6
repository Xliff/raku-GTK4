use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Box:ver<4>;

use GLib::Roles::Implementor;

our subset GtkShortcutsSectionAncestry is export of Mu
  where GtkShortcutsSection | GtkBoxAncestry;

class GTK::Shortcut::Section:ver<4> is GTK::Box:ver<4> {
  has GtkShortcutsSection $!gtk-ss is implementor;

  submethod BUILD ( :$gtk-shortcut-section ) {
    self.setGtkShortcutsSection($gtk-shortcut-section)
      if $gtk-shortcut-section
  }

  method setGtkShortcutsSection (GtkShortcutsSectionAncestry $_) {
    my $to-parent;

    $!gtk-ss = do {
      when GtkShortcutsSection {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutsSection, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutsSection
    is also<GtkShortcutsSection>
  { $!gtk-ss }

  multi method new (
    $gtk-shortcut-section where * ~~ GtkShortcutsSectionAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcut-section;

    my $o = self.bless( :$gtk-shortcut-section );
    $o.ref if $ref;
    $o;
  }
  multi method new (*%hash) {
    my $gtk-shortcut-section = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    my $o = $gtk-shortcut-section ?? self.bless( :$gtk-shortcut-section )
                                  !! Nil;

    $o.setAttributes(%hash) if +%hash;
    $o;
  }

  # Type: uint
  method max-height is rw  is g-property is also<max_height> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-height', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('max-height', $gv);
      }
    );
  }

  # Type: string
  method section-name is rw  is g-property is also<section_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('section-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('section-name', $gv);
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

  # Type: string
  method view-name is rw  is g-property is also<view_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view-name', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_shortcuts_section_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gtk/gtkshortcutssection.h

sub gtk_shortcuts_section_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Entry:ver<4>;

use GLib::Roles::Implementor;
use GIO::MenuModel;

our subset GtkPasswordEntryAncestry is export of Mu
  where GtkPasswordEntry | GtkEntryAncestry;

class GTK::Entry::Password:ver<4> is GTK::Entry:ver<4> {
  has GtkPasswordEntry $!gtk-pe is implementor;

  submethod BUILD ( :$gtk-password-entry ) {
    self.setGtkPasswordEntry($gtk-password-entry)
      if $gtk-password-entry
  }

  method setGtkPasswordEntry (GtkPasswordEntryAncestry $_) {
    my $to-parent;

    $!gtk-pe = do {
      when GtkPasswordEntry {
        $to-parent = cast(GtkEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPasswordEntry, $_);
      }
    }
    self.setGtkEntry($to-parent);
  }

  method GTK::Raw::Definitions::GtkPasswordEntry
    is also<GtkPasswordEntry>
  { $!gtk-pe }

  multi method new (
    $gtk-password-entry where * ~~ GtkPasswordEntryAncestry,

    :$ref = True
  ) {
    return unless $gtk-password-entry;

    my $o = self.bless( :$gtk-password-entry );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-password-entry = gtk_password_entry_new();

    $gtk-password-entry ?? self.bless( :$gtk-password-entry ) !! Nil;
  }

  # Type: boolean
  method activates-default is rw  is g-property is also<activates_default> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activates-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activates-default', $gv);
      }
    );
  }

  # Type: GtkMenuModel
  method extra-menu ( :$raw = False )
    is rw
    is g-property
    is also<extra_menu>
  {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('extra-menu', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        );
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('extra-menu', $gv);
      }
    );
  }

  # Type: string
  method placeholder-text is rw  is g-property is also<placeholder_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('placeholder-text', $gv);
      }
    );
  }

  # Type: boolean
  method show-peek-icon is rw  is g-property is also<show_peek_icon> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-peek-icon', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-peek-icon', $gv);
      }
    );
  }

  method get_extra_menu ( :$raw = False ) is also<get-extra-menu> {
    propReturnObject(
      gtk_password_entry_get_extra_menu($!gtk-pe),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_show_peek_icon is also<get-show-peek-icon> {
    so gtk_password_entry_get_show_peek_icon($!gtk-pe);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_password_entry_get_type, $n, $t );
  }

  method set_extra_menu (GMenuModel() $model) is also<set-extra-menu> {
    gtk_password_entry_set_extra_menu($!gtk-pe, $model);
  }

  method set_show_peek_icon (Int() $show_peek_icon)
    is also<set-show-peek-icon>
  {
    my gboolean $s = $show_peek_icon;

    gtk_password_entry_set_show_peek_icon($!gtk-pe, $s);
  }

}

### /usr/src/gtk4/gtk/gtkpasswordentry.h

sub gtk_password_entry_get_extra_menu (GtkPasswordEntry $entry)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_password_entry_get_show_peek_icon (GtkPasswordEntry $entry)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_password_entry_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_password_entry_new
  returns GtkPasswordEntry
  is      native(gtk4)
  is      export
{ * }

sub gtk_password_entry_set_extra_menu (
  GtkPasswordEntry $entry,
  GMenuModel       $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_password_entry_set_show_peek_icon (
  GtkPasswordEntry $entry,
  gboolean         $show_peek_icon
)
  is      native(gtk4)
  is      export
{ * }

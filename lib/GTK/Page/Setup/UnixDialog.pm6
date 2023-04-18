use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Page::Setup::UnixDialog:ver<4>;

use GTK::Dialog:ver<4>;

use GLib::Roles::Implementor;

our subset GtkPageSetupUnixDialogAncestry is export of Mu
  where GtkPageSetupUnixDialog | GtkDialog;

class GTK::Page::Setup::UnixDialog:ver:<4> is GTK::Dialog:ver<4> {
  has GtkPageSetupUnixDialog $!gtk-psd is implementor;

  submethod BUILD ( :$gtk-page-setup ) {
    self.setGtkPageSetup($gtk-page-setup) if $gtk-page-setup
  }

  method setGtkPageSetup (GtkPageSetupUnixDialogAncestry $_) {
    my $to-parent;

    $!gtk-psd = do {
      when GtkPageSetup {
        $to-parent = cast(GtkDialog, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPageSetup, $_);
      }
    }
    self.set-GtkDialog($to-parent);
  }

  method GTK::Raw::Definitions::GtkPageSetup
    is also<GtkPageSetup>
  { $!gtk-psd }

  proto method new (|)
  { * }

  multi method new (
     $gtk-page-setup where * ~~ GtkPageSetupUnixDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-page-setup;

    my $o = self.bless( :$gtk-page-setup );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkWindow() $parent) {
    my $gtk-page-setup = gtk_page_setup_unix_dialog_new($!gtk-psd, $parent);

    $gtk-page-setup ?? self.bless( :$gtk-page-setup ) !! Nil;
  }

  method page_setup is rw is g-accessor is also<page-setup> {
    Proxy.new:
      FETCH => -> $     { self.get_page_setup    },
      STORE => -> $, \v { self.set_page_setup(v) }
  }

  method print_settings is rw is g-accessor is also<print-settings> {
    Proxy.new:
      FETCH => -> $     { self.get_print_settings    },
      STORE => -> $, \v { self.set_print_settings(v) }
  }

  method get_page_setup ( :$raw = False ) is also<get-page-setup> {
    propReturnObject(
      gtk_page_setup_unix_dialog_get_page_setup($!gtk-psd),
      $raw,
      |GTK::Page::Setup.getTypePair
    );
  }

  method get_print_settings ( :$raw = False ) is also<get-print-settings> {
    propReturnObject(
      gtk_page_setup_unix_dialog_get_print_settings($!gtk-psd),
      $raw,
      |GTK::Print::Settings.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_page_setup_unix_dialog_get_type,
      $n,
      $t
    );
  }

  method set_page_setup (GtkPageSetup() $page_setup)
    is also<set-page-setup>
  {
    gtk_page_setup_unix_dialog_set_page_setup($!gtk-psd, $page_setup);
  }

  method set_print_settings (GtkPrintSettings() $print_settings)
    is also<set-print-settings>
  {
    gtk_page_setup_unix_dialog_set_print_settings(
      $!gtk-psd,
      $print_settings
    );
  }

}

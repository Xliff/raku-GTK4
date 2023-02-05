use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Print::UnixDialog:ver<4>;

use GTK::Dialog:ver<4>;
use GTK::Page::Setup:ver<4>;
use GTK::Print::Settings:ver<4>;
use GTK::Printer:ver<4>;

use GLib::Roles::Implementor;

our subset GtkPrintUnixDialogAncestry is export of Mu
  where GtkPrintUnixDialog | GtkDialogAncestry;

class GTK::Print::UnixDialog:ver<4> is GTK::Dialog:ver<4> {
  has GtkPrintUnixDialog $!gtk-pud is implementor;

  submethod BUILD ( :$gtk-print-unixdialog ) {
    self.setGtkPrintUnixDialog($gtk-print-unixdialog)
      if $gtk-print-unixdialog
  }

  method setGtkPrintUnixDialog (GtkPrintUnixDialogAncestry $_) {
    my $to-parent;

    $!gtk-pud = do {
      when GtkPrintUnixDialog {
        $to-parent = cast(GtkDialog, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrintUnixDialog, $_);
      }
    }
    self.setGtkDialog($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrintUnixDialog
    is also<GtkPrintUnixDialog>
  { $!gtk-pud }

  multi method new (
    $gtk-print-unixdialog where * ~~ GtkPrintUnixDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-print-unixdialog;

    my $o = self.bless( :$gtk-print-unixdialog );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $title, GtkWindow() $parent = GtkWindow) {
    my $gtk-print-unixdialog = gtk_print_unix_dialog_new($title, $parent);

    $gtk-print-unixdialog ?? self.bless( :$gtk-print-unixdialog ) !! Nil;
  }

  # Type: int
  method current-page is rw  is g-property is also<current_page> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('current-page', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('current-page', $gv);
      }
    );
  }

  # Type: boolean
  method embed-page-setup is rw  is g-property is also<embed_page_setup> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('embed-page-setup', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('embed-page-setup', $gv);
      }
    );
  }

  # Type: boolean
  method has-selection is rw  is g-property is also<has_selection> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-selection', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-selection', $gv);
      }
    );
  }

  # Type: GtkPrintCapabilities
  method manual-capabilities ( :set(:$flags) = True )
    is rw
    is g-property
    is also<manual_capabilities>
  {
    my $gv = GLib::Value.new-enum( GtkPrintCapabilities );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('manual-capabilities', $gv);
        my $f = $gv.flags;
        return $f unless $flags;
        getFlags(GtkPrintCapabilitiesEnum, $f);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPrintCapabilities) = $val;
        self.prop_set('manual-capabilities', $gv);
      }
    );
  }

  # Type: GtkPageSetup
  method page-setup ( :$raw = False )
    is rw
    is g-property
    is also<page_setup>
  {
    my $gv = GLib::Value.new( GTK::Page::Setup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page-setup', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Page::Setup.getTypePair
        );
      },
      STORE => -> $, GtkPageSetup() $val is copy {
        $gv.object = $val;
        self.prop_set('page-setup', $gv);
      }
    );
  }

  # Type: GtkPrintSettings
  method print-settings ( :$raw = False )
    is rw
    is g-property
    is also<print_settings>
  {
    my $gv = GLib::Value.new( GTK::Print::Settings.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('print-settings', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Print::Settings.getTypePair
        )
      },
      STORE => -> $, GtkPrintSettings() $val is copy {
        $gv.object = $val;
        self.prop_set('print-settings', $gv);
      }
    );
  }

  # Type: GtkPrinter
  method selected-printer ( :$raw = False )
    is rw
    is g-property
    is also<selected_printer>
  {
    my $gv = GLib::Value.new( GTK::Printer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected-printer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GTK::Printer.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'selected-printer does not allow writing'
      }
    );
  }

  # Type: boolean
  method support-selection is rw  is g-property is also<support_selection> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('support-selection', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('support-selection', $gv);
      }
    );
  }

  method add_custom_tab (GtkWidget() $child, GtkWidget() $tab_label)
    is also<add-custom-tab>
  {
    gtk_print_unix_dialog_add_custom_tab($!gtk-pud, $child, $tab_label);
  }

  method get_current_page is also<get-current-page> {
    gtk_print_unix_dialog_get_current_page($!gtk-pud);
  }

  method get_embed_page_setup is also<get-embed-page-setup> {
    so gtk_print_unix_dialog_get_embed_page_setup($!gtk-pud);
  }

  method get_has_selection is also<get-has-selection> {
    so gtk_print_unix_dialog_get_has_selection($!gtk-pud);
  }

  method get_manual_capabilities ( :set(:$flags) = True )
    is also<get-manual-capabilities>
  {
    my $c = gtk_print_unix_dialog_get_manual_capabilities($!gtk-pud);
    return $c unless $flags;
    getFlags(GtkPrintCapabilitiesEnum, $c);
  }

  method get_page_setup ( :$raw = False ) is also<get-page-setup> {
    propReturnObject(
      gtk_print_unix_dialog_get_page_setup($!gtk-pud),
      $raw,
      |GTK::Page::Setup.getTypePair
    );
  }

  method get_page_setup_set is also<get-page-setup-set> {
    so gtk_print_unix_dialog_get_page_setup_set($!gtk-pud);
  }

  method get_selected_printer ( :$raw = False ) is also<get-selected-printer> {
    propReturnObject(
      gtk_print_unix_dialog_get_selected_printer($!gtk-pud),
      $raw,
      |GTK::Printer.getTypePair
    );
  }

  method get_settings ( :$raw = False ) is also<get-settings> {
    propReturnObject(
      gtk_print_unix_dialog_get_settings($!gtk-pud),
      $raw,
      |GTK::Print::Setting.getTypePair
    );
  }

  method get_support_selection is also<get-support-selection> {
    so gtk_print_unix_dialog_get_support_selection($!gtk-pud);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_unix_dialog_get_type, $n, $t );
  }

  method set_current_page (Int() $current_page) is also<set-current-page> {
    my gint $c = $current_page;
    gtk_print_unix_dialog_set_current_page($!gtk-pud, $current_page);
  }

  method set_embed_page_setup (Int() $embed) is also<set-embed-page-setup> {
    my gboolean $e = $embed.so.Int;

    gtk_print_unix_dialog_set_embed_page_setup($!gtk-pud, $e);
  }

  method set_has_selection (Int() $has_selection) is also<set-has-selection> {
    my gboolean $h = $has_selection.so.Int;

    gtk_print_unix_dialog_set_has_selection($!gtk-pud, $h);
  }

  method set_manual_capabilities (Int() $capabilities)
    is also<set-manual-capabilities>
  {
    my GtkPrintCapabilities $c = $capabilities;

    gtk_print_unix_dialog_set_manual_capabilities($!gtk-pud, $c);
  }

  method set_page_setup (GtkPageSetup() $page_setup) is also<set-page-setup> {
    gtk_print_unix_dialog_set_page_setup($!gtk-pud, $page_setup);
  }

  method set_settings (GtkPrintSettings() $settings) is also<set-settings> {
    gtk_print_unix_dialog_set_settings($!gtk-pud, $settings);
  }

  method set_support_selection (Int() $support_selection)
    is also<set-support-selection>
  {
    my gboolean $s = $support_selection.so.Int;

    gtk_print_unix_dialog_set_support_selection($!gtk-pud, $s);
  }

}

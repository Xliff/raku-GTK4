use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Print::Operation:ver<4>;

use GTK::Page::Setup;
use GTK::Print::Settings;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Print::Operation::Preview:ver<4>;

class GTK::Print::Operation:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Print::Operation::Preview;

  has GtkPrintOperation $!gtk-po is implementor;

  method new {
    my $gtk-print-operation = gtk_print_operation_new();

    $gtk-print-operation ?? self.bless( :$gtk-print-operation ) !! Nil;
  }

  # Type: boolean
  method allow-async is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('allow-async', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('allow-async', $gv);
      }
    );
  }

  # Type: int
  method current-page is rw  is g-property {
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

  # Type: string
  method custom-tab-label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('custom-tab-label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('custom-tab-label', $gv);
      }
    );
  }

  # Type: GtkPageSetup
  method default-page-setup ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::PageSetup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-page-setup', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::PageSetup.getTypePair
        );
      },
      STORE => -> $, GtkPageSetup() $val is copy {
        $gv.object = $val;
        self.prop_set('default-page-setup', $gv);
      }
    );
  }

  # Type: boolean
  method embed-page-setup is rw  is g-property {
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

  # Type: string
  method export-filename is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('export-filename', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('export-filename', $gv);
      }
    );
  }

  # Type: boolean
  method has-selection is rw  is g-property {
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

  # Type: string
  method job-name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('job-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('job-name', $gv);
      }
    );
  }

  # Type: int
  method n-pages is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-pages', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('n-pages', $gv);
      }
    );
  }

  # Type: int
  method n-pages-to-print is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-pages-to-print', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-pages-to-print does not allow writing'
      }
    );
  }

  # Type: GtkPrintSettings
  method print-settings ( :$raw = False ) is rw  is g-property {
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

  # Type: boolean
  method show-progress is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-progress', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-progress', $gv);
      }
    );
  }

  # Type: GtkPrintStatus
  method status ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkPrintStatus );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('status', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GtkPrintStatusEnum($s);
      },
      STORE => -> $,  $val is copy {
        warn 'status does not allow writing'
      }
    );
  }

  # Type: string
  method status-string is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('status-string', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'status-string does not allow writing'
      }
    );
  }

  # Type: boolean
  method support-selection is rw  is g-property {
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

  # Type: boolean
  method track-print-status is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('track-print-status', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('track-print-status', $gv);
      }
    );
  }

  # Type: GtkUnit
  method unit ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkUnit );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('unit', $gv);
        my $u = $gv.enum;
        return $u unless $enum;
        GtkUnitEnum($u);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkUnit) = $val;
        self.prop_set('unit', $gv);
      }
    );
  }

  # Type: boolean
  method use-full-page is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-full-page', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-full-page', $gv);
      }
    );
  }

  method cancel {
    gtk_print_operation_cancel($!gtk-po);
  }

  method draw_page_finish {
    gtk_print_operation_draw_page_finish($!gtk-po);
  }

  method get_default_page_setup ( :$raw = False ) {
    propReturnObject(
      gtk_print_operation_get_default_page_setup($!gtk-po),
      $raw,
      |GTK::Page::Setup.getTypePair
    );
  }

  method get_embed_page_setup {
    so gtk_print_operation_get_embed_page_setup($!gtk-po);
  }

  method get_error (CArray[Pointer[GError]] $error = gerror) {
    gtk_print_operation_get_error($!gtk-po, $error);
  }

  method get_has_selection {
    so gtk_print_operation_get_has_selection($!gtk-po);
  }

  method get_n_pages_to_print {
    gtk_print_operation_get_n_pages_to_print($!gtk-po);
  }

  method get_print_settings ( :$raw = False ) {
    propReturnObject(
      gtk_print_operation_get_print_settings($!gtk-po),
      $raw,
      |GTK::Print::Settings.getTypePair
    );
  }

  method get_status ( :$enum = True ) {
    my $s = gtk_print_operation_get_status($!gtk-po);
    return $s unless $enum;
    GtkPrintStatusEnum($s);
  }

  method get_status_string {
    gtk_print_operation_get_status_string($!gtk-po);
  }

  method get_support_selection {
    so gtk_print_operation_get_support_selection($!gtk-po);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_operation_get_type, $n, $t );
  }

  method is_finished {
    so gtk_print_operation_is_finished($!gtk-po);
  }

  method run (
    Int()                   $action,
    GtkWindow()             $parent  = GtkWindow,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my GtkPrintOperationAction $a = $action;

    clear_error;
    my $rv = gtk_print_operation_run($!gtk-po, $action, $parent, $error);
    set_error($error);
    $rv;
  }

  method set_allow_async (Int() $allow_async) {
    my gboolean $a = $allow_async.so.Int;

    gtk_print_operation_set_allow_async($!gtk-po, $a);
  }

  method set_current_page (Int() $current_page) {
    my gint $c = $current_page;

    gtk_print_operation_set_current_page($!gtk-po, $current_page);
  }

  method set_custom_tab_label (Str() $label) {
    gtk_print_operation_set_custom_tab_label($!gtk-po, $label);
  }

  method set_default_page_setup (GtkPageSetup() $default_page_setup) {
    gtk_print_operation_set_default_page_setup($!gtk-po, $default_page_setup);
  }

  method set_defer_drawing {
    gtk_print_operation_set_defer_drawing($!gtk-po);
  }

  method set_embed_page_setup (Int() $embed) {
    my gboolean $e = $embed.so.Int;

    gtk_print_operation_set_embed_page_setup($!gtk-po, $e);
  }

  method set_export_filename (Str() $filename) {
    gtk_print_operation_set_export_filename($!gtk-po, $filename);
  }

  method set_has_selection (Int() $has_selection) {
    my gboolean $h = $has_selection.so.Int;

    gtk_print_operation_set_has_selection($!gtk-po, $h);
  }

  method set_job_name (Str() $job_name) {
    gtk_print_operation_set_job_name($!gtk-po, $job_name);
  }

  method set_n_pages (Int() $n_pages) {
    my gint $n = $n_pages;

    gtk_print_operation_set_n_pages($!gtk-po, $n);
  }

  method set_print_settings (GtkPrintSettings() $print_settings) {
    gtk_print_operation_set_print_settings($!gtk-po, $print_settings);
  }

  method set_show_progress (Int() $show_progress) {
    my gboolean $s = $show_progress.so.Int;

    gtk_print_operation_set_show_progress($!gtk-po, $s);
  }

  method set_support_selection (Int() $support_selection) {
    my gboolean $s = $support_selection.so.Int;

    gtk_print_operation_set_support_selection($!gtk-po, $s);
  }

  method set_track_print_status (Int() $track_status) {
    my gboolean $t = $track_status.so.Int;

    gtk_print_operation_set_track_print_status($!gtk-po, $t);
  }

  method set_unit (Int() $unit) {
    gtk_print_operation_set_unit($!gtk-po, $unit);
  }

  method set_use_full_page (Int() $full_page) {
    my gboolean $f = $full_page.so.Int;

    gtk_print_operation_set_use_full_page($!gtk-po, $f);
  }

}


# cw: What was the intended purpose of this class?
# class GTK::Print::Run {
#
#   method error_quark is static {
#     gtk_print_error_quark();
#   }
#
#   method dialog (GtkPageSetup() $page_setup, GtkPrintSettings() $settings) {
#     setup_dialog($!gtk-po, $page_setup, $settings);
#   }
#
#   method dialog_async (
#     GtkPageSetup()     $page_setup,
#     GtkPrintSettings() $settings,
#                        &done_cb,
#     gpointer           $data        = gpointer
#   ) {
#     setup_dialog_async($!gtk-po, $page_setup, $settings, &done_cb, $data);
#   }
#
# }

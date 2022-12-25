use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Print::Settings:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Print::Settings {
  also does GLib::Roles::Object;

  has GtkPrintSettings $!gtk-pset is implementor;

  method new {
    my $gtk-print-settings = gtk_print_settings_new();

    $gtk-print-settings ?? self.bless( :$gtk-print-settings ) !! Nil
  }

  method new_from_file (
    Str()                   $file_name,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    clear_error;
    my $gtk-print-settings = gtk_print_settings_new_from_file(
      $file_name,
      $error
    );
    set_error($error);

    $gtk-print-settings ?? self.bless( :$gtk-print-settings ) !! Nil
  }

  method new_from_gvariant (GVariant() $variant) {
    my $gtk-print-settings = gtk_print_settings_new_from_gvariant($variant);

    $gtk-print-settings ?? self.bless( :$gtk-print-settings ) !! Nil
  }

  method new_from_key_file (
    GKeyFile()              $key_file,
    Str()                   $group_name,
    CArray[Pointer[GError]] $error        = gerror;
  ) {
    clear_error;
    my $gtk-print-settings = gtk_print_settings_new_from_key_file(
      $key_file,
      $group_name,
      $error
    );
    set_error($error);

    $gtk-print-settings ?? self.bless( :$gtk-print-settings ) !! Nil
  }

  method bool is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_bool    },
      STORE => -> $, \v { self.set_bool(v) }
  }

  method collate is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_collate    },
      STORE => -> $, \v { self.set_collate(v) }
  }

  method default_source is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_default_source    },
      STORE => -> $, \v { self.set_default_source(v) }
  }

  method dither is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_dither    },
      STORE => -> $, \v { self.set_dither(v) }
  }

  method double is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_double    },
      STORE => -> $, \v { self.set_double(v) }
  }

  method duplex is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_duplex    },
      STORE => -> $, \v { self.set_duplex(v) }
  }

  method finishings is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_finishings    },
      STORE => -> $, \v { self.set_finishings(v) }
  }

  method int is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_int    },
      STORE => -> $, \v { self.set_int(v) }
  }

  method length is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_length    },
      STORE => -> $, \v { self.set_length(v) }
  }

  method media_type is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_media_type    },
      STORE => -> $, \v { self.set_media_type(v) }
  }

  method n_copies is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_n_copies    },
      STORE => -> $, \v { self.set_n_copies(v) }
  }

  method number_up is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_number_up    },
      STORE => -> $, \v { self.set_number_up(v) }
  }

  method number_up_layout is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_number_up_layout    },
      STORE => -> $, \v { self.set_number_up_layout(v) }
  }

  method orientation is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_orientation    },
      STORE => -> $, \v { self.set_orientation(v) }
  }

  method output_bin is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_output_bin    },
      STORE => -> $, \v { self.set_output_bin(v) }
  }

  method page_ranges is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_page_ranges    },
      STORE => -> $, \v { self.set_page_ranges(v) }
  }

  method page_set is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_page_set    },
      STORE => -> $, \v { self.set_page_set(v) }
  }

  method paper_height is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_paper_height    },
      STORE => -> $, \v { self.set_paper_height(v) }
  }

  method paper_size is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_paper_size    },
      STORE => -> $, \v { self.set_paper_size(v) }
  }

  method paper_width is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_paper_width    },
      STORE => -> $, \v { self.set_paper_width(v) }
  }

  method print_pages is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_print_pages    },
      STORE => -> $, \v { self.set_print_pages(v) }
  }

  method printer is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_printer    },
      STORE => -> $, \v { self.set_printer(v) }
  }

  method printer_lpi is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_printer_lpi    },
      STORE => -> $, \v { self.set_printer_lpi(v) }
  }

  method quality is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_quality    },
      STORE => -> $, \v { self.set_quality(v) }
  }

  method resolution is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_resolution    },
      STORE => -> $, \v { self.set_resolution(v) }
  }

  method reverse is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_reverse    },
      STORE => -> $, \v { self.set_reverse(v) }
  }

  method scale is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_scale    },
      STORE => -> $, \v { self.set_scale(v) }
  }

  method use_color is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_use_color    },
      STORE => -> $, \v { self.set_use_color(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_print_settings_copy($!gtk-pset),
      $raw,
      |self.getTypePair
    );
  }

  method foreach (&func, gpointer $user_data = gpointer) {
    gtk_print_settings_foreach($!gtk-pset, &func, $user_data);
  }

  method get (Str() $key) {
    gtk_print_settings_get($!gtk-pset, $key);
  }

  method get_bool (Str() $key) {
    gtk_print_settings_get_bool($!gtk-pset, $key);
  }

  method get_collate {
    gtk_print_settings_get_collate($!gtk-pset);
  }

  method get_default_source {
    gtk_print_settings_get_default_source($!gtk-pset);
  }

  method get_dither {
    so gtk_print_settings_get_dither($!gtk-pset);
  }

  method get_double (Str() $key) {
    gtk_print_settings_get_double($!gtk-pset, $key);
  }

  method get_double_with_default (Str() $key, Num() $def) {
    my gdouble $d = $def;

    gtk_print_settings_get_double_with_default($!gtk-pset, $key, $d);
  }

  method get_duplex {
    gtk_print_settings_get_duplex($!gtk-pset);
  }

  method get_finishings {
    gtk_print_settings_get_finishings($!gtk-pset);
  }

  method get_int (Str() $key) {
    gtk_print_settings_get_int($!gtk-pset, $key);
  }

  method get_int_with_default (Str() $key, Int() $def) {
    my gint $d = $def;

    gtk_print_settings_get_int_with_default($!gtk-pset, $key, $d);
  }

  method get_length (Str() $key, Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_print_settings_get_length($!gtk-pset, $key, $u);
  }

  method get_media_type {
    gtk_print_settings_get_media_type($!gtk-pset);
  }

  method get_n_copies {
    gtk_print_settings_get_n_copies($!gtk-pset);
  }

  method get_number_up {
    gtk_print_settings_get_number_up($!gtk-pset);
  }

  method get_number_up_layout {
    gtk_print_settings_get_number_up_layout($!gtk-pset);
  }

  method get_orientation ( :$enum = True ) {
    my $o = gtk_print_settings_get_orientation($!gtk-pset);
    return $o unless $enum;
    GtkOrientationEnum($o);
  }

  method get_output_bin {
    gtk_print_settings_get_output_bin($!gtk-pset);
  }

  proto method get_page_ranges (|)
  { * }

  multi method get_page_ranges {
    samewith($);
  }
  multi method get_page_ranges ($num_ranges is rw) {
    my gint $n = 0;

    my $r = gtk_print_settings_get_page_ranges($!gtk-pset, $n);
    $num_ranges = $n;
    CArrayToArray($r, $n);
  }

  method get_page_set {
    gtk_print_settings_get_page_set($!gtk-pset);
  }

  method get_paper_height (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_print_settings_get_paper_height($!gtk-pset, $u);
  }

  method get_paper_size {
    gtk_print_settings_get_paper_size($!gtk-pset);
  }

  method get_paper_width (Int() $unit) {
    my GtkUnit $u =$unit;

    gtk_print_settings_get_paper_width($!gtk-pset, $u);
  }

  method get_print_pages {
    gtk_print_settings_get_print_pages($!gtk-pset);
  }

  method get_printer {
    gtk_print_settings_get_printer($!gtk-pset);
  }

  method get_printer_lpi {
    gtk_print_settings_get_printer_lpi($!gtk-pset);
  }

  method get_quality {
    gtk_print_settings_get_quality($!gtk-pset);
  }

  method get_resolution {
    gtk_print_settings_get_resolution($!gtk-pset);
  }

  method get_resolution_x {
    gtk_print_settings_get_resolution_x($!gtk-pset);
  }

  method get_resolution_y {
    gtk_print_settings_get_resolution_y($!gtk-pset);
  }

  method get_reverse {
    so gtk_print_settings_get_reverse($!gtk-pset);
  }

  method get_scale {
    gtk_print_settings_get_scale($!gtk-pset);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_settings_get_type, $n, $t );
  }

  method get_use_color {
    gtk_print_settings_get_use_color($!gtk-pset);
  }

  method has_key (Str() $key) {
    gtk_print_settings_has_key($!gtk-pset, $key);
  }

  method load_file (
    Str                     $file_name,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    clear_error;
    my $rv = gtk_print_settings_load_file($!gtk-pset, $file_name, $error);
    set_error($error);
    $rv;
  }

  method load_key_file (
    GKeyFile()              $key_file,
    Str()                   $group_name,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = gtk_print_settings_load_key_file(
      $!gtk-pset,
      $key_file,
      $group_name,
      $error
    );
    set_error($error);
    $rv;
  }

  method set (Str() $key, Str() $value) {
    gtk_print_settings_set($!gtk-pset, $key, $value);
  }

  method set_bool (Str() $key, Int() $value) {
    my gboolean $v = $value.so.Int;

    gtk_print_settings_set_bool($!gtk-pset, $key, $value);
  }

  method set_collate (Int() $collate) {
    my gboolean $c = $collate.so.Int;

    gtk_print_settings_set_collate($!gtk-pset, $collate);
  }

  method set_default_source (Str() $default_source) {
    gtk_print_settings_set_default_source($!gtk-pset, $default_source);
  }

  method set_dither (Str() $dither) {
    gtk_print_settings_set_dither($!gtk-pset, $dither);
  }

  method set_double (Str() $key, Num() $value) {
    my gdouble $v = $value;

    gtk_print_settings_set_double($!gtk-pset, $key, $v);
  }

  method set_duplex (Int() $duplex) {
    my GtkPrintDuplex $d = $duplex;

    gtk_print_settings_set_duplex($!gtk-pset, $d);
  }

  method set_finishings (Str() $finishings) {
    gtk_print_settings_set_finishings($!gtk-pset, $finishings);
  }

  method set_int (Str() $key, Int() $value) {
    my gint $v = $value;

    gtk_print_settings_set_int($!gtk-pset, $key, $v);
  }

  method set_length (Str() $key, Num() $value, Int() $unit) {
    my gdouble $v = $value;
    my GtkUnit $u = $unit;

    gtk_print_settings_set_length($!gtk-pset, $key, $value, $u);
  }

  method set_media_type (Str() $media_type) {
    gtk_print_settings_set_media_type($!gtk-pset, $media_type);
  }

  method set_n_copies (Int() $num_copies) {
    my gint $n = $num_copies;

    gtk_print_settings_set_n_copies($!gtk-pset, $n);
  }

  method set_number_up (Int() $number_up) {
    my gint $n = $number_up;

    gtk_print_settings_set_number_up($!gtk-pset, $n);
  }

  method set_number_up_layout (Int() $number_up_layout) {
    my GtkNumberUpLayout $n = $number_up_layout;

    gtk_print_settings_set_number_up_layout($!gtk-pset, $n);
  }

  method set_orientation (Int() $orientation) {
    my GtkPageOrientation $o = $orientation;

    gtk_print_settings_set_orientation($!gtk-pset, $o);
  }

  method set_output_bin (Str() $output_bin) {
    gtk_print_settings_set_output_bin($!gtk-pset, $output_bin);
  }

  method set_page_ranges (GtkPageRange() $page_ranges, Int() $num_ranges) {
    my gint $n = $num_ranges;

    gtk_print_settings_set_page_ranges($!gtk-pset, $page_ranges, $n);
  }

  method set_page_set (GtkPageSet() $page_set) {
    gtk_print_settings_set_page_set($!gtk-pset, $page_set);
  }

  method set_paper_height (Num() $height, Int() $unit) {
    my gdouble $h = $height;
    my GtkUnit $u = $unit;

    gtk_print_settings_set_paper_height($!gtk-pset, $h, $u);
  }

  method set_paper_size (Int() $paper_size) {
    my GtkPaperSize $p = $paper_size;

    gtk_print_settings_set_paper_size($!gtk-pset, $paper_size);
  }

  method set_paper_width (Num() $width, Int() $unit) {
    my gdouble $w = $width;
    my GtkUnit $u = $unit;

    gtk_print_settings_set_paper_width($!gtk-pset, $w, $unit);
  }

  method set_print_pages (GtkPrintPages() $pages) {
    gtk_print_settings_set_print_pages($!gtk-pset, $pages);
  }

  method set_printer (Str() $printer) {
    gtk_print_settings_set_printer($!gtk-pset, $printer);
  }

  method set_printer_lpi (Num() $lpi) {
    my gdouble $l = $lpi;

    gtk_print_settings_set_printer_lpi($!gtk-pset, $l);
  }

  method set_quality (Int() $quality) {
    my GtkPrintQuality $q = $quality;

    gtk_print_settings_set_quality($!gtk-pset, $q);
  }

  method set_resolution (Int() $resolution) {
    my gint $r = $resolution;

    gtk_print_settings_set_resolution($!gtk-pset, $r);
  }

  method set_resolution_xy (
    Int() $resolution_x,
    Int() $resolution_y
  ) {
    my gint $x = $resolution_x;
    my gint $y = $resolution_y;

    gtk_print_settings_set_resolution_xy($!gtk-pset, $x, $y);
  }

  method set_reverse (Int() $reverse) {
    my gboolean $r = $reverse.so.Int;

    gtk_print_settings_set_reverse($!gtk-pset, $reverse);
  }

  method set_scale (Num() $scale) {
    my gdouble $s = $scale;

    gtk_print_settings_set_scale($!gtk-pset, $s);
  }

  method set_use_color (Int() $use_color) {
    my gboolean $u = $use_color.so.Int;

    gtk_print_settings_set_use_color($!gtk-pset, $use_color);
  }

  method to_file (
    Str()                   $file_name,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    gtk_print_settings_to_file($!gtk-pset, $file_name, $error);
    set_error($error);
  }

  method to_gvariant ( :$raw = False ) {
    propReturnObject(
      gtk_print_settings_to_gvariant($!gtk-pset),
      $raw,
      |GLib::Variant.getTypePair
    );
  }

  method to_key_file (
    GKeyFile()         $key_file,
    Str()              $group_name
  ) {
    gtk_print_settings_to_key_file($!gtk-pset, $key_file, $group_name);
  }

  method unset (
    GtkPrintSettings() $settings,
    Str()              $key
  ) {
    gtk_print_settings_unset($!gtk-pset, $key);
  }

}

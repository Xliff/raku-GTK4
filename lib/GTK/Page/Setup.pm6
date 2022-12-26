use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Page::Setup:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Page::Setup {
  also does GLib::Roles::Object;

  has GtkPageSetup $!gtk-ps is implementor;

  method new {
    my $gtk-page-setup = gtk_page_setup_new();

    $gtk-page-setup ?? self.bless( :$gtk-page-setup ) !! Nil;
  }

  method new_from_file (
    Str()                   $file_name,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<new-from-file>
  {
    clear_error;
    my $gtk-page-setup = gtk_page_setup_new_from_file($file_name, $error);
    set_error($error);
    $gtk-page-setup ?? self.bless( :$gtk-page-setup ) !! Nil;
  }

  method new_from_gvariant (GVariant() $variant) is also<new-from-gvariant> {
    my $gtk-page-setup = gtk_page_setup_new_from_gvariant($variant);

    $gtk-page-setup ?? self.bless( :$gtk-page-setup ) !! Nil;
  }

  method new_from_key_file (
    GKeyFile()              $key_file,
    Str()                   $group_name,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<new-from-key-file>
  {
    clear_error;
    my $gtk-page-setup = gtk_page_setup_new_from_key_file(
      $key_file,
      $group_name,
      $error
    );
    set_error($error);

    $gtk-page-setup ?? self.bless( :$gtk-page-setup ) !! Nil;
  }

  method bottom_margin is rw is g-accessor is also<bottom-margin> {
    Proxy.new:
      FETCH => -> $     { self.get_bottom_margin    },
      STORE => -> $, \v { self.set_bottom_margin(v) }
  }

  method left_margin is rw is g-accessor is also<left-margin> {
    Proxy.new:
      FETCH => -> $     { self.get_left_margin    },
      STORE => -> $, \v { self.set_left_margin(v) }
  }

  method orientation is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_orientation    },
      STORE => -> $, \v { self.set_orientation(v) }
  }

  method paper_size is rw is g-accessor is also<paper-size> {
    Proxy.new:
      FETCH => -> $     { self.get_paper_size    },
      STORE => -> $, \v { self.set_paper_size(v) }
  }

  method right_margin is rw is g-accessor is also<right-margin> {
    Proxy.new:
      FETCH => -> $     { self.get_right_margin    },
      STORE => -> $, \v { self.set_right_margin(v) }
  }

  method top_margin is rw is g-accessor is also<top-margin> {
    Proxy.new:
      FETCH => -> $     { self.get_top_margin    },
      STORE => -> $, \v { self.set_top_margin(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_page_setup_copy($!gtk-ps),
      $raw,
      |self.getTypePair
    );
  }

  method get_bottom_margin (Int() $unit) is also<get-bottom-margin> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_bottom_margin($!gtk-ps, $u);
  }

  method get_left_margin (Int() $unit) is also<get-left-margin> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_left_margin($!gtk-ps, $u);
  }

  method get_orientation ( :$enum = True ) is also<get-orientation> {
    my $o = gtk_page_setup_get_orientation($!gtk-ps);
    return $o unless $enum;
    GtkOrientationEnum($o);
  }

  method get_page_height (Int() $unit) is also<get-page-height> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_page_height($!gtk-ps, $u);
  }

  method get_page_width (Int() $unit) is also<get-page-width> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_page_width($!gtk-ps, $u);
  }

  method get_paper_height (Int() $unit) is also<get-paper-height> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_paper_height($!gtk-ps, $u);
  }

  method get_paper_size is also<get-paper-size> {
    gtk_page_setup_get_paper_size($!gtk-ps);
  }

  method get_paper_width (Int() $unit) is also<get-paper-width> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_paper_width($!gtk-ps, $u);
  }

  method get_right_margin (Int() $unit) is also<get-right-margin> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_right_margin($!gtk-ps, $u);
  }

  method get_top_margin (Int() $unit) is also<get-top-margin> {
    my GtkUnit $u = $unit;

    gtk_page_setup_get_top_margin($!gtk-ps, $u);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_page_setup_get_type, $n, $t );
  }

  method load_file (
    Str()                   $file_name,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<load-file>
  {
    clear_error;
    my $rv = gtk_page_setup_load_file($!gtk-ps, $file_name, $error);
    set_error($error);
    $rv;
  }

  method load_key_file (
    GKeyFile()              $key_file,
    Str()                   $group_name,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<load-key-file>
  {
    clear_error;
    my $rv = gtk_page_setup_load_key_file($key_file, $group_name, $error);
    set_error($error);
    $rv;
  }

  method set_bottom_margin (Num() $margin, Int() $unit)
    is also<set-bottom-margin>
  {
    my gdouble $m =  $margin;
    my GtkUnit $u =  $unit;

    gtk_page_setup_set_bottom_margin($!gtk-ps, $m, $u);
  }

  method set_left_margin (Num() $margin, Int() $unit)
    is also<set-left-margin>
  {
    gtk_page_setup_set_left_margin($!gtk-ps, $m, $u);
  }

  method set_orientation (Int() $orientation)
    is also<set-orientation>
  {
    my GtkPageOrientation $o = $orientation;

    gtk_page_setup_set_orientation($!gtk-ps, $o);
  }

  method set_paper_size (GtkPaperSize() $size)
    is also<set-paper-size>
  {
    gtk_page_setup_set_paper_size($!gtk-ps, $size);
  }

  method set_paper_size_and_default_margins (GtkPaperSize() $size)
    is also<set-paper-size-and-default-margins>
  {
    gtk_page_setup_set_paper_size_and_default_margins($!gtk-ps, $size);
  }

  method set_right_margin (Num() $margin, Int() $unit)
    is also<set-right-margin>
  {
    gtk_page_setup_set_right_margin($!gtk-ps,  $m, $u);
  }

  method set_top_margin (Num() $margin, Int() $unit)
    is also<set-top-margin>
  {
    gtk_page_setup_set_top_margin($!gtk-ps, $m, $u);
  }

  method to_file (
    Str()                   $file_name,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<to-file>
  {
    clear_error;
    my $rv = gtk_page_setup_to_file($!gtk-ps, $file_name, $error);
    set_error($error);
    $rv;
  }

  method to_gvariant ( :$raw = False ) is also<to-gvariant> {
    propReturnObject(
      gtk_page_setup_to_gvariant($!gtk-ps),
      $raw,
      |GLib::Variant.getTypePair
    );
  }

  method to_key_file (
    GKeyFile() $key_file,
    Str()      $group_name
  )
    is also<to-key-file>
  {
    gtk_page_setup_to_key_file($!gtk-ps, $key_file, $group_name);
  }

}

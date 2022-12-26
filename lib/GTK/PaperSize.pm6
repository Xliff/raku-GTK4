use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::PaperSize:ver<4>;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::PaperSize {
  also does GLib::Roles::Object;

  has GtkPaperSize $!gtk-psize is implementor;

  method new (Str() $name) {
    my $gtk-paper-size = gtk_paper_size_new($name);

    $gtk-paper-size ?? self.bless( :$gtk-paper-size ) !! Nil;
  }

  method new_custom (
    Str() $name,
    Str() $display_name,
    Num() $width,
    Num() $height,
    Int() $unit
  ) {
    my GtkUnit  $u      =  $unit;
    my gdouble ($w, $h) = ($width, $height);

    my $gtk-paper-size = gtk_paper_size_new_custom(
      $name,
      $display_name,
      $width,
      $height,
      $u
    );

    $gtk-paper-size ?? self.bless( :$gtk-paper-size ) !! Nil;
  }

  method new_from_gvariant (GVariant() $variant) {
    my $gtk-paper-size = gtk_paper_size_new_from_gvariant($variant);

    $gtk-paper-size ?? self.bless( :$gtk-paper-size ) !! Nil;
  }

  method new_from_ipp (Str() $ipp_name, Num() $width, Num() $height) {
    my gdouble ($w, $h) = ($width, $height);

    my $gtk-paper-size = gtk_paper_size_new_from_ipp($ipp_name, $w, $h);

    $gtk-paper-size ?? self.bless( :$gtk-paper-size ) !! Nil;
  }

  method new_from_key_file (
    GKeyFile()              $key_file,
    Str()                   $group_name,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $gtk-paper-size = gtk_paper_size_new_from_key_file(
      $key_file,
      $group_name,
      $error
    );
    set_error($error);

    $gtk-paper-size ?? self.bless( :$gtk-paper-size ) !! Nil;
  }

  method new_from_ppd (
    Str() $ppd_name,
    Str() $ppd_display_name,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($w, $h) = ($width, $height);

    my $gtk-paper-size = gtk_paper_size_new_from_ppd(
      $ppd_name,
      $ppd_display_name,
      $w,
      $h
    );

    $gtk-paper-size ?? self.bless( :$gtk-paper-size ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_paper_size_copy($!gtk-psize),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    gtk_paper_size_free($!gtk-psize);
  }

  method get_default_bottom_margin (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_paper_size_get_default_bottom_margin($!gtk-psize, $u);
  }

  method get_default {
    gtk_paper_size_get_default();
  }

  method get_default_left_margin (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_paper_size_get_default_left_margin($!gtk-psize, $u);
  }

  method get_default_right_margin (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_paper_size_get_default_right_margin($!gtk-psize, $u);
  }

  method get_default_top_margin (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_paper_size_get_default_top_margin($!gtk-psize, $u);
  }

  method get_display_name {
    gtk_paper_size_get_display_name($!gtk-psize);
  }

  method get_height (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_paper_size_get_height($!gtk-psize, $u);
  }

  method get_name {
    gtk_paper_size_get_name($!gtk-psize);
  }

  method get_paper_sizes (
    Int()  $include_custom,
          :$raw              = False,
          :$glist            = False
  ) {
    my gboolean $i = $include_custom.so.Int;

    returnGList(
      gtk_paper_size_get_paper_sizes($i),
      $raw,
      $glist,
      |self.getTypePair
    );
  }

  method get_ppd_name {
    gtk_paper_size_get_ppd_name($!gtk-psize);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_paper_size_get_type, $n, $t );
  }

  method get_width (Int() $unit) {
    my GtkUnit $u = $unit;

    gtk_paper_size_get_width($!gtk-psize, $u);
  }

  method is_custom {
    so gtk_paper_size_is_custom($!gtk-psize);
  }

  method is_equal (GtkPaperSize() $size2) {
    gtk_paper_size_is_equal($!gtk-psize, $size2);
  }

  method is_ipp {
    so gtk_paper_size_is_ipp($!gtk-psize);
  }

  method set_size (Num() $width, Num() $height, Int() $unit) {
    my GtkUnit  $u      =  $unit;
    my gdouble ($w, $h) = ($width, $height);

    gtk_paper_size_set_size($!gtk-psize, $w, $h, $u);
  }

  method to_gvariant ( :$raw = False ) {
    propReturnObject(
      gtk_paper_size_to_gvariant($!gtk-psize),
      $raw,
      |GLib::Variant.getTypePair
    );
  }

  method to_key_file (
    GKeyFile() $key_file,
    Str()      $group_name
  ) {
    gtk_paper_size_to_key_file($!gtk-psize, $key_file, $group_name);
  }

}

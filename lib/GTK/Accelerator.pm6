use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Accelerator:ver<4>;

use GLib::Roles::StaticClass;

class GTK::Accelerator:ver<4> {
  also does GLib::Roles::StaticClass;

  method get_default_mod_mask {
    gtk_accelerator_get_default_mod_mask();
  }

  method get_label (
    Int() $accelerator_key,
    Int() $accelerator_mods
  ) {
    my guint           $k = $accelerator_key;
    my GdkModifierType $m = $accelerator_mods;

    gtk_accelerator_get_label($k, $m);
  }

  method get_label_with_keycode (
    GdkDisplay() $display,
    Int()        $accelerator_key,
    Int()        $keycode,
    Int()        $accelerator_mods
  ) {
    my gint            ($a, $k) = ($accelerator_key, $keycode);
    my GdkModifierType  $m      =  $accelerator_mods;

    gtk_accelerator_get_label_with_keycode($display, $a, $k, $m);
  }

  method name (
    Int() $accelerator_key,
    Int() $accelerator_mods
  ) {
    my guint           $k = $accelerator_key;
    my GdkModifierType $m = $accelerator_mods;

    gtk_accelerator_name($k, $m);
  }

  method name_with_keycode (
    GdkDisplay() $display,
    Int()        $accelerator_key,
    Int()        $keycode,
    Int()        $accelerator_mods
  ) {
    my gint            ($a, $k) = ($accelerator_key, $keycode);
    my GdkModifierType  $m      =  $accelerator_mods;

    gtk_accelerator_name_with_keycode($display, $a, $k, $m);
  }

  multi method parse (Str() $accelerator) {
    samewith($accelerator, $, $);
  }
  multi method parse (
    Str() $accelerator,
          $accelerator_key  is rw,
          $accelerator_mods is rw
  ) {
    my gint            $k = 0;
    my GdkModifierType $m = 0;

    gtk_accelerator_parse($accelerator, $k, $m);
    ($accelerator_key, $accelerator_mods) = ($k, $m);
  }

  proto method parse_with_keycode (|)
  { * }

  multi method parse_with_keycode (
    Str()         $accelerator,
    GdkDisplay()  $display,
                 :$raw          = False
  ) {
    return-with-all(
      samewith($accelerator, $display, $, $, $, :all)
    );
  }
  multi method parse_with_keycode (
    Str()         $accelerator,
    GdkDisplay()  $display,
                  $accelerator_key   is rw,
                  $accelerator_codes is rw,
                  $accelerator_mods  is rw,
                 :$all                      = False,
                 :$raw                      = False
  ) {
    my guint           $k = 0;
    my CArray[guint]   $c = newCArray(guint);
    my GdkModifierType $m = $0;

    my $rv =  gtk_accelerator_parse_with_keycode(
      $accelerator,
      $display,
      $k,
      $c,
      $m
    );
    ($accelerator_key, $accelerator_mods) = ($k, $m);

     $accelerator_codes = $raw ?? $c !! CArrayToArray($c);

    $all.not ?? $rv
             !! ($rv, $accelerator_key, $accelerator_mods, $accelerator_codes);
  }

  method valid (Int() $keyval, Int() $modifiers) {
    my guint           $k = $keyval;
    my GdkModifierType $m = $modifiers;

    so gtk_accelerator_valid($k, $m);
  }

}

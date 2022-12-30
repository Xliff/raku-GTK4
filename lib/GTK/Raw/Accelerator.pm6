use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Accelerator;

### /usr/src/gtk4/gtk/gtkaccelgroup.h

sub gtk_accelerator_get_default_mod_mask
  returns GdkModifierType
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_get_label (
  guint           $accelerator_key,
  GdkModifierType $accelerator_mods
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_get_label_with_keycode (
  GdkDisplay      $display,
  guint           $accelerator_key,
  guint           $keycode,
  GdkModifierType $accelerator_mods
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_name (
  guint           $accelerator_key,
  GdkModifierType $accelerator_mods
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_name_with_keycode (
  GdkDisplay      $display,
  guint           $accelerator_key,
  guint           $keycode,
  GdkModifierType $accelerator_mods
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_parse (
  Str             $accelerator,
  guint           $accelerator_key   is rw,
  GdkModifierType $accelerator_mods  is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_parse_with_keycode (
  Str             $accelerator,
  GdkDisplay      $display,
  guint           $accelerator_key    is rw,
  CArray[guint]   $accelerator_codes,
  GdkModifierType $accelerator_mods   is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_accelerator_valid (
  guint           $keyval,
  GdkModifierType $modifiers
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

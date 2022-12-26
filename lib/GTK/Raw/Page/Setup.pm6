use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Page::Setup;

### /usr/src/gtk4/gtk/gtkpagesetup.h

sub gtk_page_setup_copy (GtkPageSetup $other)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_bottom_margin (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_left_margin (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_orientation (GtkPageSetup $setup)
  returns GtkPageOrientation
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_page_height (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_page_width (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_paper_height (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_paper_size (GtkPageSetup $setup)
  returns GtkPaperSize
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_paper_width (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_right_margin (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_top_margin (
  GtkPageSetup $setup,
  GtkUnit      $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_load_file (
  GtkPageSetup            $setup,
  Str                     $file_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_load_key_file (
  GtkPageSetup            $setup,
  GKeyFile                $key_file,
  Str                     $group_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_new
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_new_from_file (
  Str                     $file_name,
  CArray[Pointer[GError]] $error
)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_new_from_gvariant (GVariant $variant)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_new_from_key_file (
  GKeyFile                $key_file,
  Str                     $group_name,
  CArray[Pointer[GError]] $error
)
  returns GtkPageSetup
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_bottom_margin (
  GtkPageSetup $setup,
  gdouble      $margin,
  GtkUnit      $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_left_margin (
  GtkPageSetup $setup,
  gdouble      $margin,
  GtkUnit      $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_orientation (
  GtkPageSetup       $setup,
  GtkPageOrientation $orientation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_paper_size (
  GtkPageSetup $setup,
  GtkPaperSize $size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_paper_size_and_default_margins (
  GtkPageSetup $setup,
  GtkPaperSize $size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_right_margin (
  GtkPageSetup $setup,
  gdouble      $margin,
  GtkUnit      $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_set_top_margin (
  GtkPageSetup $setup,
  gdouble      $margin,
  GtkUnit      $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_to_file (
  GtkPageSetup            $setup,
  Str                     $file_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_to_gvariant (GtkPageSetup $setup)
  returns GVariant
  is      native(gtk4)
  is      export
{ * }

sub gtk_page_setup_to_key_file (
  GtkPageSetup $setup,
  GKeyFile     $key_file,
  Str          $group_name
)
  is      native(gtk4)
  is      export
{ * }

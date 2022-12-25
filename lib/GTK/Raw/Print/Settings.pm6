use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Print::Settings:ver<4>;

### /usr/src/gtk4/gtk/gtkprintsettings.h

sub gtk_print_settings_copy (GtkPrintSettings $other)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_foreach (
  GtkPrintSettings     $settings,
                       &func (Str, Str, gpointer),
  gpointer             $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get (
  GtkPrintSettings $settings,
  Str              $key
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_bool (
  GtkPrintSettings $settings,
  Str              $key
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_collate (GtkPrintSettings $settings)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_default_source (GtkPrintSettings $settings)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_dither (GtkPrintSettings $settings)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_double (
  GtkPrintSettings $settings,
  Str              $key
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_double_with_default (
  GtkPrintSettings $settings,
  Str              $key,
  gdouble          $def
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_duplex (GtkPrintSettings $settings)
  returns GtkPrintDuplex
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_finishings (GtkPrintSettings $settings)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_int (
  GtkPrintSettings $settings,
  Str              $key
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_int_with_default (
  GtkPrintSettings $settings,
  Str              $key,
  gint             $def
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_length (
  GtkPrintSettings $settings,
  Str              $key,
  GtkUnit          $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_media_type (GtkPrintSettings $settings)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_n_copies (GtkPrintSettings $settings)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_number_up (GtkPrintSettings $settings)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_number_up_layout (GtkPrintSettings $settings)
  returns GtkNumberUpLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_orientation (GtkPrintSettings $settings)
  returns GtkPageOrientation
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_output_bin (GtkPrintSettings $settings)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_page_ranges (
  GtkPrintSettings $settings,
  gint             $num_ranges is rw
)
  returns GtkPageRange
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_page_set (GtkPrintSettings $settings)
  returns GtkPageSet
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_paper_height (
  GtkPrintSettings $settings,
  GtkUnit          $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_paper_size (GtkPrintSettings $settings)
  returns GtkPaperSize
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_paper_width (
  GtkPrintSettings $settings,
  GtkUnit          $unit
)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_print_pages (GtkPrintSettings $settings)
  returns GtkPrintPages
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_printer (GtkPrintSettings $settings)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_printer_lpi (GtkPrintSettings $settings)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_quality (GtkPrintSettings $settings)
  returns GtkPrintQuality
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_resolution (GtkPrintSettings $settings)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_resolution_x (GtkPrintSettings $settings)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_resolution_y (GtkPrintSettings $settings)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_reverse (GtkPrintSettings $settings)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_scale (GtkPrintSettings $settings)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_get_use_color (GtkPrintSettings $settings)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_has_key (
  GtkPrintSettings $settings,
  Str              $key
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_load_file (
  GtkPrintSettings        $settings,
  Str                     $file_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_load_key_file (
  GtkPrintSettings        $settings,
  GKeyFile                $key_file,
  Str                     $group_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_new
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_new_from_file (
  Str                     $file_name,
  CArray[Pointer[GError]] $error
)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_new_from_gvariant (GVariant $variant)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_new_from_key_file (
  GKeyFile                $key_file,
  Str                     $group_name,
  CArray[Pointer[GError]] $error
)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set (
  GtkPrintSettings $settings,
  Str              $key,
  Str              $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_bool (
  GtkPrintSettings $settings,
  Str              $key,
  gboolean         $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_collate (
  GtkPrintSettings $settings,
  gboolean         $collate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_default_source (
  GtkPrintSettings $settings,
  Str              $default_source
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_dither (
  GtkPrintSettings $settings,
  Str              $dither
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_double (
  GtkPrintSettings $settings,
  Str              $key,
  gdouble          $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_duplex (
  GtkPrintSettings $settings,
  GtkPrintDuplex   $duplex
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_finishings (
  GtkPrintSettings $settings,
  Str              $finishings
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_int (
  GtkPrintSettings $settings,
  Str              $key,
  gint             $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_length (
  GtkPrintSettings $settings,
  Str              $key,
  gdouble          $value,
  GtkUnit          $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_media_type (
  GtkPrintSettings $settings,
  Str              $media_type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_n_copies (
  GtkPrintSettings $settings,
  gint             $num_copies
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_number_up (
  GtkPrintSettings $settings,
  gint             $number_up
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_number_up_layout (
  GtkPrintSettings  $settings,
  GtkNumberUpLayout $number_up_layout
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_orientation (
  GtkPrintSettings   $settings,
  GtkPageOrientation $orientation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_output_bin (
  GtkPrintSettings $settings,
  Str              $output_bin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_page_ranges (
  GtkPrintSettings $settings,
  GtkPageRange     $page_ranges,
  gint             $num_ranges
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_page_set (
  GtkPrintSettings $settings,
  GtkPageSet       $page_set
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_paper_height (
  GtkPrintSettings $settings,
  gdouble          $height,
  GtkUnit          $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_paper_size (
  GtkPrintSettings $settings,
  GtkPaperSize     $paper_size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_paper_width (
  GtkPrintSettings $settings,
  gdouble          $width,
  GtkUnit          $unit
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_print_pages (
  GtkPrintSettings $settings,
  GtkPrintPages    $pages
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_printer (
  GtkPrintSettings $settings,
  Str              $printer
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_printer_lpi (
  GtkPrintSettings $settings,
  gdouble          $lpi
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_quality (
  GtkPrintSettings $settings,
  GtkPrintQuality  $quality
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_resolution (
  GtkPrintSettings $settings,
  gint             $resolution
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_resolution_xy (
  GtkPrintSettings $settings,
  gint             $resolution_x,
  gint             $resolution_y
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_reverse (
  GtkPrintSettings $settings,
  gboolean         $reverse
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_scale (
  GtkPrintSettings $settings,
  gdouble          $scale
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_set_use_color (
  GtkPrintSettings $settings,
  gboolean         $use_color
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_to_file (
  GtkPrintSettings        $settings,
  Str                     $file_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_to_gvariant (GtkPrintSettings $settings)
  returns GVariant
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_to_key_file (
  GtkPrintSettings $settings,
  GKeyFile         $key_file,
  Str              $group_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_settings_unset (
  GtkPrintSettings $settings,
  Str              $key
)
  is      native(gtk4)
  is      export
{ * }

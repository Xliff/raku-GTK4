use v6.c;

use NativeCall;

use Cairo;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Print::Job:ver<4>;

### /usr/src/gtk4/gtk/gtkprintjob.h

sub gtk_print_job_get_collate (GtkPrintJob $job)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_n_up (GtkPrintJob $job)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_n_up_layout (GtkPrintJob $job)
  returns GtkNumberUpLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_num_copies (GtkPrintJob $job)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_page_ranges (
  GtkPrintJob $job,
  gint        $n_ranges is rw
)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_page_set (GtkPrintJob $job)
  returns GtkPageSet
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_pages (GtkPrintJob $job)
  returns GtkPrintPages
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_printer (GtkPrintJob $job)
  returns GtkPrinter
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_reverse (GtkPrintJob $job)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_rotate (GtkPrintJob $job)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_scale (GtkPrintJob $job)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_settings (GtkPrintJob $job)
  returns GtkPrintSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_status (GtkPrintJob $job)
  returns GtkPrintStatus
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_surface (
  GtkPrintJob             $job,
  CArray[Pointer[GError]] $error
)
  returns Cairo::cairo_surface_t
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_title (GtkPrintJob $job)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_track_print_status (GtkPrintJob $job)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_new (
  Str              $title,
  GtkPrinter       $printer,
  GtkPrintSettings $settings,
  GtkPageSetup     $page_setup
)
  returns GtkPrintJob
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_send (
  GtkPrintJob $job,
              &callback (GtkPrintJob, gpointer, GError),
  gpointer    $user_data,
              &dnotify (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_collate (
  GtkPrintJob $job,
  gboolean    $collate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_n_up (
  GtkPrintJob $job,
  guint       $n_up
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_n_up_layout (
  GtkPrintJob       $job,
  GtkNumberUpLayout $layout
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_num_copies (
  GtkPrintJob $job,
  gint        $num_copies
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_page_ranges (
  GtkPrintJob $job,
  Pointer     $ranges,
  gint        $n_ranges
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_page_set (
  GtkPrintJob $job,
  GtkPageSet  $page_set
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_pages (
  GtkPrintJob   $job,
  GtkPrintPages $pages
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_reverse (
  GtkPrintJob $job,
  gboolean    $reverse
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_rotate (
  GtkPrintJob $job,
  gboolean    $rotate
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_scale (
  GtkPrintJob $job,
  gdouble     $scale
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_source_fd (
  GtkPrintJob             $job,
  gint                    $fd,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_source_file (
  GtkPrintJob             $job,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_job_set_track_print_status (
  GtkPrintJob $job,
  gboolean    $track_status
)
  is      native(gtk4)
  is      export
{ * }

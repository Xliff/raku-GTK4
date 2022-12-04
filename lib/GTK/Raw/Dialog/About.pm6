use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog::About:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkaboutdialog.h

sub gtk_about_dialog_add_credit_section (
  GtkAboutDialog $about,
  Str            $section_name,
  CArray[Str]    $people
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_artists (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_authors (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_comments (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_copyright (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_documenters (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_license (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_license_type (GtkAboutDialog $about)
  returns GtkLicense
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_logo (GtkAboutDialog $about)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_logo_icon_name (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_program_name (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_system_information (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_translator_credits (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_version (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_website (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_website_label (GtkAboutDialog $about)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_get_wrap_license (GtkAboutDialog $about)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_show_about_dialog (
  GtkWindow $parent,
  Str       $first_property_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_new
  returns GtkAboutDialog
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_artists (
  GtkAboutDialog $about,
  CArray[Str]    $artists
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_authors (
  GtkAboutDialog $about,
  CArray[Str]    $authors
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_comments (
  GtkAboutDialog $about,
  Str            $comments
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_copyright (
  GtkAboutDialog $about,
  Str            $copyright
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_documenters (
  GtkAboutDialog $about,
  CArray[Str]    $documenters
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_license (
  GtkAboutDialog $about,
  Str            $license
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_license_type (
  GtkAboutDialog $about,
  GtkLicense     $license_type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_logo (
  GtkAboutDialog $about,
  GdkPaintable   $logo
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_logo_icon_name (
  GtkAboutDialog $about,
  Str            $icon_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_program_name (
  GtkAboutDialog $about,
  Str            $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_system_information (
  GtkAboutDialog $about,
  Str            $system_information
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_translator_credits (
  GtkAboutDialog $about,
  Str            $translator_credits
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_version (
  GtkAboutDialog $about,
  Str            $version
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_website (
  GtkAboutDialog $about,
  Str            $website
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_website_label (
  GtkAboutDialog $about,
  Str            $website_label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_about_dialog_set_wrap_license (
  GtkAboutDialog $about,
  gboolean       $wrap_license
)
  is      native(gtk4)
  is      export
{ * }

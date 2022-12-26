use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Pango::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog::Font;

### /usr/src/gtk4/gtk/gtkfontdialog.h

sub gtk_font_dialog_choose_face (
  GtkFontDialog       $self,
  GtkWindow           $parent,
  PangoFontFace       $initial_value,
  GCancellable        $cancellable,
                      &callback (GtkFontDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_face_finish (
  GtkFontDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns PangoFontFace
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_family (
  GtkFontDialog       $self,
  GtkWindow           $parent,
  PangoFontFamily     $initial_value,
  GCancellable        $cancellable,
                      &callback (GtkFontDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_family_finish (
  GtkFontDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns PangoFontFamily
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_font (
  GtkFontDialog        $self,
  GtkWindow            $parent,
  PangoFontDescription $initial_value,
  GCancellable         $cancellable,
                           &callback (GtkFontDialog, GAsyncResult, gpointer),
  gpointer             $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_font_and_features (
  GtkFontDialog        $self,
  GtkWindow            $parent,
  PangoFontDescription $initial_value,
  GCancellable         $cancellable,
                       &callback (GtkFontDialog, GAsyncResult, gpointer),
  gpointer             $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_font_and_features_finish (
  GtkFontDialog                $self,
  GAsyncResult                 $result,
  CArray[PangoFontDescription] $font_desc,
  CArray[Str]                  $font_features,
  CArray[PangoLanguage]        $language,
  CArray[Pointer[GError]]      $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_choose_font_finish (
  GtkFontDialog           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns PangoFontDescription
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_get_filter (GtkFontDialog $self)
  returns GtkFilter
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_get_font_map (GtkFontDialog $self)
  returns PangoFontMap
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_get_language (GtkFontDialog $self)
  returns PangoLanguage
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_get_modal (GtkFontDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_get_title (GtkFontDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_new
  returns GtkFontDialog
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_set_filter (
  GtkFontDialog $self,
  GtkFilter     $filter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_set_font_map (
  GtkFontDialog $self,
  PangoFontMap  $fontmap
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_set_language (
  GtkFontDialog $self,
  PangoLanguage $language
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_set_modal (
  GtkFontDialog $self,
  gboolean      $modal
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_font_dialog_set_title (
  GtkFontDialog $self,
  Str           $title
)
  is      native(gtk4)
  is      export
{ * }


sub gtk_font_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

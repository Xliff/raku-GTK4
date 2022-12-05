use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog::Color:ver<4>;

### /usr/src/gtk4/gtk/gtkcolordialog.h

sub gtk_color_dialog_choose_rgba (
  GtkColorDialog      $self,
  GtkWindow           $parent,
  GdkRGBA             $initial_color,
  GCancellable        $cancellable,
                      &callback (GtkColorDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_choose_rgba_finish (
  GtkColorDialog          $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GdkRGBA
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_get_modal (GtkColorDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_get_title (GtkColorDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_get_with_alpha (GtkColorDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_new
  returns GtkColorDialog
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_set_modal (
  GtkColorDialog $self,
  gboolean       $modal
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_set_title (
  GtkColorDialog $self,
  Str            $title
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_dialog_set_with_alpha (
  GtkColorDialog $self,
  gboolean       $with_alpha
)
  is      native(gtk4)
  is      export
{ * }

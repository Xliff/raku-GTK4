use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::NativeDialog;

### /usr/src/gtk4/gtk/gtknativedialog.h

sub gtk_native_dialog_destroy (GtkNativeDialog $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_get_modal (GtkNativeDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_get_title (GtkNativeDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_get_transient_for (GtkNativeDialog $self)
  returns GtkWindow
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_get_visible (GtkNativeDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_hide (GtkNativeDialog $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_set_modal (
  GtkNativeDialog $self,
  gboolean        $modal
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_set_title (
  GtkNativeDialog $self,
  Str             $title
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_set_transient_for (
  GtkNativeDialog $self,
  GtkWindow       $parent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_native_dialog_show (GtkNativeDialog $self)
  is      native(gtk4)
  is      export
{ * }

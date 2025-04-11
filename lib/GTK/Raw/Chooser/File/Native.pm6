use v6.c;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Chooser::File::Native:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkfilechoosernative.h

sub gtk_file_chooser_native_get_accept_label (GtkFileChooserNative $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_chooser_native_get_cancel_label (GtkFileChooserNative $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_chooser_native_new (
  Str                  $title,
  GtkWindow            $parent,
  GtkFileChooserAction $action,
  Str                  $accept_label,
  Str                  $cancel_label
)
  returns GtkFileChooserNative
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_chooser_native_set_accept_label (
  GtkFileChooserNative $self,
  Str                  $accept_label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_file_chooser_native_set_cancel_label (
  GtkFileChooserNative $self,
  Str                  $cancel_label
)
  is      native(gtk4)
  is      export
{ * }

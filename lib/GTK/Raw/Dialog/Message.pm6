use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog::Message;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkmessagedialog.h

sub gtk_message_dialog_format_secondary_markup (
  GtkMessageDialog $message_dialog,
  Str              $message_format,
  Str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_message_dialog_format_secondary_text (
  GtkMessageDialog $message_dialog,
  Str              $message_format,
  Str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_message_dialog_get_message_area (GtkMessageDialog $message_dialog)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_message_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_message_dialog_new (
  GtkWindow      $parent,
  GtkDialogFlags $flags,
  GtkMessageType $type,
  GtkButtonsType $buttons,
  Str            $message_format,
  Str
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_message_dialog_new_with_markup (
  GtkWindow      $parent,
  GtkDialogFlags $flags,
  GtkMessageType $type,
  GtkButtonsType $buttons,
  Str            $message_format,
  Str
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_message_dialog_set_markup (
  GtkMessageDialog $message_dialog,
  Str              $str
)
  is      native(gtk4)
  is      export
{ * }

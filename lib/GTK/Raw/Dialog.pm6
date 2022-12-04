use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkdialog.h

sub gtk_dialog_add_action_widget (
  GtkDialog $dialog,
  GtkWidget $child,
  gint      $response_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_add_button (
  GtkDialog $dialog,
  Str       $button_text,
  gint      $response_id
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

# sub gtk_dialog_add_buttons (
#   GtkDialog $dialog,
#   Str       $first_button_text
#   gint      $response
#   Str
# )
#   is      native(gtk4)
#   is      export
# { * }

sub gtk_dialog_get_content_area (GtkDialog $dialog)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_get_header_bar (GtkDialog $dialog)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_get_response_for_widget (
  GtkDialog $dialog,
  GtkWidget $widget
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_get_widget_for_response (
  GtkDialog $dialog,
  gint      $response_id
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_new
  returns GtkDialog
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_new_with_button (
  Str            $title,
  GtkWindow      $parent,
  GtkDialogFlags $flags,
  Str            $first_text,
  gint           $first_response,
  Str
)
  returns GtkDialog
  is      native(gtk4)
  is      export
  is      symbol('gtk_dialog_new_with_buttons')
{ * }

sub gtk_dialog_response (
  GtkDialog $dialog,
  gint      $response_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_set_default_response (
  GtkDialog $dialog,
  gint      $response_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_dialog_set_response_sensitive (
  GtkDialog $dialog,
  gint      $response_id,
  gboolean  $setting
)
  is      native(gtk4)
  is      export
{ * }

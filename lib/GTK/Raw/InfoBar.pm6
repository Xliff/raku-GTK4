use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::InfoBar:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkinfobar.h

sub gtk_info_bar_add_action_widget (
  GtkInfoBar $info_bar,
  GtkWidget  $child,
  gint       $response_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_add_button (
  GtkInfoBar $info_bar,
  Str        $button_text,
  gint       $response_id
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_add_buttons (
  GtkInfoBar $info_bar,
  Str        $first_button_text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_add_child (
  GtkInfoBar $info_bar,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_get_message_type (GtkInfoBar $info_bar)
  returns GtkMessageType
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_get_revealed (GtkInfoBar $info_bar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_get_show_close_button (GtkInfoBar $info_bar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_new
  returns GtkInfoBar
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_new_with_buttons (
  Str  $first_button_text,
  gint $response_id,
  Str
)
  returns GtkInfoBar
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_remove_action_widget (
  GtkInfoBar $info_bar,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_remove_child (
  GtkInfoBar $info_bar,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_response (
  GtkInfoBar $info_bar,
  gint       $response_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_set_default_response (
  GtkInfoBar $info_bar,
  gint       $response_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_set_message_type (
  GtkInfoBar     $info_bar,
  GtkMessageType $message_type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_set_response_sensitive (
  GtkInfoBar $info_bar,
  gint       $response_id,
  gboolean   $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_set_revealed (
  GtkInfoBar $info_bar,
  gboolean   $revealed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_info_bar_set_show_close_button (
  GtkInfoBar $info_bar,
  gboolean   $setting
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::HeaderBar:ver<4>;

### /usr/src/gtk4/gtk/gtkheaderbar.h

sub gtk_header_bar_get_decoration_layout (GtkHeaderBar $bar)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_get_show_title_buttons (GtkHeaderBar $bar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_get_title_widget (GtkHeaderBar $bar)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_new
  returns GtkHeaderBar
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_pack_end (
  GtkHeaderBar $bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_pack_start (
  GtkHeaderBar $bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_remove (
  GtkHeaderBar $bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_set_decoration_layout (
  GtkHeaderBar $bar,
  Str          $layout
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_set_show_title_buttons (
  GtkHeaderBar $bar,
  gboolean     $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_header_bar_set_title_widget (
  GtkHeaderBar $bar,
  GtkWidget    $title_widget
)
  is      native(gtk4)
  is      export
{ * }

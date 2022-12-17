use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::SearchBar:ver<4>;

### /usr/src/gtk4/gtk/gtksearchbar.h

sub gtk_search_bar_connect_entry (
  GtkSearchBar $bar,
  GtkEditable  $entry
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_get_child (GtkSearchBar $bar)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_get_key_capture_widget (GtkSearchBar $bar)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_get_search_mode (GtkSearchBar $bar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_get_show_close_button (GtkSearchBar $bar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_set_child (
  GtkSearchBar $bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_set_key_capture_widget (
  GtkSearchBar $bar,
  GtkWidget    $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_set_search_mode (
  GtkSearchBar $bar,
  gboolean     $search_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_bar_set_show_close_button (
  GtkSearchBar $bar,
  gboolean     $visible
)
  is      native(gtk4)
  is      export
{ * }

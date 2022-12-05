use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::ActionBar;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkactionbar.h

sub gtk_action_bar_get_center_widget (GtkActionBar $action_bar)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_get_revealed (GtkActionBar $action_bar)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_pack_end (
  GtkActionBar $action_bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_pack_start (
  GtkActionBar $action_bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_remove (
  GtkActionBar $action_bar,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_set_center_widget (
  GtkActionBar $action_bar,
  GtkWidget    $center_widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_action_bar_set_revealed (
  GtkActionBar $action_bar,
  gboolean     $revealed
)
  is      native(gtk4)
  is      export
{ * }

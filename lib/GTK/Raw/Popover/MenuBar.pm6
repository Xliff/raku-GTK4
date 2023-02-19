use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Popover::MenuBar:ver<4>;

### /usr/src/gtk4/gtk/gtkpopovermenubar.h

sub gtk_popover_menu_bar_add_child (
  GtkPopoverMenuBar $bar,
  GtkWidget         $child,
  Str               $id
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_bar_get_menu_model (GtkPopoverMenuBar $bar)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_bar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_bar_new_from_model (GMenuModel $model)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_bar_remove_child (
  GtkPopoverMenuBar $bar,
  GtkWidget         $child
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_bar_set_menu_model (
  GtkPopoverMenuBar $bar,
  GMenuModel        $model
)
  is      native(gtk4)
  is      export
{ * }

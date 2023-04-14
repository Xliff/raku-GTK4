use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GTK::Raw::Structs;

unit package GTK::Raw::PopoverMenu;

### /usr/src/gtk4/gtk/gtkpopovermenu.h

sub gtk_popover_menu_add_child (
  GtkPopoverMenu $popover,
  GtkWidget      $child,
  Str            $id
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_get_menu_model (GtkPopoverMenu $popover)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_new_from_model (GMenuModel $model)
  returns GtkPopoverMenu
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_new_from_model_full (
  GMenuModel          $model,
  GtkPopoverMenuFlags $flags
)
  returns GtkPopoverMenu
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_remove_child (
  GtkPopoverMenu $popover,
  GtkWidget      $child
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_popover_menu_set_menu_model (
  GtkPopoverMenu $popover,
  GMenuModel     $model
)
  is      native(gtk4)
  is      export
{ * }

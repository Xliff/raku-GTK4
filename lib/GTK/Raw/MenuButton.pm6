use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::MenuButton:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkmenubutton.h

sub gtk_menu_button_get_always_show_arrow (GtkMenuButton $menu_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_child (GtkMenuButton $menu_button)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_direction (GtkMenuButton $menu_button)
  returns GtkArrowType
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_has_frame (GtkMenuButton $menu_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_icon_name (GtkMenuButton $menu_button)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_label (GtkMenuButton $menu_button)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_menu_model (GtkMenuButton $menu_button)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_popover (GtkMenuButton $menu_button)
  returns GtkPopover
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_primary (GtkMenuButton $menu_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_get_use_underline (GtkMenuButton $menu_button)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_new
  returns GtkMenuButton
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_popdown (GtkMenuButton $menu_button)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_popup (GtkMenuButton $menu_button)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_always_show_arrow (
  GtkMenuButton $menu_button,
  gboolean      $always_show_arrow
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_child (
  GtkMenuButton $menu_button,
  GtkWidget     $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_create_popup_func (
  GtkMenuButton $menu_button,
                &func (GtkMenuButton, gpointer),
  gpointer      $user_data,
                &destroy_notify (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_direction (
  GtkMenuButton $menu_button,
  GtkArrowType  $direction
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_has_frame (
  GtkMenuButton $menu_button,
  gboolean      $has_frame
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_icon_name (
  GtkMenuButton $menu_button,
  Str           $icon_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_label (
  GtkMenuButton $menu_button,
  Str           $label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_menu_model (
  GtkMenuButton $menu_button,
  GMenuModel    $menu_model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_popover (
  GtkMenuButton $menu_button,
  GtkWidget     $popover
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_primary (
  GtkMenuButton $menu_button,
  gboolean      $primary
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_menu_button_set_use_underline (
  GtkMenuButton $menu_button,
  gboolean      $use_underline
)
  is      native(gtk4)
  is      export
{ * }

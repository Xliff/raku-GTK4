use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Tooltip:ver<4>;

### /usr/src/gtk4/gtk/gtktooltip.

sub gtk_tooltip_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_custom (
  GtkTooltip $tooltip,
  GtkWidget  $custom_widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_icon (
  GtkTooltip   $tooltip,
  GdkPaintable $paintable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_icon_from_gicon (
  GtkTooltip $tooltip,
  GIcon      $gicon
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_icon_from_icon_name (
  GtkTooltip $tooltip,
  Str        $icon_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_markup (
  GtkTooltip $tooltip,
  Str        $markup
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_text (
  GtkTooltip $tooltip,
  Str        $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tooltip_set_tip_area (
  GtkTooltip   $tooltip,
  GdkRectangle $rect
)
  is      native(gtk4)
  is      export
{ * }

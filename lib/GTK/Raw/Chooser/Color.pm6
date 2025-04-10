use v6.c;

use GLib::Raw::Definitions;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Chooser::Color:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcolorchooser.h

sub gtk_color_chooser_add_palette (
  GtkColorChooser $chooser,
  GtkOrientation  $orientation,
  gint            $colors_per_line,
  gint            $n_colors,
  gpointer        $colors             #= ARRAY[GtkRGBA]
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_chooser_get_rgba (
  GtkColorChooser $chooser,
  GdkRGBA         $color
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_chooser_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_chooser_get_use_alpha (GtkColorChooser $chooser)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_chooser_set_rgba (
  GtkColorChooser $chooser,
  GdkRGBA         $color
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_chooser_set_use_alpha (
  GtkColorChooser $chooser,
  gboolean        $use_alpha
)
  is      native(gtk4)
  is      export
{ * }

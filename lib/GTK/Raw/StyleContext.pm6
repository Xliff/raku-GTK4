use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::StyleContext:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkstylecontext.h

sub gtk_style_context_add_class (
  GtkStyleContext $context,
  Str             $class_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_add_provider (
  GtkStyleContext  $context,
  GtkStyleProvider $provider,
  guint            $priority
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_add_provider_for_display (
  GdkDisplay       $display,
  GtkStyleProvider $provider,
  guint            $priority
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_border (
  GtkStyleContext $context,
  GtkBorder       $border
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_color (
  GtkStyleContext $context,
  GdkRGBA         $color
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_display (GtkStyleContext $context)
  returns GdkDisplay
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_margin (
  GtkStyleContext $context,
  GtkBorder       $margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_padding (
  GtkStyleContext $context,
  GtkBorder       $padding
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_scale (GtkStyleContext $context)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_state (GtkStyleContext $context)
  returns GtkStateFlags
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_has_class (
  GtkStyleContext $context,
  Str             $class_name
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_lookup_color (
  GtkStyleContext $context,
  Str             $color_name,
  GdkRGBA         $color
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_remove_class (
  GtkStyleContext $context,
  Str             $class_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_remove_provider (
  GtkStyleContext  $context,
  GtkStyleProvider $provider
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_remove_provider_for_display (
  GdkDisplay       $display,
  GtkStyleProvider $provider
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_restore (GtkStyleContext $context)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_save (GtkStyleContext $context)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_set_display (
  GtkStyleContext $context,
  GdkDisplay      $display
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_set_scale (
  GtkStyleContext $context,
  gint            $scale
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_set_state (
  GtkStyleContext $context,
  GtkStateFlags   $flags
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_to_string (
  GtkStyleContext           $context,
  GtkStyleContextPrintFlags $flags
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

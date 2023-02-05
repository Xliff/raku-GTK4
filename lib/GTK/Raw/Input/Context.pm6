use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Input::Context:ver<4>;

### /usr/src/gtk4/gtk/gtkimcontext.h

sub gtk_im_context_delete_surrounding (
  GtkIMContext $context,
  gint         $offset,
  gint         $n_chars
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_filter_key (
  GtkIMContext    $context,
  gboolean        $press,
  GdkSurface      $surface,
  GdkDevice       $device,
  guint32         $time,
  guint           $keycode,
  GdkModifierType $state,
  gint            $group
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_filter_keypress (
  GtkIMContext $context,
  GdkEvent     $event
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_focus_in (GtkIMContext $context)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_focus_out (GtkIMContext $context)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_get_preedit_string (
  GtkIMContext                   $context,
  CArray[Str]                    $str,
  CArray[Pointer[PangoAttrList]] $attrs,
  gint                           $cursor_pos is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_get_surrounding (
  GtkIMContext $context,
  CArray[Str]  $text,
  gint         $cursor_index is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_get_surrounding_with_selection (
  GtkIMContext $context,
  CArray[Str]  $text,
  gint         $cursor_index is rw,
  gint         $anchor_index is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_reset (GtkIMContext $context)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_set_client_widget (
  GtkIMContext $context,
  GtkWidget    $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_set_cursor_location (
  GtkIMContext $context,
  GdkRectangle $area
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_set_surrounding (
  GtkIMContext $context,
  Str          $text,
  gint         $len,
  gint         $cursor_index
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_set_surrounding_with_selection (
  GtkIMContext $context,
  Str          $text,
  gint         $len,
  gint         $cursor_index,
  gint         $anchor_index
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_set_use_preedit (
  GtkIMContext $context,
  gboolean     $use_preedit
)
  is      native(gtk4)
  is      export
{ * }

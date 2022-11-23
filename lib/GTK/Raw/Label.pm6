use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Label:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtklabel.h

sub gtk_label_get_attributes (GtkLabel $self)
  returns PangoAttrList
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_current_uri (GtkLabel $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_ellipsize (GtkLabel $self)
  returns PangoEllipsizeMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_extra_menu (GtkLabel $self)
  returns GMenuModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_justify (GtkLabel $self)
  returns GtkJustification
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_label (GtkLabel $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_layout (GtkLabel $self)
  returns PangoLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_layout_offsets (
  GtkLabel $self,
  gint     $x is rw,
  gint     $y is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_lines (GtkLabel $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_max_width_chars (GtkLabel $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_mnemonic_keyval (GtkLabel $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_mnemonic_widget (GtkLabel $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_natural_wrap_mode (GtkLabel $self)
  returns GtkNaturalWrapMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_selectable (GtkLabel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_selection_bounds (
  GtkLabel $self,
  gint     $start is rw,
  gint     $end is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_single_line_mode (GtkLabel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_tabs (GtkLabel $self)
  returns PangoTabArray
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_text (GtkLabel $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_use_markup (GtkLabel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_use_underline (GtkLabel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_width_chars (GtkLabel $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_wrap (GtkLabel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_wrap_mode (GtkLabel $self)
  returns PangoWrapMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_xalign (GtkLabel $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_get_yalign (GtkLabel $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_new (Str $str)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_new_with_mnemonic (Str $str)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_select_region (
  GtkLabel $self,
  gint     $start_offset,
  gint     $end_offset
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_attributes (
  GtkLabel      $self,
  PangoAttrList $attrs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_ellipsize (
  GtkLabel           $self,
  PangoEllipsizeMode $mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_extra_menu (
  GtkLabel   $self,
  GMenuModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_justify (
  GtkLabel         $self,
  GtkJustification $jtype
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_label (
  GtkLabel $self,
  Str      $str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_lines (
  GtkLabel $self,
  gint     $lines
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_markup (
  GtkLabel $self,
  Str      $str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_markup_with_mnemonic (
  GtkLabel $self,
  Str      $str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_max_width_chars (
  GtkLabel $self,
  gint     $n_chars
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_mnemonic_widget (
  GtkLabel  $self,
  GtkWidget $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_natural_wrap_mode (
  GtkLabel           $self,
  GtkNaturalWrapMode $wrap_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_selectable (
  GtkLabel $self,
  gboolean $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_single_line_mode (
  GtkLabel $self,
  gboolean $single_line_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_tabs (
  GtkLabel      $self,
  PangoTabArray $tabs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_text (
  GtkLabel $self,
  Str      $str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_text_with_mnemonic (
  GtkLabel $self,
  Str      $str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_use_markup (
  GtkLabel $self,
  gboolean $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_use_underline (
  GtkLabel $self,
  gboolean $setting
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_width_chars (
  GtkLabel $self,
  gint     $n_chars
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_wrap (
  GtkLabel $self,
  gboolean $wrap
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_wrap_mode (
  GtkLabel      $self,
  PangoWrapMode $wrap_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_xalign (
  GtkLabel $self,
  gfloat   $xalign
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_label_set_yalign (
  GtkLabel $self,
  gfloat   $yalign
)
  is      native(gtk4)
  is      export
{ * }

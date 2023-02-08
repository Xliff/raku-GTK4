use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Inscription:ver<4>;

### /usr/src/gtk4/gtk/gtkinscription.h

sub gtk_inscription_get_attributes (GtkInscription $self)
  returns PangoAttrList
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_min_chars (GtkInscription $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_min_lines (GtkInscription $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_nat_chars (GtkInscription $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_nat_lines (GtkInscription $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_text (GtkInscription $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_text_overflow (GtkInscription $self)
  returns GtkInscriptionOverflow
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_wrap_mode (GtkInscription $self)
  returns PangoWrapMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_xalign (GtkInscription $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_get_yalign (GtkInscription $self)
  returns gfloat
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_new (Str $text)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_attributes (
  GtkInscription $self,
  PangoAttrList  $attrs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_markup (GtkInscription $self, Str $markup)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_min_chars (GtkInscription $self, guint $min_chars)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_min_lines ( GtkInscription $self, guint $min_lines)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_nat_chars (GtkInscription $self, guint $nat_chars)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_nat_lines (GtkInscription $self, guint $nat_lines)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_text (GtkInscription $self, Str $text)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_text_overflow (
  GtkInscription         $self,
  GtkInscriptionOverflow $overflow
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_wrap_mode (
  GtkInscription $self,
  PangoWrapMode  $wrap_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_xalign (GtkInscription $self, gfloat $xalign)
  is      native(gtk4)
  is      export
{ * }

sub gtk_inscription_set_yalign (GtkInscription $self, gfloat $yalign)
  is      native(gtk4)
  is      export
{ * }

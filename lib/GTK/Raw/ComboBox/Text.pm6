use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::ComboBox::Text:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcomboboxtext.h

sub gtk_combo_box_text_append (
  GtkComboBoxText $combo_box,
  Str             $id,
  Str             $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_append_text (
  GtkComboBoxText $combo_box,
  Str             $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_get_active_text (GtkComboBoxText $combo_box)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_insert (
  GtkComboBoxText $combo_box,
  gint            $position,
  Str             $id,
  Str             $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_insert_text (
  GtkComboBoxText $combo_box,
  gint            $position,
  Str             $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_new
  returns GtkComboBoxText
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_new_with_entry
  returns GtkComboBoxText
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_prepend (
  GtkComboBoxText $combo_box,
  Str             $id,
  Str             $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_prepend_text (
  GtkComboBoxText $combo_box,
  Str             $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_remove (
  GtkComboBoxText $combo_box,
  gint            $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_text_remove_all (GtkComboBoxText $combo_box)
  is      native(gtk4)
  is      export
{ * }

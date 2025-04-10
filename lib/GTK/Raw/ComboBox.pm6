use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::ComboBox:ver<4>;

### /usr/src/gtk4/gtk/deprecated/gtkcombobox.h

sub gtk_combo_box_get_active (GtkComboBox $combo_box)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_active_id (GtkComboBox $combo_box)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_active_iter (
  GtkComboBox $combo_box,
  GtkTreeIter $iter
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_button_sensitivity (GtkComboBox $combo_box)
  returns GtkSensitivityType
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_child (GtkComboBox $combo_box)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_entry_text_column (GtkComboBox $combo_box)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_has_entry (GtkComboBox $combo_box)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_id_column (GtkComboBox $combo_box)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_model (GtkComboBox $combo_box)
  returns GtkTreeModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_popup_fixed_width (GtkComboBox $combo_box)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_row_separator_func (GtkComboBox $combo_box)
  returns gpointer      #= &(GtkTreeModel,  GtkTreeIter,  gpointer --> gboolean)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_new_with_entry
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_new_with_model (GtkTreeModel $model)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_new_with_model_and_entry (GtkTreeModel $model)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_popdown (GtkComboBox $combo_box)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_popup (GtkComboBox $combo_box)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_popup_for_device (
  GtkComboBox $combo_box,
  GdkDevice   $device
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_active (
  GtkComboBox $combo_box,
  gint        $index_
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_active_id (
  GtkComboBox $combo_box,
  Str         $active_id
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_active_iter (
  GtkComboBox $combo_box,
  GtkTreeIter $iter
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_button_sensitivity (
  GtkComboBox        $combo_box,
  GtkSensitivityType $sensitivity
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_child (
  GtkComboBox $combo_box,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_entry_text_column (
  GtkComboBox $combo_box,
  gint        $text_column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_id_column (
  GtkComboBox $combo_box,
  gint        $id_column
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_model (
  GtkComboBox  $combo_box,
  GtkTreeModel $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_popup_fixed_width (
  GtkComboBox $combo_box,
  gboolean    $fixed
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_combo_box_set_row_separator_func (
  GtkComboBox $combo_box,
              &func (GtkTreeModel,  GtkTreeIter,  gpointer --> gboolean),
  gpointer    $data,
              &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

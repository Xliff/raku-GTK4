use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::SelectionModel:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkselectionmodel.h

sub gtk_selection_model_get_selection (GtkSelectionModel $model)
  returns GtkBitset
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_get_selection_in_range (
  GtkSelectionModel $model,
  guint             $position,
  guint             $n_items
)
  returns GtkBitset
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_is_selected (
  GtkSelectionModel $model,
  guint             $position
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_select_all (GtkSelectionModel $model)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_select_item (
  GtkSelectionModel $model,
  guint             $position,
  gboolean          $unselect_rest
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_select_range (
  GtkSelectionModel $model,
  guint             $position,
  guint             $n_items,
  gboolean          $unselect_rest
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_selection_changed (
  GtkSelectionModel $model,
  guint             $position,
  guint             $n_items
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_set_selection (
  GtkSelectionModel $model,
  GtkBitset         $selected,
  GtkBitset         $mask
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_unselect_all (GtkSelectionModel $model)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_unselect_item (
  GtkSelectionModel $model,
  guint             $position
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_unselect_range (
  GtkSelectionModel $model,
  guint             $position,
  guint             $n_items
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_selection_model_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

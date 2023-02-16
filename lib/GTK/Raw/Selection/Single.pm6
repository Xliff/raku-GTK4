use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Selection::Single:ver<4>;

### /usr/src/gtk4/gtk/gtksingleselection.h

sub gtk_single_selection_get_autoselect (GtkSingleSelection $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_get_can_unselect (GtkSingleSelection $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_get_model (GtkSingleSelection $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_get_selected (GtkSingleSelection $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_get_selected_item (GtkSingleSelection $self)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_new (GListModel $model)
  returns GtkSingleSelection
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_set_autoselect (
  GtkSingleSelection $self,
  gboolean           $autoselect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_set_can_unselect (
  GtkSingleSelection $self,
  gboolean           $can_unselect
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_set_model (
  GtkSingleSelection $self,
  GListModel         $model
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_single_selection_set_selected (
  GtkSingleSelection $self,
  guint              $position
)
  is      native(gtk4)
  is      export
{ * }

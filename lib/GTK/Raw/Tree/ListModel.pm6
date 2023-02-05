use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Tree::ListModel;

### /usr/src/gtk4/gtk/gtktreelistmodel.h

sub gtk_tree_list_model_get_autoexpand (GtkTreeListModel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_model_get_child_row (
  GtkTreeListModel $self,
  guint            $position
)
  returns GtkTreeListRow
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_model_get_model (GtkTreeListModel $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_model_get_passthrough (GtkTreeListModel $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_model_get_row (
  GtkTreeListModel $self,
  guint            $position
)
  returns GtkTreeListRow
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_child_row (
  GtkTreeListRow $self,
  guint          $position
)
  returns GtkTreeListRow
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_children (GtkTreeListRow $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_depth (GtkTreeListRow $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_expanded (GtkTreeListRow $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_item (GtkTreeListRow $self)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_parent (GtkTreeListRow $self)
  returns GtkTreeListRow
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_get_position (GtkTreeListRow $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_is_expandable (GtkTreeListRow $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_row_set_expanded (
  GtkTreeListRow $self,
  gboolean       $expanded
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_model_new (
  GListModel $root,
  gboolean   $passthrough,
  gboolean   $autoexpand,
             &create_func (
               GObject,
               gpointer
               --> GtkTreeListModel
             ),
  gpointer   $user_data,
             &user_destroy (gpointer)
)
  returns GtkTreeListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_list_model_set_autoexpand (
  GtkTreeListModel $self,
  gboolean         $autoexpand
)
  is      native(gtk4)
  is      export
{ * }

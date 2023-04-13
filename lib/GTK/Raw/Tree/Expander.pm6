use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;

unit package GTK::Raw::Tree::Expander;

### /usr/src/gtk4/gtk/gtktreeexpander.h

sub gtk_tree_expander_get_child (GtkTreeExpander $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_get_hide_expander (GtkTreeExpander $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_get_indent_for_depth (GtkTreeExpander $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_get_indent_for_icon (GtkTreeExpander $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_get_item (GtkTreeExpander $self)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_get_list_row (GtkTreeExpander $self)
  returns GtkTreeListRow
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_set_child (
  GtkTreeExpander $self,
  GtkWidget       $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_set_hide_expander (
  GtkTreeExpander $self,
  gboolean        $hide_expander
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_set_indent_for_depth (
  GtkTreeExpander $self,
  gboolean        $indent_for_depth
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_set_indent_for_icon (
  GtkTreeExpander $self,
  gboolean        $indent_for_icon
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_tree_expander_set_list_row (
  GtkTreeExpander $self,
  GtkTreeListRow  $list_row
)
  is      native(gtk4)
  is      export
{ * }

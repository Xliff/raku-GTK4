use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::List::Item:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtklistitem.h

sub gtk_list_item_get_activatable (GtkListItem $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_get_child (GtkListItem $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_get_item (GtkListItem $self)
  returns Pointer
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_get_position (GtkListItem $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_get_selectable (GtkListItem $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_get_selected (GtkListItem $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_set_activatable (
  GtkListItem $self,
  gboolean    $activatable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_set_child (
  GtkListItem $self,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_list_item_set_selectable (
  GtkListItem $self,
  gboolean    $selectable
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::BookmarkList:ver<4>;

### /usr/src/gtk4/gtk/gtkbookmarklist.h

sub gtk_bookmark_list_get_attributes (GtkBookmarkList $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_bookmark_list_get_filename (GtkBookmarkList $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_bookmark_list_get_io_priority (GtkBookmarkList $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_bookmark_list_is_loading (GtkBookmarkList $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bookmark_list_new (Str $filename, Str $attributes)
  returns GtkBookmarkList
  is      native(gtk4)
  is      export
{ * }

sub gtk_bookmark_list_set_attributes (GtkBookmarkList $self, Str $attributes)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bookmark_list_set_io_priority (
  GtkBookmarkList $self,
  gint            $io_priority
)
  is      native(gtk4)
  is      export
{ * }

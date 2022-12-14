use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Assistant:ver<4>;

### /usr/src/gtk4/gtk/gtkassistant.h

sub gtk_assistant_add_action_widget (
  GtkAssistant $assistant,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_append_page (
  GtkAssistant $assistant,
  GtkWidget    $page
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_commit (GtkAssistant $assistant)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_current_page (GtkAssistant $assistant)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_n_pages (GtkAssistant $assistant)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_nth_page (
  GtkAssistant $assistant,
  gint         $page_num
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_page (
  GtkAssistant $assistant,
  GtkWidget    $child
)
  returns GtkAssistantPage
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_page_complete (
  GtkAssistant $assistant,
  GtkWidget    $page
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_page_title (
  GtkAssistant $assistant,
  GtkWidget    $page
)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_page_type (
  GtkAssistant $assistant,
  GtkWidget    $page
)
  returns GtkAssistantPageType
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_pages (GtkAssistant $assistant)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_insert_page (
  GtkAssistant $assistant,
  GtkWidget    $page,
  gint         $position
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_next_page (GtkAssistant $assistant)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_page_get_child (GtkAssistantPage $page)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_page_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_prepend_page (
  GtkAssistant $assistant,
  GtkWidget    $page
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_previous_page (GtkAssistant $assistant)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_remove_action_widget (
  GtkAssistant $assistant,
  GtkWidget    $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_remove_page (
  GtkAssistant $assistant,
  gint         $page_num
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_set_current_page (
  GtkAssistant $assistant,
  gint         $page_num
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_set_forward_page_func (
  GtkAssistant         $assistant,
                       &page_func (gint, gpointer --> gint),
  gpointer             $data,
                       &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_set_page_complete (
  GtkAssistant $assistant,
  GtkWidget    $page,
  gboolean     $complete
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_set_page_title (
  GtkAssistant $assistant,
  GtkWidget    $page,
  Str          $title
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_set_page_type (
  GtkAssistant         $assistant,
  GtkWidget            $page,
  GtkAssistantPageType $type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_assistant_update_buttons_state (GtkAssistant $assistant)
  is      native(gtk4)
  is      export
{ * }

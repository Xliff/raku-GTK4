use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Calendar:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkcalendar.h

sub gtk_calendar_clear_marks (GtkCalendar $calendar)
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_get_date (GtkCalendar $self)
  returns GDateTime
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_get_day_is_marked (
  GtkCalendar $calendar,
  guint       $day
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_get_show_day_names (GtkCalendar $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_get_show_heading (GtkCalendar $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_get_show_week_numbers (GtkCalendar $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_mark_day (
  GtkCalendar $calendar,
  guint       $day
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_select_day (
  GtkCalendar $self,
  GDateTime   $date
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_set_show_day_names (
  GtkCalendar $self,
  gboolean    $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_set_show_heading (
  GtkCalendar $self,
  gboolean    $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_set_show_week_numbers (
  GtkCalendar $self,
  gboolean    $value
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_calendar_unmark_day (
  GtkCalendar $calendar,
  guint       $day
)
  is      native(gtk4)
  is      export
{ * }

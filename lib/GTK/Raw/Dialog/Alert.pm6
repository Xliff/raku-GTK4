use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Dialog::Alert:ver<4>;

### /usr/src/gtk4/gtk/gtkalertdialog.h

sub gtk_alert_dialog_new (Str $format, Str)
  returns GtkAlertDialog
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_choose (
  GtkAlertDialog      $self,
  GtkWindow           $parent,
  GCancellable        $cancellable,
                      &callback (GtkAlertDialog, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_choose_finish (
  GtkAlertDialog $self,
  GAsyncResult   $result
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_get_buttons (GtkAlertDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_get_cancel_button (GtkAlertDialog $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_get_default_button (GtkAlertDialog $self)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_get_detail (GtkAlertDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_get_message (GtkAlertDialog $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_get_modal (GtkAlertDialog $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_set_buttons (
  GtkAlertDialog $self,
  CArray[Str]    $labels
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_set_cancel_button (
  GtkAlertDialog $self,
  gint           $button
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_set_default_button (
  GtkAlertDialog $self,
  gint           $button
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_set_detail (
  GtkAlertDialog $self,
  Str            $detail
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_set_message (
  GtkAlertDialog $self,
  Str            $message
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_set_modal (
  GtkAlertDialog $self,
  gboolean       $modal
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_alert_dialog_show (
  GtkAlertDialog $self,
  GtkWindow      $parent
)
  is      native(gtk4)
  is      export
{ * }

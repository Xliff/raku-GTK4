use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::Print::Operation::Preview:ver<4>;

role GTK::Roles::Print::Operation::Preview {
  also does GTK::Roles::Signals::Print::Operation::Preview;

  has GtkPrintOperationPreview $!gtk-pop is implementor;

  method GTK::Raw::Definitions::GtkPrintOperationPreview
  { $!gtk-pop }
  method GtkPrintOperationPreview
  { $!gtk-pop }

  method roleInit-GtkPrintOperationPreview {
    return if $!gtk-pop;

    my \i     = findProperImplementor(self.^attributes);

    $!gtk-pop = cast( GtkPrintOperationPreview, i.get_value(self) )
  }

  method Got-Page-Size {
    self.connect-got-page-size($!gtk-pop);
  }

  method Ready {
    self.connect-print-context($!gtk-pop, 'ready');
  }

  method end_preview {
    gtk_print_operation_preview_end_preview($!gtk-pop);
  }

  method gtkprintoperationpreview_get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_print_operation_preview_get_type,
      $n,
      $t
    );
  }

  method is_selected (Int() $page_nr) {
    so gtk_print_operation_preview_is_selected($!gtk-pop, $page_nr);
  }

  method render_page (Int() $page_nr) {
    gtk_print_operation_preview_render_page($!gtk-pop, $page_nr);
  }

}

our subset GtkPrintOperationPreviewAncestry is export of Mu
  where GtkPrintOperationPreview | GObject;

class GTK::Print::Operation::Preview:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Print::Operation::Preview;

  submethod BUILD ( :$gtk-print-preview ) {
    self.setGtkPrintOperationPreview($gtk-print-preview)
      if $gtk-print-preview
  }

  method setGtkPrintOperationPreview (GtkPrintOperationPreviewAncestry $_) {
    my $to-parent;

    $!gtk-pop = do {
      when GtkPrintOperationPreview {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrintOperationPreview, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
     $gtk-print-preview where * ~~ GtkPrintOperationPreviewAncestry,

    :$ref = True
  ) {
    return unless $gtk-print-preview;

    my $o = self.bless( :$gtk-print-preview );
    $o.ref if $ref;
    $o;
  }

}

### /usr/src/gtk4/gtk/gtkprintoperationpreview.h

sub gtk_print_operation_preview_end_preview (
  GtkPrintOperationPreview $preview
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_operation_preview_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_operation_preview_is_selected (
  GtkPrintOperationPreview $preview,
  gint                     $page_nr
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_print_operation_preview_render_page (
  GtkPrintOperationPreview $preview,
  gint                     $page_nr
)
  is      native(gtk4)
  is      export
{ * }

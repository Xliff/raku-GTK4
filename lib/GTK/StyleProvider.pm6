use v6.c;

use NativeCall;

use GTK::Raw::Types;

use GDK::Display:ver<4>;

use MONKEY-TYPING;

class GTK::Style::Provider {

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_style_provider_get_type, $n, $t );
  }

}


augment class GDK::Display {

  method add_provider_for_display (
    GtkStyleProvider() $provider,
    Int()              $priority
  ) {
    my guint $p = $priority;

    gtk_style_context_add_provider_for_display(
      self.GdkDisplay,
      $provider,
      $p
    );
  }

  method remove_provider_for_display (GtkStyleProvider() $provider) {
    gtk_style_context_remove_provider_for_display(
      self.GdkDisplay,
      $provider
    );
  }

}


### /usr/src/gtk4/gtk/gtkstyleprovider.h

sub gtk_style_provider_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_add_provider_for_display (
  GdkDisplay       $display,
  GtkStyleProvider $provider,
  guint            $priority
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_style_context_remove_provider_for_display (
  GdkDisplay       $display,
  GtkStyleProvider $provider
)
  is      native(gtk4)
  is      export
{ * }

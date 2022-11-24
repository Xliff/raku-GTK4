use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::CssProvider:ver<4> {
  has %!signals-gtk-css;

  # GtkApplication, GtkWindow, gpointer
  method connect-parsing-error (
    $obj,
    $signal = 'parsing-error',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-css{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-parsing-error($obj, $signal,
        -> $, $s, $e, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $s, $e, $ud ] );
        },
        gpointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid ];
    };
    %!signals-gtk-css{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-css{$signal}[0];
  }

}

# GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
sub g-connect-parsing-error(
  Pointer $app,
  Str     $name,
          &handler (
            GtkApplication,
            GtkCssSection,
            GError,
            gpointer
          ),
  Pointer $data,
  uint32  $flags
)
  is      export
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

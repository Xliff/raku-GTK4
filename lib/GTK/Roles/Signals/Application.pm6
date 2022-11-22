use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Application {
  has %!signals-gtk-win;

  # GtkApplication, GtkWindow, gpointer
  method connect-window (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk-app{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-window($obj, $signal,
        -> $, $w, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $w, $ud ] );
        },
        gpointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid ];
    };
    %!signals-gtk-app{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-app{$signal}[0];
  }

}

# GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
sub g-connect-window(
  Pointer $app,
  Str     $name,
          &handler (
            GtkApplication,
            GtkTooltip,
            gpointer
          ),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

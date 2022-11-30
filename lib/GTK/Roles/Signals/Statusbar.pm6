use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Subs:ver<4>;

role GTK::Roles::Signals::Statusbar:ver<4> {
  has %!signals-gtk-sb;

  # GtkStatusbar, guint, gchar, gpointer --> void
  method connect-text (
    $obj is copy,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk-sb{$signal} //= do {
      my $s = Supplier.new;
      $obj .= p if $obj.^can('p');
      $hid = g-connect-text($obj, $signal,
        -> $, $ui, $str, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ui, $str, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-sb{$signal}[0];
  }

}

# Define for each signal
sub g-connect-text(
  Pointer $app,
  Str     $name,
          &handler (GtkStatusbar, guint, Str, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
  { * }

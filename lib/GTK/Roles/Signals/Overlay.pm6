use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Overlay {
  has %!signals-gtk-o;

  # GtkRange, GtkScrollType is rw, Pointer -- gboolean
  method connect-get-child-position (
    $obj,
    $signal = 'get-child-position',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-o{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-get-child-position($obj, $signal,
        -> $, $w, $a, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          # cw: Consider reassigning $st to another lexical
          my $r = ReturnedValue.new;
          $s.emit( [self, $w, $a, $ud, $r] );
          $r.r
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-o{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-o{$signal}[0];
  }
}

sub g-connect-get-child-position (
  Pointer $app,
  Str     $name,
          &handler (
            GtkOverlay,
            GtkWidget,
            GdkRectangle,
            gpointer
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

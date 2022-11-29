use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Panes {
  has %!signals-gtk-p;
  # GtkRange, GtkScrollType is rw, Pointer -- gboolean
  method connect-move-handle (
    $obj,
    $signal = 'move-handle',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-p{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-move-handle($obj, $signal,
        -> $, $st is rw, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          # cw: Consider reassigning $st to another lexical
          my $r = ReturnedValue.new;
          $s.emit( [self, $st, $ud, $r] );
          $r.r
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-p{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-p{$signal}[0];
  }
}

sub g-connect-move-handle (
  Pointer $app,
  Str     $name,
          &handler (GtkRange, GtkScrollType is rw, Pointer --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

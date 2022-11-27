use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Generic:ver<4> {
  has %!signals-gtk;

  method connect-move-cursor (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_move_cursor>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_cursor($obj, $signal,
        -> $, $ms is rw, $c, $es, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ms, $c, $es, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

}

sub g_connect_move_cursor (
  Pointer $app,
  Str     $name,
          &handler (gpointer, uint32 is rw, gint, gboolean, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

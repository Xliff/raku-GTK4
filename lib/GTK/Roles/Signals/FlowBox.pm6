use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::FlowBox:ver<4> {
  has %!signals-gtk-fb;

  method connect-child-activated (
    $obj,
    $signal    = 'child-activated',
    &handler?
  )
    is also<connect_child_activated>
  {
    my $hid;
    %!signals-gtk-fb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-child-activated($obj, $signal,
        -> $, $c, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $c, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-fb{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-fb{$signal}[0];
  }

  method connect-move-cursor2 (
    $obj,
    $signal    = 'move-cursor',
    &handler?
  )
    is also<connect_move_cursor2>
  {
    my $hid;
    %!signals-gtk-fb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_cursor2($obj, $signal,
        -> $, $ms is rw, $c, $e, $m, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ms, $c, $e, $m, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-fb{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-fb{$signal}[0];
  }

}

sub g-connect-child-activated (
  Pointer $app,
  Str     $name,
          &handler (GtkFlowBox, GtkFlowBoxChild, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

sub g_connect_move_cursor2 (
  Pointer $app,
  Str     $name,
          &handler (gpointer, uint32 is rw, gint, gboolean, gboolean, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Subs:ver<4>;

role GTK::Roles::Signals::Range:ver<4> {
  has %!signals-gtk-r;

  # GtkRange, CArray[GtkScrollType], gdouble, Pointer
  method connect-change-value (
    $obj,
    $signal = 'change-value',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-r{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-change-value($obj, $signal,
        -> $r, $st is rw, $v, $ud {
          CATCH {
            default { note($_) }
          }

          # cw: Consider reassigning $st to another lexical
          $s.emit( [self, $st, $v, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-r{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-r{$signal}[0];
  }

  # GtkRange, GtkScrollType is rw, Pointer
  method connect-move-slider (
    $obj,
    $signal = 'move-slider',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-r{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-move-slider($obj, $signal,
        -> $r, $st is rw, $ud {
          CATCH {
            default { note($_) }
          }

          # cw: Consider reassigning $st to another lexical
          $s.emit( [self, $st, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-r{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-r{$signal}[0];
  }

}

# Define for each signal
sub g-connect-change-value(
  Pointer $app,
  Str     $name,
          &handler (GtkRange, GtkScrollType is rw, gdouble, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

sub g-connect-move-slider(
  Pointer $app,
  Str     $name,
          &handler (GtkRange, GtkScrollType is rw, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

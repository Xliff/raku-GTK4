use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Subs:ver<4>;

role GTK::Roles::Signals::SpinButton:ver<4> {
  has %!signals-gtk-sb;

  # GtkRange, CArray[GtkScrollType], Pointer
  method connect-change-value2 (
    $obj,
    $signal = 'change-value',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-sb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-change-value2($obj, $signal,
        -> $, $st is rw, $ud {
          CATCH {
            default { note($_) }
          }

          # cw: Consider reassigning $st to another lexical
          $s.emit( [self, $st,  $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-sb{$signal}[0];
  }

  # GtkRange, gdouble is rw, Pointer --> gint
  method connect-input (
    $obj,
    $signal = 'input',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-sb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-input($obj, $signal,
        -> $, $d is rw, $ud {
          CATCH {
            default { note($_) }
          }

          # cw: Consider reassigning $st to another lexical
          my $r = ReturnedValue.new;
          $s.emit( [self, $d, $ud, $r] );
          $r.r;
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
sub g-connect-change-value2 (
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

sub g-connect-input (
  Pointer $app,
  Str     $name,
          &handler (GtkRange, gdouble is rw, Pointer --> gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

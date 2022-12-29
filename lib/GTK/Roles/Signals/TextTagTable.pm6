use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::TextTagTable:ver<4> {
  has %!signals-ttt;

  # Copy for each signal.
  method connect-tag (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ttt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-tag($obj, $signal,
        -> $, $tag, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $tag, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-ttt{$signal}[0].tap(&handler) with &handler;
    %!signals-ttt{$signal}[0];
  }

  # GtkTextTagTable, GtkTextTag, gboolean, gpointer --> void
  method connect-tag-changed (
    $obj,
    $signal = 'tag-changed',
    &handler?
  ) {
    my $hid;
    %!signals-ttt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-tag-changed($obj, $signal,
        -> $, $tag, $b, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $tag, $b, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-ttt{$signal}[0].tap(&handler) with &handler;
    %!signals-ttt{$signal}[0];
  }

}

# Define for each signal
sub g-connect-tag(
  Pointer $app,
  Str     $name,
          &handler (GtkTextTagTable, GtkTextTag, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-tag-changed(
  Pointer $app,
  Str     $name,
          &handler (GtkTextTagTable, GtkTextTag, gboolean, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

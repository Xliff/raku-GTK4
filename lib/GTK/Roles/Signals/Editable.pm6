use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Object::Supplyish;

role GTK::Roles::Signals::Editable {
  has %!signals-e;

  #  char *text,  int length,  int *position --> void
  method connect-insert-text (
    $obj,
    $signal = 'insert-text',
    &handler?
  ) {
    my $hid;
    %!signals-e{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $c, $i1, $i2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $c, $i1, $i2] );
        },
        Pointer, 0
      );
      [ create-signal-supply(𝒮), $obj, $hid ];
    };
    %!signals-e{$signal}[0].tap(&handler) with &handler;
    %!signals-e{$signal}[0];
  }

}

# GtkEditable *editable,  char *text,  int length,  int *position
sub g-connect-insert-text (
  Pointer $app,
  Str     $name,
          &handler (Pointer, Str, int, int),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

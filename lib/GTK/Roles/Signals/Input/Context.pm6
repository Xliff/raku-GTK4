use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Input::Context {
  has %!signals-im;

  #  int offset,  int n_chars --> gboolean
  method connect-delete-surrounding (
    $obj,
    $signal = 'delete-surrounding',
    &handler?
  ) {
    my $hid;
    %!signals-im{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-delete-surrounding($obj, $signal,
        -> $, $i1, $i2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $i1, $i2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-im{$signal}[0].tap(&handler) with &handler;
    %!signals-im{$signal}[0];
  }

}

# GtkIMContext *context,  int offset,  int n_chars --> gboolean
sub g-connect-delete-surrounding (
  Pointer $app,
  Str     $name,
          &handler (Pointer, gint, gint --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

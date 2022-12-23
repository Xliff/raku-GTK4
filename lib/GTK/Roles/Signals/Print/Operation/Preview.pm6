use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Print::Operation::Preview:ver<4> {
  has %!signals-pop;

  #  GtkPrintContext *context,  GtkPageSetup *page_setup --> void
  method connect-got-page-size (
    $obj,
    $signal = 'got-page-size',
    &handler?
  ) {
    my $hid;
    %!signals-pop{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-got-page-size($obj, $signal,
        -> $, $gpc, $gps, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gpc, $gps, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-pop{$signal}[0].tap(&handler) with &handler;
    %!signals-pop{$signal}[0];
  }

}


# GtkPrintOperationPreview *preview,  GtkPrintContext *context,  GtkPageSetup *page_setup
sub g-connect-got-page-size (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkPrintContext, GtkPageSetup, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

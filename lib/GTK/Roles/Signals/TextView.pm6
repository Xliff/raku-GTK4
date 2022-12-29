use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::TextView {
  has %!signals-tv;

  # GtkTextExtendSelection granularity,
  # GtkTextIter *location,
  # GtkTextIter *start,
  # GtkTextIter *end --> gboolean
  method connect-extend-selection (
    $obj,
    $signal = 'extend-selection',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-extend-selection($obj, $signal,
        -> $, $gtes, $gti1, $gti2, $gti3, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gtes, $gti1, $gti2, $gti3, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  #  GtkDeleteType type is rw,  int count --> void
  method connect-enumP-int (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-enumP-int($obj, $signal,
        -> $, $gdt is rw, $i, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gdt, $i, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

}

# GtkTextView *text_view,  GtkTextExtendSelection granularity,  GtkTextIter *location,  GtkTextIter *start,  GtkTextIter *end --> gboolean
sub g-connect-extend-selection (
  Pointer $app,
  Str     $name,
          &handler (
            GtkTextView,
            GtkTextExtendSelection,
            GtkTextIter,
            GtkTextIter,
            GtkTextIter
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextView *text_view,  GtkDeleteType type,  int count
sub g-connect-enumP-int (
  Pointer $app,
  Str     $name,
          &handler (GtkTextView, guint is rw, int, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

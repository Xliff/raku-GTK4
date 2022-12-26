use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Generic:ver<4> {
  has %!signals-gtk;

  method connect-double-double (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_double_double>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_2double($obj, $signal,
        -> $, $d1, $d2, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $d1, $d2, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-widget (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_widget>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_widget($obj, $signal,
        -> $, $w, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $w, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

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

  #  GtkPrintContext *context --> void
  method connect-print-context (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-print-context($obj, $signal,
        -> $, $pc, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $pc, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

}

sub g_connect_2double (
  Pointer $app,
  Str     $name,
          &handler (gpointer, gdouble, gdouble, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_widget (
  Pointer $app,
  Str     $name,
          &handler (gpointer, GtkWidget, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

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

# GtkPrintOperationPreview *preview,  GtkPrintContext *context
sub g-connect-print-context (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GtkPrintContext, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

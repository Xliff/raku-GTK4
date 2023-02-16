use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Event::Controller::Key:ver<4> {
  has %!signals-gtk-eck;

  # GtkEventControllerKey, guint, guint, GdkModifierType, gpointer --> gboolean
  method connect-key (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk-eck{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-key($obj, $signal,
        -> $, $u1, $u2, $mt is copy, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $mt = GdkModifierTypeEnum($mt);
          $s.emit( [self, $u1, $u2, $mt, $ud, $r] );
          $r.r
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-eck{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-eck{$signal}[0];
  }
}

sub g-connect-key (
  Pointer $app,
  Str     $name,
          &handler (
            GtkEventControllerKey,
            guint,
            guint,
            GdkModifierType,
            gpointer
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

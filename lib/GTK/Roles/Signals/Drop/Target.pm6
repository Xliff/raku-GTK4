use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Subs:ver<4>;

role GTK::Roles::Signals::Drop::Target:ver<4> {
  has %!signals-gtk-dt;

  # GtkStatusbar, GdkDrop, gpointer --> gboolean
  method connect-gdkdrop (
    $obj      is copy,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk-dt{$signal} //= do {
      my $s = Supplier.new;
      $obj .= p if $obj.^can('p');
      $hid = g-connect-gdkdrop($obj, $signal,
        -> $, $d, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my $r = GLib::Raw::ReturnedValue.new;
          $s.emit( [self, $d, $ud, $r] );
          $r.r.Int;
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-dt{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-dt{$signal}[0];
  }

  # GtkStatusbar, GValue, gdouble, gdouble, gpointer --> gboolean
  method connect-drop (
    $obj    is copy,
    $signal          = 'drop',
    &handler?
  ) {
    my $hid;
    %!signals-gtk-dt{$signal} //= do {
      my $s = Supplier.new;
      $obj .= p if $obj.^can('p');
      $hid = g-connect-drop($obj, $signal,
        -> $, $v, $x, $y, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my $r = GLib::Raw::ReturnedValue.new;
          $s.emit( [self, $v, $x, $y, $ud, $r] );
          $r.r.Int;
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-dt{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-dt{$signal}[0];
  }

}

# Define for each signal
sub g-connect-gdkdrop(
  Pointer $app,
  Str     $name,
          &handler (GtkDropTarget, GdkDrop, Pointer --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

# Define for each signal
sub g-connect-drop(
  Pointer $app,
  Str     $name,
          &handler (
            GtkDropTarget,
            GValue,
            gdouble,
            gdouble,
            Pointer
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

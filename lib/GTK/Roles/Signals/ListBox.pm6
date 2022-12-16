use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::ListBox:ver<4> {
  has %!signals-gtk-lb;

  method connect-list-box-row (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_list_box_row>
  {
    my $hid;
    %!signals-gtk-lb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_list_box_row($obj, $signal,
        -> $, $lbr, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $lbr, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-lb{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-lb{$signal}[0];
  }

}

sub g_connect_list_box_row (
  Pointer $app,
  Str     $name,
          &handler (GtkListBox, GtkListBoxRow, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

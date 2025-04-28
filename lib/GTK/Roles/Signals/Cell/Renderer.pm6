use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Cell::Renderer:ver<4> {
  has %!signals-cr;

  #  GtkCellEditable *editable,  char *path --> void
  method connect-editing-started (
     $obj,
     $signal    = 'editing-started',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-cr{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-editing-started($obj, $signal,
        -> $, $gce is copy, $p, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gce = GTK::Cell::Editable.new($gce) unless $raw;

          𝒮.emit( [self, $gce, $p, $ud] )
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-cr{$signal}[0].tap(&handler) with &handler;
    %!signals-cr{$signal}[0];
  }

}

# GtkCellRenderer *cell,  GtkCellEditable *editable,  Str *path
sub g-connect-editing-started (
  Pointer $app,
  Str     $name,
          &handler (GtkCellRenderer,  GtkCellEditable, Str, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

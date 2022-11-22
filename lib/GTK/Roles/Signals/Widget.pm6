use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Widget {
  has %!signals-gtk-w;

 # GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
 method connect-query-tooltip (
   $obj,
   $signal = 'query-tooltip',
   &handler?
 ) {
   my $hid;
   %!signals-gtk-w{$signal} //= do {
     my $s = Supplier.new;
     $hid = g-connect-query-tooltip($obj, $signal,
       -> $, $i1, $i2, $ui, $tt, $ud --> uint32 {
         CATCH { default { note($_) } }

         my ReturnedValue $r .= new;
         my @valid-types = (Bool, Int);
         $s.emit( [self, $i1, $i2, $ui, $tt, $ud, $r] );
         # die 'Invalid return type' if $r.r ~~ @valid-types.any;
         # $r.r = .Int if $r.r ~~ @valid-types.any;
         $r.r;
       },
       OpaquePointer, 0
     );
     [ self.create-signal-supply($signal, $s), $obj, $hid ];
   };
   %!signals-gtk-w{$signal}[0].tap(&handler) with &handler;
   %!signals-gtk-w{$signal}[0];
 }

}

# GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
sub g-connect-query-tooltip(
  Pointer $app,
  Str     $name,
          &handler (
            GtkWidget,
            gint,
            gint,
            gboolean,
            GtkTooltip,
            Pointer
            --> uint32
          ),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Subs:ver<4>;

role GTK::Roles::Signals::DragSource:ver<4> {
  has %!signals-gtk-ds;

  # Pointer, GdkDrag, gpointer
  method connect-gdkdrag (
    $obj      is copy,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk-ds{$signal} //= do {
      my $s = Supplier.new;
      $obj .= p if $obj.^can('p');
      $hid = g-connect-gdkdrag($obj, $signal,
        -> $, $d, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $d, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-ds{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-ds{$signal}[0];
  }

   # Pointer, GdkDrop, gint*, gpointer --> gboolean
   method connect-drag-cancel (
     $obj      is copy,
     $signal            = 'drag-cancel',
     &handler?
   ) {
     my $hid;
     %!signals-gtk-ds{$signal} //= do {
       my $s = Supplier.new;
       $obj .= p if $obj.^can('p');
       $hid = g-connect-drag-cancel($obj, $signal,
         -> $, $d, $i is rw, $ud --> gboolean {
           CATCH {
             default { note($_) }
           }

           my $r = GLib::Raw::ReturnedValue.new;
           $s.emit( [self, $d, $i, $ud, $r] );
           $r.r.Int;
         },
         Pointer, 0
       );
       [ self.create-signal-supply($signal, $s), $obj, $hid];
     };
     %!signals-gtk-ds{$signal}[0].tap(&handler) with &handler;
     %!signals-gtk-ds{$signal}[0];
   }

   # Pointer, GdkDrag, gboolean, gpointer
   method connect-drag-end (
     $obj      is copy,
     $signal,
     &handler?
   ) {
     my $hid;
     %!signals-gtk-ds{$signal} //= do {
       my $s = Supplier.new;
       $obj .= p if $obj.^can('p');
       $hid = g-connect-drag-end($obj, $signal,
         -> $, $d, $b, $ud {
           CATCH {
             default { note($_) }
           }

           $s.emit( [self, $d, $b, $ud] );
         },
         Pointer, 0
       );
       [ self.create-signal-supply($signal, $s), $obj, $hid];
     };
     %!signals-gtk-ds{$signal}[0].tap(&handler) with &handler;
     %!signals-gtk-ds{$signal}[0];
   }

  # Pointer, gdouble, gdouble, gpointer --> GdkContentProvider
  method connect-prepare (
    $obj      is copy,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtk-ds{$signal} //= do {
      my $s = Supplier.new;
      $obj .= p if $obj.^can('p');
      $hid = g-connect-prepare($obj, $signal,
        -> $, $n1, $n2, $ud --> GdkContentProvider {
          CATCH {
            default { note($_) }
          }

          my $r = GLib::Raw::ReturnedValue;
          $s.emit( [self, $n1, $n2, $ud] );
          $r.r.^can('GdkContentProvider') ?? $r.r.GdkContentProvider
                                          !! $r.r;
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, $s), $obj, $hid];
    };
    %!signals-gtk-ds{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk-ds{$signal}[0];
  }

}

# Pointer, GdkDrag, gpointer
sub g-connect-gdkdrag (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GdkDrag, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

# Pointer, GdkDrag, gboolean, gpointer
sub g-connect-drag-end (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GdkDrag, gboolean, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }


# Pointer, GdkDrop, gint*, gpointer --> gboolean
sub g-connect-drag-cancel (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GdkDrag, guint is rw, Pointer --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }


# Pointer, gdouble, gdouble, gpointer --> GdkContentProvider
sub g-connect-prepare (
  Pointer $app,
  Str     $name,
          &handler (Pointer, gdouble, gdouble, Pointer --> GdkContentProvider),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native('gobject-2.0')
  is      symbol('g_signal_connect_object')
{ * }

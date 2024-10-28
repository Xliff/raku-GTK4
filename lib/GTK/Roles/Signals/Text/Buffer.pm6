use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GDK::Clipboard:ver<4>;
use GTK::Text::Child::Anchor:ver<4>;
use GTK::Text::Iter:ver<4>;
use GTK::Text::Mark:ver<4>;
use GTK::Text::Tag:ver<4>;

use GDK::Roles::Paintable:ver<4>;

role GTK::Roles::Signals::Text::Buffer {
  has %!signals-tb;

  #  GtkTextIter *pos,  char *new_text,  int new_text_length --> void
  method connect-insert-text (
    $obj,
    $signal    = 'insert-text',
    &handler?,
    :$raw      = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $gti is copy, $c, $i {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gti = GTK::Text::Iter.new($gti) unless $raw;

          𝒮.emit( [self, $gti, $c, $i ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextIter *location,  GtkTextMark *mark --> void
  method connect-mark-set (
     $obj,
     $signal    = 'mark-set',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-mark-set($obj, $signal,
        -> $, $gti is copy, $gtm is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gti = GTK::Text::Iter.new($gti);
            $gtm = GTK::Text::Mark.new($gtm);
          }

          𝒮.emit( [self, $gti, $gtm ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextIter *start,  GtkTextIter *end --> void
  method connect-delete-range (
     $obj,
     $signal    = 'delete-range',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-delete-range($obj, $signal,
        -> $, $gti1 is copy, $gti2 is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gti1 = GTK::Text::Iter.new($gti1);
            $gti2 = GTK::Text::Iter.new($gti2);
          }

          𝒮.emit( [ self, $gti1, $gti2 ] )
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextIter *iter,  GdkPaintable *paintable --> void
  method connect-insert-paintable (
     $obj,
     $signal     = 'insert-paintable',
     &handler?,
    :$raw        = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-paintable($obj, $signal,
        -> $, $gti, $gp {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gti = GTK::Text::Iter.new($gti);
            $gp  = GDK::Paintable.new($gp);
          }

          𝒮.emit( [self, $gti, $gp ] );

        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end --> void
  method connect-remove-tag (
     $obj,
     $signal    = 'remove-tag',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-remove-tag($obj, $signal,
        -> $, $gtt is copy, $gti1 is copy, $gti2 is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gtt  = GTK::Text::Tag.new($gtt);
            $gti1 = GTK::Text::Iter.new($gti1);
            $gti2 = GTK::Text::Iter.new($gti2);
          }

          𝒮.emit( [self, $gtt, $gti1, $gti2 ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextIter *iter,  GtkTextChildAnchor *anchor --> void
  method connect-insert-child-anchor (
     $obj,
     $signal    = 'insert-child-anchor',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-child-anchor($obj, $signal,
        -> $, $gti is copy, $gtca is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gti  = GTK::Text::Iter.new($gti);
            $gtca = GTK::Text::Child::Anchor.new($gtca);
          }

          𝒮.emit( [self, $gti, $gtca ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end --> void
  method connect-apply-tag (
     $obj,
     $signal    = 'apply-tag',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-apply-tag($obj, $signal,
        -> $, $gtt is copy, $gti1 is copy, $gti2 is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gtt  = GTK::Text::Tag.new($gtt);
            $gti1 = GTK::Text::Iter.new($gti1);
            $gti2 = GTK::Text::Iter.new($gti2);
          }

          𝒮.emit( [ self, $gtt, $gti1, $gti2 ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GtkTextMark *mark --> void
  method connect-mark-deleted (
     $obj,
     $signal    = 'mark-deleted',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-mark-deleted($obj, $signal,
        -> $, $gtm is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gtm = GTK::Text::Mark.new($gtm) unless $raw;

          𝒮.emit( [self, $gtm ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

  #  GdkClipboard *clipboard --> void
  method connect-paste-done (
     $obj,
     $signal    = 'paste-done',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-paste-done($obj, $signal,
        -> $, $gc is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gc = GDK::Clipboard.new($gc) unless $raw;

          𝒮.emit( [self, $gc ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

}


# GtkTextBuffer *buffer,  GtkTextIter *pos,  char *new_text,  int new_text_length
sub g-connect-insert-text (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextIter, Str, int32),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *location,  GtkTextMark *mark
sub g-connect-mark-set (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextIter, GtkTextMark),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-delete-range (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextIter, GtkTextIter),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *iter,  GdkPaintable *paintable
sub g-connect-insert-paintable (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextIter, GdkPaintable),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-remove-tag (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextTag, GtkTextIter, GtkTextIter),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *iter,  GtkTextChildAnchor *anchor
sub g-connect-insert-child-anchor (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextIter, GtkTextChildAnchor),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-apply-tag (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextTag, GtkTextIter, GtkTextIter),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextMark *mark
sub g-connect-mark-deleted (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GtkTextMark),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GdkClipboard *clipboard
sub g-connect-paste-done (
  Pointer $app,
  Str     $name,
          &handler (GtkTextBuffer,  GdkClipboard),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

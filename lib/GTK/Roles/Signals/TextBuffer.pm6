  # Is originally:
  # GtkTextBuffer *buffer --> void
  method redo {
    self.connect-redo($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextIter *iter,  GtkTextChildAnchor *anchor --> void
  method insert-child-anchor {
    self.connect-insert-child-anchor($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextIter *start,  GtkTextIter *end --> void
  method delete-range {
    self.connect-delete-range($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer --> void
  method undo {
    self.connect-undo($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GdkClipboard *clipboard --> void
  method paste-done {
    self.connect-paste-done($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextIter *location,  GtkTextMark *mark --> void
  method mark-set {
    self.connect-mark-set($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer --> void
  method begin-user-action {
    self.connect-begin-user-action($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextMark *mark --> void
  method mark-deleted {
    self.connect-mark-deleted($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextIter *pos,  char *new_text,  int new_text_length --> void
  method insert-text {
    self.connect-insert-text($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer --> void
  method modified-changed {
    self.connect-modified-changed($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextIter *iter,  GdkPaintable *paintable --> void
  method insert-paintable {
    self.connect-insert-paintable($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end --> void
  method remove-tag {
    self.connect-remove-tag($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer --> void
  method end-user-action {
    self.connect-end-user-action($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer,  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end --> void
  method apply-tag {
    self.connect-apply-tag($!w);
  }

  # Is originally:
  # GtkTextBuffer *buffer --> void
  method changed {
    self.connect-changed($!w);
  }

  #  --> void
  method connect-redo (
    $obj,
    $signal = 'redo',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-redo($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextIter *iter,  GtkTextChildAnchor *anchor --> void
  method connect-insert-child-anchor (
    $obj,
    $signal = 'insert-child-anchor',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-child-anchor($obj, $signal,
        -> $, $gti, $gtca {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $gtca, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextIter *start,  GtkTextIter *end --> void
  method connect-delete-range (
    $obj,
    $signal = 'delete-range',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-delete-range($obj, $signal,
        -> $, $gti1, $gti2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti1, $gti2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  --> void
  method connect-undo (
    $obj,
    $signal = 'undo',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-undo($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GdkClipboard *clipboard --> void
  method connect-paste-done (
    $obj,
    $signal = 'paste-done',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-paste-done($obj, $signal,
        -> $, $gc {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gc, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextIter *location,  GtkTextMark *mark --> void
  method connect-mark-set (
    $obj,
    $signal = 'mark-set',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-mark-set($obj, $signal,
        -> $, $gti, $gtm {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $gtm, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  --> void
  method connect-begin-user-action (
    $obj,
    $signal = 'begin-user-action',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-begin-user-action($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextMark *mark --> void
  method connect-mark-deleted (
    $obj,
    $signal = 'mark-deleted',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-mark-deleted($obj, $signal,
        -> $, $gtm {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gtm, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextIter *pos,  char *new_text,  int new_text_length --> void
  method connect-insert-text (
    $obj,
    $signal = 'insert-text',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $gti, $c, $i {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $c, $i, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  --> void
  method connect-modified-changed (
    $obj,
    $signal = 'modified-changed',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-modified-changed($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextIter *iter,  GdkPaintable *paintable --> void
  method connect-insert-paintable (
    $obj,
    $signal = 'insert-paintable',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-paintable($obj, $signal,
        -> $, $gti, $gp {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $gp, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end --> void
  method connect-remove-tag (
    $obj,
    $signal = 'remove-tag',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-remove-tag($obj, $signal,
        -> $, $gtt, $gti1, $gti2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gtt, $gti1, $gti2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  --> void
  method connect-end-user-action (
    $obj,
    $signal = 'end-user-action',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-end-user-action($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end --> void
  method connect-apply-tag (
    $obj,
    $signal = 'apply-tag',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-apply-tag($obj, $signal,
        -> $, $gtt, $gti1, $gti2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gtt, $gti1, $gti2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

  #  --> void
  method connect-changed (
    $obj,
    $signal = 'changed',
    &handler?
  ) {
    my $hid;
    %!signals-w{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-changed($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-w{$signal}[0].tap(&handler) with &handler;
    %!signals-w{$signal}[0];
  }

# GtkTextBuffer *buffer
sub g-connect-redo (
  Pointer $app,
  Str $name,
  &handler (Pointer ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *iter,  GtkTextChildAnchor *anchor
sub g-connect-insert-child-anchor (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextIter, GtkTextChildAnchor),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-delete-range (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextIter, GtkTextIter),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer
sub g-connect-undo (
  Pointer $app,
  Str $name,
  &handler (Pointer ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GdkClipboard *clipboard
sub g-connect-paste-done (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GdkClipboard),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *location,  GtkTextMark *mark
sub g-connect-mark-set (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextIter, GtkTextMark),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer
sub g-connect-begin-user-action (
  Pointer $app,
  Str $name,
  &handler (Pointer ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextMark *mark
sub g-connect-mark-deleted (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextMark),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *pos,  char *new_text,  int new_text_length
sub g-connect-insert-text (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextIter, char, int),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer
sub g-connect-modified-changed (
  Pointer $app,
  Str $name,
  &handler (Pointer ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextIter *iter,  GdkPaintable *paintable
sub g-connect-insert-paintable (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextIter, GdkPaintable),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-remove-tag (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextTag, GtkTextIter, GtkTextIter),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer
sub g-connect-end-user-action (
  Pointer $app,
  Str $name,
  &handler (Pointer ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer,  GtkTextTag *tag,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-apply-tag (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GtkTextTag, GtkTextIter, GtkTextIter),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GtkTextBuffer *buffer
sub g-connect-changed (
  Pointer $app,
  Str $name,
  &handler (Pointer ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

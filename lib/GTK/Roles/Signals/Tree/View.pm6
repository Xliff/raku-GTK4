use v6.c;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Signals::Tree::View {
  has %!signals-tv;

  #  GtkTreeIter *iter,  GtkTreePath *path --> void
  method connect-row-collapsed (
    $obj,
    $signal = 'row-collapsed',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-row-collapsed($obj, $signal,
        -> $, $gti, $gtp {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gti, $gtp] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  #  GtkTreeIter *iter,  GtkTreePath *path --> gboolean
  method connect-test-expand-row (
    $obj,
    $signal = 'test-expand-row',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-test-expand-row($obj, $signal,
        -> $, $gti, $gtp {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $gtp, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  #  GtkMovementStep step,  int count,  gboolean extend,  gboolean modify --> gboolean
  method connect-move-cursor (
    $obj,
    $signal = 'move-cursor',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-move-cursor($obj, $signal,
        -> $, $gms, $i, $g1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gms, $i, $g1, $g2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  #  gboolean logical,  gboolean expand,  gboolean open_all --> gboolean
  method connect-expand-collapse-cursor-row (
    $obj,
    $signal = 'expand-collapse-cursor-row',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-expand-collapse-cursor-row($obj, $signal,
        -> $, $g1, $g21, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $g1, $g21, $g2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  #  GtkTreePath *path,  GtkTreeViewColumn *column --> void
  method connect-row-activated (
    $obj,
    $signal = 'row-activated',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-row-activated($obj, $signal,
        -> $, $gtp, $gtvc {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gtp, $gtvc, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  #  gboolean start_editing --> gboolean
  method connect-select-cursor-row (
    $obj,
    $signal = 'select-cursor-row',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-select-cursor-row($obj, $signal,
        -> $, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $g, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }
}

# GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path
sub g-connect-row-collapsed (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTreeIter, GtkTreePath),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path --> gboolean
sub g-connect-test-expand-row (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTreeIter, GtkTreePath --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path
sub g-connect-row-expanded (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTreeIter, GtkTreePath),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTreeView *tree_view,  GtkMovementStep step,  int count,  gboolean extend,  gboolean modify --> gboolean
sub g-connect-move-cursor (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GtkMovementStep, int, gboolean, gboolean --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }


# GtkTreeView *tree_view,  gboolean logical,  gboolean expand,  gboolean open_all --> gboolean
sub g-connect-expand-collapse-cursor-row (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  gboolean, gboolean, gboolean --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTreeView *tree_view,  GtkTreePath *path,  GtkTreeViewColumn *column
sub g-connect-row-activated (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTreePath, GtkTreeViewColumn),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkTreeView *tree_view,  GtkTreeIter *iter,  GtkTreePath *path --> gboolean
sub g-connect-test-collapse-row (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTreeIter, GtkTreePath --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }


# GtkTreeView *tree_view,  gboolean start_editing --> gboolean
sub g-connect-select-cursor-row (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  gboolean --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

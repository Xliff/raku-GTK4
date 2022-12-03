use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Bitset:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkbitset.h

sub gtk_bitset_add (GtkBitset $self, guint $value)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_add_range (
  GtkBitset $self,
  guint     $start,
  guint     $n_items
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_add_range_closed (
  GtkBitset $self,
  guint     $first,
  guint     $last
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_add_rectangle (
  GtkBitset $self,
  guint     $start,
  guint     $width,
  guint     $height,
  guint     $stride
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_contains (GtkBitset $self, guint $value)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_copy (GtkBitset $self)
  returns GtkBitset
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_difference (GtkBitset $self, GtkBitset $other)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_equals (GtkBitset $self, GtkBitset $other)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_get_maximum (GtkBitset $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_get_minimum (GtkBitset $self)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_get_nth (
  GtkBitset $self,
  guint     $nth
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_get_size (GtkBitset $self)
  returns guint64
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_get_size_in_range (
  GtkBitset $self,
  guint     $first,
  guint     $last
)
  returns guint64
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_intersect (GtkBitset $self, GtkBitset $other)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_is_empty (GtkBitset $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_get_value (GtkBitsetIter $iter)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_init_at (
  GtkBitsetIter $iter,
  GtkBitset     $set,
  guint         $target,
  CArray[guint] $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_init_first (
  GtkBitsetIter $iter,
  GtkBitset     $set,
  CArray[guint] $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_init_last (
  GtkBitsetIter $iter,
  GtkBitset     $set,
  CArray[gint]  $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_is_valid (GtkBitsetIter $iter)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_next (
  GtkBitsetIter $iter,
  CArray[guint] $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_iter_previous (
  GtkBitsetIter $iter,
  CArray[guint] $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_new_empty
  returns GtkBitset
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_new_range (
  guint $start,
  guint $n_items
)
  returns GtkBitset
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_ref (GtkBitset $self)
  returns GtkBitset
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_remove (
  GtkBitset $self,
  guint     $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_remove_all (GtkBitset $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_remove_range (
  GtkBitset $self,
  guint     $start,
  guint     $n_items
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_remove_range_closed (
  GtkBitset $self,
  guint     $first,
  guint     $last
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_remove_rectangle (
  GtkBitset $self,
  guint     $start,
  guint     $width,
  guint     $height,
  guint     $stride
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_shift_left (GtkBitset $self, guint $amount)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_shift_right (GtkBitset $self, guint $amount)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_splice (
  GtkBitset $self,
  guint     $position,
  guint     $removed,
  guint     $added
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_subtract (GtkBitset $self, GtkBitset $other)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_union (GtkBitset $self, GtkBitset $other)
  is      native(gtk4)
  is      export
{ * }

sub gtk_bitset_unref (GtkBitset $self)
  is      native(gtk4)
  is      export
{ * }

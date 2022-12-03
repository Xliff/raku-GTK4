use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Bitset:ver<4>;

use GLib::Roles::Implementor;

# BOXED

class GTK::Bitset {
  also does GLib::Roles::Implementor;

  has GtkBitset $!gtk-bs is implementor is built;

  submethod BUILD ( :gtk-bitset(:$!gtk-bs) )
  { }

  method GTK::Raw::Definitions::GtkBitset
    is also<GtkBitset>
  { $!gtk-bs }

  method new_empty is also<new-empty> {
    my $gtk-bitset = gtk_bitset_new_empty();

    $gtk-bitset ?? self.bless( :$gtk-bitset ) !! Nil;
  }

  method new_range (Int() $start, Int() $n_items) is also<new-range> {
    my guint ($s, $n) = ($start, $n_items);

    my $gtk-bitset = gtk_bitset_new_range($s, $n);

    $gtk-bitset ?? self.bless( :$gtk-bitset ) !! Nil;
  }

  method add (Int() $value) {
    my guint $v = $value;

    gtk_bitset_add($!gtk-bs, $v);
    self;
  }

  method add_range (Int() $start, Int() $n_items) is also<add-range> {
    my guint ($s, $n) = ($start, $n_items);

    gtk_bitset_add_range($!gtk-bs, $s, $n);
    self;
  }

  method add_range_closed (Int() $first, Int() $last)
    is also<add-range-closed>
  {
    my guint ($f, $l) = ($first, $last);

    gtk_bitset_add_range_closed($!gtk-bs, $f, $l);
    self
  }

  method add_rectangle (
    Int() $start,
    Int() $width,
    Int() $height,
    Int() $stride
  )
    is also<add-rectangle>
  {
    my guint ($s, $w, $h, $st) = ($start, $width, $height, $stride);

    gtk_bitset_add_rectangle($!gtk-bs, $s, $w, $h, $st);
    self;
  }

  method contains (Int() $value) {
    my guint $v = $value;

    so gtk_bitset_contains($!gtk-bs, $value);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_bitset_copy($!gtk-bs),
      $raw,
      |self.getTypePair
    )
  }

  method difference (GtkBitset() $other) {
    gtk_bitset_difference($!gtk-bs, $other);
    self
  }

  method equals (GtkBitset() $other) {
    so gtk_bitset_equals($!gtk-bs, $other);
  }

  method get_maximum
    is also<
      get-maximum
      max
      maximum
    >
  {
    gtk_bitset_get_maximum($!gtk-bs);
  }

  method get_minimum
    is also<
      get-minimum
      min
      minimum
    >
  {
    gtk_bitset_get_minimum($!gtk-bs);
  }

  method getRange is also<range> {
    ( self.get_minimum, self.maximum );
  }

  method get_nth (Int() $nth) is also<get-nth> {
    my guint $n = $nth;

    gtk_bitset_get_nth($!gtk-bs, $n);
    self;
  }

  method get_size
    is also<
      get-size
      size
    >
  {
    gtk_bitset_get_size($!gtk-bs);
  }

  method get_size_in_range (Int() $first, Int() $last)
    is also<get-size-in-range>
  {
    my guint ($f, $l) = ($first, $last);

    gtk_bitset_get_size_in_range($!gtk-bs, $first, $last);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_bitset_get_type, $n, $t );
  }

  method intersect (GtkBitset() $other) {
    gtk_bitset_intersect($!gtk-bs, $other);
    self
  }

  method is_empty is also<is-empty> {
    so gtk_bitset_is_empty($!gtk-bs);
  }

  method ref {
    gtk_bitset_ref($!gtk-bs);
    self;
  }

  method remove (Int() $value) {
    my guint $v = $value;

    gtk_bitset_remove($!gtk-bs, $value);
    self
  }

  method remove_all is also<remove-all> {
    gtk_bitset_remove_all($!gtk-bs);
    self
  }

  method remove_range (Int() $start, Int() $n_items) is also<remove-range> {
    my guint ($s, $n) = ($start, $n_items);

    gtk_bitset_remove_range($!gtk-bs, $s, $n);
    self
  }

  method remove_range_closed (Int() $first, Int() $last)
    is also<remove-range-closed>
  {
    my guint ($f, $l) = ($first, $last);

    gtk_bitset_remove_range_closed($!gtk-bs, $f, $l);
    self;
  }

  method remove_rectangle (
    Int() $start,
    Int() $width,
    Int() $height,
    Int() $stride
  )
    is also<remove-rectangle>
  {
    my guint ($s, $w, $h, $st) = ($start, $width, $height, $stride);

    gtk_bitset_remove_rectangle($!gtk-bs, $s, $w, $h, $st);
    self
  }

  method shift_left (Int() $amount) is also<shift-left> {
    my guint $a = $amount;

    gtk_bitset_shift_left($!gtk-bs, $a);
    self;
  }

  method shift_right (Int() $amount) is also<shift-right> {
    my guint $a = $amount;

    gtk_bitset_shift_right($!gtk-bs, $a);
    self
  }

  method splice (Int() $position, Int() $removed, Int() $added) {
    my gint ($p, $r, $a) = ($position, $removed, $added);

    gtk_bitset_splice($!gtk-bs, $p, $r, $a);
    self
  }

  method subtract (GtkBitset $other) {
    gtk_bitset_subtract($!gtk-bs, $other);
    self;
  }

  method union (GtkBitset() $other) {
    gtk_bitset_union($!gtk-bs, $other);
    self;
  }

  method unref {
    gtk_bitset_unref($!gtk-bs);
  }

}

class GTK::Bitset::Iter {
  also does GLib::Roles::Implementor;

  has GtkBitsetIter $!gtk-bsi is implementor is built;

  submethod BUILD ( :gtk-bitset-iter(:$!gtk-bsi) )
  { }

  method Array {
    my @a = self.value;

    while self.next {
      @a.push: self.value;
    }

    @a;
  }

  method GTK::Raw::Structs::GtkBitsetIter
    is also<GtkBitsetIter>
  { $!gtk-bsi }

  method new (
    GtkBitset()  $set,
                :$at     is copy,
                :$first           = $at ?? False !! True,
                :$last            = $first.not && $at.defined.not,
  ) {
    my $i = GtkBitsetIter.new;
    return Nil unless $i;
    {
       when $first      { ::?CLASS.init_first($i, $set)   }
       when $last       { ::?CLASS.init_last($i, $set)    }
       when $at.defined { ::?CLASS.init_at($i, $set, $at) }

    }
    self.bless( gtk-bitset-iter => $i );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_bitset_iter_get_type, $n, $t );
  }

  method get_value
    is also<
      get-value
      value
    >
  {
    gtk_bitset_iter_get_value($!gtk-bsi);
  }

  proto method init_at (|)
    is static
    is also<init-at>
  { *}

  multi method init_at (
    GtkBitsetIter $iter,
    GtkBitset()   $set,
    Int()         $target,
  ) {
    samewith($iter, $set, $target, $);
  }
  multi method init_at (
    GtkBitsetIter $iter,
    GtkBitset()   $set,
    Int()         $target,
                  $value   is rw
  ) {
    my      $v = newCArray(gint);
    my gint $t = $target;

    gtk_bitset_iter_init_at($iter, $set, $t, $v);
    $value = $v[0]
  }

  proto method init_first (|)
    is also<init-first>
  { * }

  multi method init_first (GtkBitsetIter $iter, GtkBitset() $set) {
    samewith($iter, $set, $);
  }
  multi method init_first (
    GtkBitsetIter $iter,
    GtkBitset()   $set,
                  $value is rw
  ) {
    my $v = newCArray(gint);

    gtk_bitset_iter_init_first($iter, $set, $v);
    $value = $v
  }

  proto method init_last (|)
    is also<init-last>
    is static
  { * }

  multi method init_last (GtkBitsetIter $iter, GtkBitset() $set) {
    samewith($iter, $set, $);
  }
  multi method init_last (
    GtkBitsetIter $iter,
    GtkBitset()   $set,
                  $value is rw
  ) {
    my $v = newCArray(gint);

    gtk_bitset_iter_init_last($iter, $set, $v);
    $value = $v[0]
  }

  method is_valid is also<is-valid> {
    so gtk_bitset_iter_is_valid($!gtk-bsi);
  }

  multi method next {
    samewith($);
  }
  multi method next ($value is rw) {
    my $v = newCArray(gint);

    my $rv = gtk_bitset_iter_next($!gtk-bsi, $v);
    $value = $v[0];
    $rv ?? self !! Nil;
  }

  multi method previous {
    samewith($);
  }
  multi method previous ($value is rw) {
    my $v = newCArray(gint);

    my $rv = gtk_bitset_iter_previous($!gtk-bsi, $v);
    $value = $v;
    $rv ?? self !! Nil;
  }

}

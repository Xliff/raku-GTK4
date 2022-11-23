use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Entry::Buffer:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkEntryBufferAncestry is export of Mu
  where GtkEntryBuffer | GObject;

class GTK::Entry::Buffer {
  also does GLib::Roles::Object;

  has GtkEntryBuffer $!gtk-eb is implementor;

  submethod BUILD ( :$gtk-entry-buffer ) {
    self.setGtkEntryBuffer($gtk-entry-buffer) if $gtk-entry-buffer
  }

  method setGtkEntryBuffer (GtkEntryBufferAncestry $_) {
    my $to-parent;

    $!gtk-eb = do {
      when GtkEntryBuffer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEntryBuffer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkEntryBuffer
    is also<GtkEntryBuffer>
  { $!gtk-eb }

  multi method new (
     $gtk-entry-buffer where * ~~ GtkEntryBufferAncestry,
    :$ref                                                 = True
  ) {
    return unless $gtk-entry-buffer;

    my $o = self.bless( :$gtk-entry-buffer );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $initial_chars,
    Int() $n_initial_chars = $initial_chars.chars
  ) {
    my gint $n = $n_initial_chars;

    my $gtk-entry-buffer = gtk_entry_buffer_new(
      $initial_chars,
      $n_initial_chars
    );

    $gtk-entry-buffer ?? self.bless( :$gtk-entry-buffer ) !! Nil;
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: uint
  method length is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('length', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'length does not allow writing'
      }
    );
  }

  # Type: int
  method max-length is rw  is g-property is also<max_length> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-length', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-length', $gv);
      }
    );
}

  method delete_text (Int() $position, Int() $n_chars) is also<delete-text> {
    my guint  $p = $position;
    my gint   $n = $n_chars;

    gtk_entry_buffer_delete_text($!gtk-eb, $p, $n);
  }

  method emit_deleted_text (Int() $position, Int() $n_chars)
    is also<emit-deleted-text>
  {
    my guint ($p, $n) = ($position, $n_chars);

    gtk_entry_buffer_emit_deleted_text($!gtk-eb, $p, $n);
  }

  method emit_inserted_text (
    Int() $position,
    Str() $chars,
    Int() $n_chars   = $chars.chars
  )
    is also<emit-inserted-text>
  {
    my guint  $p = $position;
    my gint   $n = $n_chars;

    gtk_entry_buffer_emit_inserted_text($!gtk-eb, $p, $chars, $n);
  }

  method get_bytes ( :$raw = False ) is also<get-bytes> {
    propReturnObject(
      gtk_entry_buffer_get_bytes($!gtk-eb),
      $raw,
      |GLib::Bytes.getTypePair
    );
  }

  method get_length is also<get-length> {
    gtk_entry_buffer_get_length($!gtk-eb);
  }

  method get_max_length is also<get-max-length> {
    gtk_entry_buffer_get_max_length($!gtk-eb);
  }

  method get_text is also<get-text> {
    gtk_entry_buffer_get_text($!gtk-eb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_entry_buffer_get_type, $n, $t );
  }

  method insert_text (
    Int() $position,
    Str() $chars,
    Int() $n_chars   = $chars.chars
  )
    is also<insert-text>
  {
    my guint  $p = $position;
    my gint   $n = $n_chars;

    gtk_entry_buffer_insert_text($!gtk-eb, $p, $chars, $n);
  }

  method set_max_length (Int() $max_length) is also<set-max-length> {
    my gint $m = $max_length;
    gtk_entry_buffer_set_max_length($!gtk-eb, $max_length);
  }

  method set_text (Str() $chars, Int() $n_chars = $chars.chars)
    is also<set-text>
  {
    my gint $n = $n_chars;

    gtk_entry_buffer_set_text($!gtk-eb, $chars, $n);
  }

}

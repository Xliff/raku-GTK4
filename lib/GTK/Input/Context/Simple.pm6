use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Input::Context:ver<4>;

use GLib::Roles::Implementor;

our subset GtkIMContextSimpleAncestry is export of Mu
  where GtkIMContextSimple | GtkIMContextAncestry;

class GTK::Input::Context::Simple:ver<4> is GTK::Input::Context:ver<4> {
  has GtkIMContextSimple $!gtk-im-s is implementor;

  submethod BUILD ( :$gtk-im-simple ) {
    self.setGtkIMContextSimple($gtk-im-simple) if $gtk-im-simple
  }

  method setGtkIMContextSimple (GtkIMContextSimpleAncestry $_) {
    my $to-parent;

    $!gtk-im-s = do {
      when GtkIMContextSimple {
        $to-parent = cast(GtkIMContext, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkIMContextSimple, $_);
      }
    }
    self.setGtkIMContext($to-parent);
  }

  method GTK::Raw::Definitions::GtkIMContextSimpleAncestry
    is also<GtkIMContextSimple>
  { $!gtk-im-s }

  multi method new (
     $gtk-im-simple where * ~~ GtkIMContextSimpleAncestry,

    :$ref = True
  ) {
    return unless $gtk-im-simple;

    my $o = self.bless( :$gtk-im-simple );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-ic-simple = gtk_im_context_simple_new();

    $gtk-ic-simple ?? self.bless( :$gtk-ic-simple ) !! Nil;
  }

  method add_compose_file (Str() $compose_file) is also<add-compose-file> {
    gtk_im_context_simple_add_compose_file($!gtk-im-s, $compose_file);
  }

  proto method add_table (|)
    is also<add-table>
  { * }

  multi method add_table (@data, Int() $max_seq_len) {
    samewith( ArrayToCArray(guint16, @data), $max_seq_len, @data.elems );
  }
  multi method add_table (
    CArray[guint16] $data,
    Int()           $max_seq_len,
    Int()           $n_seqs
  ) {
    my gint ($m, $n) = ($max_seq_len, $n_seqs);

    gtk_im_context_simple_add_table($!gtk-im-s, $data, $m, $n);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_im_context_simple_get_type, $n, $t );
  }

}


### /usr/src/gtk4/gtk/gtkimcontextsimple.h

sub gtk_im_context_simple_add_compose_file (
  GtkIMContextSimple $context_simple,
  Str                $compose_file
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_simple_add_table (
  GtkIMContextSimple $context_simple,
  guint16            $data            is rw,
  gint               $max_seq_len,
  gint               $n_seqs
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_simple_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_context_simple_new
  returns GtkIMContextSimple
  is      native(gtk4)
  is      export
{ * }

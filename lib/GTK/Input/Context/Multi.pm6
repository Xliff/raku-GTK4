use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Input::Context:ver<4>;

use GLib::Roles::Implementor;

our subset GtkIMMultiContextAncestry is export of Mu
  where GtkIMMultiContext | GtkIMContextAncestry;

class GTK::Input::Context::Multi {
  has GtkIMMultiContext $!gtk-ic-mc is implementor;

  submethod BUILD ( :$gtk-input-multi ) {
    self.setGtkIMMultiContext($gtk-input-multi)
      if $gtk-input-multi
  }

  method setGtkIMMultiContext (GtkIMMultiContextAncestry $_) {
    my $to-parent;

    $!gtk-ic-mc = do {
      when GtkIMMultiContext {
        $to-parent = cast(GtkIMContext, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkIMMultiContext, $_);
      }
    }
    self.setGtkIMContext($to-parent);
  }

  method GTK::Raw::Definitions::GtkIMMultiContext
    is also<GtkIMMultiContext>
  { $!gtk-ic-mc }

  multi method new (
    $gtk-input-multi where * ~~ GtkIMMultiContextAncestry,

    :$ref = True
  ) {
    return unless $gtk-input-multi;

    my $o = self.bless( :$gtk-input-multi );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-input-multi = gtk_im_multicontext_new();

    $gtk-input-multi ?? self.bless( :$gtk-input-multi ) !! Nil;
  }

  method get_context_id is also<get-context-id> {
    gtk_im_multicontext_get_context_id($!gtk-ic-mc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_im_multicontext_get_type, $n, $t );
  }

  method set_context_id (Str() $context_id) is also<set-context-id> {
    gtk_im_multicontext_set_context_id($!gtk-ic-mc, $context_id);
  }

}

### /usr/src/gtk4/gtk/gtkimmulticontext.h

sub gtk_im_multicontext_get_context_id (GtkIMMultiContext $context)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_multicontext_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_multicontext_new
  returns GtkIMMultiContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_im_multicontext_set_context_id (
  GtkIMMultiContext $context,
  Str               $context_id
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;
#use GTK::Raw::Macros:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor:ver<4>;
use GLib::Roles::Object:ver<4>;

our subset GtkShortcutLabelAncestry is export of Mu
  where GtkShortcutLabel | GObject;

class GTK::Shortcut::Label:ver<4> is GTK::Widget:ver<4> {
  has GtkShortcutLabel $!gtk-sl is implementor;

  submethod BUILD ( :$gtk-shortcut-label ) {
    self.setGtkShortcutLabel($gtk-shortcut-label) if $gtk-shortcut-label
  }

  method setGtkShortcutLabel (GtkShortcutLabelAncestry $_) {
    my $to-parent;

    $!gtk-sl = do {
      when GtkShortcutLabel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutLabel, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutLabel
    is also<GtkShortcutLabel>
  { $!gtk-sl }

  multi method new (
     $gtk-shortcut-label where * ~~ GtkShortcutLabelAncestry,

    :$ref = True
  ) {
    return unless $gtk-shortcut-label;

    my $o = self.bless( :$gtk-shortcut-label );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $accelerator) {
    my $gtk-shortcut-label = gtk_shortcut_label_new($accelerator);

    $gtk-shortcut-label ?? self.bless( :$gtk-shortcut-label ) !! Nil;
  }

  # Type: string
  method accelerator is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accelerator', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accelerator', $gv);
      }
    );
  }

  # Type: string
  method disabled-text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('disabled-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('disabled-text', $gv);
      }
    );
  }

  method get_accelerator is also<get-accelerator> {
    gtk_shortcut_label_get_accelerator($!gtk-sl);
  }

  method get_disabled_text is also<get-disabled-text> {
    gtk_shortcut_label_get_disabled_text($!gtk-sl);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_shortcut_label_get_type, $n, $t );
  }

  method set_accelerator (Str() $accelerator) is also<set-accelerator> {
    gtk_shortcut_label_set_accelerator($!gtk-sl, $accelerator);
  }

  method set_disabled_text (Str() $disabled_text) is also<set-disabled-text> {
    gtk_shortcut_label_set_disabled_text($!gtk-sl, $disabled_text);
  }

}



### /usr/src/gtk4/gtk/gtkshortcutlabel.h

sub gtk_shortcut_label_get_accelerator (GtkShortcutLabel $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_label_get_disabled_text (GtkShortcutLabel $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_label_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_label_new (Str $accelerator)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_label_set_accelerator (
  GtkShortcutLabel $self,
  Str              $accelerator
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_shortcut_label_set_disabled_text (
  GtkShortcutLabel $self,
  Str              $disabled_text
)
  is      native(gtk4)
  is      export
{ * }

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Shortcut::Label;
#   my \P = O.getTypePair;
#   given 'widget-types.json'.IO.open( :rw ) {
#     .lock;
#     my $existing = .slurp;
#     %widgets = try from-json($existing) if $existing.chars;
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::Shortcut::Label;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

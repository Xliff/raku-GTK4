use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Popover:ver<4>;

use GLib::Roles::Implementor;

our subset GtkEmojiChooserAncestry is export of Mu
  where GtkEmojiChooser | GtkPopoverAncestry;

class GTK::EmojiChooser:ver<4> is GTK::Popover:ver<4> {
  has GtkEmojiChooser $!gtk-ec is implementor;

  submethod BUILD ( :$gtk-emoji-chooser ) {
    self.setGtkEmojiChooser($gtk-emoji-chooser) if $gtk-emoji-chooser
  }

  method setGtkEmojiChooser (GtkEmojiChooserAncestry $_) {
    my $to-parent;

    $!gtk-ec = do {
      when GtkEmojiChooser {
        $to-parent = cast(GtkPopover, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEmojiChooser, $_);
      }
    }
    self.setGtkPopover($to-parent);
  }

  method GTK::Raw::Definitions::GtkEmojiChooser
    is also<GtkEmojiChooser>
  { $!gtk-ec }

  multi method new (
    $gtk-emoji-chooser where * ~~ GtkEmojiChooserAncestry,

    :$ref = True
  ) {
    return unless $gtk-emoji-chooser;

    my $o = self.bless( :$gtk-emoji-chooser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-emoji-chooser = gtk_emoji_chooser_new();

    $gtk-emoji-chooser ?? self.bless( :$gtk-emoji-chooser ) !! Nil
  }

  method Emoji-Picked is also<Emoji_Picked> {
    self.connect-string($!gtk-ec, 'emoji-picked');
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_emoji_chooser_get_type, $n, $t );
  }

}

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::EmojiChooser;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     %widgets = from-json( .slurp );
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::EmojiChooser;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}


### /usr/src/gtk4-4.8.1+ds/gtk/gtkemojichooser.h

sub gtk_emoji_chooser_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_emoji_chooser_new
  returns GtkEmojiChooser
  is      native(gtk4)
  is      export
{ * }

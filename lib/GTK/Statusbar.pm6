use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Statusbar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Signals::Statusbar:ver<4>;

our subset GtkStatusbarAncestry is export of Mu
  where GtkStatusbar | GtkWidgetAncestry;

class GTK::Statusbar:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Signals::Statusbar;

  has GtkStatusbar $!gtk-sb is implementor;

  submethod BUILD ( :$gtk-statusbar ) {
    self.setGtkStatusbar($gtk-statusbar) if $gtk-statusbar
  }

  method setGtkStatusbar (GtkStatusbarAncestry $_) {
    my $to-parent;

    $!gtk-sb = do {
      when GtkStatusbar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStatusbar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkStatusbar
    is also<GtkStatusbar>
  { $!gtk-sb }

  multi method new (
    $gtk-statusbar where * ~~ GtkStatusbarAncestry,

    :$ref = True
  ) {
    return unless $gtk-statusbar;

    my $o = self.bless( :$gtk-statusbar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-statusbar = gtk_statusbar_new();

    $gtk-statusbar ?? self.bless( :$gtk-statusbar ) !! Nil;
  }

  method Text-Popped is also<Text_Popped> {
    self.connect-text($!gtk-sb, 'text-popped');
  }

  method Text-Pushed is also<Text_Pushed> {
    self.connect-text($!gtk-sb, 'text-pushed');
  }

  method get_context_id (Str() $context_description) is also<get-context-id> {
    gtk_statusbar_get_context_id($!gtk-sb, $context_description);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_statusbar_get_type, $n, $t );
  }

  method pop (Int() $context_id) {
    my guint $c = $context_id;

    gtk_statusbar_pop($!gtk-sb, $c);
  }

  method push (Int() $context_id, Str() $text) {
    my guint $c = $context_id;

    gtk_statusbar_push($!gtk-sb, $c, $text);
  }

  method remove (Int() $context_id, Int() $message_id) {
    my guint ($c, $m) = ($context_id, $message_id);

    gtk_statusbar_remove($!gtk-sb, $context_id, $message_id);
  }

  method remove_all (Int() $context_id) is also<remove-all> {
    my guint $c = $context_id;

    gtk_statusbar_remove_all($!gtk-sb, $c);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Statusbar;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Statusbar;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

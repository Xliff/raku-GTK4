use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tooltip:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset GtkTooltipAncestry is export of Mu
  where GtkTooltip | GObject;

class GTK::Tooltip:ver<4> {
  also does GLib::Roles::Object;

  has GtkTooltip $!gtk-tt is implementor;

  submethod BUILD ( :$gtk-tooltip ) {
    self.setGtkTooltip($gtk-tooltip) if $gtk-tooltip
  }

  method setGtkTooltip (GtkTooltipAncestry $_) {
    my $to-parent;

    $!gtk-tt = do {
      when GtkTooltip {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTooltip, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTooltip
    is also<GtkTooltip>
  { $!gtk-tt }

  multi method new (
    $gtk-tooltip where * ~~ GtkTooltipAncestry,

    :$ref = True
  ) {
    return unless $gtk-tooltip;

    my $o = self.bless( :$gtk-tooltip );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tooltip_get_type, $n, $t );
  }

  method set_custom (GtkWidget() $custom_widget) is also<set-custom> {
    gtk_tooltip_set_custom($!gtk-tt, $custom_widget);
  }

  method set_icon (GdkPaintable() $paintable) is also<set-icon> {
    gtk_tooltip_set_icon($!gtk-tt, $paintable);
  }

  method set_icon_from_gicon (GIcon() $gicon) is also<set-icon-from-gicon> {
    gtk_tooltip_set_icon_from_gicon($!gtk-tt, $gicon);
  }

  method set_icon_from_icon_name (Str() $icon_name)
    is also<set-icon-from-icon-name>
  {
    gtk_tooltip_set_icon_from_icon_name($!gtk-tt, $icon_name);
  }

  method set_markup (Str() $markup) is also<set-markup> {
    gtk_tooltip_set_markup($!gtk-tt, $markup);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_tooltip_set_text($!gtk-tt, $text);
  }

  method set_tip_area (GdkRectangle() $rect) is also<set-tip-area> {
    gtk_tooltip_set_tip_area($!gtk-tt, $rect);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Tooltip;
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
  my \O = GTK::Tooltip;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

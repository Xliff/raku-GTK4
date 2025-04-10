use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Chooser::Color:ver<4>;

use GLib::Roles::Implementor;

role GTK::Roles::Chooser::Color:ver<4> {
  has GtkColorChooser $!gtk-color-chooser is implementor;

  method roleInit-ColorChooser {
    self.roleInit-GtkColorChooser
  }
  method roleInit-GtkColorChooser {
    return if $!gtk-color-chooser;

    my \i = findProperImplementor(self.^attributes);

    $!gtk-color-chooser = cast( GtkColorChooser, i.get_value(self) );
  }

  method color-activated {
    self.connect($!gtk-color-chooser, 'color-activated');
  }
  method color_activated {
    $.color-activated;
  }

  proto method add_palette (|)
  { * }

  multi method add_palette (
    $orientation,
    $colors_per_line,
    @colors
  ) {
    samewith(
      $orientation,
      $colors_per_line,
      @colors.elems,
      GLib::Roles::TypedBuffer[GdkRGBA].new(@colors).p
    );
  }
  multi method add_palette (
    Int()    $orientation,
    Int()    $colors_per_line,
    Int()    $n_colors,
    gpointer $colors
  ) {
    my GtkOrientation  $o      =  $orientation;
    my gint           ($l, $n) = ($colors_per_line, $n_colors);

    gtk_color_chooser_add_palette(
      $!gtk-color-chooser,
      $o,
      $colors_per_line,
      $n_colors,
      $colors
    );
  }

  proto method get_rgba (GdkRGBA $color)
  { * }

  multi method get_rgba ( :$raw = False ){
    samewith( GdkRGBA.new );
  }
  multi method get_rgba (GdkRGBA $color, :$raw = False) {
    gtk_color_chooser_get_rgba($!gtk-color-chooser, $color);
    propReturnObject($color, $raw, |GDK::RGBA.getTypePair);
  }

  method gtkcolorchooser_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_color_chooser_get_type, $n, $t );
  }

  method get_use_alpha {
    gtk_color_chooser_get_use_alpha($!gtk-color-chooser);
  }

  method set_rgba (GdkRGBA()  $color) {
    gtk_color_chooser_set_rgba($!gtk-color-chooser, $color);
  }

  method set_use_alpha (Int() $use_alpha) {
    my gboolean $u = $use_alpha;

    gtk_color_chooser_set_use_alpha($!gtk-color-chooser, $u);
  }

}

class GTK::Color::Chooser:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Chooser::Color;

  has GtkColorChooser $!gtk-chooser-color;
}

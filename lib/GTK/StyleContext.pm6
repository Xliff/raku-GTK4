use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::StyleContext:ver<4>;

use GDK::Display:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkStyleContextAncestry is export of Mu
  where GtkStyleContext | GObject;

class GTK::StyleContext:ver<4> {
  also does GLib::Roles::Object;

  has GtkStyleContext $!gtk-sc is implementor;

  submethod BUILD ( :$gtk-style-context ) {
    self.setGtkStyleContext($gtk-style-context) if $gtk-style-context
  }

  method setGtkStyleContext (GtkStyleContextAncestry $_) {
    my $to-parent;

    $!gtk-sc = do {
      when GtkStyleContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStyleContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkStyleContext
    is also<GtkStyleContext>
  { $!gtk-sc }

  multi method new (
    GtkStyleContextAncestry  $gtk-style-context,
                            :$ref                = True
  ) {
    return unless $gtk-style-context;

    my $o = self.bless( :$gtk-style-context );
    $o.ref if $ref;
    $o;
  }

  method add_class (Str() $class_name) is also<add-class> {
    gtk_style_context_add_class($!gtk-sc, $class_name);
  }

  method add_provider (
    GtkStyleProvider() $provider,
    Int()              $priority  = GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
  )
    is also<add-provider>
  {
    my guint $p = $priority;

    gtk_style_context_add_provider($!gtk-sc, $provider, $p);
  }

  method addProviderForCurrentDisplay (
    GtkStyleProvider() $provider,
    Int()              $priority  = GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
  )
    is static
  {
    ::?CLASS.add_provider_for_display(
      GDK::Display.get_default,
      $provider,
      $priority
    );
  }

  method add_provider_for_display (
    GdkDisplay()       $display,
    GtkStyleProvider() $provider,
    Int()              $priority  = GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
  )
    is static
    is also<add-provider-for-display>
  {
    my guint $p = $priority;

    gtk_style_context_add_provider_for_display($display, $provider, $p);
  }

  proto method get_border (|)
    is also<get-border>
  { * }

  multi method get_border {
    samewith(GtkBorder.new);
  }
  multi method get_border (GtkBorder() $border) {
    gtk_style_context_get_border($!gtk-sc, $border);
  }

  proto method get_color (|)
    is also<get-color>
  { * }

  multi method get_color {
    samewith(GdkRGBA.new);
  }
  multi method get_color (GdkRGBA() $color) {
    gtk_style_context_get_color($!gtk-sc, $color);
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gtk_style_context_get_display($!gtk-sc),
      $raw,
      |GDK::Display.getTypePair
    )
  }

  proto method get_margin (|)
    is also<get-margin>
  { * }

  multi method get_margin {
    samewith(GtkBorder.new);
  }
  multi method get_margin (GtkBorder() $margin) {
    gtk_style_context_get_margin($!gtk-sc, $margin);
    $margin;
  }

  proto method get_padding (|)
    is also<get-padding>
  { * }

  multi method get_padding {
    samewith(GtkBorder.new);
  }
  multi method get_padding (GtkBorder() $padding) {
    gtk_style_context_get_padding($!gtk-sc, $padding);
  }

  method get_scale is also<get-scale> {
    gtk_style_context_get_scale($!gtk-sc);
  }

  method get_state ( :set(:$flags) = True ) is also<get-state> {
    my $f = gtk_style_context_get_state($!gtk-sc);
    return $f unless $flags;
    getFlags(GtkStateFlagsEnum, $f);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_style_context_get_type, $n, $t );
  }

  method has_class (
    Str             $class_name
  )
    is also<has-class>
  {
    gtk_style_context_has_class($!gtk-sc, $class_name);
  }

  proto method lookup_color (|)
    is also<lookup-color>
  { * }

  multi method lookup_color (Str() $color_name, :$raw) {
    return-with-all( samewith($color_name, GdkRGBA.new, :all, :$raw) );
  }
  multi method lookup_color (
    Str        $color_name,
    GdkRGBA()  $color       is copy,
              :$all                   = False,
              :$raw                   = False
  ) {
    my $rv = gtk_style_context_lookup_color($!gtk-sc, $color_name, $color);

    $color = propReturnObject($color, $raw, |GDK::RGBA.getTypePair);

    $all.not ?? $rv !! ($rv, $color);
  }

  method remove_class (Str() $class_name) is also<remove-class> {
    gtk_style_context_remove_class($!gtk-sc, $class_name);
  }

  method remove_provider (GtkStyleProvider() $provider) is also<remove-provider> {
    gtk_style_context_remove_provider($!gtk-sc, $provider);
  }

  method remove_provider_for_display (GtkStyleProvider() $provider)
    is also<remove-provider-for-display>
  {
    gtk_style_context_remove_provider_for_display($!gtk-sc, $provider);
  }

  method restore {
    gtk_style_context_restore($!gtk-sc);
  }

  method save {
    gtk_style_context_save($!gtk-sc);
  }

  method set_display (GdkDisplay() $display) is also<set-display> {
    gtk_style_context_set_display($!gtk-sc, $display);
  }

  method set_scale (Int() $scale) is also<set-scale> {
    my gint $s = $scale;

    gtk_style_context_set_scale($!gtk-sc, $s);
  }

  method set_state (Int() $flags) is also<set-state> {
    my GtkStateFlags  $f = $flags;

    gtk_style_context_set_state($!gtk-sc, $f);
  }

  method to_string (Int() $flags) is also<to-string> {
    my GtkStyleContextPrintFlags $f = $flags;

    gtk_style_context_to_string($!gtk-sc, $f);
  }

}

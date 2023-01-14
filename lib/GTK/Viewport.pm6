use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Scrollable:ver<4>;

our subset GtkViewportAncestry is export of Mu
  where GtkViewport | GtkWidgetAncestry;

class GTK::Viewport:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Scrollable;

  has GtkViewport $!gtk-vp is implementor;

  submethod BUILD ( :$gtk_viewport ) {
    self.setGtkViewport($gtk_viewport) if $gtk_viewport;
  }

  method setGtkViewport (GtkViewportAncestry $_) {
    my $to-parent;

    $!gtk-vp = do {
      when GtkViewport {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkViewport, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkViewport
    is also<GtkVieport>
  { $!gtk-vp }

  multi method new (
     $gtk_viewport where * ~~ GtkViewportAncestry,

    :$ref = True
  ) {
    return unless $gtk_viewport;

    my $o = self.bless( :$gtk_viewport );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkAdjustment() $hadjustment, GtkAdjustment() $vadjustment) {
    my $gtk-viewport = gtk_viewport_new($hadjustment, $vadjustment);

    $gtk-viewport ?? self.bless( :$gtk-viewport ) !! Nil;
  }
  multi method new (
    GtkAdjustment() :h(:$hadjustment) = GtkAdjustment,
    GtkAdjustment() :v(:$vadjustment) = GtkAdjustment
  ) {
    my $gtk-viewport = gtk_viewport_new($hadjustment, $vadjustment);

    $gtk-viewport ?? self.bless( :$gtk-viewport ) !! Nil;
  }


  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method scroll-to-focus is rw  is g-property is also<scroll_to_focus> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scroll-to-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('scroll-to-focus', $gv);
      }
    );
}

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_viewport_get_child($!gtk-vp),
      $raw,
      $proper
    );
  }

  method get_scroll_to_focus is also<get-scroll-to-focus> {
    gtk_viewport_get_scroll_to_focus($!gtk-vp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_viewport_get_type, $n, $t );
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_viewport_set_child($!gtk-vp, $child);
  }

  method set_scroll_to_focus (Int() $scroll_to_focus) is also<set-scroll-to-focus> {
    my gboolean $s = $scroll_to_focus.so.Int;

    gtk_viewport_set_scroll_to_focus($!gtk-vp, $s);
  }

}

### /usr/src/gtk4/gtk/gtkviewport.h

sub gtk_viewport_get_child (GtkViewport $viewport)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_viewport_get_scroll_to_focus (GtkViewport $viewport)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_viewport_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_viewport_new (GtkAdjustment $hadjustment, GtkAdjustment $vadjustment)
  returns GtkViewport
  is      native(gtk4)
  is      export
{ * }

sub gtk_viewport_set_child (
  GtkViewport $viewport,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_viewport_set_scroll_to_focus (
  GtkViewport $viewport,
  gboolean    $scroll_to_focus
)
  is      native(gtk4)
  is      export
{ * }

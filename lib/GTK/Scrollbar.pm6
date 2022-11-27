use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Raw::Traits;
use GTK::Adjustment:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;

our subset GtkScrollbarAncestry is export of Mu
  where GtkScrollbar | GtkWidgetAncestry;

class GTK::Scrollbar:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;

  has GtkScrollbar $!gtk-sb is implementor;

  submethod BUILD ( :$gtk-scrollbar ) {
    self.setGtkScrollbar($gtk-scrollbar) if $gtk-scrollbar
  }

  method setGtkScrollbar (GtkScrollbarAncestry $_) {
    my $to-parent;

    $!gtk-sb = do {
      when GtkScrollbar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkScrollbar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkScrollbar
    is also<GtkScrollbar>
  { $!gtk-sb }

  multi method new (GtkScrollbarAncestry $gtk-scrollbar, :$ref = True) {
    return unless $gtk-scrollbar;

    my $o = self.bless( :$gtk-scrollbar );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientable, GtkAdjustment() $adjustment) {
    my GtkOrientation $o = $orientable;

    my $gtk-scrollbar = gtk_scrollbar_new($0, $adjustment);

    $gtk-scrollbar ?? self.bless( :$gtk-scrollbar ) !! Nil;
  }

  # Type: GTKAdjustment
  method adjustment ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Adjustment.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('adjustment', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Adjustment.getTypePair
        );
      },
      STORE => -> $, GtkAdjustment() $val is copy {
        $gv.object = $val;
        self.prop_set('adjustment', $gv);
      }
    );
  }

  method get_adjustment ( :$raw = False ) is also<get-adjustment> {
    propReturnObject(
      gtk_scrollbar_get_adjustment($!gtk-sb),
      $raw,
      |GTK::Adjustment.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_scrollbar_get_type, $n, $t );
  }

  method set_adjustment (GtkAdjustment() $adjustment) is also<set-adjustment> {
    gtk_scrollbar_set_adjustment($!gtk-sb, $adjustment);
  }

}


### /usr/src/gtk4-4.8.1+ds/gtk/gtkscrollbar.h

sub gtk_scrollbar_get_adjustment (GtkScrollbar $self)
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollbar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollbar_new (
  GtkOrientation $orientation,
  GtkAdjustment  $adjustment
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollbar_set_adjustment (
  GtkScrollbar  $self,
  GtkAdjustment $adjustment
)
  is      native(gtk4)
  is      export
{ * }

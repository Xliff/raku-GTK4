use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkDragIconAncestry is export of Mu
  where GtkDragIcon | GtkWidgetAncestry;

class GTK::DragIcon is GTK::Widget:ver<4> {
  has GtkDragIcon $!gtk-d-icon is implementor;

  submethod BUILD ( :$gtk-drag-icon ) {
    self.setGtkDragIcon($gtk-drag-icon) if $gtk-drag-icon
  }

  method setGtkDragIcon (GtkDragIconAncestry $_) {
    my $to-parent;

    $!gtk-d-icon = do {
      when GtkDragIcon {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkDragIcon, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkDragIcon
    is also<GtkDragIcon>
  { $!gtk-d-icon }

  multi method new (
     $gtk-drag-icon where * ~~ GtkDragIconAncestry,
    :$ref = True
  ) {
    return unless $gtk-drag-icon;

    my $o = self.bless( :$gtk-drag-icon );
    $o.ref if $ref;
    $o;
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

  method create_widget_for_value (GValue() $value, :$raw = False)
    is also<create-widget-for-value>
    is static
  {
    propReturnObject(
      gtk_drag_icon_create_widget_for_value($value),
      $raw,
      |GTK::Widget.getTypePair
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
      gtk_drag_icon_get_child($!gtk-d-icon),
      $raw,
      $proper
    );
  }

  method get_for_drag ( GdkDrag() $drag, :$raw = False )
    is static
    is also<get-for-drag>
  {
    propReturnObject(
      gtk_drag_icon_get_for_drag($drag),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    @!children.push: $child;
    gtk_drag_icon_set_child($!gtk-d-icon, $child);
  }

  method set_from_paintable (
    GdkDrag()      $drag,
    GdkPaintable() $paintable,
    Int()          $hot_x,
    Int()          $hot_y
  )
    is static
    is also<set-from-paintable>
  {
    my gint ($x, $y) = ($hot_x, $hot_y);

    gtk_drag_icon_set_from_paintable($drag, $paintable, $x, $y);
  }

}


### /usr/src/gtk4/gtk/gtkdragicon.h

sub gtk_drag_icon_create_widget_for_value (GValue $value)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_icon_get_child (GtkDragIcon $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_icon_get_for_drag (GdkDrag $drag)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_icon_set_child (
  GtkDragIcon $self,
  GtkWidget   $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_drag_icon_set_from_paintable (
  GdkDrag      $drag,
  GdkPaintable $paintable,
  gint         $hot_x,
  gint         $hot_y
)
  is      native(gtk4)
  is      export
{ * }

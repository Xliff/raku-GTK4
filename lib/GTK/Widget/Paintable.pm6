use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GDK::Roles::Paintable:ver<4>;

our subset GtkWidgetPaintableAncestry is export of Mu
  where GtkWidgetPaintable | GObject;

class GTK::Widget::Paintable:ver<4> {
  also does GLib::Roles::Object;

  has GtkWidgetPaintable $!gtk-wp is implementor;

  submethod BUILD ( :$gtk-widget-paintable ) {
    self.setGtkWidgetPaintable($gtk-widget-paintable) if $gtk-widget-paintable;
  }

  method setGtkWidgetPaintable (GtkWidgetPaintableAncestry $_) {
    my $to-parent;

    $!gtk-wp = do {
      when GtkWidgetPaintable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkWidgetPaintable, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkWidgetPaintable
    is also<GtkWidgetPaintable>
  { $!gtk-wp }

  multi method new (
    $gtk-widget-paintable where * ~~ GtkWidgetPaintableAncestry,

    :$ref = True
  ) {
    return unless $gtk-widget-paintable;

    my $o = self.bless( :$gtk-widget-paintable );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkWidget() $widget) {
    my $gtk-widget-paintable = gtk_widget_paintable_new($widget);

    $gtk-widget-paintable ?? self.bless( :$gtk-widget-paintable ) !! Nil;
  }

  method get_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-widget>
  {
    returnProperWidget(
      gtk_widget_paintable_get_widget($!gtk-wp),
      $raw,
      $proper
    );
  }

  method set_widget (GtkWidget() $widget) is also<set-widget> {
    gtk_widget_paintable_set_widget($!gtk-wp, $widget);
  }

}


### /usr/src/gtk4/gtk/gtkwidgetpaintable.h

sub gtk_widget_paintable_get_widget (GtkWidgetPaintable $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_paintable_new (GtkWidget $widget)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_paintable_set_widget (
  GtkWidgetPaintable $self,
  GtkWidget          $widget
)
  is      native(gtk4)
  is      export
{ * }

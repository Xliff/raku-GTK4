  use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::LayoutManager:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::LayoutManager:ver<4> {
  also does GLib::Roles::Object;

  has GtkLayoutManager $!gtk-lm is implementor;

  method allocate (
    GtkWidget        $widget,
    gint             $width,
    gint             $height,
    gint             $baseline
  ) {
    gtk_layout_manager_allocate($!gtk-lm, $widget, $width, $height, $baseline);
  }

  method get_layout_child (GtkWidget() $child) {
    gtk_layout_manager_get_layout_child($!gtk-lm, $child);
  }

  method get_request_mode {
    gtk_layout_manager_get_request_mode($!gtk-lm);
  }

  method get_widget (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_layout_manager_get_widget($!gtk-lm),
      $raw,
      $proper
    );
  }

  method layout_changed {
    gtk_layout_manager_layout_changed($!gtk-lm);
  }

  # cw: -XXX- Finish adding multis!\
  method measure (
    GtkWidget        $widget,
    GtkOrientation   $orientation,
    gint             $for_size,
    gint             $minimum          is rw,
    gint             $natural          is rw,
    gint             $minimum_baseline is rw,
    gint             $natural_baseline is rw
  ) {
    gtk_layout_manager_measure($!gtk-lm, $widget, $orientation, $for_size, $minimum, $natural, $minimum_baseline, $natural_baseline);
  }

}

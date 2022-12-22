 use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::HeaderBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkHeaderBarAncestry is export of Mu
  where GtkHeaderBar | GtkWidgetAncestry;

class GTK::HeaderBar:ver<4> is GTK::Widget:ver<4> {
  has GtkHeaderBar $!gtk-hb is implementor;

  submethod BUILD ( :$gtk-header-bar ) {
    self.setGtkHeaderBar($gtk-header-bar) if $gtk-header-bar
  }

  method setGtkHeaderBar (GtkHeaderBarAncestry $_) {
    my $to-parent;

    $!gtk-hb = do {
      when GtkHeaderBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkHeaderBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkHeaderBar
    is also<GtkHeaderBar>
  { $!gtk-hb }

  multi method new (
     $gtk-header-bar where * ~~ GtkHeaderBarAncestry,

    :$ref = True
  ) {
    return unless $gtk-header-bar;

    my $o = self.bless( :$gtk-header-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-header-bar = gtk_header_bar_new();

    $gtk-header-bar ?? self.bless( :$gtk-header-bar ) !! Nil;
  }

  # Type: string
  method decoration-layout is rw  is g-property is also<decoration_layout> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('decoration-layout', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('decoration-layout', $gv);
      }
    );
  }

  # Type: boolean
  method show-title-buttons is rw  is g-property is also<show_title_buttons> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-title-buttons', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-title-buttons', $gv);
      }
    );
  }

  # Type: GtkWidget
  method title-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
    is also<title_widget>
  {
    my $gv = GLib::Value.new( GtkWidget );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('title-widget', $gv);
      }
    );
  }

  method get_decoration_layout is also<get-decoration-layout> {
    gtk_header_bar_get_decoration_layout($!gtk-hb);
  }

  method get_show_title_buttons is also<get-show-title-buttons> {
    so gtk_header_bar_get_show_title_buttons($!gtk-hb);
  }

  method get_title_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-title-widget>
  {
    returnProperWidget(
      gtk_header_bar_get_title_widget($!gtk-hb),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_header_bar_get_type, $n, $t );
  }

  method pack_end (GtkWidget() $child) is also<pack-end> {
    gtk_header_bar_pack_end($!gtk-hb, $child);
  }

  method pack_start (GtkWidget() $child) is also<pack-start> {
    gtk_header_bar_pack_start($!gtk-hb, $child);
  }

  method remove (GtkWidget() $child) {
    gtk_header_bar_remove($!gtk-hb, $child);
  }

  method set_decoration_layout (Str() $layout)
    is also<set-decoration-layout>
  {
    gtk_header_bar_set_decoration_layout($!gtk-hb, $layout);
  }

  method set_show_title_buttons (Int() $setting)
    is also<set-show-title-buttons>
  {
    my gboolean $s = $setting.so.Int;

    gtk_header_bar_set_show_title_buttons($!gtk-hb, $s);
  }

  method set_title_widget (GtkWidget() $title_widget)
    is also<set-title-widget>
  {
    gtk_header_bar_set_title_widget($!gtk-hb, $title_widget);
  }

}

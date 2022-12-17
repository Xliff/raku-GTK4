use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::ActionBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkActionBarAncestry is export of Mu
  where GtkActionBar | GtkWidgetAncestry;

class GTK::ActionBar:ver<4> is GTK::Widget:ver<4> {
  has GtkActionBar $!gtk-ab is implementor;

  submethod BUILD ( :$gtk-action-bar ) {
    self.setGtkActionBar($gtk-action-bar) if $gtk-action-bar
  }

  method setGtkActionBar (GtkActionBarAncestry $_) {
    my $to-parent;

    $!gtk-ab = do {
      when GtkActionBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkActionBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkActionBar
  { $!gtk-ab }

  multi method new (
    $gtk-action-bar where * ~~ GtkActionBarAncestry,

    :$ref = True
  ) {
    return unless $gtk-action-bar;

    my $o = self.bless( :$gtk-action-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-action-bar = gtk_action_bar_new();

    $gtk-action-bar ?? self.bless( :$gtk-action-bar ) !! Nil;
  }

  # Type: boolean
  method revealed is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('revealed', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('revealed', $gv);
      }
    );
  }

  method get_center_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<
      get-center-widget
      center_widget
      center-widget
    >
  {
    returnProperWidget(
      gtk_action_bar_get_center_widget($!gtk-ab),
      $raw,
      $proper
    );
  }

  method get_revealed is also<get-revealed> {
    so gtk_action_bar_get_revealed($!gtk-ab);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_action_bar_get_type, $n, $t );
  }

  method pack_end (GtkWidget() $child) is also<pack-end> {
    gtk_action_bar_pack_end($!gtk-ab, $child);
  }

  method pack_start (GtkWidget() $child) is also<pack-start> {
    gtk_action_bar_pack_start($!gtk-ab, $child);
  }

  method remove (GtkWidget() $child) {
    gtk_action_bar_remove($!gtk-ab, $child);
  }

  method set_center_widget (GtkWidget() $center_widget)
    is also<set-center-widget>
  {
    gtk_action_bar_set_center_widget($!gtk-ab, $center_widget);
  }

  method set_revealed (Int() $revealed) is also<set-revealed> {
    my gboolean $r = $revealed.so.Int;

    gtk_action_bar_set_revealed($!gtk-ab, $r);
  }

}

INIT {
  my \O = GTK::ActionBar;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

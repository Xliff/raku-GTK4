use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::SearchBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;


our subset GtkSearchBarAncestry is export of Mu
  where GtkSearchBar | GtkWidgetAncestry;

class GTK::SearchBar:ver<4> is GTK::Widget:ver<4> {
  has GtkSearchBar $!gtk-sb is implementor;

  submethod BUILD ( :$gtk-search-bar ) {
    self.setGtkSearchBar($gtk-search-bar)
      if $gtk-search-bar
  }

  method setGtkSearchBar (GtkSearchBarAncestry $_) {
    my $to-parent;

    $!gtk-sb = do {
      when GtkSearchBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSearchBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkSearchBar
    is also<GtkSearchBar>
  { $!gtk-sb }

  multi method new (
    $gtk-search-bar where * ~~ GtkSearchBarAncestry,

    :$ref = True
  ) {
    return unless $gtk-search-bar;

    my $o = self.bless( :$gtk-search-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-search-bar = gtk_search_bar_new();

    $gtk-search-bar ?? self.bless( :$gtk-search-bar ) !! Nil;
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
        )
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: GtkWidget
  method key-capture-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
    is also<key_capture_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('key-capture-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        )
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('key-capture-widget', $gv);
      }
    );
  }

  # Type: boolean
  method search-mode-enabled
    is rw
    is g-property
    is also<search_mode_enabled>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-mode-enabled', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('search-mode-enabled', $gv);
      }
    );
  }

  # Type: boolean
  method show-close-button
    is rw
    is g-property
    is also<show_close_button>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-close-button', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-close-button', $gv);
      }
    );
  }

  method connect_entry (GtkEditable() $entry) is also<connect-entry> {
    gtk_search_bar_connect_entry($!gtk-sb, $entry);
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_search_bar_get_child($!gtk-sb),
      $raw,
      $proper
    );
  }

  method get_key_capture_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-key-capture-widget>
  {
    returnProperWidget(
      gtk_search_bar_get_key_capture_widget($!gtk-sb),
      $raw,
      $proper
    );
  }

  method get_search_mode is also<get-search-mode> {
    so gtk_search_bar_get_search_mode($!gtk-sb);
  }

  method get_show_close_button is also<get-show-close-button> {
    so gtk_search_bar_get_show_close_button($!gtk-sb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_search_bar_get_type, $n, $t );
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_search_bar_set_child($!gtk-sb, $child);
  }

  method set_key_capture_widget (GtkWidget() $widget)
    is also<set-key-capture-widget>
  {
    gtk_search_bar_set_key_capture_widget($!gtk-sb, $widget);
  }

  method set_search_mode (Int() $search_mode) is also<set-search-mode> {
    my gboolean $s = $search_mode.so.Int;

    gtk_search_bar_set_search_mode($!gtk-sb, $search_mode);
  }

  method set_show_close_button (Int() $visible)
    is also<set-show-close-button>
  {
    my gboolean $v = $visible.so.Int;

    gtk_search_bar_set_show_close_button($!gtk-sb, $visible);
  }

}

INIT {
  my \O = GTK::SearchBar;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

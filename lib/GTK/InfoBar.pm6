use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::InfoBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

class GTK::InfoBar:ver<4> is GTK::Widget:ver<4> {
  has GtkInfoBar $!gtk-info is implementor;

  method new {
    my $gtk-info-bar = gtk_info_bar_new();

    $gtk-info-bar ?? self.bless( :$gtk-info-bar ) !! Nil
  }

  proto method new_with_buttons (|)
  { * }

  multi method new_with_buttons (
    *@buttons where { .none ~~ Pair && .elems % 2 == 0 }
  ) {
    samewith( @buttons.rotor(2) );
  }
  multi method new_with_buttons (
    @buttons where { .map( *.elems ).all == 2 && .map( .tail ).all ~~ Int }
  ) {
    my $o = ::?CLASS.new;
    $o.add_button( |$_ ) for @buttons;
    $o;
  }
  multi method new_with_buttons (@buttons where *.all ~~ Pair) {
    my $first   = @buttons.shift;
    my $o = ::?CLASS.new_with_button($first.key, $first.value);
    $o.add_button( .key, .value ) for @buttons;
    $o;
  }
  multi method new_with_button (Str() $button, Int() $response) {
    my $gtk-info-bar = gtk_info_bar_new_with_buttons($button, $response, Str);

    $gtk-info-bar ?? self.bless( :$gtk-info-bar ) !! Nil
  }

  # Type: GTKMessageType
  method message-type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkMessageType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('message-type', $gv);
        my $t = $gv.valueFromEnum(GtkMessageType);
        return $t unless $enum;
        GtkMessageTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkMessageType) = $val;
        self.prop_set('message-type', $gv);
      }
    );
  }

  # Type: boolean
  method show-close-button is rw  is g-property {
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

  method Close {
    self.connect($!gtk-info, 'close');
  }

  method Response {
    self.connect-int($!gtk-info, 'response');
  }

  method add_action_widget (GtkWidget()  $child, Int() $response_id) {
    my gint $r = $response_id;

    gtk_info_bar_add_action_widget($!gtk-info, $child, $r);
  }

  method add_button (Str() $button_text, Int() $response_id) {
    my gint $r = $response_id;

    gtk_info_bar_add_button($!gtk-info, $button_text, $r);
  }

  proto method add_buttons (|)
  { * }

  multi method add_buttons (
    *@buttons where { .none ~~ Pair && .elems % 2 == 0 }
  ) {
    samewith( @buttons.rotor(2) );
  }
  multi method add_buttons (
    @buttons where { .map( *.elems ).all == 2 && .map( .tail ).all ~~ Int }
  ) {
    self.add_button( |$_ ) for @buttons;
  }
  multi method add_buttons (@buttons where *.all ~~ Pair) {
    .add_button( .key, .value ) for @buttons.pairs;
  }

  method add_child (GtkWidget() $widget) {
    gtk_info_bar_add_child($!gtk-info, $widget);
  }

  method get_message_type ( :$enum = True ) {
    my $m = gtk_info_bar_get_message_type($!gtk-info);
    return $m unless $enum;
    GtkMessageTypeEnum($m);
  }

  method get_revealed {
    so gtk_info_bar_get_revealed($!gtk-info);
  }

  method get_show_close_button {
    so gtk_info_bar_get_show_close_button($!gtk-info);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_info_bar_get_type, $n, $t );
  }

  method remove_action_widget (GtkWidget() $widget) {
    gtk_info_bar_remove_action_widget($!gtk-info, $widget);
  }

  method remove_child (GtkWidget() $widget) {
    gtk_info_bar_remove_child($!gtk-info, $widget);
  }

  method response (Int() $response_id) {
    my gint $r = $response_id;

    gtk_info_bar_response($!gtk-info, $r);
  }

  method set_default_response (Int() $response_id) {
    my gint $r = $response_id;

    gtk_info_bar_set_default_response($!gtk-info, $r);
  }

  method set_message_type (Int() $message_type) {
    my GtkMessageType $m = $message_type;

    gtk_info_bar_set_message_type($!gtk-info, $m);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting) {
    my gint     $r = $response_id;
    my gboolean $s = $setting;

    gtk_info_bar_set_response_sensitive($!gtk-info, $r, $s);
  }

  method set_revealed (Int() $revealed) {
    my gboolean $r = $revealed;

    gtk_info_bar_set_revealed($!gtk-info, $r);
  }

  method set_show_close_button (Int() $setting) {
    my gboolean $s = $setting;

    gtk_info_bar_set_show_close_button($!gtk-info, $s);
  }

}

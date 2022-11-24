use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::InfoBar:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkInfoBarAncestry is export of Mu
  where GtkInfoBar | GtkWidgetAncestry;

class GTK::InfoBar:ver<4> is GTK::Widget:ver<4> {
  has GtkInfoBar $!gtk-info is implementor;

  submethod BUILD ( :$gtk-info-bar ) {
    self.setGtkInfoBar($gtk-info-bar) if $gtk-info-bar
  }

  method setGtkInfoBar (GtkInfoBarAncestry $_) {
    my $to-parent;

    $!gtk-info = do {
      when GtkInfoBar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkInfoBar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkInfoBar
    is also<GtkInfoBar>
  { $!gtk-info }

  multi method new (GtkInfoBarAncestry $gtk-info-bar, :$ref = True) {
    return unless $gtk-info-bar;

    my $o = self.bless( :$gtk-info-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-info-bar = gtk_info_bar_new();

    $gtk-info-bar ?? self.bless( :$gtk-info-bar ) !! Nil
  }

  proto method new_with_buttons (|)
    is also<new-with-buttons>
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
  multi method new_with_button (Str() $button, Int() $response)
    is also<new-with-button>
  {
    my $gtk-info-bar = gtk_info_bar_new_with_buttons($button, $response, Str);

    $gtk-info-bar ?? self.bless( :$gtk-info-bar ) !! Nil
  }

  # Type: GTKMessageType
  method message-type ( :$enum = True )
    is rw
    is g-property
    is also<message_type>
  {
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
  method show-close-button is rw  is g-property is also<show_close_button> {
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

  method add_action_widget (GtkWidget()  $child, Int() $response_id)
    is also<add-action-widget>
  {
    my gint $r = $response_id;

    gtk_info_bar_add_action_widget($!gtk-info, $child, $r);
  }

  method add_button (Str() $button_text, Int() $response_id)
    is also<add-button>
  {
    my gint $r = $response_id;

    gtk_info_bar_add_button($!gtk-info, $button_text, $r);
  }

  proto method add_buttons (|)
    is also<add-buttons>
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

  method add_child (GtkWidget() $widget) is also<add-child> {
    gtk_info_bar_add_child($!gtk-info, $widget);
  }

  method get_message_type ( :$enum = True ) is also<get-message-type> {
    my $m = gtk_info_bar_get_message_type($!gtk-info);
    return $m unless $enum;
    GtkMessageTypeEnum($m);
  }

  method get_revealed is also<get-revealed> {
    so gtk_info_bar_get_revealed($!gtk-info);
  }

  method get_show_close_button is also<get-show-close-button> {
    so gtk_info_bar_get_show_close_button($!gtk-info);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_info_bar_get_type, $n, $t );
  }

  method remove_action_widget (GtkWidget() $widget)
    is also<remove-action-widget>
  {
    gtk_info_bar_remove_action_widget($!gtk-info, $widget);
  }

  method remove_child (GtkWidget() $widget) is also<remove-child> {
    gtk_info_bar_remove_child($!gtk-info, $widget);
  }

  method response (Int() $response_id) {
    my gint $r = $response_id;

    gtk_info_bar_response($!gtk-info, $r);
  }

  method set_default_response (Int() $response_id)
    is also<set-default-response>
  {
    my gint $r = $response_id;

    gtk_info_bar_set_default_response($!gtk-info, $r);
  }

  method set_message_type (Int() $message_type) is also<set-message-type> {
    my GtkMessageType $m = $message_type;

    gtk_info_bar_set_message_type($!gtk-info, $m);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting)
    is also<set-response-sensitive>
  {
    my gint     $r = $response_id;
    my gboolean $s = $setting;

    gtk_info_bar_set_response_sensitive($!gtk-info, $r, $s);
  }

  method set_revealed (Int() $revealed) is also<set-revealed> {
    my gboolean $r = $revealed;

    gtk_info_bar_set_revealed($!gtk-info, $r);
  }

  method set_show_close_button (Int() $setting)
    is also<set-show-close-button>
  {
    my gboolean $s = $setting;

    gtk_info_bar_set_show_close_button($!gtk-info, $s);
  }

}

INIT {
  my \O = GTK::InfoBar;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

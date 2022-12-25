use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Button::Toggle:ver<4>;

use GTK::Button:ver<4>;

use GLib::Roles::Implementor;

our subset GtkToggleButtonAncestry is export of Mu
  where GtkToggleButton | GtkButtonAncestry;

class GTK::Button::Toggle:ver<4> is GTK::Button:ver<4> {
  has GtkToggleButton $!gtk-tb is implementor;

  submethod BUILD ( :$gtk-toggle-button ) {
    self.setGtkToggleButton($gtk-toggle-button) if $gtk-toggle-button
  }

  method setGtkToggleButton (GtkToggleButtonAncestry $_) {
    my $to-parent;

    $!gtk-tb = do {
      when GtkToggleButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkToggleButton, $_);
      }
    }
    self.setGtkButton($to-parent);
  }

  method GTK::Raw::Structs::GtkToggleButton
    is also<GtkToggleButton>
  { $!gtk-tb }

  multi method new (
    $gtk-toggle-button where * ~~ GtkToggleButtonAncestry,

    :$ref = True
  ) {
    return unless $gtk-toggle-button;

    my $o = self.bless( :$gtk-toggle-button );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-toggle-button = gtk_toggle_button_new();

    $gtk-toggle-button ?? self.bless( :$gtk-toggle-button ) !! Nil;
  }

  method new_with_label (Str() $label) is also<new-with-label> {
    my $gtk-toggle-button = gtk_toggle_button_new_with_label($label);

    $gtk-toggle-button ?? self.bless( :$gtk-toggle-button ) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $gtk-toggle-button = gtk_toggle_button_new_with_mnemonic($label);

    $gtk-toggle-button ?? self.bless( :$gtk-toggle-button ) !! Nil;
  }

  # Type: boolean
  method active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: GtkToggleButton
  method group is rw  is g-property {
    my $gv = GLib::Value.new( GtkToggleButton );
    Proxy.new(
      FETCH => sub ($) {
        warn 'group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkToggleButton = $val;
        self.prop_set('group', $gv);
      }
    );
  }

  method Toggled {
    self.connect($!gtk-tb, 'toggled');
  }

  method get_active is also<get-active> {
    so gtk_toggle_button_get_active($!gtk-tb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_toggle_button_get_type, $n, $t );
  }

  method set_active (Int() $is_active) is also<set-active> {
    my gboolean $i = $is_active.so.Int;

    gtk_toggle_button_set_active($!gtk-tb, $i);
  }

  method set_group (GtkToggleButton() $group) is also<set-group> {
    gtk_toggle_button_set_group($!gtk-tb, $group);
  }

  method toggled {
    gtk_toggle_button_toggled($!gtk-tb);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Button::Toggle;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Button::Toggle;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog::Message:ver<4>;

use GTK::Dialog:ver<4>;

use GLib::Roles::Implementor;

our subset GtkMessageDialogAncestry is export of Mu
  where GtkMessageDialog | GtkDialogAncestry;

class GTK::Dialog::Message:ver<4> is GTK::Dialog:ver<4> {
  has GtkMessageDialog $!gtk-d-m is implementor;

  submethod BUILD ( :$gtk-message-dialog ) {
    self.setGtkMessageDialog($gtk-message-dialog) if $gtk-message-dialog
  }

  method setGtkMessageDialog (GtkMessageDialogAncestry $_) {
    my $to-parent;

    $!gtk-d-m = do {
      when GtkMessageDialog {
        $to-parent = cast(GtkDialog, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMessageDialog, $_);
      }
    }
    self.setGtkDialog($to-parent);
  }

  method GTK::Raw::Definitions::GtkMessageDialog
    is also<GtkMessageDialog>
  { $!gtk-d-m }

  multi method new (
     $gtk-message-dialog where * ~~ GtkMessageDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-message-dialog;

    my $o = self.bless( :$gtk-message-dialog );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()        $message,
    GtkWindow() :$parent   = GtkWindow,
    Int()       :$flags    = GTK_DIALOG_DESTROY_WITH_PARENT,
    Int()       :$type     = GTK_MESSAGE_INFO,
    Int()       :$buttons  = GTK_BUTTONS_CLOSE,
  ) {
    samewith(
      $parent,
      $flags,
      $type,
      $buttons,
      $message,
    );
  }
  multi method new (
    GtkWindow() $parent,
    Int()       $flags,
    Int()       $type,
    Int()       $buttons,
    Str()       $message
  ) {
    my GtkDialogFlags $f = $flags;
    my GtkMessageType $t = $type;
    my GtkButtonsType $b = $buttons;

    my $gtk-message-dialog = gtk_message_dialog_new(
      $parent,
      $flags,
      $type,
      $buttons,
      $message,
      Str
    );

    $gtk-message-dialog ?? self.bless( :$gtk-message-dialog ) !! Nil
  }

  proto method new_with_markup (|)
    is also<new-with-markup>
  { * }

  multi method new_with_markup (
    Str()        $message,
    GtkWindow() :$parent   = GtkWindow,
    Int()       :$flags    = GTK_DIALOG_DESTROY_WITH_PARENT,
    Int()       :$type     = GTK_MESSAGE_INFO,
    Int()       :$buttons  = GTK_BUTTONS_CLOSE
  ) {
    samewith(
      $parent,
      $flags,
      $type,
      $buttons,
      $message
    );
  }
  multi method new_with_markup (
    GtkWindow() $parent,
    Int()       $flags,
    Int()       $type,
    Int()       $buttons,
    Str()       $message
  ) {
    my GtkDialogFlags $f = $flags;
    my GtkMessageType $t = $type;
    my GtkButtonsType $b = $buttons;

    my $gtk-message-dialog = gtk_message_dialog_new_with_markup(
      $parent,
      $flags,
      $type,
      $buttons,
      $message,
      Str
    );

    $gtk-message-dialog ?? self.bless( :$gtk-message-dialog ) !! Nil
  }

  # Type: GtkButtonsType
  method buttons is rw  is g-property {
    my $gv = GLib::Value.new( GtkButtonsType );
    Proxy.new(
      FETCH => sub ($) {
        warn 'buttons does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkButtonsType = $val;
        self.prop_set('buttons', $gv);
      }
    );
  }

  # Type: GtkMessageType
  method message-type ( :$enum = True )
    is rw
    is g-property
    is also<message_type>
  {
    my $gv = GLib::Value.new-enum(GtkMessageType);
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('message-type', $gv);
        my $t = $gv.enum;
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
  method secondary-use-markup
    is rw
    is g-property
    is also<secondary_use_markup>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-use-markup', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('secondary-use-markup', $gv);
      }
    );
  }

  # Type: boolean
  method use-markup is rw  is g-property is also<use_markup> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-markup', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-markup', $gv);
      }
    );
  }

  method format_secondary_markup (Str() $message_format)
    is also<format-secondary-markup>
  {
    gtk_message_dialog_format_secondary_markup($!gtk-d-m, $message_format);
  }

  method format_secondary_text (Str() $message_format)
    is also<format-secondary-text>
  {
    gtk_message_dialog_format_secondary_text($!gtk-d-m, $message_format);
  }

  method get_message_area (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-message-area>
  {
    returnProperWidget(
      gtk_message_dialog_get_message_area($!gtk-d-m),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_message_dialog_get_type, $n, $t );
  }

  method set_markup (Str() $str) is also<set-markup> {
    gtk_message_dialog_set_markup($!gtk-d-m, $str);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Dialog::Message;
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
  my \O = GTK::Dialog::Message;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

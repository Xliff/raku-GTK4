use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog::Alert:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkAlertDialogAncestry is export of Mu
  where GtkAlertDialog | GObject;

class GTK::Dialog::Alert {
  also does GLib::Roles::Object;

  has GtkAlertDialog $!gtk-d-a is implementor;

  submethod BUILD ( :$gtk-alert-dialog ) {
    self.setGtkAlertDialog($gtk-alert-dialog) if $gtk-alert-dialog
  }

  method setGtkAlertDialog (GtkAlertDialogAncestry $_) {
    my $to-parent;

    $!gtk-d-a = do {
      when GtkAlertDialog {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAlertDialog, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkAlertDialog
    is also<GtkAlertDialog>
  { $!gtk-d-a }

  proto method new (|)
  { * }

  multi method new (
     $gtk-alert-dialog where * ~~ GtkAlertDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-alert-dialog;

    my $o = self.bless( :$gtk-alert-dialog );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $message = Str) {
    my $gtk-alert-dialog = gtk_alert_dialog_new($message, Str);

    $gtk-alert-dialog ?? self.bless( :$gtk-alert-dialog ) !! Nil;
  }

  # Type: GtkStrv
  method buttons ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('buttons', $gv);
        my $a = cast(CArray[Str], $gv.boxed);
        return $a if $raw;
        CArrayToArray($raw);
      },
      STORE => -> $, $val is copy {
        $val .= Array if $val.^can('Array');
        $val = ArrayToCArray(Str, $val, :null) if $val ~~ Array;
        $gv.boxed = $val;
        X::GLib::InvalidArgument.new(
          message => "Invalid argument of type { $val.^name } passed to {
                      &?ROUTINE.name }!"
        ).throw unless $val ~~ CArray[Str];
        self.prop_set('buttons', $gv);
      }
    );
  }

  # Type: int
  method cancel-button is rw  is g-property is also<cancel_button> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cancel-button', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('cancel-button', $gv);
      }
    );
  }

  # Type: int
  method default-button is rw  is g-property is also<default_button> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-button', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('default-button', $gv);
      }
    );
  }

  # Type: string
  method detail is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('detail', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('detail', $gv);
      }
    );
  }

  # Type: string
  method message is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('message', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('message', $gv);
      }
    );
  }

  # Type: boolean
  method modal is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('modal', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('modal', $gv);
      }
    );
  }

  multi method choose (
                    &callback,
    gpointer        $user_data   = gpointer,
    GtkWindow()    :$parent      = GtkWindow,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $parent,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method choose (
    GtkWindow()    $parent,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gtk_alert_dialog_choose(
      $!gtk-d-a,
      $parent,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method choose_finish (GAsyncResult() $result)
    is also<choose-finish>
  {
    gtk_alert_dialog_choose_finish($!gtk-d-a, $result);
  }

  method get_buttons is also<get-buttons> {
    gtk_alert_dialog_get_buttons($!gtk-d-a);
  }

  method get_cancel_button is also<get-cancel-button> {
    gtk_alert_dialog_get_cancel_button($!gtk-d-a);
  }

  method get_default_button is also<get-default-button> {
    gtk_alert_dialog_get_default_button($!gtk-d-a);
  }

  method get_detail is also<get-detail> {
    gtk_alert_dialog_get_detail($!gtk-d-a);
  }

  method get_message is also<get-message> {
    gtk_alert_dialog_get_message($!gtk-d-a);
  }

  method get_modal is also<get-modal> {
    so gtk_alert_dialog_get_modal($!gtk-d-a);
  }

  # method get_type is also<get-type> {
  #   state ($n, $t);
  #
  #   unstable_get_type( self.^name, &gtk_alert_dialog_get_type, $n, $t );
  # }

  proto method set_buttons (|)
    is also<set-buttons>
  { * }

  multi method set_buttons (@labels) {
    samewith( ArrayToCArray(Str, @labels) );
  }
  multi method set_buttons (CArray[Str] $labels) {
    gtk_alert_dialog_set_buttons($!gtk-d-a, $labels);
  }

  method set_cancel_button (Int() $button) is also<set-cancel-button> {
    my gint $b = $button;

    gtk_alert_dialog_set_cancel_button($!gtk-d-a, $b);
  }

  method set_default_button (Int() $button) is also<set-default-button> {
    my gint $b = $button;

    gtk_alert_dialog_set_default_button($!gtk-d-a, $b);
  }

  method set_detail (Str() $detail) is also<set-detail> {
    gtk_alert_dialog_set_detail($!gtk-d-a, $detail);
  }

  method set_message (Str() $message) is also<set-message> {
    gtk_alert_dialog_set_message($!gtk-d-a, $message);
  }

  method set_modal (Int() $modal) is also<set-modal> {
    my gboolean $m = $modal.so.Int;

    gtk_alert_dialog_set_modal($!gtk-d-a, $m);
  }

  method show (GtkWindow() $parent) {
    gtk_alert_dialog_show($!gtk-d-a, $parent);
  }

}

# cw: No gtk_dialog_alert_get_type in GTK 4.10!
#
# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Dialog::Alert;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     %widgets = from-json( .slurp );
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }
#
# INIT {
#   my \O = GTK::Dialog::Alert;
#   %widget-types{O.get_type} = {
#     name        => O.^name,
#     object      => O,
#     pair        => O.getTypePair
#   }
# }

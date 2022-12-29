use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GDK::RGBA;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog::Color:ver<4>;

use GLib::Roles::Object;

our subset GtkColorDialogAncestry is export of Mu
  where GtkColorDialog | GObject;

class GTK::Dialog::Color:ver<4> {
  also does GLib::Roles::Object;

  has GtkColorDialog $!gtk-d-color is implementor;

  submethod BUILD ( :$gtk-color-dialog ) {
    self.setGtkColorDialog($gtk-color-dialog) if $gtk-color-dialog
  }

  method setGtkColorDialog (GtkColorDialogAncestry $_) {
    my $to-parent;

    $!gtk-d-color = do {
      when GtkColorDialog {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkColorDialog, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkColorDialog
    is also<GtkColorDialog>
  { $!gtk-d-color }

  multi method new (
    $gtk-color-dialog where * ~~ GtkColorDialogAncestry,

     :$ref = True
  ) {
    return unless $gtk-color-dialog;

    my $o = self.bless( :$gtk-color-dialog );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-color-dialog = gtk_color_dialog_new();

    $gtk-color-dialog ?? self.bless( :$gtk-color-dialog ) !! Nil;
  }

  method modal is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_modal    },
      STORE => -> $, \v { self.set_modal(v) }
  }

  method title is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_title    },
      STORE => -> $, \v { self.set_title(v) }
  }

  method with_alpha
    is also<
      with-alpha
      has_alpha
      has-alpha
    >
    is rw
    is g-accessor
  {
    Proxy.new:
      FETCH => -> $     { self.get_with_alpha    },
      STORE => -> $, \v { self.set_with_alpha(v) }
  }

  proto method choose_rgba (|)
    is also<choose-rgba>
  { * }

  multi method choose_rgba (
                   &callback,
    gpointer       $user_data      = gpointer,
    GtkWindow     :$parent         = GtkWindow,
    GdkRGBA()     :$initial_color  = GdkRGBA,
    GdkRGBA()     :$initial-color  = GdkRGBA,
    GCancellable  :$cancellable    = GCancellable
  ) {
    samewith(
      $parent,
      $initial_color,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method choose_rgba (
    GtkWindow     $parent,
    GdkRGBA       $initial_color,
    GCancellable  $cancellable,
                  &callback,
    gpointer      $user_data      = gpointer
  ) {
    gtk_color_dialog_choose_rgba(
      $!gtk-d-color,
      $parent,
      $initial_color,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method choose_rgba_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False

  )
    is also<choose-rgba-finish>
  {
    clear_error;
    my $c = gtk_color_dialog_choose_rgba_finish(
      $!gtk-d-color,
      $result,
      $error
    );
    set_error($error);
    propReturnObject($c, $raw, |GDK::RGBA.getTypePair)
  }

  method get_modal is also<get-modal> {
    so gtk_color_dialog_get_modal($!gtk-d-color);
  }

  method get_title is also<get-title> {
    gtk_color_dialog_get_title($!gtk-d-color);
  }

  method get_with_alpha is also<get-with-alpha> {
    so gtk_color_dialog_get_with_alpha($!gtk-d-color);
  }

  method set_modal (Int() $modal) is also<set-modal> {
    my gboolean $m = $modal;

    gtk_color_dialog_set_modal($!gtk-d-color, $m);
  }

  method set_title (Str() $title) is also<set-title> {
    gtk_color_dialog_set_title($!gtk-d-color, $title);
  }

  method set_with_alpha (Int() $with_alpha) is also<set-with-alpha> {
    my gboolean $w = $with_alpha;

    gtk_color_dialog_set_with_alpha($!gtk-d-color, $w);
  }

}


# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Dialog::Color;
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
#   my \O = GTK::Dialog::Color;
#   %widget-types{O.get_type} = {
#     name        => O.^name,
#     object      => O,
#     pair        => O.getTypePair
#   }
# }

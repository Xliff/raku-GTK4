use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::NativeDialog:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkNativeDialogAncestry is export of Mu
  where GtkNativeDialog | GObject;

class GTK::NativeDialog:ver<4> {
  also does GLib::Roles::Object;

  has GtkNativeDialog $!gtk-nd is implementor;

  submethod BUILD ( :$gtk-native-dialog ) {
    self.setGtkNativeDialog($gtk-native-dialog) if $gtk-native-dialog
  }

  method setGtkNativeDialog (GtkNativeDialogAncestry $_) {
    my $to-parent;

    $!gtk-nd = do {
      when GtkNativeDialog {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNativeDialog, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkNativeDialog
    is also<GtkNativeDialog>
  { $!gtk-nd }

  multi method new (
    $gtk-native-dialog where * ~~ GtkNativeDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-native-dialog;

    my $o = self.bless( :$gtk-native-dialog );
    $o.ref if $ref;
    $o;
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

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: GtkWindow
  method transient-for ( :$raw = False )
    is rw
    is g-property
    is also<transient_for>
  {
    my $gv = GLib::Value.new( GTK::Window.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transient-for', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Window.getTypePair
        );
      },
      STORE => -> $, GtkWindow() $val is copy {
        $gv.object = $val;
        self.prop_set('transient-for', $gv);
      }
    );
  }

  # Type: boolean
  method visible is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible', $gv);
      }
    );
  }

  method Response {
    self.connect-int($!gtk-nd, 'response');
  }

  method destroy {
    gtk_native_dialog_destroy($!gtk-nd);
  }

  method get_modal is also<get-modal> {
    so gtk_native_dialog_get_modal($!gtk-nd);
  }

  method get_title is also<get-title> {
    gtk_native_dialog_get_title($!gtk-nd);
  }

  method get_transient_for ( :$raw = False ) is also<get-transient-for> {
    propReturnObject(
      gtk_native_dialog_get_transient_for($!gtk-nd),
      $raw,
      |GTK::Window.getTypePair
    );
  }

  method get_visible is also<get-visible> {
    so gtk_native_dialog_get_visible($!gtk-nd);
  }

  method hide {
    gtk_native_dialog_hide($!gtk-nd);
  }

  method set_modal (Int() $modal) is also<set-modal> {
    my gboolean $m = $modal.so.Int;

    gtk_native_dialog_set_modal($!gtk-nd, $m);
  }

  method set_title (Str() $title) is also<set-title> {
    gtk_native_dialog_set_title($!gtk-nd, $title);
  }

  method set_transient_for (GtkWindow() $parent) is also<set-transient-for> {
    gtk_native_dialog_set_transient_for($!gtk-nd, $parent);
  }

  method show {
    gtk_native_dialog_show($!gtk-nd);
  }

}

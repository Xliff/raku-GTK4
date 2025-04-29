use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Chooser::File::Native:ver<4>;

use GTK::NativeDialog:ver<4>;

our subset GtkFileChooserNativeAncestry is export of Mu
  where GtkFileChooserNative | GtkNativeDialogAncestry;

class GTK::File::Chooser::Dialog is GTK::NativeDialog:ver<4> {
  has GtkFileChooserNative $!gfcn is implementor;

  submethod BUILD ( :$gtk-file-native ) {
    self.setGtkFileChooserNative($gtk-file-native) if $gtk-file-native
  }

  method setGtkFileChooserNative (GtkFileChooserNativeAncestry $_) {
    my $to-parent;

    $!gfcn = do {
      when GtkFileChooserNative {
        $to-parent = cast(GtkNativeDialog, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFileChooserNative, $_);
      }
    }
    self.setGtkNativeDialog($to-parent);
  }

  method GTK::Raw::Definitions::GtkFileChooserNative
    is also<GtkFileChooserNative>
  { $!gfcn }

  multi method new (
    $gtk-file-native where * ~~ GtkFileChooserNativeAncestry,

    :$ref = True
  ) {
    return unless $gtk-file-native;

    my $o = self.bless( :$gtk-file-native );
    $o.ref if $ref;
    $o;
  }
  multi method new (
     $title,
    :$action       is copy = GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER,
    :$accept_label         = 'OK',
    :$cancel_label         = 'Cancel',
    :$parent               = GtkWindow,
    :$save
  ) {
    $action = GTK_FILE_CHOOSER_ACTION_SAVE if $save;

    samewith(
      $title,
      $parent,
      $action,
      $accept_label,
      $cancel_label
    );
  }
  multi method new (
    Str()       $title,
    GtkWindow() $parent,
    Int()       $action,
    Str()       $accept_label,
    Str()       $cancel_label
  ) {
    my GtkFileChooserAction $a = $action;

    my $gtk-file-native = GTK::Chooser::File::Native.new(
      $title,
      action => $a,
      ok     => $accept_label,
      cancel => $cancel_label,
      parent => $parent
    );

    $gtk-file-native ?? self.bless( :$gtk-file-native ) !! Nil;
  }

  # Type: string
  method accept-label is rw  is g-property is also<accept_label> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accept-label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accept-label', $gv);
      }
    );
  }

  # Type: string
  method cancel-label is rw  is g-property is also<cancel_label> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cancel-label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('cancel-label', $gv);
      }
    );
  }

  method get_accept_label is also<get-accept-label> {
    gtk_file_chooser_native_get_accept_label($!gfcn);
  }

  method get_cancel_label is also<get-cancel-label> {
    gtk_file_chooser_native_get_cancel_label($!gfcn);
  }

  method set_accept_label (Str() $accept_label) is also<set-accept-label> {
    gtk_file_chooser_native_set_accept_label($!gfcn, $accept_label);
  }

  method set_cancel_label (Str() $cancel_label) is also<set-cancel-label> {
    gtk_file_chooser_native_set_cancel_label($!gfcn, $cancel_label);
  }

}

use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Dialog:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Chooser::Color:ver<4>;

our subset GtkColorChooserDialogAncestry is export of Mu
  where GtkColorChooserDialog | GtkDialogAncestry;

class GTK::Chooser::Color::Dialog:ver<4> is GTK::Dialog {
  also does GTK::Roles::Chooser::Color;

  has GtkColorChooserDialog $!gccd is implementor;

  submethod BUILD ( :$gtk-chooser-color ) {
    self.setGtkColorChooserDialog($gtk-chooser-color) if $gtk-chooser-color
  }

  method setGtkColorChooserDialog (GtkColorChooserDialogAncestry $_) {
    my $to-parent;

    $!gccd = do {
      when GtkColorChooserDialog {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkColorChooser {
        $!gtk-color-chooser = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkColorChooserDialog, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkDialog, $_);
      }
    }
    self.roleInit-GtkColorChooser;
    self.setGtkDialog($to-parent);
  }

  method GTK::Raw::Definitions::GtkColorChooserDialog
    is also<GtkColorChooserDialog>
  { $!gccd }

  multi method new (
    $gtk-chooser-color where * ~~ GtkColorChooserDialogAncestry,

     :$ref = True
  ) {
    return unless $gtk-chooser-color;

    my $o = self.bless( :$gtk-chooser-color );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    samewith(Str, GtkWindow);
  }
  multi method new (
    Str() $title,
          $parent where $parent.^can('GtkWindow')
  ) {
    samewith($title, $parent.GtkWindow);
  }
  multi method new (Str() $title, GtkWindow $parent) {
    my $gtk-chooser-color = gtk_color_chooser_dialog_new($title, $parent);

    $gtk-chooser-color ?? self.bless( :$gtk-chooser-color ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_color_chooser_dialog_get_type,
      $n,
      $t
    );
  }

}

### /usr/src/gtk4/gtk/deprecated/gtkcolorchooserdialog.h

sub gtk_color_chooser_dialog_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_color_chooser_dialog_new (
  Str       $title,
  GtkWindow $parent
)
  returns GtkColorChooserDialog
  is      native(gtk4)
  is      export
{ * }

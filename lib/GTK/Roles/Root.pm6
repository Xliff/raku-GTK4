use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GDK::Display:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Root {
  has GtkRoot $!gtk-r is implementor;

  method roleInit-GtkRoot {
    return if $!gtk-r;

    my \i   = findProperImplementor(self.^attributes);
    $!gtk-r = cast( GtkRoot, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkRoot
  { $!gtk-r }
  method GtkRoot
  { $!gtk-r }

  method get_display ( :$raw = False ) {
    propReturnObject(
      gtk_root_get_display($!gtk-r),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_focus (
    :$raw                   = False,
    :quick(:$fast)          = False,
    :slow(:$proper)         = $fast.not
  ) {
    returnProperWidget(
      gtk_root_get_focus($!gtk-r),
      $raw,
      $proper
    );
  }

  method set_focus (GtkWidget() $focus) {
    gtk_root_set_focus($!gtk-r, $focus);
  }

  method gtkroot_get_type {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gtk_root_get_type, $n, $t );
  }

}

our subset GtkRootAncestry is export of Mu
  where GtkRoot | GObject;

class GTK::Root {
  also does GLib::Roles::Object;
  also does GTK::Roles::Root;

  submethod BUILD ( :$gtk-root ) {
    self.setGtkRoot($gtk-root) if $gtk-root;
  }

  method setGtkRoot (GtkRootAncestry $_) {
    my $to-parent;

    $!gtk-r = do {
      when GtkRoot {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkRoot, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GtkRootAncestry $gtk-root, :$ref = True) {
    return unless $gtk-root;

    my $o = self.bless( :$gtk-root );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gtkroot_get_type
  }

}


### /usr/src/gtk4-4.8.1+ds/gtk/gtkroot.h

sub gtk_root_get_display (GtkRoot $self)
  returns GdkDisplay
  is      native(gtk4)
  is      export
{ * }

sub gtk_root_get_focus (GtkRoot $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_root_set_focus (
  GtkRoot   $self,
  GtkWidget $focus
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_root_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

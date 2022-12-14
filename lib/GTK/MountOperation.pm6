use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::MountOperation:ver<4>;

use GIO::MountOperation;

use GLib::Roles::Implementor;

our subset GtkMountOperationAncestry is export of Mu
  where GtkMountOperation | GMountOperationAncestry;

class GTK::MountOperation:ver<4> is GIO::MountOperation {
  has GtkMountOperation $!gtk-mo is implementor;

  submethod BUILD ( :$gtk-mount-operation ) {
    self.setGtkMountOperation($gtk-mount-operation)
      if $gtk-mount-operation
  }

  method setGtkMountOperation (GtkMountOperationAncestry $_) {
    my $to-parent;

    $!gtk-mo = do {
      when GtkMountOperation {
        $to-parent = cast(GMountOperation, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMountOperation, $_);
      }
    }
    self.setGMountOperation($to-parent);
  }

  method GTK::Raw::Definitions::GtkMountOperation
    is also<GtkMountOperation>
  { $!gtk-mo }

  multi method new (
    $gtk-mount-operation where * ~~ GtkMountOperationAncestry,

    :$ref = True
  ) {
    return unless $gtk-mount-operation;

    my $o = self.bless( :$gtk-mount-operation );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdkDisplay() $window) {
    my $gtk-mount-operation = gtk_mount_operation_new($window);

    $gtk-mount-operation ?? self.bless( :$gtk-mount-operation ) !! Nil;
  }

  # Type: GtkDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Display.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Display.getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  proto method is-showing (|)
    is also<is_showing>
  { * }

  # Type: booleam
  multi method is-showing is rw  is g-property  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-showing', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-showing does not allow writing'
      }
    );
  }

  # Type: GtkWindow
  method parent ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Window.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('parent', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Window.getTypePair
        );
      },
      STORE => -> $, GtkWindow() $val is copy {
        $gv.object = $val;
        self.prop_set('parent', $gv);
      }
    );
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gtk_mount_operation_get_display($!gtk-mo),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_parent (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-parent>
  {
    returnProperWidget(
      gtk_mount_operation_get_parent($!gtk-mo),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_mount_operation_get_type, $n, $t );
  }

  multi method is_showing ( :$method is required ) {
    so gtk_mount_operation_is_showing($!gtk-mo);
  }

  method set_display (GdkDisplay() $display) is also<set-display> {
    gtk_mount_operation_set_display($!gtk-mo, $display);
  }

  method set_parent (GtkWindow() $parent) is also<set-parent> {
    gtk_mount_operation_set_parent($!gtk-mo, $parent);
  }

}

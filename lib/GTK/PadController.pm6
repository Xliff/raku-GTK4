use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkPadControllerAncestry is export of Mu
  where GtkPadController | GtkEventControllerAncestry;

class GTK::PadController:ver<4> is GTK::Event::Controller:ver<4> {
  has GtkPadController $!gtk-pc is implementor;

  submethod BUILD ( :$gtk-pad-controller ) {
    self.setGtkPadContrller($gtk-pad-controller) if $gtk-pad-controller
  }

  method setGtkPadContrller (GtkPadControllerAncestry $_) {
    my $to-parent;

    $!gtk-pc = do {
      when GtkPadController {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPadController, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkPadController
    is also<GtkPadController>
  { $!gtk-pc }

  multi method new (
    $gtk-pad-controller where * ~~ GtkPadControllerAncestry,

    :$ref = True
  ) {
    return unless $gtk-pad-controller;

    my $o = self.bless( :$gtk-pad-controller );
    $o.ref if $ref;
    $o;
  }
  multi method new (GActionGroup() $group, GdkDevice() $pad) {
    my $gtk-action-group = gtk_pad_controller_new($group, $pad);

    $gtk-action-group ?? self.bless( :$gtk-action-group ) !! Nil;
  }

  # Type: GActionGroup
  method action-group ( :$raw = False )
    is rw
    is g-property
    is also<action_group>
  {
    my $gv = GLib::Value.new( GIO::ActionGroup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action-group', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ActionGroup.getTypePair
        );
      },
      STORE => -> $, GActionGroup() $val is copy {
        $gv.object = $val;
        self.prop_set('action-group', $gv);
      }
    );
  }

  # Type: GdkDevice
  method pad ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Device.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pad', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Device.getTypePair
        );
      },
      STORE => -> $, GdkDevice() $val is copy {
        $gv.object = $val;
        self.prop_set('pad', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &gtk_pad_controller_get_type, $n, $t);
  }

  method set_action (
    Int() $type,
    Int() $index,
    Int() $mode,
    Str() $label,
    Str() $action_name
  )
    is also<set-action>
  {
    my GtkPadActionType   $t      =  $type;
    my gint              ($i, $m) = ($index, $mode);

    gtk_pad_controller_set_action(
      $!gtk-pc,
      $t,
      $i,
      $m,
      $label,
      $action_name
    );
  }

  proto method set_action_entries (|)
    is also<set-action-entries>
  { * }

  multi method set_action_entries (@entries) {
    samewith(
      GLib::Roles::TypedBuffer[GtkPadActionEntry].new(@entries).p,
      @entries.elems
    );
  }
  multi method set_action_entries (
    Pointer $entries,    # Array of GtkPadActionEntry
    Int()   $n_entries
  ) {
    my gint $n = $n_entries;

    gtk_pad_controller_set_action_entries($!gtk-pc, $entries, $n);
  }

}

### /usr/src/gtk4/gtk/gtkpadcontroller.h

sub gtk_pad_controller_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_pad_controller_new (
  GActionGroup $group,
  GdkDevice    $pad
)
  returns GtkPadController
  is      native(gtk4)
  is      export
{ * }

sub gtk_pad_controller_set_action (
  GtkPadController $controller,
  GtkPadActionType $type,
  gint             $index,
  gint             $mode,
  Str              $label,
  Str              $action_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_pad_controller_set_action_entries (
  GtkPadController $controller,
  Pointer          $entries,
  gint             $n_entries
)
  is      native(gtk4)
  is      export
{ * }

use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkStackSwitcherAncestry is export of Mu
  where GtkStackSwitcher | GtkWidgetAncestry;

class GTK::Stack::Switcher:ver<4> is GTK::Widget:ver<4> {
  has GtkStackSwitcher $!gtk-ss is implementor;

  submethod BUILD ( :$gtk-stack-switcher ) {
    self.setGtkStackSwitcher($gtk-stack-switcher) if $gtk-stack-switcher
  }

  method setGtkStackSwitcher (GtkStackSwitcherAncestry $_) {
    my $to-parent;

    $!gtk-ss = do {
      when GtkStackSwitcher {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStackSwitcher, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkStackSwitcher
    is also<GtkStackSwitcher>
  { $!gtk-ss }

  multi method new (
    $gtk-stack-switcher where * ~~ GtkStackSwitcherAncestry,

    :$ref = True
  ) {
    return unless $gtk-stack-switcher;

    my $o = self.bless( :$gtk-stack-switcher );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-stack-switcher = gtk_stack_switcher_new();

    $gtk-stack-switcher ?? self.bless( :$gtk-stack-switcher ) !! Nil;
  }

  # Type: GtkStack
  method stack ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Stack.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('stack', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Stack.getTypePair
        );
      },
      STORE => -> $, GtkStack() $val is copy {
        $gv.object = $val;
        self.prop_set('stack', $gv);
      }
    );
  }

  method get_stack ( :$raw = False ) is also<get-stack> {
    propReturnObject(
      gtk_stack_switcher_get_stack($!gtk-ss),
      $raw,
      |GTK::Stack.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_stack_switcher_get_type, $n, $t );
  }

  method set_stack (GtkStack() $stack) is also<set-stack> {
    gtk_stack_switcher_set_stack($!gtk-ss, $stack);
  }

}

### /usr/src/gtk4/gtk/gtkstackswitcher.h

sub gtk_stack_switcher_get_stack (GtkStackSwitcher $switcher)
  returns GtkStack
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_switcher_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_switcher_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_switcher_set_stack (
  GtkStackSwitcher $switcher,
  GtkStack         $stack
)
  is      native(gtk4)
  is      export
{ * }

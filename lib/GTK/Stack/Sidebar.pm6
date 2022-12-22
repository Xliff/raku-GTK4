use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;
use GTK::Stack:ver<4>;

our subset GtkStackSidebarAncestry is export of Mu
  where GtkStackSidebar | GtkWidgetAncestry;

class GTK::Stack::Sidebar:ver<4> is GTK::Widget:ver<4> {
  has GtkStackSidebar $!gtk-ssb is implementor;

  submethod BUILD ( :$gtk-stack-sidebar ) {
    self.setGtkStackSidebar($gtk-stack-sidebar) if $gtk-stack-sidebar
  }

  method setGtkStackSidebar (GtkStackSidebarAncestry $_) {
    my $to-parent;

    $!gtk-ssb = do {
      when GtkStackSidebar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStackSidebar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkStackSidebar
    is also<GtkStackSidebar>
  { $!gtk-ssb }

  multi method new (
     $gtk-stack-sidebar where * ~~ GtkStackSidebarAncestry,

    :$ref = True
  ) {
    return unless $gtk-stack-sidebar;

    my $o = self.bless( :$gtk-stack-sidebar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-stack-sidebar = gtk_stack_sidebar_new();

    $gtk-stack-sidebar ?? self.bless( :$gtk-stack-sidebar ) !! Nil;
  }

  method stack ( :$raw = False ) is rw is g-property {
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
      gtk_stack_sidebar_get_stack($!gtk-ssb),
      $raw,
      |GTK::Stack.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_stack_sidebar_get_type, $n, $t );
  }

  method set_stack (GtkStack() $stack) is also<set-stack> {
    gtk_stack_sidebar_set_stack($!gtk-ssb, $stack);
  }

}

### /usr/src/gtk4/gtk/gtkstacksidebar.h

sub gtk_stack_sidebar_get_stack (GtkStackSidebar $self)
  returns GtkStack
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_sidebar_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_sidebar_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_stack_sidebar_set_stack (
  GtkStackSidebar $self,
  GtkStack        $stack
)
  is      native(gtk4)
  is      export
{ * }

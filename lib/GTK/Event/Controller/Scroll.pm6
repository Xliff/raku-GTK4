use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;

use GTK::Event::Controller:ver<4>;

our subset GtkEventControllerScrollAncestry is export of Mu
  where GtkEventControllerScroll | GtkEventControllerAncestry;

class GTK::Event::Controller::Scroll:ver<4>
  is GTK::Event::Controller:ver<4>
{
  has GtkEventControllerScroll $!gtk-g-s is implementor;

  submethod BUILD ( :$gtk-gesture-scroll ) {
    self.setGtkEventControllerScroll($gtk-gesture-scroll)
      if $gtk-gesture-scroll
  }

  method setGtkEventControllerScroll (GtkEventControllerScrollAncestry $_) {
    my $to-parent;

    $!gtk-g-s = do {
      when GtkEventControllerScroll {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEventControllerScroll, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkEventControllerScroll
    is also<GtkEventControllerScroll>
  { $!gtk-g-s }

  multi method new (
    $gtk-gesture-scroll where * ~~ GtkEventControllerScrollAncestry,

    :$ref = True
  ) {
    return unless $gtk-gesture-scroll;

    my $o = self.bless( :$gtk-gesture-scroll );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $flags) {
    my GtkEventControllerScrollFlags $f = $flags;

    my $gtk-gesture-scroll = gtk_event_controller_scroll_new($f);

    $gtk-gesture-scroll ?? self.bless( :$gtk-gesture-scroll ) !! Nil;
  }

  # Type: GtkEventControllerScrollFlags
  method flags ( :set(:$flags) ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkEventControllerScrollFlags );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('flags', $gv);
        my $f = $gv.enum;
        return $f unless $flags;
        GtkEventControllerScrollFlagsEnum($f);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkEventControllerScrollFlags) = $val;
        self.prop_set('flags', $gv);
      }
    );
  }

  method Decelerate {
    self.connect-numnum($!gtk-g-s, 'decelerate');
  }

  method Scroll {
    self.connect-numnum($!gtk-g-s, 'scroll');
  }

  method Scroll-Begin is also<Scroll_Begin> {
    self.connect($!gtk-g-s, 'scroll-begin');
  }

  method Scroll-End is also<Scroll_End> {
    self.connect($!gtk-g-s, 'scroll-end');
  }

  # cw: This needs consistenct. Are we using flags by default or not.
  #     It might be necessary to return a Flags object that coerces tto Int
  #     so this can always be True
  method get_flags ( :set(:$flags) = False ) is also<get-flags> {
    my $f = gtk_event_controller_scroll_get_flags($!gtk-g-s);
    return $f unless $flags;
    getFlags(GtkEventControllerScrollFlagsEnum, $f);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_event_controller_scroll_get_type,
      $n,
      $t
    );
  }

  method get_unit ( :$enum = True ) is also<get-unit> {
    my $u = gtk_event_controller_scroll_get_unit($!gtk-g-s);
    return $u unless $enum;
    GdkScrollUnitEnum($u);
  }

  method set_flags (Int() $flags) is also<set-flags> {
    my GtkEventControllerScrollFlags $f = $flags;

    gtk_event_controller_scroll_set_flags($!gtk-g-s, $f);
  }

}

### /usr/src/gtk4/gtk/gtkeventcontrollerscroll.h

sub gtk_event_controller_scroll_get_flags (GtkEventControllerScroll $scroll)
  returns GtkEventControllerScrollFlags
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_scroll_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_scroll_get_unit (GtkEventControllerScroll $scroll)
  returns GdkScrollUnit
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_scroll_new (GtkEventControllerScrollFlags $flags)
  returns GtkEventController
  is      native(gtk4)
  is      export
{ * }

sub gtk_event_controller_scroll_set_flags (
  GtkEventControllerScroll      $scroll,
  GtkEventControllerScrollFlags $flags
)
  is      native(gtk4)
  is      export
{ * }

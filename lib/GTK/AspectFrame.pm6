use v6.c;

use Method::Also;

use GLib::Raw::Traits;\
use GTK::Raw::Types:ver<4>;
use GTK::Raw::AspectFrame:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkAspectFrameAncestry is export of Mu
  where GtkAspectFrame | GtkWidgetAncestry;

class GTK::AspectFrame:ver<4> is GTK::Widget:ver<4> {
  has GtkAspectFrame $!gtk-af is implementor;

  submethod BUILD ( :$gtk-aspect-frame ) {
    self.setGtkAspectFrame($gtk-aspect-frame) if $gtk-aspect-frame
  }

  method setGtkAspectFrame (GtkAspectFrameAncestry $_) {
    my $to-parent;

    $!gtk-af = do {
      when GtkAspectFrame {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAspectFrame, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkAspectFrame
    is also<GtkAspectFrame>
  { $!gtk-af }

  multi method new (
    $gtk-aspect-frame where * ~~ GtkAspectFrameAncestry,

    :$ref = True
  ) {
    return unless $gtk-aspect-frame;

    my $o = self.bless( :$gtk-aspect-frame );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    Num() $xalign,
    Num() $yalign,
    Num() $ratio,
    Int() $obey_child
  ) {
    my gfloat   $x = $xalign;
    my gfloat   $y = $yalign;
    my gfloat   $r = $ratio;
    my gboolean $o = $obey_child.so.Int;

    my $gtk-aspect-frame = gtk_aspect_frame_new($x, $y, $r, $o);

    $gtk-aspect-frame ?? self.bless( :$gtk-aspect-frame ) !! Nil;
  }
  multi method new ( *%a ) {
    die "Must specify xalign, yalign, ratio and obey-child!"
      unless %a<xalign> && %a<yalign> && %a<ratio> && %a<obey-child>;

    my $o = samewith( |%a<xalign yalign ratio obey-child>:delete );
    $o.setAttributes(%a) if $o +%a;
    $o;
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GtkWidget );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method obey-child is rw  is g-property is also<obey_child> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('obey-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('obey-child', $gv);
      }
    );
  }

  # Type: float
  method ratio is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ratio', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('ratio', $gv);
      }
    );
  }

  # Type: float
  method xalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: float
  method yalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_aspect_frame_get_child($!gtk-af),
      $raw,
      $proper
    );
  }

  method get_obey_child is also<get-obey-child> {
    so gtk_aspect_frame_get_obey_child($!gtk-af);
  }

  method get_ratio is also<get-ratio> {
    gtk_aspect_frame_get_ratio($!gtk-af);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_aspect_frame_get_type, $n, $t );
  }

  method get_xalign is also<get-xalign> {
    gtk_aspect_frame_get_xalign($!gtk-af);
  }

  method get_yalign is also<get-yalign> {
    gtk_aspect_frame_get_yalign($!gtk-af);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_aspect_frame_set_child($!gtk-af, $child);
  }

  method set_obey_child (Int() $obey_child) is also<set-obey-child> {
    my gboolean $o = $obey_child.so.Int;

    gtk_aspect_frame_set_obey_child($!gtk-af, $o);
  }

  method set_ratio (Num() $ratio) is also<set-ratio> {
    my gfloat $r = $ratio;

    gtk_aspect_frame_set_ratio($!gtk-af, $r);
  }

  method set_xalign (Num() $xalign) is also<set-xalign> {
    my gfloat $x = $xalign;

    gtk_aspect_frame_set_xalign($!gtk-af, $x);
  }

  method set_yalign (Num() $yalign) is also<set-yalign> {
    my gfloat $y = $yalign;

    gtk_aspect_frame_set_yalign($!gtk-af, $y);
  }

}

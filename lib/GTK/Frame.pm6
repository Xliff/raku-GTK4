use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Frame:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkFrameAncestry is export of Mu
  where GtkFrame | GtkWidgetAncestry;

class GTK::Frame:ver<4> is GTK::Widget:ver<4> {
  has GtkFrame $!gtk-f is implementor;

  submethod BUILD ( :$gtk-frame ) {
    self.setGtkFrame($gtk-frame) if $gtk-frame
  }

  method setGtkFrame (GtkFrameAncestry $_) {
    my $to-parent;

    $!gtk-f = do {
      when GtkFrame {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFrame, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkFrame
    is also<GtkFrame>
  { $!gtk-f }

  multi method new (GtkFrameAncestry $gtk-frame, :$ref = True) {
    return unless $gtk-frame;

    my $o = self.bless( :$gtk-frame );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $label = '')  {
    my $gtk-frame = gtk_frame_new($label);

    $gtk-frame ?? self.bless( :$gtk-frame ) !! Nil;
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
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);

        say "Frame-child: { $gv.object }";

        returnProperWidget(
          $gv.object,
          :$raw,
          :$proper
        )
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: GtkWidget
  method label-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
    is also<label_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label-widget', $gv);
        say "label-widget: { $gv.object }";

        returnProperWidget(
          $gv.object,
          :$raw,
          :$proper
        );
      },

      STORE => -> $, GtkWidget() $val is copy {
        $gv.GtkWidget = $val;
        self.prop_set('label-widget', $gv);
      }
    );
  }

  # Type: float
  method label-xalign
    is rw
    is g-property
    is also<label_xalign>
  {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label-xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('label-xalign', $gv);
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
      gtk_frame_get_child($!gtk-f),
      :$raw,
      :$proper
    );
  }

  method get_label is also<get-label> {
    gtk_frame_get_label($!gtk-f);
  }

  method get_label_align is also<get-label-align> {
    gtk_frame_get_label_align($!gtk-f);
  }

  method get_label_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-label-widget>
  {
    my $lw = gtk_frame_get_label_widget($!gtk-f);
    say "LabelWidget: { $lw }";
    say "Type: { $lw.parent.g_type_instance.g_class.g_type }";

    returnProperWidget(
      $lw,
      :$raw,
      :$proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_frame_get_type, $n, $t );
  }

  method set_child (GtkWidget() $child)
    is also<
      set-child
      add
    >
  {
    gtk_frame_set_child($!gtk-f, $child);
  }

  method set_label (Str() $label) is also<set-label> {
    gtk_frame_set_label($!gtk-f, $label);
  }

  method set_label_align (Num() $xalign) is also<set-label-align> {
    my gfloat $x = $xalign;

    gtk_frame_set_label_align($!gtk-f, $x);
  }

  method set_label_widget (GtkWidget() $label_widget) is also<set-label-widget> {
    gtk_frame_set_label_widget($!gtk-f, $label_widget);
  }

}

INIT {
  my \O = GTK::Frame;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

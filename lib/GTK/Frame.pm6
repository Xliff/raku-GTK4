use v6.c;

use Method::Also;

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
  multi method new (Str() $label)  {
    my $gtk-frame = gtk_frame_new($label);

    $gtk-frame ?? self.bless( :$gtk-frame ) !! Nil;
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
      $raw,
      $proper
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
    returnProperWidget(
      gtk_frame_get_label_widget($!gtk-f),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_frame_get_type, $n, $t );
  }

  method set_child (GtkWidget() $child) is also<set-child> {
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

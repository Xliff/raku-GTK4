use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Gesture:ver<4>;

use GLib::GList;
use GDK::Device:ver<4>;
use GDK::Events:ver<4>;
use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;

our subset GtkGestureAncestry is export of Mu
  where GtkGesture | GtkEventControllerAncestry;

class GTK::Gesture:ver<4> is GTK::Event::Controller:ver<4> {
  has GtkGesture $!gtk-g is implementor;

  submethod BUILD ( :$gtk-gesture ) {
    self.setGtkGesture($gtk-gesture) if $gtk-gesture
  }

  method setGtkGesture (GtkGestureAncestry $_) {
    my $to-parent;

    $!gtk-g = do {
      when GtkGesture {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGesture, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkGesture
  { $!gtk-g }

  multi method new (
     $gtk-gesture where * ~~ GtkGestureAncestry,

    :$ref = True
  ) {
    return unless $gtk-gesture;

    my $o = self.bless( :$gtk-gesture );
    $o.ref if $ref;
    $o;
  }

  # Type: uint
  method n-points is rw  is g-property is also<n_points> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-points', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('n-points', $gv);
      }
    );
  }

  method sequence_state is also<sequence-state> is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_sequence_state    },
      STORE => -> $, \v { self.set_sequence_state(v) }
  }

  method get_bounding_box (GdkRectangle() $rect) is also<get-bounding-box> {
    gtk_gesture_get_bounding_box($!gtk-g, $rect);
  }

  proto method get_bounding_box_center (|)
    is also<get-bounding-box-center>
  { * }

  multi method get_bounding_box_center {
    samewith($, $);
  }
  multi method get_bounding_box_center ($x is rw, $y is rw) {
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gtk_gesture_get_bounding_box_center($!gtk-g, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_device ( :$raw = False ) is also<get-device> {
    propReturnObject(
      gtk_gesture_get_device($!gtk-g),
      $raw,
      |GDK::Device.getTypePair
    );
  }

  method get_group ( :$raw = False, :$glist = False ) is also<get-group> {
    returnGList(
      gtk_gesture_get_group($!gtk-g),
      $raw,
      $glist,
      |self.getTypePair
    );
  }

  method get_last_event (GdkEventSequence() $sequence, :$raw = False)
    is also<get-last-event>
  {
    propReturnObject(
      gtk_gesture_get_last_event($!gtk-g, $sequence),
      $raw,
      |GDK::Event.getTypePair
    );
  }

  method get_last_updated_sequence ( :$raw = False )
    is also<get-last-updated-sequence>
  {
    propReturnObject(
      gtk_gesture_get_last_updated_sequence($!gtk-g),
      $raw,
      |GDK::Event::Sequence.getTypePair
    );
  }

  proto method get_point (|)
    is also<get-point>
  { * }

  multi method get_point (GdkEventSequence() $sequence) {
    samewith($sequence, $, $);
  }
  multi method get_point (
    GdkEventSequence() $sequence,
                       $x          is rw,
                       $y          is rw
  ) {
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gtk_gesture_get_point($!gtk-g, $sequence, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_sequence_state (GdkEventSequence() $sequence, :$enum = True)
    is also<get-sequence-state>
  {
    my $s = gtk_gesture_get_sequence_state($!gtk-g, $sequence);
    return $s unless $enum;
    GtkEventSequenceStateEnum($s);
  }

  method get_sequences ( :$raw = False, :$glist = False )
    is also<get-sequences>
  {
    returnGList(
      gtk_gesture_get_sequences($!gtk-g),
      $raw,
      $glist,
      |GDK::Event::Sequences.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_gesture_get_type, $n, $t );
  }

  method group (GtkGesture() $gesture) {
    gtk_gesture_group($!gtk-g, $gesture);
  }

  method handles_sequence (GdkEventSequence() $sequence)
    is also<handles-sequence>
  {
    so gtk_gesture_handles_sequence($!gtk-g, $sequence);
  }

  method is_active is also<is-active> {
    so gtk_gesture_is_active($!gtk-g);
  }

  method is_grouped_with (GtkGesture $other) is also<is-grouped-with> {
    so gtk_gesture_is_grouped_with($!gtk-g, $other);
  }

  method is_recognized is also<is-recognized> {
    so gtk_gesture_is_recognized($!gtk-g);
  }

  method set_sequence_state (
    GdkEventSequence() $sequence,
    Int()              $state
  )
    is also<set-sequence-state>
  {
    my GtkEventSequenceState $s = $state;

    gtk_gesture_set_sequence_state($!gtk-g, $sequence, $s);
  }

  method set_state (Int() $state) is also<set-state> {
    my GtkEventSequenceState $s = $state;

    gtk_gesture_set_state($!gtk-g, $s);
  }

  method ungroup {
    gtk_gesture_ungroup($!gtk-g);
  }

}

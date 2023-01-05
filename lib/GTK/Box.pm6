use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Box:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;

our subset GtkBoxAncestry is export of Mu
  where GtkBox | GtkOrientable | GtkWidgetAncestry;

class GTK::Box:ver<4> is GTK::Widget {
  also does GTK::Roles::Orientable;

  has GtkBox $!gtk-box is implementor;

  submethod BUILD ( :$gtk-box ) {
    self.setGtkBox($gtk-box) if $gtk-box
  }

  method setGtkBox (GtkBoxAncestry $_) {
    my $to-parent;

    $!gtk-box = do {
      when GtkBox {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkOrientable {
        $!gtk-o = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkBox, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkBox, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkOrientable;
  }

  method GTK::Raw::Structs::GtkBox
    is also<GtkBox>
  { $!gtk-box }

  multi method new (
    $gtk-box where $gtk-box ~~ GtkBoxAncestry,

    :$ref = True
  ) {
    return unless $gtk-box;

    my $o = self.bless( :$gtk-box );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientation, Int() $spacing = 0) {
    my GtkOrientation $o = $orientation;
    my gint           $s = $spacing;

    my $gtk-box = gtk_box_new($o, $s);

    $gtk-box ?? self.bless( :$gtk-box ) !! Nil;
  }

  method new-h-box (Int() $spacing = 0)
    is also<
      new_h_box
      new_hbox
      new-hbox
    >
  {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, $spacing);
  }

  method new-v-box (Int() $spacing = 0)
    is also<
      new_v_box
      new_vbox
      new-vbox
    >
  {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, $spacing);
  }

  # Type: int
  method spacing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('spacing', $gv);
      }
    );
  }

  # Type: boolean
  method homogeneous is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('homogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('homogeneous', $gv);
      }
    );
  }

  # Type: GTKBaselinePosition
  method baseline-position ( :$enum = True )
    is rw
    is g-property
    is also<baseline_position>
  {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkBaselinePosition) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('baseline-position', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GtkBaselinePositionEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkBaselinePosition) = $val;
        self.prop_set('baseline-position', $gv);
      }
    );
  }

  method pack_start ($child, *@a)
    is also<pack-start>
  {
    if @a.head {
      (self.orientation == GTK_ORIENTATION_HORIZONTAL
        ?? $child.vexpand
        !! $child.hexpand ) = True;
    }
    if @a.head(2).tail {
      (self.orientation == GTK_ORIENTATION_HORIZONTAL
        ?? $child.hexpand
        !! $child.vexpand ) = True;
    }

    self.prepend($child);
  }

  method pack_end ($child, *@a)
    is also<pack-end>
  {
    if @a.head {
      (self.orientation == GTK_ORIENTATION_HORIZONTAL
        ?? $child.vexpand
        !! $child.hexpand ) = True;
    }
    if @a.head(2).tail {
      (self.orientation == GTK_ORIENTATION_HORIZONTAL
        ?? $child.hexpand
        !! $child.vexpand ) = True;
    }

    self.append($child);
  }


  multi method append (@children) {
    samewith( |@children );
  }
  multi method append (*@children where * > 1) {
    self.append($_) for @children;
  }
  multi method append ($child is copy) {
     $child = $child.GtkWidget if $child.^can('GtkWidget');
    gtk_box_append($!gtk-box, $child);
  }

  method get_baseline_position ( :$enum = True )
    is also<get-baseline-position>
  {
    my $p = gtk_box_get_baseline_position($!gtk-box);
    return $p unless $enum;
    GtkBaselinePositionEnum($p);
  }

  method get_homogeneous is also<get-homogeneous> {
    so gtk_box_get_homogeneous($!gtk-box);
  }

  method get_spacing is also<get-spacing> {
    gtk_box_get_spacing($!gtk-box);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_box_get_type, $n, $t );
  }

  method insert_child_after (GtkWidget() $child, GtkWidget() $sibling)
    is also<insert-child-after>
  {
    gtk_box_insert_child_after($!gtk-box, $child, $sibling);
  }

  multi method prepend (@children) {
    samewith(|@children);
  }
  multi method prepend (*@children where *.elems > 1) {
    self.append($_) for @children;
  }
  multi method prepend (GtkWidget() $child) {
    gtk_box_prepend($!gtk-box, $child);
  }

  method remove (GtkWidget() $child) {
    gtk_box_remove($!gtk-box, $child);
  }

  method reorder_child_after (GtkWidget() $child, GtkWidget() $sibling)
    is also<reorder-child-after>
  {
    gtk_box_reorder_child_after($!gtk-box, $child, $sibling);
  }

  method set_baseline_position (Int() $position)
    is also<set-baseline-position>
  {
    my GtkBaselinePosition $p = $position;

    gtk_box_set_baseline_position($!gtk-box, $p);
  }

  method set_homogeneous (Int() $homogeneous) is also<set-homogeneous> {
    my gboolean $h = $homogeneous.so.Int;

    gtk_box_set_homogeneous($!gtk-box, $h);
  }

  method set_spacing (Int() $spacing) is also<set-spacing> {
    my gint $s = $spacing;

    gtk_box_set_spacing($!gtk-box, $s);
  }

}

INIT {
  my \O = GTK::Box;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

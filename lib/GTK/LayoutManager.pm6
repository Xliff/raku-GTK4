use v6.c;

use Method::Also;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::LayoutManager:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Layout::Child:ver<4> { ... }

our subset GtkLayoutManagerAncestry is export of Mu
  where GtkLayoutManager | GObject;

class GTK::LayoutManager:ver<4> {
  also does GLib::Roles::Object;

  has GtkLayoutManager $!gtk-lm is implementor;

  submethod BUILD ( :$gtk-layout-manager ) {
    self.setGtkLayoutManager($gtk-layout-manager) if $gtk-layout-manager
  }

  method setGtkLayoutManager (GtkLayoutManagerAncestry $_) {
    my $to-parent;

    $!gtk-lm = do {
      when GtkLayoutManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkLayoutManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkLayoutManager
    is also<GtkLayoutManager>
  { $!gtk-lm }

  method new (
    GtkLayoutManagerAncestry  $gtk-layout-manager,
                             :$ref                 = True
  ) {
    return unless $gtk-layout-manager;

    my $o = self.bless( :$gtk-layout-manager );
    $o.ref if $ref;
    $o;
  }

  method allocate (
    GtkWidget() $widget,
    Int()       $width,
    Int()       $height,
    Int()       $baseline
  ) {
    my gint ($w, $h, $b) = ($width, $height, $baseline);

    gtk_layout_manager_allocate($!gtk-lm, $widget, $w, $h, $b);
  }

  method get_layout_child (GtkWidget() $child, :$raw = False)
    is also<get-layout-child>
  {
    propReturnObject(
      gtk_layout_manager_get_layout_child($!gtk-lm, $child),
      $raw,
      |GTK::Layout::Child.getTypePair
    );
  }

  method get_request_mode ( :$enum = True ) is also<get-request-mode> {
    my $m = gtk_layout_manager_get_request_mode($!gtk-lm);
    return $m unless $enum;
    GtkSizeRequestModeEnum($m);
  }

  method get_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-widget>
  {
    returnProperWidget(
      gtk_layout_manager_get_widget($!gtk-lm),
      $raw,
      $proper
    );
  }

  method layout_changed is also<layout-changed> {
    gtk_layout_manager_layout_changed($!gtk-lm);
  }

  multi method measure (
    GtkWidget() $widget,
    Int()       $orientation,
    Int()       $for_size
  ) {
    samewith($widget, $orientation, $for_size, $, $, $, $);
  }
  multi method measure (
    GtkWidget() $widget,
    Int()       $orientation,
    Int()       $for_size,
                $minimum          is rw,
                $natural          is rw,
                $minimum_baseline is rw,
                $natural_baseline is rw
  ) {
    my GtkOrientation  $o                = $orientation;
    my gint            $f                = $for_size;
    my gint           ($m, $n, $mb, $nb) = 0 xx 4;

    gtk_layout_manager_measure($!gtk-lm, $widget, $o, $f, $m, $n, $mb, $nb);
    ($minimum, $natural, $minimum_baseline, $natural_baseline) =
      ($m, $n, $mb, $nb)
  }

}

our subset GtkLayoutChildAncestry is export of Mu
  where GtkLayoutChild | GObject;

class GTK::Layout::Child {
  also does GLib::Roles::Object;

  has GtkLayoutChild $!gtk-lc;

  submethod BUILD ( :$gtk-layout-child ) {
    self.setGtkLayoutChild($gtk-layout-child) if $gtk-layout-child
  }

  method setGtkLayoutManager (GtkLayoutChildAncestry $_) {
    my $to-parent;

    $!gtk-lc = do {
      when GtkLayoutChild {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkLayoutChild, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkLayoutManager
    is also<GtkLayoutManager>
  { $!gtk-lc }

  method new (GtkLayoutChildAncestry $gtk-layout-child, :$ref = True) {
    return unless $gtk-layout-child;

    my $o = self.bless( :$gtk-layout-child );
    $o.ref if $ref;
    $o;
  }

  method get_child_widget (
    :$raw,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child-widget>
  {
    returnProperWidget(
      gtk_layout_child_get_child_widget($!gtk-lc),
      $raw,
      $proper
    );
  }

  method get_layout_manager ( :$raw = False ) is also<get-layout-manager> {
    propReturnObject(
      gtk_layout_child_get_layout_manager($!gtk-lc),
      $raw,
      |GTK::LayoutManger.getTypePair
    );
  }

}

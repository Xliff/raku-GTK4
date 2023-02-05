use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::DragSource:ver<4>;

use GTK::Gesture::Single:ver<4>;

use GLib::Roles::Implementor:ver<4>;
use GTK::Roles::Signals::DragSource:ver<4>;

our subset GtkDragSourceAncestry is export of Mu
  where GtkDragSource | GtkGestureSingleAncestry;

class GTK::DragSource:ver<4> is GTK::Gesture::Single:ver<4> {
  also does GTK::Roles::Signals::DragSource;

  has GtkDragSource $!gtk-ds is implementor;

  submethod BUILD ( :$gtk-drag-source ) {
    self.setGtkDragSource($gtk-drag-source) if $gtk-drag-source
  }

  method setGtkDragSource (GtkDragSourceAncestry $_) {
    my $to-parent;

    $!gtk-ds = do {
      when GtkDragSource {
        $to-parent = cast(GtkGestureSingle, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkDragSource, $_);
      }
    }
    self.setGtkGestureSingle($to-parent);
  }

  method GTK::Raw::Definitions::GtkDragSource
    is also<GtkDragSource>
  { $!gtk-ds }

  multi method new (
     $gtk-drag-source where * ~~ GtkDragSourceAncestry,

    :$ref = True
  ) {
    return unless $gtk-drag-source;

    my $o = self.bless( :$gtk-drag-source );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-drag-source = gtk_drag_source_new();

    $gtk-drag-source ?? self.bless( :$gtk-drag-source ) !! Nil;
  }

  # Type: GtkDragAction
  method actions ( :$flags = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkDragAction) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('actions', $gv);
        my $f = $gv.valueFromEnum(GdkDragAction);
        return $f unless $flags;
        getFlags(GdkDragActionEnum, $f);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdkDragAction) = $val;
        self.prop_set('actions', $gv);
      }
    );
  }

  # Type: GdkContentProvider
  method content ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::ContentProvider.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::ContentProvider.getTypePair
        );
      },
      STORE => -> $, GdkContentProvider() $val is copy {
        $gv.object = $val;
        self.prop_set('content', $gv);
      }
    );
  }

  method Drag-Begin is also<Drag_Begin> {
    self.connect-gdkdrag($!gtk-ds, 'drag-begin');
  }

  method Drag-Cancel is also<Drag_Cancel> {
    self.connect-drag-cancel($!gtk-ds);
  }

  method Drag-End is also<Drag_End> {
    self.connect-drag-end($!gtk-ds);
  }

  method Prepare {
    self.connect-prepare($!gtk-ds);
  }

  method drag_cancel is also<drag-cancel> {
    gtk_drag_source_drag_cancel($!gtk-ds);
  }

  method get_actions ( :$flags = False ) is also<get-actions> {
    my $f = gtk_drag_source_get_actions($!gtk-ds);
    return $f unless $flags;
    getFlags(GdkDragActionEnum, $f);
  }

  method get_content ( :$raw = False ) is also<get-content> {
    propReturnObject(
      gtk_drag_source_get_content($!gtk-ds),
      $raw,
      |GDK::ContentProvider.getTypePair
    );
  }

  method get_drag ( :$raw = False ) is also<get-drag> {
    propReturnObject(
      gtk_drag_source_get_drag($!gtk-ds),
      $raw,
      |GDK::Drag.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_drag_source_get_type, $n, $t );
  }

  method drag_check_threshold (
    GtkWidget() $widget,
    Int()       $start_x,
    Int()       $start_y,
    Int()       $current_x,
    Int()       $current_y
  )
    is static
    is also<drag-check-threshold>
  {
    my gint ($sx, $sy, $cx, $cy) =
      ($start_x, $start_y, $current_x, $current_y);

    gtk_drag_check_threshold($widget, $sx, $sy, $cx, $cy);
  }

  proto method set_actions (|)
    is also<set-actions>
  { * }

  multi method set_actions ( :$ask, :$copy, :$link, :$move, :$all ) {
    samewith( resolveGdkActions( :$ask, :$copy, :$link, :$move, :$all ) );
  }
  multi method set_actions (Int() $actions) {
    my GdkDragAction $a = $actions;

    gtk_drag_source_set_actions($!gtk-ds, $a);
  }

  method set_content (GdkContentProvider() $content) is also<set-content> {
    gtk_drag_source_set_content($!gtk-ds, $content);
  }

  method set_icon (
    GdkPaintable() $paintable,
    Int()          $hot_x,
    Int()          $hot_y
  )
    is also<set-icon>
  {
    my gint ($x, $y) = ($hot_x, $hot_y);

    gtk_drag_source_set_icon($!gtk-ds, $paintable, $x, $y);
  }

}

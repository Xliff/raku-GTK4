use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::DropTarget:ver<4>;

use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::DropTarget:ver<4>;


our subset GtkDropTargetAncestry is export of Mu
  where GtkDropTarget | GtkEventControllerAncestry;

class GTK::DropTarget:ver<4> is GTK::Event::Controller:ver<4> {
  also does GTK::Roles::Signals::DropTarget;

  has GtkDropTarget $!gtk-d-t is implementor;

  submethod BUILD ( :$gtk-drop-target ) {
    self.setGtkDropTarget($gtk-drop-target)
      if $gtk-drop-target
  }

  method setGtkDropTarget (GtkDropTargetAncestry $_) {
    my $to-parent;

    $!gtk-d-t = do {
      when GtkDropTarget {
        $to-parent = cast(GtkEventController, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkDropTarget, $_);
      }
    }
    self.setGtkEventController($to-parent);
  }

  method GTK::Raw::Definitions::GtkDropTarget
    is also<GtkDropTarget>
  { $!gtk-d-t }

  multi method new (
     $gtk-drop-target where * ~~ GtkDropTargetAncestry,

    :$ref = True
  ) {
    return unless $gtk-drop-target;

    my $o = self.bless( :$gtk-drop-target );
    $o.ref if $ref;
    $o;
  }

  method !resolveActions (
    :$ask,
    :$copy,
    :$link,
    :$move,
    :$all
  ) {
    my $actions = 0;
    $actions +|= GDK_ACTION_ASK  if $ask  || $all;
    $actions +|= GDK_ACTION_COPY if $copy || $all;
    $actions +|= GDK_ACTION_LINK if $link || $all;
    $actions +|= GDK_ACTION_MOVE if $move || $all;
  }

  multi method new (
    Int()  $type,
          :$ask,
          :$copy,
          :$link,
          :$move,
          :$all
  ) {
    samewith(
      $type,
      self!resolveActions(:$ask, :$copy, :$link, :$move, :$all)
    );
  }
  multi method new (Int() $type, Int() $actions) {
    my GdkDragAction $a = $actions;

    my $gtk-drag-action = gtk_drop_target_new($!gtk-d-t, $a);

    $gtk-drag-action ?? self.bless( :$gtk-drag-action ) !! Nil;
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

  # Type: GtkDrop
  method current-drop ( :$raw = False )
    is rw
    is g-property
    is also<current_drop>
  {
    my $gv = GLib::Value.new( GDK::Drop.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('current-drop', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Drop.geTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'current-drop does not allow writing'
      }
    );
  }

  # Type: GtkDrop
  method drop ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Drop.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('drop', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Drop.getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        warn 'drop does not allow writing'
      }
    );
  }

  # Type: GtkContentFormats
  method formats ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::ContentFormats.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('formats', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::ContentFormats.getTypePair
        );
      },
      STORE => -> $, GdkContentFormats() $val is copy {
        $gv.object = $val;
        self.prop_set('formats', $gv);
      }
    );
  }

  # Type: boolean
  method preload is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('preload', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('preload', $gv);
      }
    );
  }

  # Type: GtkValue
  method value ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Value.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'value does not allow writing'
      }
    );
  }

  method Accept {
    self.connect-gdkdrop($!gtk-d-t, 'accept');
  }

  method Drop {
    self.connect-drop($!gtk-d-t);
  }

  method Enter {
    self.connect-numnum-ruint($!gtk-d-t, 'enter');
  }

  method Leave {
    self.conncet($!gtk-d-t, 'leave');
  }

  method Motion {
    self.connect-numnum-ruint($!gtk-d-t, 'motion');
  }

  method get_actions ( :$flags = False ) is also<get-actions> {
    my $f = gtk_drop_target_get_actions($!gtk-d-t);
    return $f unless $flags;
    getFlags(GdkDragActionEnum, $f);
  }

  method get_current_drop ( :$raw = False ) is also<get-current-drop> {
    propReturnObject(
      gtk_drop_target_get_current_drop($!gtk-d-t),
      $raw,
      |GDK::Drop.getTypePair
    );
  }

  method get_drop ( :$raw = False ) is also<get-drop> {
    propReturnObject(
      gtk_drop_target_get_drop($!gtk-d-t),
      $raw,
      |GDK::Drop.getTypePair
    );
  }

  method get_formats ( :$raw = False ) is also<get-formats> {
    propReturnObject(
      gtk_drop_target_get_formats($!gtk-d-t),
      $raw,
      |GDK::ContentFormats.getTypePair
    );
  }

  method get_gtypes ($n_types is rw, :$raw = False) is also<get-gtypes> {
    my gsize $n = 0;

    my $ta = gtk_drop_target_get_gtypes($!gtk-d-t, $n);
    $n_types = $n;

    return ($ta, $n) if $raw;
    CArrayToArray($ta, $n);
  }

  method get_preload is also<get-preload> {
    so gtk_drop_target_get_preload($!gtk-d-t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_drop_target_get_type, $n, $t );
  }

  method get_value ( :$raw = False ) is also<get-value> {
    propReturnObject(
      gtk_drop_target_get_value($!gtk-d-t),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method reject {
    gtk_drop_target_reject($!gtk-d-t);
  }

  proto method set_actions (|)
    is also<set-actions>
  { * }

  multi method set_actions ( :$ask, :$copy, :$link, :$move, :$all ) {
    samewith(
      self!resolveActions(:$ask, :$copy, :$link, :$move, :$all)
    );
  }
  multi method set_actions (Int() $actions) {
    my GdkDragAction $a = $actions;

    gtk_drop_target_set_actions($!gtk-d-t, $actions);
  }

  proto method set_gtypes (|)
    is also<set-gtypes>
  { * }

  multi method set_gtypes (@types) {
    samewith( ArrayToCArray(GType, @types), @types.elems );
  }
  multi method set_gtypes (CArray[GType] $types, Int() $n_types) {
    my gsize $n = $n_types;

    gtk_drop_target_set_gtypes($!gtk-d-t, $types, $n_types);
  }

  method set_preload (Int() $preload) is also<set-preload> {
    my gboolean $p = $preload.so.Int;

    gtk_drop_target_set_preload($!gtk-d-t, $p);
  }

}

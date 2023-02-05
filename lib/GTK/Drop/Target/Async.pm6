use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Drop::Target::Async:ver<4>;

use GTK::Event::Controller:ver<4>;

use GLib::Roles::Implementor;

class GTK::Drop::Target::Async is GTK::Event::Controller:ver<4> {
  has GtkDropTargetAsync $!gtk-dta is implementor;

  multi method new (
    GdkContentFormats()  $formats,
                        :$ask,
                        :$copy,
                        :$link,
                        :$move,
                        :$all
  ) {
    samewith(
      $formats,
      resolveGdkActions(:$ask, :$copy, :$link, :$move, :$all)
    );
  }
  multi method new (GdkContentFormats() $formats, Int() $actions) {
    my GdkDragAction $a = $actions;

    my $gdk-drop-async = gtk_drop_target_async_new($formats, $a);

    $gdk-drop-async ?? self.bless( :$gdk-drop-async ) !! Nil;
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

  method get_actions ( :$flags = False ) {
    my $f = gtk_drop_target_async_get_actions($!gtk-dta);
    return $f unless $flags;
    getFlags(GdkDragActionEnum, $f);
  }

  method get_formats ( :$raw = False )  {
    propReturnObject(
      gtk_drop_target_async_get_formats($!gtk-dta),
      $raw,
      |GDK::ContentFormats.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_drop_target_async_get_type, $n, $t );
  }

  method reject_drop (GdkDrop() $drop) {
    gtk_drop_target_async_reject_drop($!gtk-dta, $drop);
  }

  proto method set_actions (|)
  { * }

  multi method set_actions ( :$ask, :$copy, :$link, :$move, :$all ) {
    samewith(
      resolveGdkActions(:$ask, :$copy, :$link, :$move, :$all)
    );
  }
  multi method set_actions (Int() $actions) {
    my GdkDragAction $a = $actions;

    gtk_drop_target_async_set_actions($!gtk-dta, $a);
  }

  method set_formats (GdkContentFormats() $formats) {
    gtk_drop_target_async_set_formats($!gtk-dta, $formats);
  }

}

use v6.c;

use Method::Also;

use Cairo;
use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::DrawingArea:ver<4>;

use GTK::Widget;

use GLib::Roles::Implementor;

our subset GtkDrawingAreaAncestry is export of Mu
  where GtkDrawingArea | GtkWidgetAncestry;

class GTK::DrawingArea:ver<4> is GTK::Widget:ver<4> {
  has GtkDrawingArea $!gtk-da is implementor;

  submethod BUILD ( :$gtk-drawing-area ) {
    self.setGtkDrawingArea($gtk-drawing-area) if $gtk-drawing-area
  }

  method setGtkDrawingArea (GtkDrawingAreaAncestry $_) {
    my $to-parent;

    $!gtk-da = do {
      when GtkDrawingArea {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkDrawingArea, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkDrawingArea
    is also<GtkDrawingArea>
  { $!gtk-da }

  multi method new (GtkDrawingAreaAncestry $gtk-drawing-area, :$ref = True) {
    return unless $gtk-drawing-area;

    my $o = self.bless( :$gtk-drawing-area );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-drawing-area = gtk_drawing_area_new();

    $gtk-drawing-area  ?? self.bless( :$gtk-drawing-area  ) !! Nil;
  }

  # Type: int
  method content-width is rw  is g-property is also<content_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('content-width', $gv);
      }
    );
  }

  # Type: int
  method content-height is rw  is g-property is also<content_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('content-height', $gv);
      }
    );
  }

  method Resize {
    self.connect-intint($!gtk-da, 'resize');
  }

  method get_content_height is also<get-content-height> {
    gtk_drawing_area_get_content_height($!gtk-da);
  }

  method get_content_width is also<get-content-width> {
    gtk_drawing_area_get_content_width($!gtk-da);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_drawing_area_get_type, $n, $t );
  }

  method set_content_height (Int() $height) is also<set-content-height> {
    my gint $h = $height;

    gtk_drawing_area_set_content_height($!gtk-da, $h);
  }

  method set_content_width (Int() $width) is also<set-content-width> {
    my gint $w = $width;

    gtk_drawing_area_set_content_width($!gtk-da, $w);
  }

  method set_draw_func (
              &draw_func,
    gpointer  $user_data  = gpointer,
              &destroy    = %DEFAULT-CALLBACKS<GDestroyNotify>,
             :$raw        = False
  )
    is also<set-draw-func>
  {
    gtk_drawing_area_set_draw_func(
      $!gtk-da,
      -> *@a {
        CATCH {
          default { .message.say; .backtrace.concise.say }
        }

        my $ct = $raw ?? @a[1] !! Cairo::Context.new( @a[1] );
        &draw_func( self, $ct, |@a.skip(2) );
      },
      $user_data,
      &destroy
    );
  }
}

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::DrawingArea;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     %widgets = from-json( .slurp );
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::DrawingArea;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

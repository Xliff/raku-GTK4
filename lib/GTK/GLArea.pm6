use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::GLArea:ver<4>;

use GDK::GLContext:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkGLAreaAncestry is export of Mu
  where GtkGLArea | GtkWidgetAncestry;

class GTK::GLArea:ver<4> is GTK::Widget:ver<4> {
  has GtkGLArea $!gtk-gla is implementor;

  submethod BUILD ( :$gtk-gl-area ) {
    self.setGtkGLArea($gtk-gl-area) if $gtk-gl-area
  }

  method setGtkGLArea (GtkGLAreaAncestry $_) {
    my $to-parent;

    $!gtk-gla = do {
      when GtkGLArea {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkGLArea, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkGLArea
    is also<GtkGLArea>
  { $!gtk-gla }

  multi method new ($gtk-gl-area where * ~~ GtkGLAreaAncestry, :$ref = True) {
    return unless $gtk-gl-area;

    my $o = self.bless( :$gtk-gl-area );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-gl-area = gtk_gl_area_new();

    $gtk-gl-area ?? self.bless( :$gtk-gl-area ) !! Nil
  }

  # Type: boolean
  method auto-render is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('auto-render', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('auto-render', $gv);
      }
    );
  }

  # Type: GtkGlContext
  method context ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::GLContext.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('context', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::GLArea.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'context does not allow writing'
      }
    );
  }

  # Type: boolean
  method has-depth-buffer is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-depth-buffer', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-depth-buffer', $gv);
      }
    );
  }

  # Type: boolean
  method has-stencil-buffer is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-stencil-buffer', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-stencil-buffer', $gv);
      }
    );
  }

  # Type: boolean
  method use-es is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-es', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-es', $gv);
      }
    );
  }

  method attach_buffers is also<attach-buffers> {
    gtk_gl_area_attach_buffers($!gtk-gla);
  }

  method get_auto_render is also<get-auto-render> {
    so gtk_gl_area_get_auto_render($!gtk-gla);
  }

  method get_context ( :$raw = False ) is also<get-context> {
    propReturnObject(
      gtk_gl_area_get_context($!gtk-gla),
      $raw,
      |GDK::GLContext.getTypePair
    );
  }

  method get_error is also<get-error> {
    ppr( gtk_gl_area_get_error($!gtk-gla) );
  }

  method get_has_depth_buffer is also<get-has-depth-buffer> {
    so gtk_gl_area_get_has_depth_buffer($!gtk-gla);
  }

  method get_has_stencil_buffer is also<get-has-stencil-buffer> {
    so gtk_gl_area_get_has_stencil_buffer($!gtk-gla);
  }

  proto method get_required_version (|)
    is also<get-required-version>
  { * }

  multi method get_required_version {
    samewith($, $);
  }
  multi method get_required_version ($major is rw, $minor is rw) {
    my gint ($m1, $m2) = 0 xx 2;
    gtk_gl_area_get_required_version($!gtk-gla, $m1, $m2);
    ($major, $minor) = ($m1, $m2);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_gl_area_get_type, $n, $t );
  }

  method get_use_es is also<get-use-es> {
    so gtk_gl_area_get_use_es($!gtk-gla);
  }

  method make_current is also<make-current> {
    gtk_gl_area_make_current($!gtk-gla);
  }

  method queue_render is also<queue-render> {
    gtk_gl_area_queue_render($!gtk-gla);
  }

  method set_auto_render (Int() $auto_render) is also<set-auto-render> {
    my gboolean $a = $auto_render.so.Int;

    gtk_gl_area_set_auto_render($!gtk-gla, $a);
  }

  method set_error (Pointer[GError] $error) is also<set-error> {
    gtk_gl_area_set_error($!gtk-gla, $error);
  }

  method set_has_depth_buffer (Int() $has_depth_buffer)
    is also<set-has-depth-buffer>
  {
    my gboolean $h = $has_depth_buffer.so.Int;

    gtk_gl_area_set_has_depth_buffer($!gtk-gla, $h);
  }

  method set_has_stencil_buffer (Int() $has_stencil_buffer)
    is also<set-has-stencil-buffer>
  {
    my gboolean $h = $has_stencil_buffer.so.Int;

    gtk_gl_area_set_has_stencil_buffer($!gtk-gla, $h);
  }

  method set_required_version (Int() $major, Int() $minor)
    is also<set-required-version>
  {
    my gint ($m1, $m2) = ($major, $minor);

    gtk_gl_area_set_required_version($!gtk-gla, $major, $minor);
  }

  method set_use_es (Int() $use_es) is also<set-use-es> {
    my gboolean $u = $use_es.so.Int;

    gtk_gl_area_set_use_es($!gtk-gla, $u);
  }

}

INIT {
  my \O = GTK::GLArea;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

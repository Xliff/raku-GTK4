use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Renderer::Toggle:ver<4>;

use GTK::Cell::Renderer:ver<4>;

our subset GtkCellRendererToggleAncestry is export of Mu
  where GtkCellRendererToggle | GtkCellRendererAncestry;

class GTK::Cell::Renderer::Toggle is GTK::Cell::Renderer {
  has GtkCellRendererToggle $!gtk-crt is implementor;

  submethod BUILD ( :$gtk-renderer-toggle ) {
    self.setGtkCellRendererToggle($gtk-renderer-toggle)
      if $gtk-renderer-toggle
  }

  method setGtkCellRendererToggle (GtkCellRendererToggleAncestry $_) {
    my $to-parent;

    $!gtk-crt = do {
      when GtkCellRendererToggle {
        $to-parent = cast(GtkCellRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellRendererToggle, $_);
      }
    }
    self.setGtkCellRenderer($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellRendererToggle
    is also<GtkCellRendererToggle>
  { $!gtk-crt }

  multi method new (
    $gtk-renderer-toggle where * ~~ GtkCellRendererToggleAncestry,

    :$ref = True
  ) {
    return unless $gtk-renderer-toggle;

    my $o = self.bless( :$gtk-renderer-toggle );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-renderer-toggle = gtk_cell_renderer_toggle_new();

    $gtk-renderer-toggle ?? self.bless( :$gtk-renderer-toggle ) !! Nil;
  }

  # Type: boolean
  method activatable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activatable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activatable', $gv);
      }
    );
  }

  # Type: boolean
  method active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: boolean
  method inconsistent is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('inconsistent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('inconsistent', $gv);
      }
    );
  }

  # Type: boolean
  method radio is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('radio', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('radio', $gv);
      }
    );
  }

  method Toggled {
    self.connect-string($!gtk-crt, 'toggled');
  }

  method get_activatable is also<get-activatable> {
    so gtk_cell_renderer_toggle_get_activatable($!gtk-crt);
  }

  method get_active is also<get-active> {
    so gtk_cell_renderer_toggle_get_active($!gtk-crt);
  }

  method get_radio is also<get-radio> {
    so gtk_cell_renderer_toggle_get_radio($!gtk-crt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_toggle_get_type, $n, $t )
  }

  method set_activatable (Int() $setting) is also<set-activatable> {
    my gboolean $s = $setting.so.Int;

    gtk_cell_renderer_toggle_set_activatable($!gtk-crt, $s);
  }

  method set_active (Int() $setting) is also<set-active> {
    my gboolean $s = $setting.so.Int;

    gtk_cell_renderer_toggle_set_active($!gtk-crt, $s);
  }

  method set_radio (Int() $radio) is also<set-radio> {
    my gboolean $r = $radio.so.Int;

    gtk_cell_renderer_toggle_set_radio($!gtk-crt, $r);
  }

}

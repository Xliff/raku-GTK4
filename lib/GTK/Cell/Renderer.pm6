use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Renderer:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Cell::Editable;

our subset GtkCellRendererAncestry is export of Mu
  where GtkCellRenderer | GObject;

class GTK::Cell::Renderer:ver<4> {
  also does GLib::Roles::Object;

  has GtkCellRenderer $!gtk-cr is implementor;

  submethod BUILD ( :$gtk-cell-renderer ) {
    self.setGtkCellRenderer($gtk-cell-renderer) if $gtk-cell-renderer
  }

  method setGtkCellRenderer (GtkCellRendererAncestry $_) {
    my $to-parent;

    $!gtk-cr = do {
      when GtkCellRenderer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellRenderer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellRenderer
    is also<GtkCellRenderer>
  { $!gtk-cr }

  multi method new (
    $gtk-cell-renderer where * ~~ GtkCellRendererAncestry,

    :$ref = True
  ) {
    return unless $gtk-cell-renderer;

    my $o = self.bless( :$gtk-cell-renderer );
    $o.ref if $ref;
    $o;
  }

  # Type: string
  method cell-background is rw  is g-property is also<cell_background> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'cell-background does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('cell-background', $gv);
      }
    );
  }

  # Type: GtkRgba
  method cell-background-rgba ( :$raw = False )
    is rw
    is g-property
    is also<cell_background_rgba>
  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cell-background-rgba', $gv);
        propReturnObject( $gv.pointer, $raw, |GDK::RGBA.getTypePair );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.pointer = $val;
        self.prop_set('cell-background-rgba', $gv);
      }
    );
  }

  # Type: boolean
  method editing is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('editing', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'editing does not allow writing'
      }
    );
  }

  # Type: int
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: boolean
  method is-expanded is rw  is g-property is also<is_expanded> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-expanded', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-expanded', $gv);
      }
    );
  }

  # Type: boolean
  method is-expander is rw  is g-property is also<is_expander> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-expander', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-expander', $gv);
      }
    );
  }

  # Type: GtkCellRendererMode
  method mode ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.new-enum(GtkCellRendererMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkCellRendererModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.value-from-enum(GtkCellRendererMode) = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  # Type: boolean
  method sensitive is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('sensitive', $gv);
      }
    );
  }

  # Type: boolean
  method visible is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible', $gv);
      }
    );
  }

  # Type: int
  method width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # Type: float
  method xalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: uint
  method xpad is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xpad', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('xpad', $gv);
      }
    );
  }

  # Type: float
  method yalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  # Type: uint
  method ypad is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ypad', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('ypad', $gv);
      }
    );
  }

  method Editing-Canceled
    is also<
      Editing-Cancelled
      Editing_Cancelled
      Editing_Canceled
    >
  {
    self.connect($!gtk-cr, 'editing-canceled');
  }

  # Is originally:
  # GtkCellRenderer *cell,  GtkCellEditable *editable,  char *path --> void
  method Editing-Started {
    self.connect-editing-started($!gtk-cr);
  }

  method activate (
    GdkEvent()     $event,
    GtkWidget()    $widget,
    Str()          $path,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    Int()          $flags
  ) {
    my GtkCellRendererState $f = $flags;

    so gtk_cell_renderer_activate(
      $!gtk-cr,
      $event,
      $widget,
      $path,
      $background_area,
      $cell_area,
      $f
    );
  }

  proto method get_aligned_area (|)
    is also<get-aligned-area>
  { * }

  multi method get_aligned_area ($widget, $flags, $cell_area, :$raw = False) {
    samewith($widget, $flags, $cell_area, GdkRectangle.new, :$raw);
  }
  multi method get_aligned_area (
    GtkWidget()     $widget,
    Int()           $flags,
    GdkRectangle()  $cell_area,
    GdkRectangle()  $aligned_area,
                   :$raw           = False
  ) {
    my GtkCellRendererState $f = $flags;

    gtk_cell_renderer_get_aligned_area(
      $!gtk-cr,
      $widget,
      $flags,
      $cell_area,
      $aligned_area
    );

    propReturnObject(
      $aligned_area,
      $raw,
      |GDK::Rectangle.getTypePair
      :!ref
    );
  }

  proto method get_alignment(|)
    is also<get-alignment>
  { * }

  multi method get_alignment  {
    samewith($, $);
  }
  multi method get_alignment ($xalign is rw, $yalign is rw) {
    my gfloat ($x, $y) = 0e0 xx 2;

    gtk_cell_renderer_get_alignment($!gtk-cr, $x, $y);
    ($xalign, $yalign) = ($x, $y);
  }

  proto method get_fixed_size (|)
    is also<get-fixed-size>
  { * }

  multi method get_fixed_size {
    samewith($, $);
  }
  multi method get_fixed_size ($width is rw, $height is rw) {
    my gfloat ($w, $h) = 0e0 xx 2;

    gtk_cell_renderer_get_fixed_size($!gtk-cr, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_is_expanded is also<get-is-expanded> {
    so gtk_cell_renderer_get_is_expanded($!gtk-cr);
  }

  method get_is_expander is also<get-is-expander> {
    so gtk_cell_renderer_get_is_expander($!gtk-cr);
  }

  proto method get_padding (|)
    is also<get-padding>
  { * }

  multi method get_padding {
    samewith($, $);
  }
  multi method get_padding ($xpad is rw, $ypad is rw) {
    my gint ($x, $y) = 0 xx 2;

    gtk_cell_renderer_get_padding($!gtk-cr, $xpad, $ypad);
    ($xpad, $ypad) = ($x, $y);
  }

  proto method get_preferred_height (|)
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height ($widget) {
    samewith($widget, $, $);
  }
  multi method get_preferred_height (
    GtkWidget() $widget,
                $minimum_size is rw,
                $natural_size is rw
  ) {
    my gint ($m, $n) = 0 xx 2;

    gtk_cell_renderer_get_preferred_height($!gtk-cr, $widget, $m, $n);
    ($minimum_size, $natural_size) = ($m, $n);
  }

  proto method get_preferred_height_for_width (|)
    is also<get-preferred-height-for-width>
  { * }

  multi method get_preferred_height_for_width ($widget, $width) {
    samewith($widget, $width, $, $);
  }
  multi method get_preferred_height_for_width (
    GtkWidget() $widget,
    Int()       $width,
                $minimum_height is rw,
                $natural_height is rw
  ) {
    my gint ($w, $m, $n) = ($width, 0, 0);

    gtk_cell_renderer_get_preferred_height_for_width(
      $!gtk-cr,
      $widget,
      $w,
      $m,
      $n
    );
    ($minimum_height, $natural_height) = ($m, $n);
  }

  proto method get_preferred_size (|)
    is also<get-preferred-size>
  { * }

  multi method get_preferred_size ($widget, :$raw = False) {
    samewith($widget, GtkRequisition.new, GtkRequisition.new, :$raw);
  }
  multi method get_preferred_size (
    GtkWidget()        $widget,
    GtkRequisition()   $minimum_size,
    GtkRequisition()   $natural_size,
                      :$raw           = False
  ) {
    gtk_cell_renderer_get_preferred_size(
      $!gtk-cr,
      $widget,
      $minimum_size,
      $natural_size
    );

    (
      propReturnObject($minimum_size, $raw, |GTK::Requisition.getTypePair),
      propReturnObject($natural_size, $raw, |GTK::Requisition.getTypePair)
    );
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width ($widget) {
    samewith($widget, $, $);
  }
  multi method get_preferred_width (
    GtkWidget() $widget,
                $minimum_size is rw,
                $natural_size is rw
  ) {
    my gint ($m, $n) = 0 xx 2;

    gtk_cell_renderer_get_preferred_width($!gtk-cr, $widget, $m, $n);
    ($minimum_size, $natural_size) = ($m, $n);
  }

  proto method get_preferred_width_for_height (|)
    is also<get-preferred-width-for-height>
  { * }

  multi method get_preferred_width_for_height ($widget, $height) {
    samewith($widget, $height, $, $);
  }
  multi method get_preferred_width_for_height (
    GtkWidget() $widget,
    Int()       $height,
                $minimum_width is rw,
                $natural_width is rw
  ) {
    my gint ($h, $m, $n) = ($height, 0, 0);

    gtk_cell_renderer_get_preferred_width_for_height(
      $!gtk-cr,
      $widget,
      $h,
      $m,
      $n
    );
    ($minimum_width, $natural_width) = ($m, $n);
  }

  method get_request_mode ( :$enum = True ) is also<get-request-mode> {
    my $m = gtk_cell_renderer_get_request_mode($!gtk-cr);
    return $m unless $enum;
    GtkSizeRequestModeEnum($m);
  }

  method get_sensitive is also<get-sensitive> {
    so gtk_cell_renderer_get_sensitive($!gtk-cr);
  }

  proto method get_state (|)
    is also<get-state>
  { * }

  # cw: Not right now...
  # multi method get_state (
  #    $widget,
  #   :sel(:$selected),
  #   :p(:pre(:$prelit)),
  #   :i(:$insensitive),
  #   :s(:$sorted),
  #   :f(:$focused),
  #   :$expandable,
  #   :$expanded
  # ) {
  # }
  multi method get_state (
    GtkWidget()  $widget,
    Int()        $cell_state,
                :set(:$flags) = True
  ) {
    my GtkCellRendererState $c = $cell_state;

    my $s = gtk_cell_renderer_get_state($!gtk-cr, $widget, $c);
    return $s unless $flags;
    getFlags(GtkStateFlagsEnum, $s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_get_type, $n, $t );
  }

  method get_visible is also<get-visible> {
    so gtk_cell_renderer_get_visible($!gtk-cr);
  }

  method is_activatable is also<is-activatable> {
    so gtk_cell_renderer_is_activatable($!gtk-cr);
  }

  method set_alignment (Num() $xalign, Num() $yalign) is also<set-alignment> {
    my gfloat ($x, $y) = ($xalign, $yalign);

    gtk_cell_renderer_set_alignment($!gtk-cr, $x, $y);
  }

  method set_fixed_size (Int() $width,Int() $height) is also<set-fixed-size> {
    my gint ($w, $h) = ($width, $height);

    gtk_cell_renderer_set_fixed_size($!gtk-cr, $w, $h);
  }

  method set_is_expanded (Int() $is_expanded) is also<set-is-expanded> {
    my gboolean $i = $is_expanded.so.Int;

    gtk_cell_renderer_set_is_expanded($!gtk-cr, $i);
  }

  method set_is_expander (Int() $is_expander) is also<set-is-expander> {
    my gboolean $i = $is_expander.so.Int;

    gtk_cell_renderer_set_is_expander($!gtk-cr, $i);
  }

  method set_padding (Int() $xpad, Int() $ypad) is also<set-padding> {
    my gint ($x, $y) = ($xpad, $ypad);

    gtk_cell_renderer_set_padding($!gtk-cr, $x, $y);
  }

  method set_sensitive (Int() $sensitive) is also<set-sensitive> {
    my gboolean $s = $sensitive.so.Int;

    gtk_cell_renderer_set_sensitive($!gtk-cr, $s);
  }

  method set_visible (Int() $visible) is also<set-visible> {
    my gboolean $v = $visible.so.Int;

    gtk_cell_renderer_set_visible($!gtk-cr, $v);
  }

  method snapshot (
    GtkSnapshot()  $snapshot,
    GtkWidget()    $widget,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    Int()          $flags
  ) {
    my GtkCellRendererState $f = $flags;

    gtk_cell_renderer_snapshot(
      $!gtk-cr,
      $snapshot,
      $widget,
      $background_area,
      $cell_area,
      $f
    );
  }

  method start_editing (
    GdkEvent()      $event,
    GtkWidget()     $widget,
    Str()           $path,
    GdkRectangle()  $background_area,
    GdkRectangle()  $cell_area,
    Int()           $flags,
                   :$raw              = False
  )
    is also<start-editing>
  {
    my GtkCellRendererState $f = $flags;

    propReturnObject(
      gtk_cell_renderer_start_editing(
        $!gtk-cr,
        $event,
        $widget,
        $path,
        $background_area,
        $cell_area,
        $f
      ),
      $raw,
      |GTK::Cell::Editable.getTypePair
    );
  }

  method stop_editing (Int() $canceled) is also<stop-editing> {
    my gboolean $c = $canceled.so.Int;

    gtk_cell_renderer_stop_editing($!gtk-cr, $c);
  }

}

use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Snapshot:ver<4>;

use GDK::Snapshot:ver<4>;
use GSK::RenderNode;

use GLib::Roles::Implementor;
use GLib::Roles::TypedBuffer;
use GDK::Roles::Paintable:ver<4>;

our subset GtkSnapshotAncestry is export of Mu
  where GtkSnapshot | GdkSnapshotAncestry;

class GTK::Snapshot:ver<4> is GDK::Snapshot:ver<4> {
  has GtkSnapshot $!gtk-ss is implementor;

  submethod BUILD ( :$gtk-snapshot ) {
    self.setGtkSnapshot($gtk-snapshot) if $gtk-snapshot
  }

  method setGtkSnapshot (GtkSnapshotAncestry $_) {
    my $to-parent;

    $!gtk-ss = do {
      when GtkSnapshot {
        $to-parent = cast(GdkSnapshot, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSnapshot, $_);
      }
    }
    self.setGdkSnapshot($to-parent);
  }

  method GTK::Raw::Definitions::GtkSnapshot
    is also<GtkSnapshot>
  { $!gtk-ss }

  multi method new (GtkSnapshotAncestry $gtk-snapshot, :$ref = True) {
    return unless $gtk-snapshot;

    my $o = self.bless( :$gtk-snapshot );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-snapshot = gtk_snapshot_new();

    $gtk-snapshot ?? self.bless( :$gtk-snapshot ) !! Nil;
  }

  proto method append_border (|)
    is also<append-border>
  { * }

  multi method append_border (
    GskRoundedRect() $outline,
                     @border_width,
                     @border_color
  ) {
    X::GLib::InvalidSize.new(
      message => '@border_width must contain 4 elements!'
    ).throw unless @border_width.elems == 4;

    X::GLib::InvalidSize.new(
      message => '@border_color must contain 4 elements!'
    ).throw unless @border_color.elems == 4;

    samewith(
      $outline,
      ArrayToCArray(gfloat, @border_width),
      GLib::Roles::TypedBuffer[GdkRGBA].new(@border_color).p
    );
  }
  multi method append_border (
    GskRoundedRect() $outline,
    CArray[gfloat] $border_width,
    gpointer       $border_color
  ) {
    gtk_snapshot_append_border(
      $!gtk-ss,
      $outline,
      $border_width,
      $border_color
    );
  }

  method append_cairo (graphene_rect_t() $bounds) is also<append-cairo> {
    gtk_snapshot_append_cairo($!gtk-ss, $bounds);
  }

  method append_color (
    GdkRGBA()         $color,
    graphene_rect_t() $bounds
  )
    is also<append-color>
  {
    gtk_snapshot_append_color($!gtk-ss, $color, $bounds);
  }

  proto method append_conic_gradient (|)
    is also<append-conic-gradient>
  { * }

  multi method append_conic_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $rotation,
                       @stops,
  ) {
    samewith(
      $bounds,
      $center,
      $rotation,
      GLib::Roles::TypedBuffer[GskColorStop].new(@stops).p,
      @stops.elems
    );
  }
  multi method append_conic_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $rotation,
    gpointer           $stops,
    Int()              $n_stops
  ) {
    my gfloat $r = $rotation;
    my gsize  $n = $n_stops;

    gtk_snapshot_append_conic_gradient(
      $!gtk-ss,
      $bounds,
      $center,
      $r,
      $stops,
      $n
    );
  }

  method append_inset_shadow (
    GskRoundedRect() $outline,
    GdkRGBA()        $color,
    Num()            $dx,
    Num()            $dy,
    Num()            $spread,
    Num()            $blur_radius
  )
    is also<append-inset-shadow>
  {
    my gfloat ($x, $y, $s, $b) = ($dx, $dy, $spread, $blur_radius);

    gtk_snapshot_append_inset_shadow(
      $!gtk-ss,
      $outline,
      $color,
      $x,
      $y,
      $s,
      $b
    );
  }

  method append_layout (
    PangoLayout() $layout,
    GdkRGBA()     $color
  )
    is also<append-layout>
  {
    gtk_snapshot_append_layout($!gtk-ss, $layout, $color);
  }

  proto method append_linear_gradient (|)
    is also<append-linear-gradient>
  { * }

  multi method append_linear_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start_point,
    graphene_point_t() $end_point,
                       @stops
  ) {
    samewith(
      $bounds,
      $start_point,
      $end_point,
      GLib::Roles::TypedBuffer[GskColorStop].new(@stops).p,
      @stops.elems
    );
  }
  multi method append_linear_gradient (

    graphene_rect_t()  $bounds,
    graphene_point_t() $start_point,
    graphene_point_t() $end_point,
    gpointer           $stops,
    Int()              $n_stops
  ) {
    my gsize $n = $n_stops;

    gtk_snapshot_append_linear_gradient(
      $!gtk-ss,
      $bounds,
      $start_point,
      $end_point,
      $stops,
      $n_stops
    );
  }

  method append_node (GskRenderNode() $node) is also<append-node> {
    gtk_snapshot_append_node($!gtk-ss, $node);
  }

  method append_outset_shadow (
    GskRoundedRect() $outline,
    GdkRGBA()        $color,
    Num()            $dx,
    Num()            $dy,
    Num()            $spread,
    Num()            $blur_radius
  )
    is also<append-outset-shadow>
  {
    my gfloat ($x, $y, $s, $b) = ($dx, $dy, $spread, $blur_radius);

    gtk_snapshot_append_outset_shadow(
      $!gtk-ss,
      $outline,
      $color,
      $x,
      $y,
      $s,
      $b
    );
  }

  proto method append_radial_gradient (|)
    is also<append-radial-gradient>
  { * }

  multi method append_radial_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
                       @stops
  ) {
    samewith(
      $bounds,
      $center,
      $hradius,
      $vradius,
      $start,
      $end,
      GLib::Roles::TypedBuffer[GskColorStop].new(@stops).p,
      @stops.elems
    );
  }
  multi method append_radial_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
    gpointer           $stops,
    Int()              $n_stops
  ) {
    my gfloat ($h, $v, $s, $e) = ($hradius, $vradius, $start, $end);
    my gsize   $n              =  $n_stops;

    gtk_snapshot_append_radial_gradient(
      $!gtk-ss,
      $bounds,
      $center,
      $h,
      $v,
      $s,
      $e,
      $stops,
      $n_stops
     );
  }

  proto method append_repeating_linear_gradient (|)
    is also<append-repeating-linear-gradient>
  { * }

  multi method append_repeating_linear_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start_point,
    graphene_point_t() $end_point,
                       @stops
  ) {
    samewith(
      $bounds,
      $start_point,
      $end_point,
      GLib::Roles::TypedBuffer[GskColorStop].new(@stops).p,
      @stops.elems
    );
   }
  multi method append_repeating_linear_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start_point,
    graphene_point_t() $end_point,
    gpointer           $stops,
    Int()              $n_stops
  ) {
    my gsize $n = $n_stops;

    gtk_snapshot_append_repeating_linear_gradient(
      $!gtk-ss,
      $bounds,
      $start_point,
      $end_point,
      $stops,
      $n
     );
  }

  proto method append_repeating_radial_gradient (|)
    is also<append-repeating-radial-gradient>
  { * }

  multi method append_repeating_radial_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
                       @stops
  ) {
    samewith(
      $bounds,
      $center,
      $hradius,
      $vradius,
      $start,
      $end,
      GLib::Roles::TypedBuffer[GskColorStop].new(@stops).p,
      @stops.elems
    );
  }
  multi method append_repeating_radial_gradient (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
    gpointer           $stops,
    Int()              $n_stops
  ) {
    my gfloat ($h, $v, $s, $e) = ($hradius, $vradius, $start, $end);
    my gsize   $n              =  $n_stops;

    gtk_snapshot_append_repeating_radial_gradient(
      $!gtk-ss,
      $bounds,
      $center,
      $h,
      $v,
      $s,
      $e,
      $stops,
      $n
    );
  }

  method append_texture (
    GdkTexture()      $texture,
    graphene_rect_t() $bounds
  )
    is also<append-texture>
  {
    gtk_snapshot_append_texture($!gtk-ss, $texture, $bounds);
  }

  method free_to_node is also<free-to-node> {
    gtk_snapshot_free_to_node($!gtk-ss);
  }

  method free_to_paintable (graphene_size_t() $size) is also<free-to-paintable> {
    gtk_snapshot_free_to_paintable($!gtk-ss, $size);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_snapshot_get_type, $n, $t );
  }

  method gl_shader_pop_texture is also<gl-shader-pop-texture> {
    gtk_snapshot_gl_shader_pop_texture($!gtk-ss);
  }

  method perspective (Num() $depth) {
    my gfloat $d = $depth;

    gtk_snapshot_perspective($!gtk-ss, $d);
  }

  method pop {
    gtk_snapshot_pop($!gtk-ss);
  }

  method push_blend (Int() $blend_mode) is also<push-blend> {
    my GskBlendMode $b = $blend_mode;

    gtk_snapshot_push_blend($!gtk-ss, $b);
  }

  method push_blur (Num() $radius) is also<push-blur> {
    my gdouble $r = $radius;

    gtk_snapshot_push_blur($!gtk-ss, $r);
  }

  method push_clip (graphene_rect_t() $bounds) is also<push-clip> {
    gtk_snapshot_push_clip($!gtk-ss, $bounds);
  }

  method push_color_matrix (
    graphene_matrix_t() $color_matrix,
    graphene_vec4_t()   $color_offset
  )
    is also<push-color-matrix>
  {
    gtk_snapshot_push_color_matrix($!gtk-ss, $color_matrix, $color_offset);
  }

  method push_cross_fade (Num() $progress) is also<push-cross-fade> {
    my gdouble $p = $progress;

    gtk_snapshot_push_cross_fade($!gtk-ss, $p);
  }

  method push_debug (Str() $message) is also<push-debug> {
    gtk_snapshot_push_debug($!gtk-ss, $message, Str);
  }

  method push_gl_shader (
    GskGLShader()     $shader,
    graphene_rect_t() $bounds,
    GBytes()          $take_args
  )
    is also<push-gl-shader>
  {
    gtk_snapshot_push_gl_shader($!gtk-ss, $shader, $bounds, $take_args);
  }

  method push_opacity (Num() $opacity) is also<push-opacity> {
    my gdouble $o =  $opacity;

    gtk_snapshot_push_opacity($!gtk-ss, $o);
  }

  method push_repeat (
    graphene_rect_t() $bounds,
    graphene_rect_t() $child_bounds
  )
    is also<push-repeat>
  {
    gtk_snapshot_push_repeat($!gtk-ss, $bounds, $child_bounds);
  }

  method push_rounded_clip (GskRoundedRect() $bounds) is also<push-rounded-clip> {
    gtk_snapshot_push_rounded_clip($!gtk-ss, $bounds);
  }

  proto method push_shadow (|)
    is also<push-shadow>
  { * }

  multi method push_shadow (@shadows) {
    samewith(
      GLib::Roles::TypedBuffer[GskShadow].new(@shadows).p,
      @shadows.elems
    );
  }
  multi method push_shadow (
    gpointer $shadow,
    Int()    $n_shadows
  ) {
    my gsize $n = $n_shadows;

    gtk_snapshot_push_shadow($!gtk-ss, $shadow, $n);
  }

  method render_background (
    GtkStyleContext() $context,
    Num()             $x,
    Num()             $y,
    Num()             $width,
    Num()             $height
  )
    is also<render-background>
  {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gtk_snapshot_render_background($!gtk-ss, $context, $xx, $yy, $w, $h);
  }

  method render_focus (
    GtkStyleContext() $context,
    Num()             $x,
    Num()             $y,
    Num()             $width,
    Num()             $height
  )
    is also<render-focus>
  {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gtk_snapshot_render_focus($!gtk-ss, $context, $xx, $yy, $w, $h)
  }

  method render_frame (
    GtkStyleContext() $context,
    Num()             $x,
    Num()             $y,
    Num()             $width,
    Num()             $height
  )
    is also<render-frame>
  {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gtk_snapshot_render_frame($!gtk-ss, $context, $xx, $yy, $w, $h)
  }

  method render_insertion_cursor (
    GtkStyleContext() $context,
    Num()             $x,
    Num()             $y,
    PangoLayout()     $layout,
    Int()             $index,
    Int()             $direction
  )
    is also<render-insertion-cursor>
  {
    my gdouble        ($xx, $yy) = ($x, $y);
    my PangoDirection  $d        =  $direction;
    my gint            $i        =  $index;

    gtk_snapshot_render_insertion_cursor(
      $!gtk-ss,
      $context,
      $xx,
      $yy,
      $layout,
      $i,
      $d
     );
  }

  method render_layout (
    GtkStyleContext() $context,
    Num()             $x,
    Num()             $y,
    PangoLayout()     $layout
  )
    is also<render-layout>
  {
    my gdouble ($xx, $yy) = ($x, $y);

    gtk_snapshot_render_layout($!gtk-ss, $context, $xx, $yy, $layout);
  }

  method restore {
    gtk_snapshot_restore($!gtk-ss);
  }

  method rotate (Num() $angle) {
    my gfloat $a = $angle;

    gtk_snapshot_rotate($!gtk-ss, $a);
  }

  method rotate_3d (Num() $angle, graphene_vec3_t() $axis) is also<rotate-3d> {
    my gfloat $a = $angle;

    gtk_snapshot_rotate_3d($!gtk-ss, $a, $axis);
  }

  method save {
    gtk_snapshot_save($!gtk-ss);
  }

  method scale (Num() $factor_x,Num() $factor_y) {
    my gfloat ($x, $y) = ($factor_x, $factor_y);

    gtk_snapshot_scale($!gtk-ss, $x, $y);
  }

  method scale_3d (Num() $factor_x, Num() $factor_y, Num() $factor_z) is also<scale-3d> {
    my gfloat ($x, $y, $z) = ($factor_x, $factor_y, $factor_z);

    gtk_snapshot_scale_3d($!gtk-ss, $x, $y, $z);
  }

  method to_node ( :$raw = False, :$node = False ) is also<to-node> {
    returnProperNode(
      gtk_snapshot_to_node($!gtk-ss),
      $raw,
      $node
    );
  }

  method to_paintable (graphene_size_t() $size, :$raw = False) is also<to-paintable> {
    propReturnObject(
      gtk_snapshot_to_paintable($!gtk-ss, $size),
      $raw,
      |GDK::Paintable.getTypePair
     );
  }

  method transform (GskTransform() $transform) {
    gtk_snapshot_transform($!gtk-ss, $transform);
  }

  method transform_matrix (graphene_matrix_t() $matrix) is also<transform-matrix> {
    gtk_snapshot_transform_matrix($!gtk-ss, $matrix);
  }

  method translate (graphene_point_t() $point) {
    gtk_snapshot_translate($!gtk-ss, $point);
  }

  method translate_3d (graphene_point3d_t() $point) is also<translate-3d> {
    gtk_snapshot_translate_3d($!gtk-ss, $point);
  }

}

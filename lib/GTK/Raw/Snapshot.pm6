use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use Graphene::Raw::Definitions;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GSK::Raw::Definitions:ver<4>;
use GSK::Raw::Structs:ver<4>;
use GSK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Snapshot:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtksnapshot.h

sub gtk_snapshot_append_border (
  GtkSnapshot    $snapshot,
  GskRoundedRect $outline,
  CArray[gfloat] $border_width,  #= Array size 4
  gpointer       $border_color   #= Array of GdkRGBA size 4
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_cairo (
  GtkSnapshot     $snapshot,
  graphene_rect_t $bounds
)
  returns cairo_t
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_color (
  GtkSnapshot     $snapshot,
  GdkRGBA         $color,
  graphene_rect_t $bounds
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_conic_gradient (
  GtkSnapshot      $snapshot,
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $rotation,
  gpointer         $stops,
  gsize            $n_stops
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_inset_shadow (
  GtkSnapshot    $snapshot,
  GskRoundedRect $outline,
  GdkRGBA        $color,
  gfloat         $dx,
  gfloat         $dy,
  gfloat         $spread,
  gfloat         $blur_radius
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_layout (
  GtkSnapshot $snapshot,
  PangoLayout $layout,
  GdkRGBA     $color
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_linear_gradient (
  GtkSnapshot      $snapshot,
  graphene_rect_t  $bounds,
  graphene_point_t $start_point,
  graphene_point_t $end_point,
  gpointer         $stops,
  gsize            $n_stops
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_node (
  GtkSnapshot   $snapshot,
  GskRenderNode $node
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_outset_shadow (
  GtkSnapshot    $snapshot,
  GskRoundedRect $outline,
  GdkRGBA        $color,
  gfloat         $dx,
  gfloat         $dy,
  gfloat         $spread,
  gfloat         $blur_radius
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_radial_gradient (
  GtkSnapshot      $snapshot,
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $hradius,
  gfloat           $vradius,
  gfloat           $start,
  gfloat           $end,
  gpointer         $stops,
  gsize            $n_stops
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_repeating_linear_gradient (
  GtkSnapshot      $snapshot,
  graphene_rect_t  $bounds,
  graphene_point_t $start_point,
  graphene_point_t $end_point,
  gpointer         $stops,
  gsize            $n_stops
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_repeating_radial_gradient (
  GtkSnapshot      $snapshot,
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $hradius,
  gfloat           $vradius,
  gfloat           $start,
  gfloat           $end,
  gpointer         $stops,
  gsize            $n_stops
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_append_texture (
  GtkSnapshot     $snapshot,
  GdkTexture      $texture,
  graphene_rect_t $bounds
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_free_to_node (GtkSnapshot $snapshot)
  returns GskRenderNode
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_free_to_paintable (
  GtkSnapshot     $snapshot,
  graphene_size_t $size
)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_gl_shader_pop_texture (GtkSnapshot $snapshot)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_new
  returns GtkSnapshot
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_perspective (
  GtkSnapshot $snapshot,
  gfloat      $depth
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_pop (GtkSnapshot $snapshot)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_blend (
  GtkSnapshot  $snapshot,
  GskBlendMode $blend_mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_blur (
  GtkSnapshot $snapshot,
  gdouble     $radius
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_clip (
  GtkSnapshot     $snapshot,
  graphene_rect_t $bounds
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_color_matrix (
  GtkSnapshot       $snapshot,
  graphene_matrix_t $color_matrix,
  graphene_vec4_t   $color_offset
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_cross_fade (
  GtkSnapshot $snapshot,
  gdouble     $progress
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_debug (
  GtkSnapshot $snapshot,
  Str         $message,
  Str
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_gl_shader (
  GtkSnapshot     $snapshot,
  GskGLShader     $shader,
  graphene_rect_t $bounds,
  GBytes          $take_args
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_opacity (
  GtkSnapshot $snapshot,
  gdouble     $opacity
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_repeat (
  GtkSnapshot     $snapshot,
  graphene_rect_t $bounds,
  graphene_rect_t $child_bounds
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_rounded_clip (
  GtkSnapshot    $snapshot,
  GskRoundedRect $bounds
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_push_shadow (
  GtkSnapshot $snapshot,
  gpointer    $shadow,
  gsize       $n_shadows
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_render_background (
  GtkSnapshot     $snapshot,
  GtkStyleContext $context,
  gdouble         $x,
  gdouble         $y,
  gdouble         $width,
  gdouble         $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_render_focus (
  GtkSnapshot     $snapshot,
  GtkStyleContext $context,
  gdouble         $x,
  gdouble         $y,
  gdouble         $width,
  gdouble         $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_render_frame (
  GtkSnapshot     $snapshot,
  GtkStyleContext $context,
  gdouble         $x,
  gdouble         $y,
  gdouble         $width,
  gdouble         $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_render_insertion_cursor (
  GtkSnapshot     $snapshot,
  GtkStyleContext $context,
  gdouble         $x,
  gdouble         $y,
  PangoLayout     $layout,
  gint            $index,
  PangoDirection  $direction
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_render_layout (
  GtkSnapshot     $snapshot,
  GtkStyleContext $context,
  gdouble         $x,
  gdouble         $y,
  PangoLayout     $layout
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_restore (GtkSnapshot $snapshot)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_rotate (
  GtkSnapshot $snapshot,
  gfloat      $angle
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_rotate_3d (
  GtkSnapshot     $snapshot,
  gfloat          $angle,
  graphene_vec3_t $axis
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_save (GtkSnapshot $snapshot)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_scale (
  GtkSnapshot $snapshot,
  gfloat      $factor_x,
  gfloat      $factor_y
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_scale_3d (
  GtkSnapshot $snapshot,
  gfloat      $factor_x,
  gfloat      $factor_y,
  gfloat      $factor_z
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_to_node (GtkSnapshot $snapshot)
  returns GskRenderNode
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_to_paintable (
  GtkSnapshot     $snapshot,
  graphene_size_t $size
)
  returns GdkPaintable
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_transform (
  GtkSnapshot  $snapshot,
  GskTransform $transform
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_transform_matrix (
  GtkSnapshot       $snapshot,
  graphene_matrix_t $matrix
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_translate (
  GtkSnapshot      $snapshot,
  graphene_point_t $point
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_snapshot_translate_3d (
  GtkSnapshot        $snapshot,
  graphene_point3d_t $point
)
  is      native(gtk4)
  is      export
{ * }

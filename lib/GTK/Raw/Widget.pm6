use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Pango::Raw::Definitions;
use Graphene::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GSK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Widget:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkwidget.h

sub gtk_widget_action_set_enabled (
  GtkWidget $widget,
  Str       $action_name,
  gboolean  $enabled
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_activate (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_activate_action (
  GtkWidget $widget,
  Str       $name,
  Str       $format_string
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_activate_action_variant (
  GtkWidget $widget,
  Str       $name,
  GVariant  $args
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_activate_default (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_add_controller (
  GtkWidget          $widget,
  GtkEventController $controller
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_add_css_class (
  GtkWidget $widget,
  Str       $css_class
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_add_mnemonic_label (
  GtkWidget $widget,
  GtkWidget $label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_add_tick_callback (
  GtkWidget       $widget,
                  &callback (GtkWidget, GdkFrameClock, gpointer --> gboolean),
  gpointer        $user_data,
                  &notify (gpointer)
)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_allocate (
  GtkWidget    $widget,
  gint         $width,
  gint         $height,
  gint         $baseline,
  GskTransform $transform
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_child_focus (
  GtkWidget        $widget,
  GtkDirectionType $direction
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_compute_bounds (
  GtkWidget       $widget,
  GtkWidget       $target,
  graphene_rect_t $out_bounds
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_compute_expand (
  GtkWidget      $widget,
  GtkOrientation $orientation
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_compute_point (
  GtkWidget        $widget,
  GtkWidget        $target,
  graphene_point_t $point,
  graphene_point_t $out_point
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_compute_transform (
  GtkWidget         $widget,
  GtkWidget         $target,
  graphene_matrix_t $out_transform
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_contains (
  GtkWidget $widget,
  gdouble   $x,
  gdouble   $y
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_create_pango_context (GtkWidget $widget)
  returns PangoContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_create_pango_layout (
  GtkWidget $widget,
  Str       $text
)
  returns PangoLayout
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_dispose_template (
  GtkWidget $widget,
  GType     $widget_type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_error_bell (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_allocated_baseline (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_allocated_height (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_allocated_width (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_allocation (
  GtkWidget     $widget,
  GtkAllocation $allocation
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_ancestor (
  GtkWidget $widget,
  GType     $widget_type
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_can_focus (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_can_target (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_child_visible (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_clipboard (GtkWidget $widget)
  returns GdkClipboard
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_css_classes (GtkWidget $widget)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_css_name (GtkWidget $self)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_cursor (GtkWidget $widget)
  returns GdkCursor
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_default_direction
  returns GtkTextDirection
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_direction (GtkWidget $widget)
  returns GtkTextDirection
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_display (GtkWidget $widget)
  returns GdkDisplay
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_first_child (GtkWidget $widget)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_focus_child (GtkWidget $widget)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_focus_on_click (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_focusable (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_font_map (GtkWidget $widget)
  returns PangoFontMap
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_font_options (GtkWidget $widget)
  returns cairo_font_options_t
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_frame_clock (GtkWidget $widget)
  returns GdkFrameClock
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_halign (GtkWidget $widget)
  returns GtkAlign
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_has_tooltip (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_height (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_hexpand (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_hexpand_set (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_last_child (GtkWidget $widget)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_layout_manager (GtkWidget $widget)
  returns GtkLayoutManager
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_mapped (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_margin_bottom (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_margin_end (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_margin_start (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_margin_top (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_name (GtkWidget $widget)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_native (GtkWidget $widget)
  returns GtkNative
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_next_sibling (GtkWidget $widget)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_opacity (GtkWidget $widget)
  returns gdouble
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_overflow (GtkWidget $widget)
  returns GtkOverflow
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_pango_context (GtkWidget $widget)
  returns PangoContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_parent (GtkWidget $widget)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_preferred_size (
  GtkWidget      $widget,
  GtkRequisition $minimum_size,
  GtkRequisition $natural_size
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_prev_sibling (GtkWidget $widget)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_primary_clipboard (GtkWidget $widget)
  returns GdkClipboard
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_realized (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_receives_default (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_request_mode (GtkWidget $widget)
  returns GtkSizeRequestMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_root (GtkWidget $widget)
  returns GtkRoot
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_scale_factor (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_sensitive (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_settings (GtkWidget $widget)
  returns GtkSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_size (
  GtkWidget      $widget,
  GtkOrientation $orientation
)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_size_request (
  GtkWidget $widget,
  gint      $width   is rw,
  gint      $height  is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_state_flags (GtkWidget $widget)
  returns GtkStateFlags
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_style_context (GtkWidget $widget)
  returns GtkStyleContext
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_template_child (
  GtkWidget $widget,
  GType     $widget_type,
  Str       $name
)
  returns GObject
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_tooltip_markup (GtkWidget $widget)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_tooltip_text (GtkWidget $widget)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_valign (GtkWidget $widget)
  returns GtkAlign
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_vexpand (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_vexpand_set (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_visible (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_get_width (GtkWidget $widget)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_grab_focus (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_requisition_copy (GtkRequisition $requisition)
  returns GtkRequisition
  is      native(gtk4)
  is      export
{ * }

sub gtk_requisition_free (GtkRequisition $requisition)
  is      native(gtk4)
  is      export
{ * }

sub gtk_requisition_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_requisition_new
  returns GtkRequisition
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_has_css_class (
  GtkWidget $widget,
  Str       $css_class
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_has_default (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_has_focus (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_has_visible_focus (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_hide (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_in_destruction (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_insert_action_group (
  GtkWidget    $widget,
  Str          $name,
  GActionGroup $group
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_insert_after (
  GtkWidget $widget,
  GtkWidget $parent,
  GtkWidget $previous_sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_insert_before (
  GtkWidget $widget,
  GtkWidget $parent,
  GtkWidget $next_sibling
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_is_ancestor (
  GtkWidget $widget,
  GtkWidget $ancestor
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_is_drawable (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_is_focus (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_is_sensitive (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_is_visible (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_keynav_failed (
  GtkWidget        $widget,
  GtkDirectionType $direction
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_list_mnemonic_labels (GtkWidget $widget)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_map (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_measure (
  GtkWidget      $widget,
  GtkOrientation $orientation,
  gint           $for_size,
  gint           $minimum          is rw,
  gint           $natural          is rw,
  gint           $minimum_baseline is rw,
  gint           $natural_baseline is rw
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_mnemonic_activate (
  GtkWidget $widget,
  gboolean  $group_cycling
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_observe_children (GtkWidget $widget)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_observe_controllers (GtkWidget $widget)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_pick (
  GtkWidget    $widget,
  gdouble      $x,
  gdouble      $y,
  GtkPickFlags $flags
)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_queue_allocate (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_queue_draw (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_queue_resize (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_realize (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_remove_controller (
  GtkWidget          $widget,
  GtkEventController $controller
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_remove_css_class (
  GtkWidget $widget,
  Str       $css_class
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_remove_mnemonic_label (
  GtkWidget $widget,
  GtkWidget $label
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_remove_tick_callback (
  GtkWidget $widget,
  guint     $id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_can_focus (
  GtkWidget $widget,
  gboolean  $can_focus
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_can_target (
  GtkWidget $widget,
  gboolean  $can_target
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_child_visible (
  GtkWidget $widget,
  gboolean  $child_visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_css_classes (
  GtkWidget   $widget,
  CArray[Str] $classes
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_cursor (
  GtkWidget $widget,
  GdkCursor $cursor
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_cursor_from_name (
  GtkWidget $widget,
  Str       $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_default_direction (GtkTextDirection $dir)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_direction (
  GtkWidget        $widget,
  GtkTextDirection $dir
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_focus_child (
  GtkWidget $widget,
  GtkWidget $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_focus_on_click (
  GtkWidget $widget,
  gboolean  $focus_on_click
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_focusable (
  GtkWidget $widget,
  gboolean  $focusable
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_font_map (
  GtkWidget    $widget,
  PangoFontMap $font_map
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_font_options (
  GtkWidget            $widget,
  cairo_font_options_t $options
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_halign (
  GtkWidget $widget,
  GtkAlign  $align
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_has_tooltip (
  GtkWidget $widget,
  gboolean  $has_tooltip
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_hexpand (
  GtkWidget $widget,
  gboolean  $expand
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_hexpand_set (
  GtkWidget $widget,
  gboolean  $set
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_layout_manager (
  GtkWidget        $widget,
  GtkLayoutManager $layout_manager
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_margin_bottom (
  GtkWidget $widget,
  gint      $margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_margin_end (
  GtkWidget $widget,
  gint      $margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_margin_start (
  GtkWidget $widget,
  gint      $margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_margin_top (
  GtkWidget $widget,
  gint      $margin
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_name (
  GtkWidget $widget,
  Str       $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_opacity (
  GtkWidget $widget,
  gdouble   $opacity
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_overflow (
  GtkWidget   $widget,
  GtkOverflow $overflow
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_parent (
  GtkWidget $widget,
  GtkWidget $parent
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_receives_default (
  GtkWidget $widget,
  gboolean  $receives_default
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_sensitive (
  GtkWidget $widget,
  gboolean  $sensitive
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_size_request (
  GtkWidget $widget,
  gint      $width,
  gint      $height
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_state_flags (
  GtkWidget     $widget,
  GtkStateFlags $flags,
  gboolean      $clear
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_tooltip_markup (
  GtkWidget $widget,
  Str       $markup
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_tooltip_text (
  GtkWidget $widget,
  Str       $text
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_valign (
  GtkWidget $widget,
  GtkAlign  $align
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_vexpand (
  GtkWidget $widget,
  gboolean  $expand
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_vexpand_set (
  GtkWidget $widget,
  gboolean  $set
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_set_visible (
  GtkWidget $widget,
  gboolean  $visible
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_should_layout (GtkWidget $widget)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_show (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_size_allocate (
  GtkWidget     $widget,
  GtkAllocation $allocation,
  gint          $baseline
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_snapshot_child (
  GtkWidget   $widget,
  GtkWidget   $child,
  GtkSnapshot $snapshot
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_translate_coordinates (
  GtkWidget $src_widget,
  GtkWidget $dest_widget,
  gdouble   $src_x,
  gdouble   $src_y,
  gdouble   $dest_x is rw,
  gdouble   $dest_y is rw
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_trigger_tooltip_query (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_unmap (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_unparent (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_unrealize (GtkWidget $widget)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_unset_state_flags (
  GtkWidget     $widget,
  GtkStateFlags $flags
)
  is      native(gtk4)
  is      export
{ * }

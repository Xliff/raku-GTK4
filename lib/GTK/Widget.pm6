  method action_set_enabled (
    GtkWidget $widget,
    Str       $action_name,
    gboolean  $enabled
  ) {
    gtk_widget_action_set_enabled($!gtk-w, $action_name, $enabled);
  }

  method activate {
    gtk_widget_activate($!gtk-w);
  }

  method activate_action (
    GtkWidget $widget,
    Str       $name,
    Str       $format_string
  ) {
    gtk_widget_activate_action($!gtk-w, $name, $format_string);
  }

  method activate_action_variant (
    GtkWidget $widget,
    Str       $name,
    GVariant  $args
  ) {
    gtk_widget_activate_action_variant($!gtk-w, $name, $args);
  }

  method activate_default {
    gtk_widget_activate_default($!gtk-w);
  }

  method add_controller (
    GtkWidget          $widget,
    GtkEventController $controller
  ) {
    gtk_widget_add_controller($!gtk-w, $controller);
  }

  method add_css_class (
    GtkWidget $widget,
    Str       $css_class
  ) {
    gtk_widget_add_css_class($!gtk-w, $css_class);
  }

  method add_mnemonic_label (
    GtkWidget $widget,
    GtkWidget $label
  ) {
    gtk_widget_add_mnemonic_label($!gtk-w, $label);
  }

  method add_tick_callback (
    GtkWidget       $widget,
    GtkTickCallback $callback,
    gpointer        $user_data,
    GDestroyNotify  $notify
  ) {
    gtk_widget_add_tick_callback($!gtk-w, $callback, $user_data, $notify);
  }

  method allocate (
    GtkWidget    $widget,
    gint         $width,
    gint         $height,
    gint         $baseline,
    GskTransform $transform
  ) {
    gtk_widget_allocate($!gtk-w, $width, $height, $baseline, $transform);
  }

  method child_focus (
    GtkWidget        $widget,
    GtkDirectionType $direction
  ) {
    gtk_widget_child_focus($!gtk-w, $direction);
  }

  method class_add_binding (
    GtkWidgetClass  $widget_class,
    guint           $keyval,
    GdkModifierType $mods,
    GtkShortcutFunc $callback,
    Str             $format_string
  ) {
    gtk_widget_class_add_binding($!gtk-w, $keyval, $mods, $callback, $format_string);
  }

  method class_add_binding_action (
    GtkWidgetClass  $widget_class,
    guint           $keyval,
    GdkModifierType $mods,
    Str             $action_name,
    Str             $format_string
  ) {
    gtk_widget_class_add_binding_action($!gtk-w, $keyval, $mods, $action_name, $format_string);
  }

  method class_add_binding_signal (
    GtkWidgetClass  $widget_class,
    guint           $keyval,
    GdkModifierType $mods,
    Str             $signal,
    Str             $format_string
  ) {
    gtk_widget_class_add_binding_signal($!gtk-w, $keyval, $mods, $signal, $format_string);
  }

  method class_add_shortcut (
    GtkWidgetClass $widget_class,
    GtkShortcut    $shortcut
  ) {
    gtk_widget_class_add_shortcut($!gtk-w, $shortcut);
  }

  method class_bind_template_callback_full (
    GtkWidgetClass $widget_class,
    Str            $callback_name,
    GCallback      $callback_symbol
  ) {
    gtk_widget_class_bind_template_callback_full($!gtk-w, $callback_name, $callback_symbol);
  }

  method class_bind_template_child_full (
    GtkWidgetClass $widget_class,
    Str            $name,
    gboolean       $internal_child,
    gssize         $struct_offset
  ) {
    gtk_widget_class_bind_template_child_full($!gtk-w, $name, $internal_child, $struct_offset);
  }

  method class_get_accessible_role {
    gtk_widget_class_get_accessible_role($!gtk-w);
  }

  method class_get_activate_signal {
    gtk_widget_class_get_activate_signal($!gtk-w);
  }

  method class_get_css_name {
    gtk_widget_class_get_css_name($!gtk-w);
  }

  method class_get_layout_manager_type {
    gtk_widget_class_get_layout_manager_type($!gtk-w);
  }

  method class_install_action (
    GtkWidgetClass              $widget_class,
    Str                         $action_name,
    Str                         $parameter_type,
    GtkWidgetActionActivateFunc $activate
  ) {
    gtk_widget_class_install_action($!gtk-w, $action_name, $parameter_type, $activate);
  }

  method class_install_property_action (
    GtkWidgetClass $widget_class,
    Str            $action_name,
    Str            $property_name
  ) {
    gtk_widget_class_install_property_action($!gtk-w, $action_name, $property_name);
  }

  method class_query_action (
    GtkWidgetClass       $widget_class,
    guint                $index_,
    GType                $owner,
    CArray[Str]          $action_name,
    CArray[GVariantType] $parameter_type,
    CArray[Str]          $property_name
  ) {
    gtk_widget_class_query_action($!gtk-w, $index_, $owner, $action_name, $parameter_type, $property_name);
  }

  method class_set_accessible_role (
    GtkWidgetClass    $widget_class,
    GtkAccessibleRole $accessible_role
  ) {
    gtk_widget_class_set_accessible_role($!gtk-w, $accessible_role);
  }

  method class_set_activate_signal (
    GtkWidgetClass $widget_class,
    guint          $signal_id
  ) {
    gtk_widget_class_set_activate_signal($!gtk-w, $signal_id);
  }

  method class_set_activate_signal_from_name (
    GtkWidgetClass $widget_class,
    Str            $signal_name
  ) {
    gtk_widget_class_set_activate_signal_from_name($!gtk-w, $signal_name);
  }

  method class_set_css_name (
    GtkWidgetClass $widget_class,
    Str            $name
  ) {
    gtk_widget_class_set_css_name($!gtk-w, $name);
  }

  method class_set_layout_manager_type (
    GtkWidgetClass $widget_class,
    GType          $type
  ) {
    gtk_widget_class_set_layout_manager_type($!gtk-w, $type);
  }

  method class_set_template (
    GtkWidgetClass $widget_class,
    GBytes         $template_bytes
  ) {
    gtk_widget_class_set_template($!gtk-w, $template_bytes);
  }

  method class_set_template_from_resource (
    GtkWidgetClass $widget_class,
    Str            $resource_name
  ) {
    gtk_widget_class_set_template_from_resource($!gtk-w, $resource_name);
  }

  method class_set_template_scope (
    GtkWidgetClass  $widget_class,
    GtkBuilderScope $scope
  ) {
    gtk_widget_class_set_template_scope($!gtk-w, $scope);
  }

  method compute_bounds (
    GtkWidget       $widget,
    GtkWidget       $target,
    graphene_rect_t $out_bounds
  ) {
    gtk_widget_compute_bounds($!gtk-w, $target, $out_bounds);
  }

  method compute_expand (
    GtkWidget      $widget,
    GtkOrientation $orientation
  ) {
    gtk_widget_compute_expand($!gtk-w, $orientation);
  }

  method compute_point (
    GtkWidget        $widget,
    GtkWidget        $target,
    graphene_point_t $point,
    graphene_point_t $out_point
  ) {
    gtk_widget_compute_point($!gtk-w, $target, $point, $out_point);
  }

  method compute_transform (
    GtkWidget         $widget,
    GtkWidget         $target,
    graphene_matrix_t $out_transform
  ) {
    gtk_widget_compute_transform($!gtk-w, $target, $out_transform);
  }

  method contains (
    GtkWidget $widget,
    gdouble   $x,
    gdouble   $y
  ) {
    gtk_widget_contains($!gtk-w, $x, $y);
  }

  method create_pango_context {
    gtk_widget_create_pango_context($!gtk-w);
  }

  method create_pango_layout (
    GtkWidget $widget,
    Str       $text
  ) {
    gtk_widget_create_pango_layout($!gtk-w, $text);
  }

  method dispose_template (
    GtkWidget $widget,
    GType     $widget_type
  ) {
    gtk_widget_dispose_template($!gtk-w, $widget_type);
  }

  method error_bell {
    gtk_widget_error_bell($!gtk-w);
  }

  method get_allocated_baseline {
    gtk_widget_get_allocated_baseline($!gtk-w);
  }

  method get_allocated_height {
    gtk_widget_get_allocated_height($!gtk-w);
  }

  method get_allocated_width {
    gtk_widget_get_allocated_width($!gtk-w);
  }

  method get_allocation (
    GtkWidget     $widget,
    GtkAllocation $allocation
  ) {
    gtk_widget_get_allocation($!gtk-w, $allocation);
  }

  method get_ancestor (
    GtkWidget $widget,
    GType     $widget_type
  ) {
    gtk_widget_get_ancestor($!gtk-w, $widget_type);
  }

  method get_can_focus {
    gtk_widget_get_can_focus($!gtk-w);
  }

  method get_can_target {
    gtk_widget_get_can_target($!gtk-w);
  }

  method get_child_visible {
    gtk_widget_get_child_visible($!gtk-w);
  }

  method get_clipboard {
    gtk_widget_get_clipboard($!gtk-w);
  }

  method get_css_classes {
    gtk_widget_get_css_classes($!gtk-w);
  }

  method get_css_name {
    gtk_widget_get_css_name($!gtk-w);
  }

  method get_cursor {
    gtk_widget_get_cursor($!gtk-w);
  }

  method get_default_direction {
    gtk_widget_get_default_direction($!gtk-w);
  }

  method get_direction {
    gtk_widget_get_direction($!gtk-w);
  }

  method get_display {
    gtk_widget_get_display($!gtk-w);
  }

  method get_first_child {
    gtk_widget_get_first_child($!gtk-w);
  }

  method get_focus_child {
    gtk_widget_get_focus_child($!gtk-w);
  }

  method get_focus_on_click {
    gtk_widget_get_focus_on_click($!gtk-w);
  }

  method get_focusable {
    gtk_widget_get_focusable($!gtk-w);
  }

  method get_font_map {
    gtk_widget_get_font_map($!gtk-w);
  }

  method get_font_options {
    gtk_widget_get_font_options($!gtk-w);
  }

  method get_frame_clock {
    gtk_widget_get_frame_clock($!gtk-w);
  }

  method get_halign {
    gtk_widget_get_halign($!gtk-w);
  }

  method get_has_tooltip {
    gtk_widget_get_has_tooltip($!gtk-w);
  }

  method get_height {
    gtk_widget_get_height($!gtk-w);
  }

  method get_hexpand {
    gtk_widget_get_hexpand($!gtk-w);
  }

  method get_hexpand_set {
    gtk_widget_get_hexpand_set($!gtk-w);
  }

  method get_last_child {
    gtk_widget_get_last_child($!gtk-w);
  }

  method get_layout_manager {
    gtk_widget_get_layout_manager($!gtk-w);
  }

  method get_mapped {
    gtk_widget_get_mapped($!gtk-w);
  }

  method get_margin_bottom {
    gtk_widget_get_margin_bottom($!gtk-w);
  }

  method get_margin_end {
    gtk_widget_get_margin_end($!gtk-w);
  }

  method get_margin_start {
    gtk_widget_get_margin_start($!gtk-w);
  }

  method get_margin_top {
    gtk_widget_get_margin_top($!gtk-w);
  }

  method get_name {
    gtk_widget_get_name($!gtk-w);
  }

  method get_native {
    gtk_widget_get_native($!gtk-w);
  }

  method get_next_sibling {
    gtk_widget_get_next_sibling($!gtk-w);
  }

  method get_opacity {
    gtk_widget_get_opacity($!gtk-w);
  }

  method get_overflow {
    gtk_widget_get_overflow($!gtk-w);
  }

  method get_pango_context {
    gtk_widget_get_pango_context($!gtk-w);
  }

  method get_parent {
    gtk_widget_get_parent($!gtk-w);
  }

  method get_preferred_size (
    GtkWidget      $widget,
    GtkRequisition $minimum_size,
    GtkRequisition $natural_size
  ) {
    gtk_widget_get_preferred_size($!gtk-w, $minimum_size, $natural_size);
  }

  method get_prev_sibling {
    gtk_widget_get_prev_sibling($!gtk-w);
  }

  method get_primary_clipboard {
    gtk_widget_get_primary_clipboard($!gtk-w);
  }

  method get_realized {
    gtk_widget_get_realized($!gtk-w);
  }

  method get_receives_default {
    gtk_widget_get_receives_default($!gtk-w);
  }

  method get_request_mode {
    gtk_widget_get_request_mode($!gtk-w);
  }

  method get_root {
    gtk_widget_get_root($!gtk-w);
  }

  method get_scale_factor {
    gtk_widget_get_scale_factor($!gtk-w);
  }

  method get_sensitive {
    gtk_widget_get_sensitive($!gtk-w);
  }

  method get_settings {
    gtk_widget_get_settings($!gtk-w);
  }

  method get_size (
    GtkWidget      $widget,
    GtkOrientation $orientation
  ) {
    gtk_widget_get_size($!gtk-w, $orientation);
  }

  method get_size_request (
    GtkWidget $widget,
    gint      $width is rw,
    gint      $height is rw
  ) {
    gtk_widget_get_size_request($!gtk-w, $width, $height);
  }

  method get_state_flags {
    gtk_widget_get_state_flags($!gtk-w);
  }

  method get_style_context {
    gtk_widget_get_style_context($!gtk-w);
  }

  method get_template_child (
    GtkWidget $widget,
    GType     $widget_type,
    Str       $name
  ) {
    gtk_widget_get_template_child($!gtk-w, $widget_type, $name);
  }

  method get_tooltip_markup {
    gtk_widget_get_tooltip_markup($!gtk-w);
  }

  method get_tooltip_text {
    gtk_widget_get_tooltip_text($!gtk-w);
  }

  method get_type {
    gtk_widget_get_type();
  }

  method get_valign {
    gtk_widget_get_valign($!gtk-w);
  }

  method get_vexpand {
    gtk_widget_get_vexpand($!gtk-w);
  }

  method get_vexpand_set {
    gtk_widget_get_vexpand_set($!gtk-w);
  }

  method get_visible {
    gtk_widget_get_visible($!gtk-w);
  }

  method get_width {
    gtk_widget_get_width($!gtk-w);
  }

  method grab_focus {
    gtk_widget_grab_focus($!gtk-w);
  }

  method gtk_requisition_copy {
    gtk_requisition_copy($!gtk-w);
  }

  method gtk_requisition_free {
    gtk_requisition_free($!gtk-w);
  }

  method gtk_requisition_get_type {
    gtk_requisition_get_type();
  }

  method gtk_requisition_new {
    gtk_requisition_new();
  }

  method has_css_class (
    GtkWidget $widget,
    Str       $css_class
  ) {
    gtk_widget_has_css_class($!gtk-w, $css_class);
  }

  method has_default {
    gtk_widget_has_default($!gtk-w);
  }

  method has_focus {
    gtk_widget_has_focus($!gtk-w);
  }

  method has_visible_focus {
    gtk_widget_has_visible_focus($!gtk-w);
  }

  method hide {
    gtk_widget_hide($!gtk-w);
  }

  method in_destruction {
    gtk_widget_in_destruction($!gtk-w);
  }

  method insert_action_group (
    GtkWidget    $widget,
    Str          $name,
    GActionGroup $group
  ) {
    gtk_widget_insert_action_group($!gtk-w, $name, $group);
  }

  method insert_after (
    GtkWidget $widget,
    GtkWidget $parent,
    GtkWidget $previous_sibling
  ) {
    gtk_widget_insert_after($!gtk-w, $parent, $previous_sibling);
  }

  method insert_before (
    GtkWidget $widget,
    GtkWidget $parent,
    GtkWidget $next_sibling
  ) {
    gtk_widget_insert_before($!gtk-w, $parent, $next_sibling);
  }

  method is_ancestor (
    GtkWidget $widget,
    GtkWidget $ancestor
  ) {
    gtk_widget_is_ancestor($!gtk-w, $ancestor);
  }

  method is_drawable {
    gtk_widget_is_drawable($!gtk-w);
  }

  method is_focus {
    gtk_widget_is_focus($!gtk-w);
  }

  method is_sensitive {
    gtk_widget_is_sensitive($!gtk-w);
  }

  method is_visible {
    gtk_widget_is_visible($!gtk-w);
  }

  method keynav_failed (
    GtkWidget        $widget,
    GtkDirectionType $direction
  ) {
    gtk_widget_keynav_failed($!gtk-w, $direction);
  }

  method list_mnemonic_labels {
    gtk_widget_list_mnemonic_labels($!gtk-w);
  }

  method map {
    gtk_widget_map($!gtk-w);
  }

  method measure (
    GtkWidget      $widget,
    GtkOrientation $orientation,
    gint           $for_size,
    gint           $minimum is rw,
    gint           $natural is rw,
    gint           $minimum_baseline is rw,
    gint           $natural_baseline is rw
  ) {
    gtk_widget_measure($!gtk-w, $orientation, $for_size, $minimum, $natural, $minimum_baseline, $natural_baseline);
  }

  method mnemonic_activate (
    GtkWidget $widget,
    gboolean  $group_cycling
  ) {
    gtk_widget_mnemonic_activate($!gtk-w, $group_cycling);
  }

  method observe_children {
    gtk_widget_observe_children($!gtk-w);
  }

  method observe_controllers {
    gtk_widget_observe_controllers($!gtk-w);
  }

  method pick (
    GtkWidget    $widget,
    gdouble      $x,
    gdouble      $y,
    GtkPickFlags $flags
  ) {
    gtk_widget_pick($!gtk-w, $x, $y, $flags);
  }

  method queue_allocate {
    gtk_widget_queue_allocate($!gtk-w);
  }

  method queue_draw {
    gtk_widget_queue_draw($!gtk-w);
  }

  method queue_resize {
    gtk_widget_queue_resize($!gtk-w);
  }

  method realize {
    gtk_widget_realize($!gtk-w);
  }

  method remove_controller (
    GtkWidget          $widget,
    GtkEventController $controller
  ) {
    gtk_widget_remove_controller($!gtk-w, $controller);
  }

  method remove_css_class (
    GtkWidget $widget,
    Str       $css_class
  ) {
    gtk_widget_remove_css_class($!gtk-w, $css_class);
  }

  method remove_mnemonic_label (
    GtkWidget $widget,
    GtkWidget $label
  ) {
    gtk_widget_remove_mnemonic_label($!gtk-w, $label);
  }

  method remove_tick_callback (
    GtkWidget $widget,
    guint     $id
  ) {
    gtk_widget_remove_tick_callback($!gtk-w, $id);
  }

  method set_can_focus (
    GtkWidget $widget,
    gboolean  $can_focus
  ) {
    gtk_widget_set_can_focus($!gtk-w, $can_focus);
  }

  method set_can_target (
    GtkWidget $widget,
    gboolean  $can_target
  ) {
    gtk_widget_set_can_target($!gtk-w, $can_target);
  }

  method set_child_visible (
    GtkWidget $widget,
    gboolean  $child_visible
  ) {
    gtk_widget_set_child_visible($!gtk-w, $child_visible);
  }

  method set_css_classes (
    GtkWidget   $widget,
    CArray[Str] $classes
  ) {
    gtk_widget_set_css_classes($!gtk-w, $classes);
  }

  method set_cursor (
    GtkWidget $widget,
    GdkCursor $cursor
  ) {
    gtk_widget_set_cursor($!gtk-w, $cursor);
  }

  method set_cursor_from_name (
    GtkWidget $widget,
    Str       $name
  ) {
    gtk_widget_set_cursor_from_name($!gtk-w, $name);
  }

  method set_default_direction {
    gtk_widget_set_default_direction($!gtk-w);
  }

  method set_direction (
    GtkWidget        $widget,
    GtkTextDirection $dir
  ) {
    gtk_widget_set_direction($!gtk-w, $dir);
  }

  method set_focus_child (
    GtkWidget $widget,
    GtkWidget $child
  ) {
    gtk_widget_set_focus_child($!gtk-w, $child);
  }

  method set_focus_on_click (
    GtkWidget $widget,
    gboolean  $focus_on_click
  ) {
    gtk_widget_set_focus_on_click($!gtk-w, $focus_on_click);
  }

  method set_focusable (
    GtkWidget $widget,
    gboolean  $focusable
  ) {
    gtk_widget_set_focusable($!gtk-w, $focusable);
  }

  method set_font_map (
    GtkWidget    $widget,
    PangoFontMap $font_map
  ) {
    gtk_widget_set_font_map($!gtk-w, $font_map);
  }

  method set_font_options (
    GtkWidget            $widget,
    cairo_font_options_t $options
  ) {
    gtk_widget_set_font_options($!gtk-w, $options);
  }

  method set_halign (
    GtkWidget $widget,
    GtkAlign  $align
  ) {
    gtk_widget_set_halign($!gtk-w, $align);
  }

  method set_has_tooltip (
    GtkWidget $widget,
    gboolean  $has_tooltip
  ) {
    gtk_widget_set_has_tooltip($!gtk-w, $has_tooltip);
  }

  method set_hexpand (
    GtkWidget $widget,
    gboolean  $expand
  ) {
    gtk_widget_set_hexpand($!gtk-w, $expand);
  }

  method set_hexpand_set (
    GtkWidget $widget,
    gboolean  $set
  ) {
    gtk_widget_set_hexpand_set($!gtk-w, $set);
  }

  method set_layout_manager (
    GtkWidget        $widget,
    GtkLayoutManager $layout_manager
  ) {
    gtk_widget_set_layout_manager($!gtk-w, $layout_manager);
  }

  method set_margin_bottom (
    GtkWidget $widget,
    gint      $margin
  ) {
    gtk_widget_set_margin_bottom($!gtk-w, $margin);
  }

  method set_margin_end (
    GtkWidget $widget,
    gint      $margin
  ) {
    gtk_widget_set_margin_end($!gtk-w, $margin);
  }

  method set_margin_start (
    GtkWidget $widget,
    gint      $margin
  ) {
    gtk_widget_set_margin_start($!gtk-w, $margin);
  }

  method set_margin_top (
    GtkWidget $widget,
    gint      $margin
  ) {
    gtk_widget_set_margin_top($!gtk-w, $margin);
  }

  method set_name (
    GtkWidget $widget,
    Str       $name
  ) {
    gtk_widget_set_name($!gtk-w, $name);
  }

  method set_opacity (
    GtkWidget $widget,
    gdouble   $opacity
  ) {
    gtk_widget_set_opacity($!gtk-w, $opacity);
  }

  method set_overflow (
    GtkWidget   $widget,
    GtkOverflow $overflow
  ) {
    gtk_widget_set_overflow($!gtk-w, $overflow);
  }

  method set_parent (
    GtkWidget $widget,
    GtkWidget $parent
  ) {
    gtk_widget_set_parent($!gtk-w, $parent);
  }

  method set_receives_default (
    GtkWidget $widget,
    gboolean  $receives_default
  ) {
    gtk_widget_set_receives_default($!gtk-w, $receives_default);
  }

  method set_sensitive (
    GtkWidget $widget,
    gboolean  $sensitive
  ) {
    gtk_widget_set_sensitive($!gtk-w, $sensitive);
  }

  method set_size_request (
    GtkWidget $widget,
    gint      $width,
    gint      $height
  ) {
    gtk_widget_set_size_request($!gtk-w, $width, $height);
  }

  method set_state_flags (
    GtkWidget     $widget,
    GtkStateFlags $flags,
    gboolean      $clear
  ) {
    gtk_widget_set_state_flags($!gtk-w, $flags, $clear);
  }

  method set_tooltip_markup (
    GtkWidget $widget,
    Str       $markup
  ) {
    gtk_widget_set_tooltip_markup($!gtk-w, $markup);
  }

  method set_tooltip_text (
    GtkWidget $widget,
    Str       $text
  ) {
    gtk_widget_set_tooltip_text($!gtk-w, $text);
  }

  method set_valign (
    GtkWidget $widget,
    GtkAlign  $align
  ) {
    gtk_widget_set_valign($!gtk-w, $align);
  }

  method set_vexpand (
    GtkWidget $widget,
    gboolean  $expand
  ) {
    gtk_widget_set_vexpand($!gtk-w, $expand);
  }

  method set_vexpand_set (
    GtkWidget $widget,
    gboolean  $set
  ) {
    gtk_widget_set_vexpand_set($!gtk-w, $set);
  }

  method set_visible (
    GtkWidget $widget,
    gboolean  $visible
  ) {
    gtk_widget_set_visible($!gtk-w, $visible);
  }

  method should_layout {
    gtk_widget_should_layout($!gtk-w);
  }

  method show {
    gtk_widget_show($!gtk-w);
  }

  method size_allocate (
    GtkWidget     $widget,
    GtkAllocation $allocation,
    gint          $baseline
  ) {
    gtk_widget_size_allocate($!gtk-w, $allocation, $baseline);
  }

  method snapshot_child (
    GtkWidget   $widget,
    GtkWidget   $child,
    GtkSnapshot $snapshot
  ) {
    gtk_widget_snapshot_child($!gtk-w, $child, $snapshot);
  }

  method translate_coordinates (
    GtkWidget $src_widget,
    GtkWidget $dest_widget,
    gdouble   $src_x,
    gdouble   $src_y,
    gdouble   $dest_x is rw,
    gdouble   $dest_y is rw
  ) {
    gtk_widget_translate_coordinates($!gtk-w, $dest_widget, $src_x, $src_y, $dest_x, $dest_y);
  }

  method trigger_tooltip_query {
    gtk_widget_trigger_tooltip_query($!gtk-w);
  }

  method unmap {
    gtk_widget_unmap($!gtk-w);
  }

  method unparent {
    gtk_widget_unparent($!gtk-w);
  }

  method unrealize {
    gtk_widget_unrealize($!gtk-w);
  }

  method unset_state_flags (
    GtkWidget     $widget,
    GtkStateFlags $flags
  ) {
    gtk_widget_unset_state_flags($!gtk-w, $flags);
  }


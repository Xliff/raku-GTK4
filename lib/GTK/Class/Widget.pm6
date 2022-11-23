use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Widget:ver<4>;
use GTK::Raw::Class::Widget:ver<4>;

use GLib::Class::Object;

class GTK::Class::Widget:ver<$> is GLib::Class::Object {
  has GtkWidgetClass $!gtk-c-w is implementor;

  method class_add_binding (
    Int() $keyval,
    Int() $mods,
          &callback,
    Str() $format_string
  ) {
    my guint           $k = $keyval;
    my GdkModifierType $m = $mods;

    gtk_widget_class_add_binding(
      $!gtk-c-w,
      $k,
      $m,
      &callback,
      $format_string
    );
  }

  method class_add_binding_action (
    Int() $keyval,
    Int() $mods,
    Str() $action_name,
    Str() $format_string
  ) {
    my guint           $k = $keyval;
    my GdkModifierType $m = $mods;

    gtk_widget_class_add_binding_action(
      $!gtk-c-w,
      $k,
      $m,
      $action_name,
      $format_string
    );
  }

  method class_add_binding_signal (
    Int() $keyval,
    Int() $mods,
    Str() $signal,
    Str() $format_string
  ) {
    my guint           $k = $keyval;
    my GdkModifierType $m = $mods;

    gtk_widget_class_add_binding_signal(
      $!gtk-c-w,
      $keyval,
      $m,
      $signal,
      $format_string
    );
  }

  method class_add_shortcut (GtkShortcut() $shortcut) {
    gtk_widget_class_add_shortcut($!gtk-c-w, $shortcut);
  }

  method class_bind_template_callback_full (
    Str() $callback_name,
          &callback_symbol
  ) {
    gtk_widget_class_bind_template_callback_full(
      $!gtk-c-w,
      $callback_name,
      &callback_symbol
    );
  }

  method class_bind_template_child_full (
    Str() $name,
    Int() $internal_child,
    Int() $struct_offset
  ) {
    my gboolean $i = $internal_child;
    my gssize   $s = $struct_offset;

    gtk_widget_class_bind_template_child_full(
      $!gtk-c-w,
      $name,
      $internal_child,
      $struct_offset
    );
  }

  method class_get_accessible_role {
    gtk_widget_class_get_accessible_role($!gtk-c-w);
  }

  method class_get_activate_signal {
    gtk_widget_class_get_activate_signal($!gtk-c-w);
  }

  method class_get_css_name {
    gtk_widget_class_get_css_name($!gtk-c-w);
  }

  method class_get_layout_manager_type {
    gtk_widget_class_get_layout_manager_type($!gtk-c-w);
  }

  method class_install_action (
    Str() $action_name,
    Str() $parameter_type,
          &activate
  ) {
    gtk_widget_class_install_action(
      $!gtk-c-w,
      $action_name,
      $parameter_type,
      &activate
    );
  }

  method class_install_property_action (
    Str() $action_name,
    Str() $property_name
  ) {
    gtk_widget_class_install_property_action(
      $!gtk-c-w,
      $action_name,
      $property_name
    );
  }

  method class_query_action (
    guint                $index,
    GType                $owner,
    CArray[Str]          $action_name,
    CArray[GVariantType] $parameter_type,
    CArray[Str]          $property_name
  ) {
    gtk_widget_class_query_action(
      $!gtk-c-w,
      $index,
      $owner,
      $action_name,
      $parameter_type,
      $property_name
    );
  }

  method class_set_accessible_role (Int() $accessible_role) {
    my GtkAccessibleRole $a = $accessible_role;

    gtk_widget_class_set_accessible_role($!gtk-c-w, $a);
  }

  method class_set_activate_signal (Int() $signal_id) {
    my guint $s = $signal_id;

    gtk_widget_class_set_activate_signal($!gtk-c-w, $s);
  }

  method class_set_activate_signal_from_name (Str() $signal_name) {
    gtk_widget_class_set_activate_signal_from_name($!gtk-c-w, $signal_name);
  }

  method class_set_css_name (Str() $name) {
    gtk_widget_class_set_css_name($!gtk-c-w, $name);
  }

  method class_set_layout_manager_type (GType() $type) {
    gtk_widget_class_set_layout_manager_type($!gtk-c-w, $type);
  }

  method class_set_template (GBytes() $template_bytes) {
    gtk_widget_class_set_template($!gtk-c-w, $template_bytes);
  }

  method class_set_template_from_resource (Str() $resource_name) {
    gtk_widget_class_set_template_from_resource($!gtk-c-w, $resource_name);
  }

  method class_set_template_scope (GtkBuilderScope() $scope) {
    gtk_widget_class_set_template_scope($!gtk-c-w, $scope);
  }

}

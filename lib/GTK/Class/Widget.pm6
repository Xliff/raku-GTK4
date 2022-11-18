use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Widgget:ver<4>;

use GLib::Class::Object;

class GTK::Class::Widger:ver<$> is GLib::Class::Object {
  has GtkWidgetClass $!gtk-c-w is implementor;

  method class_add_binding (
    guint           $keyval,
    GdkModifierType $mods,
    GtkShortcutFunc $callback,
    Str             $format_string
  ) {
    gtk_widget_class_add_binding($!gtk-w, $keyval, $mods, $callback, $format_string);
  }

  method class_add_binding_action (
    guint           $keyval,
    GdkModifierType $mods,
    Str             $action_name,
    Str             $format_string
  ) {
    gtk_widget_class_add_binding_action($!gtk-w, $keyval, $mods, $action_name, $format_string);
  }

  method class_add_binding_signal (
    guint           $keyval,
    GdkModifierType $mods,
    Str             $signal,
    Str             $format_string
  ) {
    gtk_widget_class_add_binding_signal($!gtk-w, $keyval, $mods, $signal, $format_string);
  }

  method class_add_shortcut (GtkShortcut $shortcut) {
    gtk_widget_class_add_shortcut($!gtk-w, $shortcut);
  }

  method class_bind_template_callback_full (
    Str            $callback_name,
    GCallback      $callback_symbol
  ) {
    gtk_widget_class_bind_template_callback_full($!gtk-w, $callback_name, $callback_symbol);
  }

  method class_bind_template_child_full (
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
    Str                         $action_name,
    Str                         $parameter_type,
    GtkWidgetActionActivateFunc $activate
  ) {
    gtk_widget_class_install_action($!gtk-w, $action_name, $parameter_type, $activate);
  }

  method class_install_property_action (
    Str            $action_name,
    Str            $property_name
  ) {
    gtk_widget_class_install_property_action($!gtk-w, $action_name, $property_name);
  }

  method class_query_action (
    guint                $index_,
    GType                $owner,
    CArray[Str]          $action_name,
    CArray[GVariantType] $parameter_type,
    CArray[Str]          $property_name
  ) {
    gtk_widget_class_query_action($!gtk-w, $index_, $owner, $action_name, $parameter_type, $property_name);
  }

  method class_set_accessible_role (GtkAccessibleRole $accessible_role) {
    gtk_widget_class_set_accessible_role($!gtk-w, $accessible_role);
  }

  method class_set_activate_signal (
    guint          $signal_id
  ) {
    gtk_widget_class_set_activate_signal($!gtk-w, $signal_id);
  }

  method class_set_activate_signal_from_name (
    Str            $signal_name
  ) {
    gtk_widget_class_set_activate_signal_from_name($!gtk-w, $signal_name);
  }

  method class_set_css_name (
    Str            $name
  ) {
    gtk_widget_class_set_css_name($!gtk-w, $name);
  }

  method class_set_layout_manager_type (
    GType          $type
  ) {
    gtk_widget_class_set_layout_manager_type($!gtk-w, $type);
  }

  method class_set_template (
    GBytes         $template_bytes
  ) {
    gtk_widget_class_set_template($!gtk-w, $template_bytes);
  }

  method class_set_template_from_resource (
    Str            $resource_name
  ) {
    gtk_widget_class_set_template_from_resource($!gtk-w, $resource_name);
  }

  method class_set_template_scope (
    GtkBuilderScope $scope
  ) {
    gtk_widget_class_set_template_scope($!gtk-w, $scope);
  }

}

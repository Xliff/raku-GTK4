use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Class::Widget;

class GtkWidgetClass is repr<CPointer> does GLib::Roles::Pointers is export { }

sub gtk_widget_class_add_binding (
  GtkWidgetClass  $widget_class,
  guint           $keyval,
  GdkModifierType $mods,
                  &callback (GtkWidget, GVariant, gpointer --> gboolean),
  Str             $format_string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_add_binding_action (
  GtkWidgetClass  $widget_class,
  guint           $keyval,
  GdkModifierType $mods,
  Str             $action_name,
  Str             $format_string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_add_binding_signal (
  GtkWidgetClass  $widget_class,
  guint           $keyval,
  GdkModifierType $mods,
  Str             $signal,
  Str             $format_string
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_add_shortcut (
  GtkWidgetClass $widget_class,
  GtkShortcut    $shortcut
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_bind_template_callback_full (
  GtkWidgetClass $widget_class,
  Str            $callback_name,
  GCallback      $callback_symbol
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_bind_template_child_full (
  GtkWidgetClass $widget_class,
  Str            $name,
  gboolean       $internal_child,
  gssize         $struct_offset
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_get_accessible_role (GtkWidgetClass $widget_class)
  returns GtkAccessibleRole
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_get_activate_signal (GtkWidgetClass $widget_class)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_get_css_name (GtkWidgetClass $widget_class)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_get_layout_manager_type (GtkWidgetClass $widget_class)
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_install_action (
  GtkWidgetClass              $widget_class,
  Str                         $action_name,
  Str                         $parameter_type,
                              &activate (GtkWidget, Str, GVariant)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_install_property_action (
  GtkWidgetClass $widget_class,
  Str            $action_name,
  Str            $property_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_query_action (
  GtkWidgetClass       $widget_class,
  guint                $index_,
  GType                $owner,
  CArray[Str]          $action_name,
  CArray[GVariantType] $parameter_type,
  CArray[Str]          $property_name
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_accessible_role (
  GtkWidgetClass    $widget_class,
  GtkAccessibleRole $accessible_role
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_activate_signal (
  GtkWidgetClass $widget_class,
  guint          $signal_id
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_activate_signal_from_name (
  GtkWidgetClass $widget_class,
  Str            $signal_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_css_name (
  GtkWidgetClass $widget_class,
  Str            $name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_layout_manager_type (
  GtkWidgetClass $widget_class,
  GType          $type
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_template (
  GtkWidgetClass $widget_class,
  GBytes         $template_bytes
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_template_from_resource (
  GtkWidgetClass $widget_class,
  Str            $resource_name
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_widget_class_set_template_scope (
  GtkWidgetClass  $widget_class,
  GtkBuilderScope $scope
)
  is      native(gtk4)
  is      export
{ * }

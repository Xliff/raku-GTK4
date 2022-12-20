use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Builder:ver<4>;

#### /usr/src/gtk4/gtk/gtkbuilder.h

sub gtk_builder_add_from_file (
  GtkBuilder              $builder,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_add_from_resource (
  GtkBuilder              $builder,
  Str                     $resource_path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_add_from_string (
  GtkBuilder              $builder,
  Str                     $buffer,
  gssize                  $length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_add_objects_from_file (
  GtkBuilder              $builder,
  Str                     $filename,
  CArray[Str]             $object_ids,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_add_objects_from_resource (
  GtkBuilder              $builder,
  Str                     $resource_path,
  CArray[Str]             $object_ids,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_add_objects_from_string (
  GtkBuilder              $builder,
  Str                     $buffer,
  gssize                  $length,
  CArray[Str]             $object_ids,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_create_closure (
  GtkBuilder              $builder,
  Str                     $function_name,
  GtkBuilderClosureFlags  $flags,
  GObject                 $object,
  CArray[Pointer[GError]] $error
)
  returns GClosure
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_error_quark
  returns GQuark
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_expose_object (
  GtkBuilder $builder,
  Str        $name,
  GObject    $object
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_extend_with_template (
  GtkBuilder              $builder,
  GObject                 $object,
  GType                   $template_type,
  Str                     $buffer,
  gssize                  $length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_current_object (GtkBuilder $builder)
  returns GObject
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_object (
  GtkBuilder $builder,
  Str        $name
)
  returns GObject
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_objects (GtkBuilder $builder)
  returns GSList
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_scope (GtkBuilder $builder)
  returns GtkBuilderScope
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_translation_domain (GtkBuilder $builder)
  returns Str
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_get_type_from_name (
  GtkBuilder $builder,
  Str        $type_name
)
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_new
  returns GtkBuilder
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_new_from_file (Str $filename)
  returns GtkBuilder
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_new_from_resource (Str $resource_path)
  returns GtkBuilder
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_new_from_string (
  CArray[uint8] $string,
  gssize        $length
)
  returns GtkBuilder
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_set_current_object (
  GtkBuilder $builder,
  GObject    $current_object
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_set_scope (
  GtkBuilder      $builder,
  GtkBuilderScope $scope
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_set_translation_domain (
  GtkBuilder $builder,
  Str        $domain
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_value_from_string (
  GtkBuilder              $builder,
  GParamSpec              $pspec,
  Str                     $string,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_builder_value_from_string_type (
  GtkBuilder              $builder,
  GType                   $type,
  Str                     $string,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

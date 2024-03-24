use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Expression:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkexpression.h

sub gtk_expression_bind (
  GtkExpression $self,
  gpointer      $target,
  Str           $property,
  gpointer      $this_
)
  returns GtkExpressionWatch
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_evaluate (
  GtkExpression $self,
  gpointer      $this_,
  GValue        $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_get_value_type (GtkExpression $self)
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cclosure_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cclosure_expression_new (
  GType                 $value_type,
                        &marshal (
                          GClosure,
                          GValue,
                          guint
                          GValue,
                          gpointer,
                          gpointer
                          --> gpointer
                        ),
  guint                 $n_params,
  CArray[GtkExpression] $params,
                        &callback_func (gpointer --> gpointer),
  gpointer              $user_data,
                        &user_destroy (gpointer)
)
  returns GtkExpressionCClosure
  is      native(gtk4)
  is      export
{ * }

sub gtk_closure_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_closure_expression_new (
  GType                 $value_type,
  GClosure              $closure,
  guint                 $n_params,
  CArray[GtkExpression] $params
)
  returns GtkClosureExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_constant_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_constant_expression_get_value (GtkConstantExpression $expression)
  returns GValue
  is      native(gtk4)
  is      export
{ * }

sub gtk_constant_expression_new (GType $value_type)
  returns GtkConstantExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_constant_expression_new_for_value (GValue $value)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_object_expression_get_object (GtkObjectExpression $expression)
  returns GObject
  is      native(gtk4)
  is      export
{ * }

sub gtk_object_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_object_expression_new (GObject $object)
  returns GtkObjectExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_param_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_param_spec_expression (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GParamFlags $flags
)
  returns GParamSpec
  is      native(gtk4)
  is      export
{ * }

sub gtk_property_expression_get_expression (GtkPropertyExpression $expression)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_property_expression_get_pspec (GtkPropertyExpression $expression)
  returns GParamSpec
  is      native(gtk4)
  is      export
{ * }

sub gtk_property_expression_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_property_expression_new (
  GType         $this_type,
  GtkExpression $expression,
  Str           $property_name
)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_property_expression_new_for_pspec (
  GtkExpression $expression,
  GParamSpec    $pspec
)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_value_dup_expression (GValue $value)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_value_get_expression (GValue $value)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_value_set_expression (
  GValue        $value,
  GtkExpression $expression
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_value_take_expression (
  GValue        $value,
  GtkExpression $expression
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_is_static (GtkExpression $self)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_ref (GtkExpression $self)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_unref (GtkExpression $self)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_watch (
  GtkExpression       $self,
  gpointer            $this_,
                      &notify (GtkExpression),
  gpointer            $user_data,
                      &user_destroy (gpointer)
)
  returns GtkExpressionWatch
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_watch_evaluate (
  GtkExpressionWatch $watch,
  GValue             $value
)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_watch_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_watch_ref (GtkExpressionWatch $watch)
  returns GtkExpressionWatch
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_watch_unref (GtkExpressionWatch $watch)
  is      native(gtk4)
  is      export
{ * }

sub gtk_expression_watch_unwatch (GtkExpressionWatch $watch)
  is      native(gtk4)
  is      export
{ * }

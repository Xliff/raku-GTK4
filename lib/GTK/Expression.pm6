use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Expression:ver<4>;

use GLib::Value;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkExpressionAncestry is export of Mu
  where GtkExpression | GObject;

class GTK::Expression:ver<4> {
  also does GLib::Roles::Object;

  has GtkExpression $!gtk-e is implementor;

  submethod BUILD ( :$gtk-expr ) {
    self.setGtkExpression($gtk-expr) if $gtk-expr
  }

  method setGtkExpression (GtkExpressionAncestry $_) {
    my $to-parent;

    $!gtk-e = do {
      when GtkExpression {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkExpression, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkExpression
    is also<GtkExpression>
  { $!gtk-e }

  multi method new (
    $gtk-expr where * ~~ GtkExpressionAncestry,

    :$ref = True
  ) {
    return unless $gtk-expr;

    my $o = self.bless( :$gtk-expr );
    $o.ref if $ref;
    $o;
  }

  multi method bind (
    GObject() $target,
    Str()     $property,
    GObject() $this      = GObject,

    :e(:expr(:$expression)) is required
  ) {
    self.bind_target($target, $property, $this);
  }
  method bind_expression (
    GObject() $target,
    Str()     $property,
    GObject() $this      = GObject
  ) {
    gtk_expression_bind($!gtk-e, $target, $property, $this);
  }

  multi method evaluate {
    samewith(
      GLib::Value.new( $!gtk-e, GLib::Value.new(self.get_type) );
    );
  }
  multi method evaluate (GValue() $value) is static {
    samewith(GObject, $value);
  }
  multi method evaluate (GObject() $this, GValue()  $value) {
    gtk_expression_evaluate($!gtk-e, $this, $value);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_expression_get_type, $n, $t );
  }

  method is_static is also<is-static> {
    so gtk_expression_is_static($!gtk-e);
  }

  # cw: GtkExpressionPspec factory. Not a constructor.
  method new_for_pspec (GParamSpec() $pspec, :$raw = False)
    is also<
      new-for-pspec
      create_pspec
      create-pspec
    >
  {
    propReturnObject(
      gtk_property_expression_new_for_pspec($!gtk-e, $pspec),
      $raw,
      |GTK::Expression::PSpec
    )
  }

  method ref {
    gtk_expression_ref($!gtk-e);
    self;
  }

  method unref {
    gtk_expression_unref($!gtk-e);
  }

  method watch (
    gpointer $this,
             &notify,
    gpointer $user_data    = gpointer,
             &user_destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gtk_expression_watch($!gtk-e, $this, &notify, $user_data, &user_destroy);
  }

}


our subset GtkClosureExpressionAncestry is export of Mu
  where GtkClosureExpression | GtkExpressionAncestry;

class GTK::Expression::Closure is GTK::Expression:ver<4> {
  has GtkClosureExpression $!gtk-e-c is implementor;

  submethod BUILD ( :$gtk-expr-c ) {
    self.setGtkClosureExpression($gtk-expr-c) if $gtk-expr-c
  }

  method setGtkClosureExpression (GtkClosureExpressionAncestry $_) {
    my $to-parent;

    $!gtk-e-c = do {
      when GtkClosureExpression {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkClosureExpression, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkClosureExpression
  { $!gtk-e-c }

  multi method new (
    $gtk-expr-c where * ~~ GtkClosureExpressionAncestry,

    :$ref = True
  ) {
    return unless $gtk-expr-c;

    my $o = self.bless( :$gtk-expr-c );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int()                 $value_type,
    GClosure()            $closure,
    Int()                 $n_params,
    CArray[GtkExpression] $params
  ) {
    my GType $v = $value_type;
    my guint $n = $n_params;

    my $gtk-expr-c = gtk_closure_expression_new($v, $closure, $n, $params);

    $gtk-expr-c ?? self.bless( :$gtk-expr-c ) !! Nil;
  }

  method get_type ( :$raw = False ) is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_closure_expression_get_type, $n, $t );
  }

}


our subset GtkExpressionCClosureAncestry is export of Mu
  where GtkExpressionCClosure | GtkExpressionAncestry;

class GTK::Expression::Closure::C is GTK::Expression:ver<4> {
  has GtkExpressionCClosure $!gtk-e-cc is implementor;

  submethod BUILD ( :$gtk-expr-cc ) {
    self.setGtkExpressionCClosure($gtk-expr-cc) if $gtk-expr-cc
  }

  method setGtkExpressionCClosure (GtkExpressionCClosureAncestry $_) {
    my $to-parent;

    $!gtk-e-cc = do {
      when GtkExpressionCClosure {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkExpressionCClosure, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkExpressionCClosure
  { $!gtk-e-cc }

  multi method new (
    $gtk-expr-cc where * ~~ GtkExpressionCClosureAncestry,

    :$ref = True
  ) {
    return unless $gtk-expr-cc;

    my $o = self.bless( :$gtk-expr-cc );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    Int()  $value_type,
           &callback_func,
           @params              = (),
           $user_data           = gpointer,
          :$marshal             = Callable,
          :$user_destroy        = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    samewith(
      $value_type,
      $marshal,
      @params.elems,
      ArrayToCArray(GtkExpression, @params),
      &callback_func,
      $user_data,
      $user_destroy
    );
  }
  multi method new (
    Int()                 $value_type,
                          &marshal,
    Int()                 $n_params,
    CArray[GtkExpression] $params,
                          &callback_func,
    gpointer              $user_data,
                          &user_destroy   = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    my GType $v = $value_type;
    my guint $n = $n_params;

    my $gtk-expr-cc = gtk_cclosure_expression_new(
      $v,
      &marshal,
      $n,
      $params,
      &callback_func,
      $user_data,
      &user_destroy
    );

    $gtk-expr-cc ?? self.bless( :$gtk-expr-cc ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_cclosure_expression_get_type,
      $n,
      $t
    );
  }

}

class GTK::Expression::Constant is GTK::Expression:ver<4> {
  has GtkConstantExpression $!gtk-e-c is implementor;

  submethod BUILD ( :$gtk-expr-constant ) {
    self.setGtkExpressionCClosure($gtk-expr-constant) if $gtk-expr-constant
  }

  method setGtkExpressionCClosure (GtkExpressionCClosureAncestry $_) {
    my $to-parent;

    $!gtk-e-c = do {
      when GtkExpressionCClosure {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkExpressionCClosure, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkExpressionCClosure
    is also<GtkExpressionCClosure>
  { $!gtk-e-c }

  multi method new (
    $gtk-expr-constant where * ~~ GtkExpressionCClosureAncestry,

    :$ref = True
  ) {
    return unless $gtk-expr-constant;

    my $o = self.bless( :$gtk-expr-constant );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $type) {
    my GType $t                 = $type;
    my       $gtk-expr-constant = gtk_constant_expression_new($t);

    $gtk-expr-constant ?? self.bless( :$gtk-expr-constant ) !! Nil;
  }

  method new_for_value (GValue() $v) is also<new-for-value> {
    my $gtk-expr-constant = gtk_constant_expression_new_for_value($v);

    $gtk-expr-constant ?? self.bless( :$gtk-expr-constant ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_constant_expression_get_type,
      $n,
      $t
    );
  }

  method get_value ( :$raw = False ) is also<get-value> {
    propReturnObject(
      gtk_constant_expression_get_value($!gtk-e-c),
      $raw,
      |GLib::Value.getTypePair
    );
  }
}


our subset GtkObjectExpressionAncestry is export of Mu
  where GtkObjectExpression | GtkExpressionAncestry;

class GTK::Expression::Object is GTK::Expression:ver<4> {
  has GtkObjectExpression $!gtk-e-o is implementor;

  submethod BUILD ( :$gtk-expr-obj ) {
    self.setGtkObjectExpresson($gtk-expr-obj) if $gtk-expr-obj
  }

  method setGtkObjectExpression (GtkObjectExpressionAncestry $_) {
    my $to-parent;

    $!gtk-e-o = do {
      when GtkObjectExpression {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkObjectExpression, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkObjectExpression
    is also<GtkObjectExpression>
  { $!gtk-e-o }

  multi method new (
    $gtk-expr-obj where * ~~ GtkObjectExpressionAncestry,

    :$ref = True
  ) {
    return unless $gtk-expr-obj;

    my $o = self.bless( :$gtk-expr-obj );
    $o.ref if $ref;
    $o;
  }
  multi method new (GObject() $object) {
    my $gtk-expr-obj = gtk_object_expression_new($object);

    $gtk-expr-obj ?? self.bless( :$gtk-expr-obj ) !! Nil
  }

  method get_object ( :$raw = False ) is also<get-object> {
    propReturnObject(
      gtk_object_expression_get_object($!gtk-e-o),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_object_expression_get_type, $n, $t );
  }

}


our subset GtkParamSpecExpressionAncestry is export of Mu
  where GtkParamSpecExpression | GtkExpressionAncestry;

class GTK::Expression::Param is GTK::Expression:ver<4> {
  has GtkParamSpecExpression $!gtk-e-p is implementor;

  submethod BUILD ( :$gtk-param-expr ) {
    self.setGtkParamSpecExpression($gtk-param-expr) if $gtk-param-expr
  }

  method setGtkParamSpecExpression (GtkParamSpecExpressionAncestry $_) {
    my $to-parent;

    $!gtk-e-p = do {
      when GtkParamSpecExpression {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkParamSpecExpression, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkParamSpecExpression
    is also<GtkParamSpecExpression>
  { $!gtk-e-p }

  multi method new (
    $gtk-param-expr where * ~~ GtkParamSpecExpressionAncestry ,

    :$ref = True
  ) {
    return unless $gtk-param-expr;

    my $o = self.bless( :$gtk-param-expr );
    $o.ref if $ref;
    $o;
  }

  method expression (Str() $nick, Str() $blurb, Int() $flags) {
    my GParamFlags $f = $flags;

    my $gtk-param-expr = gtk_param_spec_expression($nick, $blurb, $f);

    $gtk-param-expr ?? self.bless( :$gtk-param-expr ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_param_expression_get_type, $n, $t );
  }

}


use MONKEY-TYPING;

augment class GLib::Value {

  method dup_expression ( :$raw = False ) is also<dup-expression> {
    propReturnObject(
      self.GValue,
      $raw,
      |GTK::Expression.getTypePair
    );
  }

  method get_expression ( :$raw = False ) is also<get-expression> {
    propReturnObject(
      self.GValue,
      $raw,
      |GTK::Expression.getTypePair
    );
  }

  method set_expression (GtkExpression() $expression)
    is also<set-expression>
  {
    gtk_value_set_expression(self.GValue, $expression);
  }

  method take_expression (GtkExpression() $expression)
    is also<take-expression>
  {
    gtk_value_take_expression(self.GValue, $expression);
  }
}


# STRUCT

our subset GtkExpressionWatchAncestry is export of Mu
  where GtkExpressionWatch | GtkExpressionAncestry;

class GTK::Expression::Watch:ver<4> is GTK::Expression:ver<4> {
  has GtkExpressionWatch $!gtk-e-w is implementor;

  submethod BUILD ( :$gtk-expr-watch ) {
    self.setGtkExpressionWatch($gtk-expr-watch) if $gtk-expr-watch
  }

  method setGtkExpressionWatch (GtkExpressionWatchAncestry $_) {
    my $to-parent;

    $!gtk-e-w = do {
      when GtkExpressionWatch {
        $to-parent = cast(GtkExpression, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkExpressionWatch, $_);
      }
    }
    self.setGtkExpression($to-parent);
  }

  method GTK::Raw::Definitions::GtkExpressionWatch
    is also<GtkExpressionWatch>
  { $!gtk-e-w }

  multi method new (
    $gtk-expr-watch where * ~~ GtkExpressionWatchAncestry,

    :$ref = True
  ) {
    return unless $gtk-expr-watch;

    my $o = self.bless( :$gtk-expr-watch );
    $o.ref if $ref;
    $o;
  }

  method evaluate (GValue() $value) {
    gtk_expression_watch_evaluate($!gtk-e-w, $value);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_expression_watch_get_type, $n, $t );
  }

  method ref {
    gtk_expression_watch_ref($!gtk-e-w);
    self;
  }

  method unref {
    gtk_expression_watch_unref($!gtk-e-w);
  }

  method unwatch {
    gtk_expression_watch_unwatch($!gtk-e-w);
  }

}

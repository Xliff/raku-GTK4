use v6.c;

use Method::Also;

use NativeCall;
use LibXML;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Builder:ver<4>;

use GLib::GList;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkBuilderAncestry is export of Mu
  where GtkBuilder | GObject;

class GTK::Builder:ver<4> {
  also does GLib::Roles::Object;
  also does Associative;

  has %!objects;
  has $!definition;

  has GtkBuilder $!gtk-build is implementor;

  submethod BUILD (
    :$gtk-builder,
    :$process,
    :$base,
    :$!definition
  ) {
    self.setGtkBuilder($gtk-builder) if $gtk-builder;
    self!processInputByName          if $!definition;

    unless $!definition {
      self!processInput(:$base)        if $process;
    }
  }

  method setGtkBuilder (GtkBuilderAncestry $_) {
    my $to-parent;

    $!gtk-build = do {
      when GtkBuilder {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkBuilder, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkBuilder
    is also<GtkBuilder>
  { $!gtk-build }

  multi method new (
    $gtk-builder where * ~~ GtkBuilderAncestry,

    :$ref = True
  ) {
    return unless $gtk-builder;

    my $o = self.bless( :$gtk-builder );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-builder = gtk_builder_new();

    $gtk-builder ?? self.bless( :$gtk-builder ) !! Nil
  }
  multi method new ( :$pod is required ) {
    ::?CLASS.new_from_string(
      getPodSection($pod, 'ui') // getPodSection($pod, 'glade')
    );
  }

  method new_from_file (Str() $filename, :$base, :$process = True)
    is also<new-from-file>
  {
    my $gtk-builder = gtk_builder_new_from_file($filename);

    $gtk-builder ?? self.bless( :$gtk-builder, :$process, :$base ) !! Nil
  }

  method new_from_resource (Str() $resource_path, :$base, :$process = True)
    is also<new-from-resource>
  {
    my $gtk-builder = gtk_builder_new_from_resource($resource_path);

    $gtk-builder ?? self.bless( :$gtk-builder, :$process, :$base ) !! Nil
  }

  method !processInput ( :$base ) {
    for self.get_objects(:$base) {
      say "Process Input: { .name }";
      %!objects{ .name } = $_;
    }
  }

  method !processInputByName ( :$base ) {
    say "Definition: { $!definition.^name }";

    my $dom = LibXML.parse(string => $!definition).root;

    my $firstLoop = True;
    my %names;
    # Determine required objects
    for $dom.find('//object | //menu') {
      my ($id, $type) = ( .getAttribute('id'), .getAttribute('class') );
      say "Object { $id } is a { $type }";
      %names{$id} = $type;
    }
    # Check required objects for need of dynamic loading.
    for %names.values {
      my $O = try ::($_);
      if $O === Nil {
        CATCH { default { .&note } }
        say "Attempting to load { $_ }...";

        require ::($ = $_);
        return  ::($ = $_)  unless $O === Nil;
      }
    }
    for %names.keys {
      say "Creating '$_'...";
      %!objects{$_} = self.get_object($_);
    }
  }

  # Role: Associative
  method AT-KEY (\k) is also<AT_KEY> {
    %!objects{k};
  }

  # Role: Associative
  method EXISTS-KEY (\k) is also<EXISTS_KEY> {
    %!objects{k}.defined;
  }

  method keys      { %!objects.keys      }
  method pairs     { %!objects.pairs     }
  method antipairs { %!objects.antipairs }
  method elems     { %!objects.elems     }
  method kv        { %!objects.kv        }

  proto method new_from_string (|)
    is also<new-from-string>
  { * }

  multi method new_from_string (
    Str  $string,
        :$encoding = 'utf8',
        :$length   = $string.chars,
        :$base,
        :$process  = True
  ) {
    samewith(
      $string.encode($encoding),
      $length,
      :$base,
      :$process,

      definition => $string
    );
  }
  multi method new_from_string (
    Blob   $string,
    Int()  $length,
          :$base,
          :$process     = True,
          :$definition
  ) {
    samewith(
       CArray[uint8].new($string),
       $length,
      :$base,
      :$process,

      definition => $definition // $string
    )
  }
  multi method new_from_string (
           @data,
    Int()  $length,
          :$base,
          :$process = True
  ) {
    samewith( CArray[uint8].new(@data), $length, :$base, :$process );
  }
  multi method new_from_string (
    CArray[uint8]  $string,
    Int()          $length,
                  :$base,
                  :$process     = True,
                  :$definition
  ) {
    my gssize $l           = $length;
    my        $gtk-builder = gtk_builder_new_from_string($string, $l);

    return Nil unless $gtk-builder;

    self.bless(
      :$gtk-builder,
      :$process,

      definition => $definition // $string
    );
  }

  method add_from_file (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<add-from-file>
  {
    clear_error;
    my $rv = so gtk_builder_add_from_file($!gtk-build, $filename, $error);
    set_error($error);
    $rv;
  }

  method add_from_resource (
    Str()                   $resource_path,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<add-from-resource>
  {
    clear_error;
    my $rv = so gtk_builder_add_from_resource(
      $!gtk-build,
      $resource_path,
      $error
    );
    set_error($error);
    $rv;
  }

  # cw: Add multis
  method add_from_string (
    Str()                   $buffer,
    Int()                   $length,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<add-from-string>
  {
    my gssize $l = $length;

    clear_error;
    my $rv = so gtk_builder_add_from_string($!gtk-build, $buffer, $l, $error);
    set_error($error);
    $rv;
  }

  method add_objects_from_file (
    Str()                   $filename,
    CArray[Str]             $object_ids,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<add-objects-from-file>
  {
    clear_error;
    my $rv = so gtk_builder_add_objects_from_file(
      $!gtk-build,
      $filename,
      $object_ids,
      $error
    );
    set_error($error);
    $rv;
  }

  method add_objects_from_resource (
    Str()                   $resource_path,
    CArray[Str]             $object_ids,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<add-objects-from-resource>
  {
    clear_error;
    my $rv = so gtk_builder_add_objects_from_resource(
      $!gtk-build,
      $resource_path,
      $object_ids,
      $error
    );
    set_error($error);
    $rv;
  }

  # cw: Add multis
  method add_objects_from_string (
    Str()                   $buffer,
    Int()                   $length,
    CArray[Str]             $object_ids,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<add-objects-from-string>
  {
    my gssize $l = $length;

    clear_error;
    my $rv = gtk_builder_add_objects_from_string(
      $!gtk-build,
      $buffer,
      $l,
      $object_ids,
      $error
    );
    set_error($error);
    $rv;
  }

  method create_closure (
    Str()                    $function_name,
    Int()                    $flags,
    GObject()                $object,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  )
    is also<create-closure>
  {
    my GtkBuilderClosureFlags $f = $flags;

    clear_error;
    my $c = gtk_builder_create_closure(
      $!gtk-build,
      $function_name,
      $f,
      $object,
      $error
    );
    set_error($error);
    propReturnObject($c, $raw, |GLib::Closure.getTypePair)
  }

  method error_quark is static is also<error-quark> {
    gtk_builder_error_quark();
  }

  method expose_object (Str() $name, GObject() $object) is also<expose-object> {
    gtk_builder_expose_object($!gtk-build, $name, $object);
  }

  proto method extend_with_template (|)
    is also<extend-with-template>
  { * }

  multi method extend_with_template (
    GObject()                $object,
    Int()                    $template_type,
                             @buffer,
    CArray[Pointer[GError]]  $error          = gerror,
    Int()                   :$length         = @buffer.elems
  ) {
    samewith(
      $object,
      $template_type,
      CArray[uint8].new(@buffer),
      $error,
      :$length
    )
  }
  multi method extend_with_template (
    GObject()                $object,
    Int()                    $template_type,
    Str                      $buffer,
    CArray[Pointer[GError]]  $error          = gerror,
    Int()                   :$length         = $buffer.chars,
                            :$encoding       = 'utf8'
  ) {
    samewith(
      $object,
      $template_type,
      $buffer.encode($encoding),
      $length,
      $error
    );
  }
  multi method extend_with_template (
    GObject()                $object,
    Int()                    $template_type,
    Blob                     $buffer,
    CArray[Pointer[GError]]  $error          = gerror,
    Int()                   :$length         = $buffer.bytes
  ) {
    samewith(
      $object,
      $template_type,
      $buffer,
      $length,
      $error
    );
  }
  multi method extend_with_template (
    GObject()               $object,
    Int()                   $template_type,
    CArray[uint8]           $buffer,
    Int()                   $length,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    my gssize $l = $length;
    my GType  $t = $template_type;

    clear_error;
    gtk_builder_extend_with_template(
      $!gtk-build,
      $object,
      $t,
      $buffer,
      $l,
      $error
    );
    set_error($error);
  }

  method get_current_object (
    :$raw                 = False,
    :quick(:$fast)        = False,
    :slow(:$proper)       = $fast.not,
    :$base                = GTK::Widget,
  )
    is also<get-current-object>
  {
    returnProperWidget(
      gtk_builder_get_current_object($!gtk-build),
      $raw,
      $proper,
      $base
    );
  }

  method get_object (
    Str()  $name,
          :$raw           = False,
          :quick(:$fast)  = False,
          :slow(:$proper) = $fast.not,
          :$base          = GTK::Widget,
  )
    is also<get-object>
  {
    returnProperWidget(
      gtk_builder_get_object($!gtk-build, $name),
      $raw,
      $proper,
      $base
    );
  }

  method get_objects (
    :$raw           = False,
    :$gslist        = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not,
    :$base          = GTK::Widget,
  )
    is also<get-objects>
  {
    my $l = returnGList(
      gtk_builder_get_objects($!gtk-build),
      $raw,
      $gslist
    );
    return $l if $raw && $gslist;

    $l.Array.map({
      returnProperWidget($_, $raw, $proper, $base)
    });
  }

  method get_scope is also<get-scope> {
    gtk_builder_get_scope($!gtk-build);
  }

  method get_translation_domain is also<get-translation-domain> {
    gtk_builder_get_translation_domain($!gtk-build);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_builder_get_type, $n, $t );
  }

  method get_type_from_name (Str() $type_name) is also<get-type-from-name> {
    gtk_builder_get_type_from_name($!gtk-build, $type_name);
  }

  method set_current_object (GObject() $current_object) is also<set-current-object> {
    gtk_builder_set_current_object($!gtk-build, $current_object);
  }

  method set_scope (Int() $scope) is also<set-scope> {
    my GtkBuilderScope $s = $scope;

    gtk_builder_set_scope($!gtk-build, $s);
  }

  method set_translation_domain (Str() $domain) is also<set-translation-domain> {
    gtk_builder_set_translation_domain($!gtk-build, $domain);
  }

  # cw: Add multi that returns the actual value and drops GValue param.
  proto method value_from_string (|)
    is also<value-from-string>
  { * }

  multi method value_from_string (
    GParamSpec()             $pspec,
    Str()                    $string,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$gvalue  = False
  ) {
    my $value = GLib::Value.new( $pspec.value_type );

    return-with-all(
      samewith($pspec, $string, $value, $error, :all, :$gvalue)
    );
  }
  multi method value_from_string (
    GParamSpec()             $pspec,
    Str()                    $string,
    GValue()                 $value,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$all     = False,
                            :$gvalue  = False
  ) {
    clear_error;
    my $rv = gtk_builder_value_from_string(
      $!gtk-build,
      $pspec,
      $string,
      $value,
      $error
    );
    set_error($error);
    $all.not ?? $rv !! ($rv, $gvalue ?? $value !! $value.value)
  }

  proto method value_from_string_type (|)
    is also<value-from-string-type>
  { * }

  multi method value_from_string_type (
    Int()                    $type,
    Str()                    $string,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$all     = False,
                            :$gvalue  = False
  ) {
    my $value = GLib::Value.new($type);
    return-with-all(
      samewith($type, $string, $value, $error, :all, :$gvalue)
    );
  }
  multi method value_from_string_type (
    Int()                    $type,
    Str()                    $string,
    GValue()                 $value,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$all     = False,
                            :$gvalue  = False
  ) {
    my GType $t = $type;

    clear_error;
    my $rv = gtk_builder_value_from_string_type(
      $!gtk-build,
      $t,
      $string,
      $value,
      $error
    );
    set_error($error);
    $all.not ?? $rv !! ($rv, $gvalue ?? $value !! $value.value)
  }

}

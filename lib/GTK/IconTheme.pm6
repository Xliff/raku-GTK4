use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::IconTheme:ver<4>;

use GDK::Display:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::GFile;

our subset GtkIconThemeAncestry is export of Mu
  where GtkIconTheme | GObject;

class GTK::IconTheme:ver<4> {
  also does GLib::Roles::Object;

  has GtkIconTheme $!gtk-it is implementor;

  submethod BUILD ( :$gtk-icon-theme ) {
    self.setGtkIconTheme($gtk-icon-theme) if $gtk-icon-theme
  }

  method setGtkIconTheme (GtkIconThemeAncestry $_) {
    my $to-parent;

    $!gtk-it = do {
      when GtkIconTheme {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkIconTheme, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkIconTheme
    is also<GtkIconTheme>
  { $!gtk-it }

  multi method new (
     $gtk-icon-theme where * ~~ GtkIconThemeAncestry,

    :$ref = True
  ) {
    return unless $gtk-icon-theme;

    my $o = self.bless( :$gtk-icon-theme );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-icon-theme = gtk_icon_theme_new();

    $gtk-icon-theme ?? self.bless( :$gtk-icon-theme ) !! Nil;
  }

  # Type: GdkDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Display.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Display.getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: GFile
  method file ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::File.getTypePair
        );
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: GtkStrv
  method icon-names ( :$raw = False )
    is rw
    is g-property
    is also<icon_names>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-names', $gv);
        my $sa = cast(CArray[Str], $gv.pointer);
        return $sa if $raw;
        CArrayToArray($sa);
      },
      STORE => -> $,  $val is copy {
        warn 'icon-names does not allow writing'
      }
    );
  }

  # Type: boolean
  method is-symbolic ( :$raw = False )
    is rw
    is g-property
    is also<is_symbolic>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-symbolic', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-symbolic', $gv);
      }
    );
  }

  # Type: GtkStrv
  method resource-path ( :$raw = False )
    is rw
    is g-property
    is also<resource_path>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resource-path', $gv);
        my $sa = cast(CArray[Str], $gv.pointer);
        return $sa if $raw;
        CArrayToArray($sa);
      },
      STORE => -> $, $val is copy {
        $val .= Array if $val.^can('Array');
        $val = newCArray(Str, $val) if $val ~~ Array;
        X::GLib::InvalidArgument.new(
          message => 'Argument to resource-path must be CArray[Str]-compatible!'
        ).throw;
        $gv.pointer = $val;
        self.prop_set('resource-path', $gv);
      }
    );
  }

  # Type: GtkStrv
  method search-path ( :$raw = False )
    is rw
    is g-property
    is also<search_path>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-path', $gv);
        my $sa = cast(CArray[Str], $gv.pointer);
        return $sa if $raw;
        CArrayToArray($sa);
      },
      STORE => -> $, $val is copy {
        $val .= Array if $val.^can('Array');
        $val = newCArray(Str, $val) if $val ~~ Array;
        X::GLib::InvalidArgument.new(
          message => 'Argument to search-path must be CArray[Str]-compatible!'
        ).throw;
        $gv.pointer = $val;
        self.prop_set('search-path', $gv);
      }
    );
  }

  # Type: string
  method theme-name is rw  is g-property is also<theme_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('theme-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('theme-name', $gv);
      }
    );
  }

  method get_for_display (GdkDisplay() $display) is also<get-for-display> {
    my $gtk-icon-theme = gtk_icon_theme_get_for_display($display);

    $gtk-icon-theme ?? self.bless( :$gtk-icon-theme ) !! Nil
  }

  method add_resource_path (Str() $path) is also<add-resource-path> {
    gtk_icon_theme_add_resource_path($!gtk-it, $path);
  }

  method add_search_path (Str() $path) is also<add-search-path> {
    gtk_icon_theme_add_search_path($!gtk-it, $path);
  }

  method error_quark is static is also<error-quark> {
    gtk_icon_theme_error_quark();
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gtk_icon_theme_get_display($!gtk-it),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_icon_names ( :$raw = False ) is also<get-icon-names> {
    # Transfer: full
    my $in = gtk_icon_theme_get_icon_names($!gtk-it);
    return $in if $raw;
    CArrayToArray($in);
  }

  method get_icon_sizes (Str() $icon_name) is also<get-icon-sizes> {
    gtk_icon_theme_get_icon_sizes($!gtk-it, $icon_name);
  }

  method get_resource_path is also<get-resource-path> {
    gtk_icon_theme_get_resource_path($!gtk-it);
  }

  method get_search_path is also<get-search-path> {
    gtk_icon_theme_get_search_path($!gtk-it);
  }

  method get_theme_name is also<get-theme-name> {
    gtk_icon_theme_get_theme_name($!gtk-it);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_icon_theme_get_type, $n, $t );
  }

  method has_gicon (GIcon() $gicon) is also<has-gicon> {
    so gtk_icon_theme_has_gicon($!gtk-it, $gicon);
  }

  method has_icon (Str() $icon_name) is also<has-icon> {
    so gtk_icon_theme_has_icon($!gtk-it, $icon_name);
  }

  method lookup_by_gicon (
    GIcon() $icon,
    Int()   $size,
    Int()   $scale,
    Int()   $direction,
    Int()   $flags
  )
    is also<lookup-by-gicon>
  {
    my gint               ($si, $sc) = ($size, $scale);
    my GtkTextDirection    $d        =  $direction;
    my GtkIconLookupFlags  $f        =  $flags;

    gtk_icon_theme_lookup_by_gicon($!gtk-it, $icon, $si, $sc, $d, $f);
  }

  proto method lookup_icon (|)
    is also<lookup-icon>
  { * }

  multi method lookup_icon (
    Str()       $icon_name,
                @fallbacks,
    Int()       $size,
    Int()       $scale,
    Int()       $direction,
    Int()       $flags
  ) {
    samewith(
      $icon_name,
      ArrayToCArray(Str, @fallbacks),
      $size,
      $scale,
      $direction,
      $flags
    );
  }
  multi method lookup_icon (
    Str()       $icon_name,
    CArray[Str] $fallbacks,
    Int()       $size,
    Int()       $scale,
    Int()       $direction,
    Int()       $flags
  ) {
    my gint               ($si, $sc) = ($size, $scale);
    my GtkTextDirection    $d        =  $direction;
    my GtkIconLookupFlags  $f        =  $flags;

    gtk_icon_theme_lookup_icon(
      $!gtk-it,
      $icon_name,
      $fallbacks,
      $si,
      $sc,
      $d,
      $f
    );
  }

  proto method set_resource_path (|)
    is also<set-resource-path>
  { * }

  multi method set_resource_path (@path) {
    samewith( ArrayToCArray(Str, @path) );
  }
  multi method set_resource_path (CArray[Str] $path) {
    gtk_icon_theme_set_resource_path($!gtk-it, $path);
  }

  proto method set_search_path (|)
    is also<set-search-path>
  { * }

  multi method set_search_path (@path) {
    samewith( ArrayToCArray(Str, @path) );
  }
  multi method set_search_path (CArray[Str] $path) {
    gtk_icon_theme_set_search_path($!gtk-it, $path);
  }

  method set_theme_name (Str() $theme_name) is also<set-theme-name> {
    gtk_icon_theme_set_theme_name($!gtk-it, $theme_name);
  }

}

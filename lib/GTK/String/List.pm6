use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::String::List:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset GtkStringListAncestry is export of Mu
  where GtkStringList | GListModel | GObject;

class GTK::String::List {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has GtkStringList $!gtk-sl is implementor;

  submethod BUILD ( :$gtk-string-list ) {
    self.setGtkStringList($gtk-string-list) if $gtk-string-list
  }

  method setGtkStringList (GtkStringListAncestry $_) {
    my $to-parent;

    $!gtk-sl = do {
      when GtkStringList {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $to-parent = cast(GObject, $_);
        $!lm       = $_;
        cast(GtkStringList, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkStringList, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel;
  }

  method GTK::Raw::Definitions::GtkStringList
    is also<GtkStringList>
  { $!gtk-sl }

  multi method new (
    $gtk-string where * ~~ GtkStringListAncestry,

    :$ref = True
  ) {
    return unless $gtk-string;

    my $o = self.bless( :$gtk-string );
    $o.ref if $ref;
    $o;
  }
  multi method new (@list) {
    samewith( ArrayToCArray(Str, @list, :null) );
  }
  multi method new (CArray[Str] $list) {
    my $gtk-string-list = gtk_string_list_new($list);

    $gtk-string-list ?? self.bless( :$gtk-string-list ) !! Nil;
  }

  method append (Str() $string) {
    gtk_string_list_append($!gtk-sl, $string);
  }

  method get_string (Int() $position) is also<get-string> {
    my guint $p = $position;

    gtk_string_list_get_string($!gtk-sl, $p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_string_list_get_type, $n, $t );
  }

  method remove (Int() $position) {
    my guint $p = $position;

    gtk_string_list_remove($!gtk-sl, $p);
  }

  multi method splice (
    Int() $position,
    Int() $n_removals,
          @additions
  ) {
    samewith(
      $position,
      $n_removals,
      ArrayToCArray(Str, @additions, :null);
    )
  }
  multi method splice (
    Int()       $position,
    Int()       $n_removals,
    CArray[Str] $additions   = CArray[Str]
  ) {
    my guint ($p, $n) = ($position, $n_removals);

    gtk_string_list_splice($!gtk-sl, $p, $n, $additions);
  }

  method take (Str() $string) {
    gtk_string_list_take($!gtk-sl, $string);
  }

}

our subset GtkStringObjectAncestry is export of Mu
  where GtkStringObject | GObject;

class GTK::String::Object {
  also does GLib::Roles::Object;

  has GtkStringObject $!gtk-so is implementor;

  submethod BUILD ( :$gtk-string-object ) {
    self.setGtkStringObject($gtk-string-object) if $gtk-string-object
  }

  method setGtkStringObject (GtkStringObjectAncestry $_) {
    my $to-parent;

    $!gtk-so = do {
      when GtkStringObject {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStringObject, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkStringObject
    is also<GtkStringObject>
  { $!gtk-so }

  multi method new (
    $gtk-string-object where * ~~ GtkStringObjectAncestry,

    :$ref = True
  ) {
    return unless $gtk-string-object;

    my $o = self.bless( :$gtk-string-object );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $string) {
    my $gtk-string-object = gtk_string_object_new($string);

    $gtk-string-object ?? self.bless( :$gtk-string-object ) !! Nil
  }

  # Type: string
  method string is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('string', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'string does not allow writing'
      }
    );
  }

  method get_string is also<get-string> {
    gtk_string_object_get_string($!gtk-so);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_string_object_get_type, $n, $t );
  }

}

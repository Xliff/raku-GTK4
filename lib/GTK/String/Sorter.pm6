use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::String::Sorter:ver<4>;

use GTK::Expression:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GtkStringSorterAncestry is export of Mu
  where GtkStringSorter | GObject;

class GTK::String::Sorter:ver<4> {
  also does GLib::Roles::Object;

  has GtkStringSorter $!gtk-ss is implementor;

  submethod BUILD ( :$gtk-string-sorter ) {
    self.setGtkStringSorter($gtk-string-sorter)
      if $gtk-string-sorter
  }

  method setGtkStringSorter (GtkStringSorterAncestry $_) {
    my $to-parent;

    $!gtk-ss = do {
      when GtkStringSorter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStringSorter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkStringSorter
    is also<GtkStringSorter>
  { $!gtk-ss }

  multi method new ($gtk-string-sorter where * ~~ GtkStringSorterAncestry , :$ref = True) {
    return unless $gtk-string-sorter;

    my $o = self.bless( :$gtk-string-sorter );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkExpression() $expression) {
    my $gtk-string-sorter = gtk_string_sorter_new($expression);

    $gtk-string-sorter ?? self.bless( :$gtk-string-sorter ) !! Nil;
  }

  # Type: GtkCollation
  method collation ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkCollation );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('collation', $gv);
        my $c = $gv.enum;
        return $c unless $enum;
        GtkCollationEnum($c);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkCollation) = $val;
        self.prop_set('collation', $gv);
      }
    );
  }

  # Type: boolean
  method ignore-case is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ignore-case', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('ignore-case', $gv);
      }
    );
  }

  method get_collation ( :$enum = True ) is also<get-collation> {
    my $e = gtk_string_sorter_get_collation($!gtk-ss);
    return $e unless $enum;
    GtkCollationEnum($e);
  }

  method get_expression ( :$raw = False ) is also<get-expression> {
    propReturnObject(
      gtk_string_sorter_get_expression($!gtk-ss),
      $raw,
      |GTK::Expression.getTypePair
    );
  }

  method get_ignore_case is also<get-ignore-case> {
    so gtk_string_sorter_get_ignore_case($!gtk-ss);
  }

  method set_collation (Int() $collation) is also<set-collation> {
    my GtkCollation $c = $collation;

    gtk_string_sorter_set_collation($!gtk-ss, $c);
  }

  method set_expression (GtkExpression() $expression)
    is also<set-expression>
  {
    gtk_string_sorter_set_expression($!gtk-ss, $expression);
  }

  method set_ignore_case (Int() $ignore_case) is also<set-ignore-case> {
    my gboolean $i = $ignore_case.so.Int;

    gtk_string_sorter_set_ignore_case($!gtk-ss, $i);
  }

}

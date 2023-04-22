use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Expression:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkNumericSorterAncestry is export of Mu
  where GtkNumericSorter | GObject;

class GTK::Numeric::Sorter {
  also does GLib::Roles::Object;

  has GtkNumericSorter $!gtk-ns is implementor;

  submethod BUILD ( :$gtk-numeric-sorter ) {
    self.setGtkNumericSorter($gtk-numeric-sorter) if $gtk-numeric-sorter;
  }

  method setGtkNumericSorter (GtkNumericSorterAncestry $_) {
    my $to-parent;

    $!gtk-ns = do {
      when GtkNumericSorter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNumericSorter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkNumericSorter
    is also<GtkNumericSorter>
  { $!gtk-ns }

  multi method new (
    $gtk-numeric-sorter where * ~~ GtkNumericSorterAncestry,

    :$ref = True
  ) {
    return unless $gtk-numeric-sorter;

    my $o = self.bless( :$gtk-numeric-sorter );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkExpression() $expression) {
    my $gtk-numeric-sorter = gtk_numeric_sorter_new($expression);

    $gtk-numeric-sorter ?? self.bless( :$gtk-numeric-sorter ) !! Nil;
  }
  multi method new ( *%a ) {
    # cw: -YYY- Replace with a properly typed expression!
    die 'Must set <express> when calling GTK::NumericSorter.new()!'
      unless %a<expression>;

    my $o = samewith( %a<expression>:delete );
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkSortType
  method expression ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Expression.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expression', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Expression.getTypePair
        );
      },
      STORE => -> $, GtkExpression() $val is copy {
        $gv.object = $val;
        self.prop_set('expression', $gv);
      }
    );
  }

  # Type: GtkSortType
  method sort-order ( :$enum = True )
    is rw
    is g-property
    is also<sort_order>
  {
    my $gv = GLib::Value.new( GTK::Enum::SortOrder.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sort-order', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GtkSortTypeEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('sort-order', $gv);
      }
    );
  }

  method get_expression ( :$raw = False ) is also<get-expression> {
    propReturnObject(
      gtk_numeric_sorter_get_expression($!gtk-ns),
      $raw,
      |GTK::Expression.getTypePair
    );
  }

  method get_sort_order ( :$enum = True ) is also<get-sort-order> {
    my $s = gtk_numeric_sorter_get_sort_order($!gtk-ns);
    return $s unless $enum;
    GtkSortTypeEnum($s);
  }

  method set_expression (GtkExpression() $expression)
    is also<set-expression>
  {
    gtk_numeric_sorter_set_expression($!gtk-ns, $expression);
  }

  method set_sort_order (GtkSortType $sort_order) is also<set-sort-order> {
    my GtkSortType $s = $sort_order;

    gtk_numeric_sorter_set_sort_order($!gtk-ns, $s);
  }

}

### /usr/src/gtk4/gtk/gtknumericsorter.h

sub gtk_numeric_sorter_get_expression (GtkNumericSorter $self)
  returns GtkExpression
  is      native(gtk4)
  is      export
{ * }

sub gtk_numeric_sorter_get_sort_order (GtkNumericSorter $self)
  returns GtkSortType
  is      native(gtk4)
  is      export
{ * }

sub gtk_numeric_sorter_new (GtkExpression $expression)
  returns GtkNumericSorter
  is      native(gtk4)
  is      export
{ * }

sub gtk_numeric_sorter_set_expression (
  GtkNumericSorter $self,
  GtkExpression    $expression
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_numeric_sorter_set_sort_order (
  GtkNumericSorter $self,
  GtkSortType      $sort_order
)
  is      native(gtk4)
  is      export
{ * }

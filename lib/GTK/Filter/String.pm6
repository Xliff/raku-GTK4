use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Filter::String:ver<4>;

use GTK::Filter:ver<4>;

our subset GtkStringFilterAncestry is export of Mu
  where GtkStringFilter | GtkFilterAncestry;

class GTK::Filter::String:ver<4> is GTK::Filter:ver<4> {
  has GtkStringFilter $!gtk-sf is implementor;

  submethod BUILD ( :$gtk-string-filter ) {
    self.setGtkStringFilter($gtk-string-filter) if $gtk-string-filter
  }

  method setGtkStringFilter (GtkStringFilterAncestry $_) {
    my $to-parent;

    $!gtk-sf = do {
      when GtkStringFilter {
        $to-parent = cast(GtkFilter, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStringFilter, $_);
      }
    }
    self.setGtkFilter($to-parent);
  }

  method GTK::Raw::Definitions::GtkStringFilter
  { $!gtk-sf }

  multi method new (
    $gtk-string-filter where * ~~ GtkStringFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-string-filter;

    my $o = self.bless( :$gtk-string-filter );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkExpression() $expr) {
    my $gtk-string-filter = gtk_string_filter_new($expr);

    $gtk-string-filter ?? self.bless( :$gtk-string-filter ) !! Nil;
  }

  # Type: boolean
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

  # Type: GtkStringFilterMatchMode
  method match-mode ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new-enum( GtkStringFilterMatchMode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('match-mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkStringFilterMatchModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.value-from-enum(GtkStringFilterMatchMode) = $val;
        self.prop_set('match-mode', $gv);
      }
    );
  }

  # Type: string
  method search is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('search', $gv);
      }
    );
  }

  method get_expression ( :$raw = False ) is also<get-expression> {
    propReturnObject(
      gtk_string_filter_get_expression($!gtk-sf),
      $raw,
      |GTK::Expression.getTypePair
    );
  }

  method get_ignore_case is also<get-ignore-case> {
    so gtk_string_filter_get_ignore_case($!gtk-sf);
  }

  method get_match_mode ( :$enum = True ) is also<get-match-mode> {
    my $m = gtk_string_filter_get_match_mode($!gtk-sf);
    return $m unless $enum;
    GtkStringFilterMatchModeEnum($m);
  }

  method get_search is also<get-search> {
    gtk_string_filter_get_search($!gtk-sf);
  }

  method set_expression (GtkExpression() $expression) is also<set-expression> {
    gtk_string_filter_set_expression($!gtk-sf, $expression);
  }

  method set_ignore_case (Int() $ignore_case) is also<set-ignore-case> {
    my gboolean $i = $ignore_case.so.Int;

    gtk_string_filter_set_ignore_case($!gtk-sf, $i);
  }

  method set_match_mode (Int() $mode) is also<set-match-mode> {
    my GtkStringFilterMatchMode $m = $mode;

    gtk_string_filter_set_match_mode($!gtk-sf, $m);
  }

  method set_search (Str() $search) is also<set-search> {
    gtk_string_filter_set_search($!gtk-sf, $search);
  }

}

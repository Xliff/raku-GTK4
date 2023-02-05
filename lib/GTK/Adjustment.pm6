use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Adjustment:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkAdjustmentAncestry is export of Mu
  where GtkAdjustment | GObject;

class GTK::Adjustment:ver<4> {
  also does GLib::Roles::Object;

  has GtkAdjustment $!gtk-adj is implementor;

  submethod BUILD ( :$gtk-adjustment ) {
    self.setGtkAdjustment($gtk-adjustment) if $gtk-adjustment
  }

  method setGtkAdjustment (GtkAdjustmentAncestry $_) {
    my $to-parent;

    $!gtk-adj = do {
      when GtkAdjustment {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAdjustment, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Structs::GtkAdjustment
    is also<GtkAdjustment>
  { $!gtk-adj }

  multi method new (
    $gtk-adjustment where * ~~ GtkAdjustmentAncestry,

    :$ref = True
  ) {
    return unless $gtk-adjustment;

    my $o = self.bless( :$gtk-adjustment );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Num() $value,
    Num() $lower          = 0,
    Num() $upper          = 100,
    Num() $step_increment = 1,
    Num() $page_increment = 10,
    Num() $page_size      = 100
  ) {
    my gdouble ($v, $l, $u, $s, $p, $sz) =
      ($value, $lower, $upper, $step_increment, $page_increment, $page_size);

    my $gtk-adjustment = gtk_adjustment_new($v, $l, $u, $s, $p, $sz);

    $gtk-adjustment ?? self.bless( :$gtk-adjustment ) !! Nil;
  }
  multi method new (
            $range where { $_ ~~ Range || .^can('Range') },
            :v(:$value)              =  $range.min,
            :step_increment(:$step)  = ($range.max - $range.min) / 20,
            :page_increment(:$page)  = ($range.max - $range.min) / 4
  ) {
    samewith($value, $range.min, $range.max, $step, $page)
  }

  # Type: double
  method lower is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('lower', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('lower', $gv);
      }
    );
  }

  # Type: double
  method page-increment
    is rw
    is g-property
    is also<page_increment>
  {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page-increment', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('page-increment', $gv);
      }
    );
  }

  # Type: double
  method page-size
    is rw
    is g-property
    is also<page_size>
  {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page-size', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('page-size', $gv);
      }
    );
  }

  # Type: double
  method step-increment
    is rw
    is g-property
    is also<step_increment>
  {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('step-increment', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('step-increment', $gv);
      }
    );
  }

  # Type: double
  method upper is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('upper', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('upper', $gv);
      }
    );
  }

  # Type: double
  method value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('value', $gv);
      }
    );
  }

  method range is g-accessor {
    Proxy.new:
      FETCH => -> $ {
        (self.lower, self.upper)
      },

      STORE => -> $, \v {
         (self.lower, self.upper) = takeIntOrArray(Num, v)
      };
  }

  method clamp_page (Num() $lower, Num() $upper) is also<clamp-page> {
    my gdouble ($l, $u) = ($lower, $upper);

    gtk_adjustment_clamp_page($!gtk-adj, $l, $u);
  }

  method configure (
    Num() $value,
    Num() $lower,
    Num() $upper,
    Num() $step_increment,
    Num() $page_increment,
    Num() $page_size
  ) {
    my ($v, $l, $u, $s, $p, $sz) =
      ($value, $lower, $upper, $step_increment, $page_increment, $page_size);

    gtk_adjustment_configure($!gtk-adj, $v, $l, $u, $s, $p, $sz);
  }

  method get_lower is also<get-lower> {
    gtk_adjustment_get_lower($!gtk-adj);
  }

  method get_minimum_increment is also<get-minimum-increment> {
    gtk_adjustment_get_minimum_increment($!gtk-adj);
  }

  method get_page_increment is also<get-page-increment> {
    gtk_adjustment_get_page_increment($!gtk-adj);
  }

  method get_page_size is also<get-page-size> {
    gtk_adjustment_get_page_size($!gtk-adj);
  }

  method get_step_increment is also<get-step-increment> {
    gtk_adjustment_get_step_increment($!gtk-adj);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_adjustment_get_type, $n, $t );
  }

  method get_upper is also<get-upper> {
    gtk_adjustment_get_upper($!gtk-adj);
  }

  method get_value is also<get-value> {
    gtk_adjustment_get_value($!gtk-adj);
  }

  method gist {
    qq:to/GIST/.chomp
      GTK::Adjustment.new(
        value          => { self.value          },
        lower          => { self.lower          },
        upper          => { self.upper          },
        step_increment => { self.step_increment },
        page_increment => { self.page_increment },
        page_size      => { self.page_size      }
      )
      GIST
  }


  method set_lower (Num() $lower) is also<set-lower> {
    my gdouble $l = $lower;

    gtk_adjustment_set_lower($!gtk-adj, $l);
  }

  method set_page_increment (Num() $page_increment)
    is also<set-page-increment>
  {
    my gdouble $i = $page_increment;

    gtk_adjustment_set_page_increment($!gtk-adj, $i);
  }

  method set_page_size (Num() $page_size) is also<set-page-size> {
    my gdouble $s = $page_size;

    gtk_adjustment_set_page_size($!gtk-adj, $s);
  }

  method set_step_increment (Num() $step_increment)
    is also<set-step-increment>
  {
    my gdouble $s = $step_increment;

    gtk_adjustment_set_step_increment($!gtk-adj, $s);
  }

  method set_upper (Num() $upper) is also<set-upper> {
    my gdouble $u = $upper;

    gtk_adjustment_set_upper($!gtk-adj, $u);
  }

  method set_value (Num() $value) is also<set-value> {
    my gdouble $v = $value;

    gtk_adjustment_set_value($!gtk-adj, $v);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Adjustment;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    my $existing = .slurp;
    %widgets = try from-json($existing) if $existing.chars;
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Adjustment;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

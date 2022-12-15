use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Expander:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkExpanderAncestry is export of Mu
  where GtkExpander | GtkWidgetAncestry;

class GTK::Expander:ver<4> is GTK::Widget:ver<4> {
  has GtkExpander $!gtk-ex is implementor;

  submethod BUILD ( :$gtk-expander ) {
    self.setGtkExpander($gtk-expander) if $gtk-expander
  }

  method setGtkExpander (GtkExpanderAncestry $_) {
    my $to-parent;

    $!gtk-ex = do {
      when GtkExpander {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkExpander, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkExpander
  { $!gtk-ex }

  multi method new (
    $gtk-expander where * ~~ GtkExpanderAncestry,

    :$ref = True
  ) {
    return unless $gtk-expander;

    my $o = self.bless( :$gtk-expander );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $label) {
    my $gtk-expander = gtk_expander_new($label);

    $gtk-expander ?? self.bless( :$gtk-expander ) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $gtk-expander = gtk_expander_new_with_mnemonic($label);

    $gtk-expander ?? self.bless( :$gtk-expander ) !! Nil;
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        returnProperWidget($gv.object, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method expanded is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expanded', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('expanded', $gv);
      }
    );
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: GtkWidget
  method label-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property

    is also<label_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label-widget', $gv);
        returnProperWidget($gv.object, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method resize-toplevel is rw  is g-property is also<resize_toplevel> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resize-toplevel', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resize-toplevel', $gv);
      }
    );
  }

  # Type: boolean
  method use-markup is rw  is g-property is also<use_markup> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-markup', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-markup', $gv);
      }
    );
  }

  # Type: boolean
  method use-underline is rw  is g-property is also<use_underline> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-underline', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-underline', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-ex, 'activate');
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_expander_get_child($!gtk-ex),
      $raw,
      $proper
    );
  }

  method get_expanded is also<get-expanded> {
    so gtk_expander_get_expanded($!gtk-ex);
  }

  method get_label is also<get-label> {
    gtk_expander_get_label($!gtk-ex);
  }

  method get_label_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-label-widget>
  {
    returnProperWidget(
      gtk_expander_get_label_widget($!gtk-ex),
      $raw,
      $proper
    );
  }

  method get_resize_toplevel is also<get-resize-toplevel> {
    so gtk_expander_get_resize_toplevel($!gtk-ex);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_expander_get_type, $n, $t );
  }

  method get_use_markup is also<get-use-markup> {
    so gtk_expander_get_use_markup($!gtk-ex);
  }

  method get_use_underline is also<get-use-underline> {
    so gtk_expander_get_use_underline($!gtk-ex);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_expander_set_child($!gtk-ex, $child);
  }

  method set_expanded (Int() $expanded) is also<set-expanded> {
    my gboolean $e = $expanded.so.Int;

    gtk_expander_set_expanded($!gtk-ex, $e);
  }

  method set_label (Str() $label) is also<set-label> {
    gtk_expander_set_label($!gtk-ex, $label);
  }

  method set_label_widget (GtkWidget() $label_widget)
    is also<set-label-widget>
  {
    gtk_expander_set_label_widget($!gtk-ex, $label_widget);
  }

  method set_resize_toplevel (Int() $resize_toplevel)
    is also<set-resize-toplevel>
  {
    my gboolean $r = $resize_toplevel.so.Int;

    gtk_expander_set_resize_toplevel($!gtk-ex, $r);
  }

  method set_use_markup (Int() $use_markup) is also<set-use-markup> {
    my gboolean $u = $use_markup.so.Int;

    gtk_expander_set_use_markup($!gtk-ex, $u);
  }

  method set_use_underline (Int() $use_underline)
    is also<set-use-underline>
  {
    my gboolean $u = $use_underline.so.Int;

    gtk_expander_set_use_underline($!gtk-ex, $u);
  }

}

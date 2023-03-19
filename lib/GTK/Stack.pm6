use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Stack:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Object;
use GTK::Roles::SelectionModel:ver<4>;

our subset GtkStackAncestry is export of Mu
  where GtkStack | GtkWidgetAncestry;

class GTK::Stack:ver<4> is GTK::Widget:ver<4> {
  has GtkStack $!gtk-stack is implementor;

  submethod BUILD ( :$gtk-stack ) {
    self.setGtkStack($gtk-stack) if $gtk-stack
  }

  method setGtkStack (GtkStackAncestry $_) {
    my $to-parent;

    $!gtk-stack = do {
      when GtkStack {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStack, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkStack
    is also<GtkStack>
  { $!gtk-stack }

  multi method new (
     $gtk-stack where * ~~ GtkStackAncestry,

    :$ref = True
  ) {
    return unless $gtk-stack;

    my $o = self.bless( :$gtk-stack );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-stack = gtk_stack_new();

    my $o = $gtk-stack ?? self.bless( :$gtk-stack ) !! Nil;
    $o.setAttributes(%a);
    $o;
  }

  # Type: boolean
  method hhomogeneous is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hhomogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hhomogeneous', $gv);
      }
    );
  }

  # Type: boolean
  method interpolate-size is rw  is g-property is also<interpolate_size> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('interpolate-size', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('interpolate-size', $gv);
      }
    );
  }

  # Type: GtkStackPage
  method item-type is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new( GtkStackPage );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        $gv.GtkStackPage;
      },
      STORE => -> $,  $val is copy {
        warn 'item-type does not allow writing'
      }
    );
  }

  # Type: uint
  method n-items is rw  is g-property is also<n_items> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-items', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-items does not allow writing'
      }
    );
  }

  # Type: boolean
  method needs-attention is rw  is g-property is also<needs_attention> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('needs-attention', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('needs-attention', $gv);
      }
    );
  }

  # Type: GtkSelectionModel
  method pages ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Selection::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pages', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Selection::Model.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'pages does not allow writing'
      }
    );
  }

  # Type: uint
  method transition-duration is rw  is g-property is also<transition_duration> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transition-duration', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('transition-duration', $gv);
      }
    );
  }

  # Type: boolean
  method transition-running is rw  is g-property is also<transition_running> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transition-running', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'transition-running does not allow writing'
      }
    );
  }

  # Type: GtkStackTransitionType
  method transition-type ( :$enum = True )
    is rw
    is g-property
    is also<transition_type>
  {
    my $gv = GLib::Value.new-enum( GtkStackTransitionType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transition-type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkStackTransitionTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkStackTransitionType) = $val;
        self.prop_set('transition-type', $gv);
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

  # Type: boolean
  method vhomogeneous is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('vhomogeneous', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('vhomogeneous', $gv);
      }
    );
  }

  # Type: GtkWidget
  method visible-child is rw  is g-property is also<visible_child> {
    my $gv = GLib::Value.new( GtkWidget );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible-child', $gv);
        $gv.GtkWidget;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkWidget = $val;
        self.prop_set('visible-child', $gv);
      }
    );
  }

  # Type: string
  method visible-child-name is rw  is g-property is also<visible_child_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible-child-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('visible-child-name', $gv);
      }
    );
  }

  method add_child (GtkWidget() $child) is also<add-child> {
    gtk_stack_add_child($!gtk-stack, $child);
  }

  method add_named (GtkWidget() $child, Str() $name) is also<add-named> {
    gtk_stack_add_named($!gtk-stack, $child, $name);
  }

  method add_titled (GtkWidget() $child, Str() $name, Str() $title)
    is also<add-titled>
  {
    gtk_stack_add_titled($!gtk-stack, $child, $name, $title);
  }

  method get_child_by_name (
    Str()  $name,
          :$raw           = False,
          :quick(:$fast)  = False,
          :slow(:$proper) = $fast.not
  )
    is also<get-child-by-name>
  {
    # Transfer: full
    returnProperWidget(
      gtk_stack_get_child_by_name($!gtk-stack, $name),
      $raw,
      $proper
    );
  }

  method get_hhomogeneous is also<get-hhomogeneous> {
    so gtk_stack_get_hhomogeneous($!gtk-stack);
  }

  method get_interpolate_size is also<get-interpolate-size> {
    gtk_stack_get_interpolate_size($!gtk-stack);
  }

  method get_page (GtkWidget() $child, :$raw = False) is also<get-page> {
    # Transfer: none
    propReturnObject(
      gtk_stack_get_page($!gtk-stack, $child),
      $raw,
      |GTK::Stack::Page.getTypePair
    );
  }

  method get_pages ( :$raw = False ) is also<get-pages> {
    propReturnObject(
      gtk_stack_get_pages($!gtk-stack),
      $raw,
      |GTK::Selection::Model.getTypePair
    );
  }

  method get_transition_duration is also<get-transition-duration> {
    gtk_stack_get_transition_duration($!gtk-stack);
  }

  method get_transition_running is also<get-transition-running> {
    so gtk_stack_get_transition_running($!gtk-stack);
  }

  method get_transition_type ( :$enum = True ) is also<get-transition-type> {
    my $t = gtk_stack_get_transition_type($!gtk-stack);
    return $t unless $enum;
    GtkStackTransitionTypeEnum($t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_stack_get_type, $n, $t );
  }

  method get_vhomogeneous is also<get-vhomogeneous> {
    so gtk_stack_get_vhomogeneous($!gtk-stack);
  }

  method get_visible_child is also<get-visible-child> {
    gtk_stack_get_visible_child($!gtk-stack);
  }

  method get_visible_child_name is also<get-visible-child-name> {
    gtk_stack_get_visible_child_name($!gtk-stack);
  }

  method remove (GtkWidget() $child) {
    gtk_stack_remove($!gtk-stack, $child);
  }

  method set_hhomogeneous (Int() $hhomogeneous) is also<set-hhomogeneous> {
    my gboolean $h = $hhomogeneous.so.Int;

    gtk_stack_set_hhomogeneous($!gtk-stack, $h);
  }

  method set_interpolate_size (Int() $interpolate_size)
    is also<set-interpolate-size>
  {
    my gboolean $i = $interpolate_size.so.Int;

    gtk_stack_set_interpolate_size($!gtk-stack, $i);
  }

  method set_transition_duration (Int() $duration)
    is also<set-transition-duration>
  {
    my guint $d = $duration;

    gtk_stack_set_transition_duration($!gtk-stack, $d);
  }

  method set_transition_type (Int() $transition)
    is also<set-transition-type>
  {
    my GtkStackTransitionType $t = $transition;

    gtk_stack_set_transition_type($!gtk-stack, $t);
  }

  method set_vhomogeneous (Int() $vhomogeneous)
    is also<set-vhomogeneous>
  {
    my gboolean $v = $vhomogeneous.so.Int;

    gtk_stack_set_vhomogeneous($!gtk-stack, $v);
  }

  method set_visible_child (GtkWidget() $child)
    is also<set-visible-child>
  {
    gtk_stack_set_visible_child($!gtk-stack, $child);
  }

  method set_visible_child_full (Str() $name, Int() $transition)
    is also<set-visible-child-full>
  {
    my GtkStackTransitionType $t = $transition;

    gtk_stack_set_visible_child_full($!gtk-stack, $name, $t);
  }

  method set_visible_child_name (Str() $name)
    is also<set-visible-child-name>
  {
    gtk_stack_set_visible_child_name($!gtk-stack, $name);
  }

}


our subset GtkStackPageAncestry is export of Mu
  where GtkStackPage | GObject;

class GTK::Stack::Page:ver<4> {
  also does GLib::Roles::Object;

  has GtkStackPage $!gtk-stack-page is implementor;

  submethod BUILD ( :$gtk-stack-page ) {
    self.setGtkStackPage($gtk-stack-page) if $gtk-stack-page
  }

  method setGtkStackPage (GtkStackPageAncestry $_) {
    my $to-parent;

    $!gtk-stack-page = do {
      when GtkStackPage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStackPage, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkStackPage
    is also<GtkStackPage>
  { $!gtk-stack-page }

  multi method new (
     $gtk-stack-page where * ~~ GtkStackPageAncestry,

    :$ref = True
  ) {
    return unless $gtk-stack-page;

    my $o = self.bless( :$gtk-stack-page );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-stack-page = GLib::Object.new-object-ptr( ::?CLASS.get_type );

    my $o = $gtk-stack-page ?? self.bless( :$gtk-stack-page ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
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
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
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

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: boolean
  method visible is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible', $gv);
      }
    );
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    returnProperWidget(
      gtk_stack_page_get_child($!gtk-stack-page),
      $raw,
      $proper,
    );
  }

  method get_icon_name is also<get-icon-name> {
    gtk_stack_page_get_icon_name($!gtk-stack-page);
  }

  method get_name is also<get-name> {
    gtk_stack_page_get_name($!gtk-stack-page);
  }

  method get_needs_attention is also<get-needs-attention> {
    so gtk_stack_page_get_needs_attention($!gtk-stack-page);
  }

  method get_title is also<get-title> {
    gtk_stack_page_get_title($!gtk-stack-page);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_stack_page_get_type, $n, $t );
  }

  method get_use_underline is also<get-use-underline> {
    so gtk_stack_page_get_use_underline($!gtk-stack-page);
  }

  method get_visible is also<get-visible> {
    so gtk_stack_page_get_visible($!gtk-stack-page);
  }

  method set_icon_name (Str() $setting) is also<set-icon-name> {
    gtk_stack_page_set_icon_name($!gtk-stack-page, $setting);
  }

  method set_name (Str() $setting) is also<set-name> {
    gtk_stack_page_set_name($!gtk-stack-page, $setting);
  }

  method set_needs_attention (Int() $setting) is also<set-needs-attention> {
    my gboolean $s = $setting.so.Int;

    gtk_stack_page_set_needs_attention($!gtk-stack-page, $s);
  }

  method set_title (Str() $setting) is also<set-title> {
    gtk_stack_page_set_title($!gtk-stack-page, $setting);
  }

  method set_use_underline (Int() $setting) is also<set-use-underline> {
    my gboolean $s = $setting.so.Int;

    gtk_stack_page_set_use_underline($!gtk-stack-page, $s);
  }

  method set_visible (Int() $visible) is also<set-visible> {
    my gboolean $v = $visible.so.Int;

    gtk_stack_page_set_visible($!gtk-stack-page, $v);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  for GTK::Stack, GTK::Stack::Page -> \O {
    my \P = O.getTypePair;
    given "widget-types.json".IO.open( :rw ) {
      if .slurp -> $j {
        if +$j.lines {
          .lock;
          %widgets = from-json( $j );
          %widgets{ P.head.^shortname } = P.tail.^name;
          .seek(0, SeekFromBeginning);
          .spurt: to-json(%widgets);
          .close;
        }
      }
    }
  }
}

INIT {
  for GTK::Stack, GTK::Stack::Page -> \O {
    %widget-types{O.get_type} = {
      name        => O.^name,
      object      => O,
      pair        => O.getTypePair
    }
  }
}

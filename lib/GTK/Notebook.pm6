use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Notebook:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkNotebookAncestry is export of Mu
  where GtkNotebook | GtkWidgetAncestry;

class GTK::Notebook:ver<4> is GTK::Widget:ver<4> {
  has GtkNotebook $!gtk-n is implementor;

  submethod BUILD ( :$gtk-notebook ) {
    self.setGtkNotebook($gtk-notebook) if $gtk-notebook
  }

  method setGtkNotebook (GtkNotebookAncestry $_) {
    my $to-parent;

    $!gtk-n = do {
      when GtkNotebook {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNotebook, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkNotebook
    is also<GtkNotebook>
  { $!gtk-n }

  multi method new (
    $gtk-notebook where * ~~ GtkNotebookAncestry,

    :$ref = True
  ) {
    return unless $gtk-notebook;

    my $o = self.bless( :$gtk-notebook );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-notebook = gtk_notebook_new();

    $gtk-notebook ?? self.bless( :$gtk-notebook ) !! Nil;
  }

  # Type: GtkWidget
  method child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        my $o = $gv.object;
        return Nil unless $o;
        returnProperWidget($o, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method detachable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('detachable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('detachable', $gv);
      }
    );
  }

  # Type: boolean
  method enable-popup is rw  is g-property is also<enable_popup> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-popup', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-popup', $gv);
      }
    );
  }

  # Type: string
  method group-name is rw  is g-property is also<group_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('group-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('group-name', $gv);
      }
    );
  }

  # Type: GtkWidget
  method menu (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GtkWidget );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('menu', $gv);
        my $o = $gv.object;
        return Nil unless $o;
        returnProperWidget($o, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('menu', $gv);
      }
    );
  }

  # Type: int
  method page is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('page', $gv);
      }
    );
  }

  # Type: GtkListModel
  method pages ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pages', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'pages does not allow writing'
      }
    );
  }

  # Type: boolean
  method reorderable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('reorderable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reorderable', $gv);
      }
    );
  }

  # Type: boolean
  method scrollable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scrollable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('scrollable', $gv);
      }
    );
  }

  # Type: boolean
  method show-border is rw  is g-property is also<show_border> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-border', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-border', $gv);
      }
    );
  }

  # Type: boolean
  method show-tabs is rw  is g-property is also<show_tabs> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-tabs', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-tabs', $gv);
      }
    );
  }

  # Type: GtkWidget
  method tab (
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
        self.prop_get('tab', $gv);
        propReturnObject($gv.object, $raw, $proper);
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('tab', $gv);
      }
    );
  }

  # Type: boolean
  method tab-expand is rw  is g-property is also<tab_expand> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tab-expand', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('tab-expand', $gv);
      }
    );
  }

  # Type: boolean
  method tab-fill is rw  is g-property is also<tab_fill> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tab-fill', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('tab-fill', $gv);
      }
    );
  }

  # Type: GtkPositionType
  method tab-pos ( :$enum = True ) is rw  is g-property is also<tab_pos> {
    my $gv = GLib::Value.new-enum( GtkPositionType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tab-pos', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkPositionTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPositionType) = $val;
        self.prop_set('tab-pos', $gv);
      }
    );
  }

  method append_page (GtkWidget() $child, GtkWidget() $tab_label)
    is also<append-page>
  {
    gtk_notebook_append_page($!gtk-n, $child, $tab_label);
  }

  method append_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab_label,
    GtkWidget() $menu_label
  )
    is also<append-page-menu>
  {
    gtk_notebook_append_page_menu(
      $!gtk-n,
      $child,
      $tab_label,
      $menu_label
    );
  }

  method detach_tab (GtkWidget() $child) is also<detach-tab> {
    gtk_notebook_detach_tab($!gtk-n, $child);
  }

  method get_action_widget (
    Int() $pack_type,
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-action-widget>
  {
    my GtkPackType $p = $pack_type;

    returnProperWidget(
      gtk_notebook_get_action_widget($!gtk-n, $pack_type),
      $raw,
      $proper
    );
  }

  method get_current_page is also<get-current-page> {
    gtk_notebook_get_current_page($!gtk-n);
  }

  method get_group_name is also<get-group-name> {
    gtk_notebook_get_group_name($!gtk-n);
  }

  method get_menu_label (GtkWidget() $child) is also<get-menu-label> {
    gtk_notebook_get_menu_label($!gtk-n, $child);
  }

  method get_menu_label_text (GtkWidget() $child)
    is also<get-menu-label-text>
  {
    gtk_notebook_get_menu_label_text($!gtk-n, $child);
  }

  method get_n_pages is also<get-n-pages> {
    gtk_notebook_get_n_pages($!gtk-n);
  }

  method get_nth_page (Int() $page_num) is also<get-nth-page> {
    my gint $p = $page_num;

    gtk_notebook_get_nth_page($!gtk-n, $p);
  }

  method get_page (GtkWidget() $child) is also<get-page> {
    gtk_notebook_get_page($!gtk-n, $child);
  }

  method get_pages is also<get-pages> {
    gtk_notebook_get_pages($!gtk-n);
  }

  method get_scrollable (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-scrollable>
  {
    returnProperWidget(
      gtk_notebook_get_scrollable($!gtk-n),
      $raw,
      $proper
    );
  }

  method get_show_border is also<get-show-border> {
    so gtk_notebook_get_show_border($!gtk-n);
  }

  method get_show_tabs is also<get-show-tabs> {
    so gtk_notebook_get_show_tabs($!gtk-n);
  }

  method get_tab_detachable (GtkWidget() $child)
    is also<get-tab-detachable>
  {
    gtk_notebook_get_tab_detachable($!gtk-n, $child);
  }

  method get_tab_label (GtkWidget() $child) is also<get-tab-label> {
    gtk_notebook_get_tab_label($!gtk-n, $child);
  }

  method get_tab_label_text (GtkWidget() $child) is also<get-tab-label-text> {
    gtk_notebook_get_tab_label_text($!gtk-n, $child);
  }

  method get_tab_pos is also<get-tab-pos> {
    gtk_notebook_get_tab_pos($!gtk-n);
  }

  method get_tab_reorderable (GtkWidget() $child)
    is also<get-tab-reorderable>
  {
    so gtk_notebook_get_tab_reorderable($!gtk-n, $child);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_notebook_get_type, $n, $t );
  }

  method insert_page (
    GtkWidget()  $child,
    GtkWidget()  $tab_label,
    Int()        $position
  )
    is also<insert-page>
  {
    my gint $p = $position;

    gtk_notebook_insert_page($!gtk-n, $child, $tab_label, $p);
  }

  method insert_page_menu (
    GtkWidget()   $child,
    GtkWidget()   $tab_label,
    GtkWidget()   $menu_label,
    Int()         $position
  )
    is also<insert-page-menu>
  {
    my gint $p = $position;

    gtk_notebook_insert_page_menu(
      $!gtk-n,
      $child,
      $tab_label,
      $menu_label,
      $position
    );
  }

  method next_page is also<next-page> {
    gtk_notebook_next_page($!gtk-n);
  }

  method popup_disable is also<popup-disable> {
    gtk_notebook_popup_disable($!gtk-n);
  }

  method popup_enable is also<popup-enable> {
    gtk_notebook_popup_enable($!gtk-n);
  }

  method prepend_page (GtkWidget() $child, GtkWidget() $tab_label)
    is also<prepend-page>
  {
    gtk_notebook_prepend_page($!gtk-n, $child, $tab_label);
  }

  method prepend_page_menu (
    GtkWidget() $child,
    GtkWidget() $tab_label,
    GtkWidget() $menu_label
  )
    is also<prepend-page-menu>
  {
    gtk_notebook_prepend_page_menu($!gtk-n, $child, $tab_label, $menu_label);
  }

  method prev_page is also<prev-page> {
    gtk_notebook_prev_page($!gtk-n);
  }

  method remove_page (Int() $page_num) is also<remove-page> {
    my gint $p = $page_num;

    gtk_notebook_remove_page($!gtk-n, $p);
  }

  method reorder_child (GtkWidget() $child, Int() $position)
    is also<reorder-child>
  {
    my gint $p = $position;

    gtk_notebook_reorder_child($!gtk-n, $child, $p);
  }

  method set_action_widget (GtkWidget() $widget, Int() $pack_type)
    is also<set-action-widget>
  {
    my GtkPackType $p = $pack_type;

    gtk_notebook_set_action_widget($!gtk-n, $widget, $p);
  }

  method set_current_page (Int() $page_num) is also<set-current-page> {
    my gint $p = $page_num;

    gtk_notebook_set_current_page($!gtk-n, $p);
  }

  method set_group_name (Str() $group_name) is also<set-group-name> {
    gtk_notebook_set_group_name($!gtk-n, $group_name);
  }

  method set_menu_label (GtkWidget() $child, GtkWidget() $menu_label)
    is also<set-menu-label>
  {
    gtk_notebook_set_menu_label($!gtk-n, $child, $menu_label);
  }


  method set_menu_label_text (GtkWidget() $child, Str() $menu_text)
    is also<set-menu-label-text>
  {
    gtk_notebook_set_menu_label_text($!gtk-n, $child, $menu_text);
  }

  method set_scrollable (Int() $scrollable) is also<set-scrollable> {
    my gboolean $s = $scrollable.so.Int;

    gtk_notebook_set_scrollable($!gtk-n, $s);
  }

  method set_show_border (Int() $show_border) is also<set-show-border> {
    my gboolean $s = $show_border.so.Int;

    gtk_notebook_set_show_border($!gtk-n, $s);
  }

  method set_show_tabs (Int() $show_tabs) is also<set-show-tabs> {
    my gboolean $s = $show_tabs.so.Int;

    gtk_notebook_set_show_tabs($!gtk-n, $s);
  }

  method set_tab_detachable (GtkWidget() $child, Int() $detachable)
    is also<set-tab-detachable>
  {
    my gboolean $d = $detachable.so.Int;

    gtk_notebook_set_tab_detachable($!gtk-n, $child, $detachable);
  }

  method set_tab_label (GtkWidget() $child, GtkWidget() $tab_label)
    is also<set-tab-label>
  {
    gtk_notebook_set_tab_label($!gtk-n, $child, $tab_label);
  }

  method set_tab_label_text (GtkWidget() $child, Str() $tab_text)
    is also<set-tab-label-text>
  {
    gtk_notebook_set_tab_label_text($!gtk-n, $child, $tab_text);
  }

  method set_tab_pos (Int() $pos) is also<set-tab-pos> {
    my GtkPositionType $p = $pos;

    gtk_notebook_set_tab_pos($!gtk-n, $p);
  }

  method set_tab_reorderable (GtkWidget $child, Int() $reorderable)
    is also<set-tab-reorderable>
  {
    my gboolean $r = $reorderable;

    gtk_notebook_set_tab_reorderable($!gtk-n, $child, $reorderable);
  }

}

our subset GtkNotebookPageAncestry is export of Mu
  where GtkNotebookPage | GtkWidgetAncestry;

class GTK::Notebook::Page {
  has GtkNotebookPage $!gtk-np is implementor;

  submethod BUILD ( :$gtk-notebook ) {
    self.setGtkNotebookPage($gtk-notebook) if $gtk-notebook
  }

  method setGtkNotebookPage (GtkNotebookPageAncestry $_) {
    my $to-parent;

    $!gtk-np = do {
      when GtkNotebookPage {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkNotebookPage, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkNotebookPage
    is also<GtkNotebook>
  { $!gtk-np }

  multi method new (
    $gtk-notebook where * ~~ GtkNotebookPageAncestry,

    :$ref = True
  ) {
    return unless $gtk-notebook;

    my $o = self.bless( :$gtk-notebook );
    $o.ref if $ref;
    $o;
  }

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-child>
  {
    propReturnObject(
      gtk_notebook_page_get_child($!gtk-np),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_notebook_page_get_type, $n, $t );
  }

  method num (GtkWidget() $child) {
    gtk_notebook_page_num($!gtk-np, $child);
  }

 }

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Notebook;
#   my \P = O.getTypePair;
#   given "widget-types.json".IO.open( :rw ) {
#     .lock;
#     %widgets = from-json( .slurp );
#     %widgets{ P.head.^shortname } = P.tail.^name;
#     .seek(0, SeekFromBeginning);
#     .spurt: to-json(%widgets);
#     .close;
#   }
# }

INIT {
  my \O = GTK::Notebook;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

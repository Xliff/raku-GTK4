use v6.c;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Assistant:ver<4>;

use GTK::Window;

use GLib::Roles::Implementor;

our subset GtkAssistantAncestry is export of Mu
  where GtkAssistant | GtkWindowAncestry;

class GTK::Assistant:ver<4> is GTK::Window:ver<4> {
  has GtkAssistant $!gtk-ass is implementor;

  submethod BUILD ( :$gtk-assistant ) {
    self.setGtkAssistant($gtk-assistant) if $gtk-assistant
  }

  method setGtkAssistant (GtkAssistantAncestry $_) {
    my $to-parent;

    $!gtk-ass = do {
      when GtkAssistant {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAssistant, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkAssistant
  { $!gtk-ass }

  multi method new (
    $gtk-assistant where * ~~ GtkAssistantAncestry,

    :$ref = True
  ) {
    return unless $gtk-assistant;

    my $o = self.bless( :$gtk-assistant );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-assistant = gtk_assistant_new();

    my $o = $gtk-assistant ?? self.bless( :$gtk-assistant ) !! Nil;
    $o.setAttributes(%a) if $o +%a;
    $o;
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

  # Type: int
  method use-header-bar is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-header-bar', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('use-header-bar', $gv);
      }
    );
  }

  method Apply {
    self.connect($!gtk-ass, 'apply');
  }

  method Cancel {
    self.connect($!gtk-ass, 'cancel');
  }

  method Close {
    self.connect($!gtk-ass, 'close');
  }

  method Escape {
    self.connect($!gtk-ass, 'escape');
  }

  method Prepare {
    self.connect-widget($!gtk-ass, 'prepare');
  }

  method add_action_widget (GtkWidget() $child) {
    gtk_assistant_add_action_widget($!gtk-ass, $child);
  }

  method append_page (GtkWidget() $page) {
    gtk_assistant_append_page($!gtk-ass, $page);
  }

  method commit {
    gtk_assistant_commit($!gtk-ass);
  }

  method get_current_page {
    gtk_assistant_get_current_page($!gtk-ass);
  }

  method get_n_pages {
    gtk_assistant_get_n_pages($!gtk-ass);
  }

  method get_nth_page (Int() $page_num) {
    my gint $p = $page_num;

    gtk_assistant_get_nth_page($!gtk-ass, $p);
  }

  method get_page (GtkWidget() $child) {
    gtk_assistant_get_page($!gtk-ass, $child);
  }

  method get_page_complete (GtkWidget() $page) {
    gtk_assistant_get_page_complete($!gtk-ass, $page);
  }

  method get_page_title (GtkWidget() $page) {
    gtk_assistant_get_page_title($!gtk-ass, $page);
  }

  method get_page_type (GtkWidget() $page) {
    gtk_assistant_get_page_type($!gtk-ass, $page);
  }

  method get_pages ( :$raw = False ) {
    # List of GtkAssistantPage
    propReturnObject(
      gtk_assistant_get_pages($!gtk-ass),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_assistant_get_type, $n, $t );
  }

  method insert_page (GtkWidget() $page, Int() $position = -1) {
    my gint $p = $position;

    gtk_assistant_insert_page($!gtk-ass, $page, $position);
  }

  method next_page {
    gtk_assistant_next_page($!gtk-ass);
  }

  method prepend_page (GtkWidget() $page) {
    gtk_assistant_prepend_page($!gtk-ass, $page);
  }

  method previous_page {
    gtk_assistant_previous_page($!gtk-ass);
  }

  method remove_action_widget (GtkWidget() $child) {
    gtk_assistant_remove_action_widget($!gtk-ass, $child);
  }

  method remove_page (Int() $page_num) {
    my gint $p = $page_num;

    gtk_assistant_remove_page($!gtk-ass, $p);
  }

  method set_current_page (Int() $page_num) {
    my gint $p = $page_num;

    gtk_assistant_set_current_page($!gtk-ass, $p);
  }

  method set_forward_page_func (
             &page_func,
    gpointer $data        = gpointer,
             &destroy     = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gtk_assistant_set_forward_page_func(
      $!gtk-ass,
      &page_func,
      $data,
      &destroy
    );
  }

  method set_page_complete (GtkWidget() $page, Int() $complete) {
    my gboolean $c = $complete.so.Int;

    gtk_assistant_set_page_complete($!gtk-ass, $page, $complete);
  }

  method set_page_title (GtkWidget() $page, Str() $title) {
    gtk_assistant_set_page_title($!gtk-ass, $page, $title);
  }

  method set_page_type (GtkWidget() $page, Int() $type) {
    my GtkAssistantPageType $t = $type;

    gtk_assistant_set_page_type($!gtk-ass, $page, $t);
  }

  method update_buttons_state {
    gtk_assistant_update_buttons_state($!gtk-ass);
  }

}

use GLib::Roles::Object;

our subset GtkAssistantPageAncestry is export of Mu
  where GtkAssistantPage | GObject;

class GTK::Assistant::Page {
  also does GLib::Roles::Object;

  has GtkAssistantPage $!gtk-ass-p is implementor;

  submethod BUILD ( :$gtk-assistant-page ) {
    self.setGtkAssistantPage($gtk-assistant-page) if $gtk-assistant-page
  }

  method setGtkAssistantPage (GtkAssistantPageAncestry $_) {
    my $to-parent;

    $!gtk-ass-p = do {
      when GtkAssistantPage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAssistantPage, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkAssistantPage
  { $!gtk-ass-p }

  multi method new (
    $gtk-assistant-page where * ~~ GtkAssistantPageAncestry,

     :$ref = True
  ) {
    return unless $gtk-assistant-page;

    my $o = self.bless( :$gtk-assistant-page );
    $o.ref if $ref;
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
    my $gv = GLib::Value.new( GtkWidget );
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
        $gv.objectg = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: boolean
  method complete is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('complete', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('complete', $gv);
      }
    );
  }

  # cw: Unknown properties!
  #
  # Type: GtkAssistantPage
  # method item-type is rw  is g-property {
  #   my $gv = GLib::Value.new( GtkAssistantPage );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       self.prop_get('item-type', $gv);
  #       $gv.GtkAssistantPage;
  #     },
  #     STORE => -> $,  $val is copy {
  #       warn 'item-type does not allow writing'
  #     }
  #   );
  # }
  #
  # Type: uint
  # method n-items is rw  is g-property {
  #   my $gv = GLib::Value.new( G_TYPE_UINT );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       self.prop_get('n-items', $gv);
  #       $gv.uint;
  #     },
  #     STORE => -> $, Int() $val is copy {
  #       warn 'n-items does not allow writing'
  #     }
  #   );
  # }

  # Type: GtkAssistantPageType
  method page-type is rw  is g-property {
    my $gv = GLib::Value.new( GtkAssistantPageType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page-type', $gv);
        $gv.GtkAssistantPageType;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkAssistantPageType = $val;
        self.prop_set('page-type', $gv);
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

  method get_child (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperWidget(
      gtk_assistant_page_get_child($!gtk-ass-p),
      $raw,
      $proper
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_assistant_page_get_type, $n, $t );
  }

}

INIT {
  my \O = GTK::Assistant;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

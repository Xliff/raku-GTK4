use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Window:ver<4>;

use GDK::Display:ver<4>;
use GTK::Widget:ver<4>;
use GTK::Window::Group:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Native:ver<4>;
use GTK::Roles::Root:ver<4>;
use GTK::Roles::ShortcutManager:ver<4>;

our subset GtkWindowAncestry is export of Mu
  where GtkWindow          | GtkNative | GtkRoot | GtkShortcutManager |
        GtkWidgetAncestry;

class GTK::Window:ver<4> is GTK::Widget {
  also does GTK::Roles::Native;
  also does GTK::Roles::Root;
  also does GTK::Roles::ShortcutManager;

  has GtkWindow $!gtk-win is implementor;

  submethod BUILD ( :$gtk-window, :$title, :$size ) {
    self.setGtkWindow($gtk-window) if $gtk-window;
  }

  method setGtkWindow (GtkWindowAncestry $_) {
    my $to-parent;

    $!gtk-win = do {
      when GtkWindow {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkNative {
        $!gtk-n    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkWindow, $_);
      }

      when GtkRoot {
        $!gtk-r    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkWindow, $_);
      }

      when GtkShortcutManager {
        $!gtk-sm   = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkWindow, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkWindow, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkNative;
    self.roleInit-GtkRoot;
    self.roleInit-GtkShortcutManager;
  }

  method GTK::Raw::Structs::GtkWindow
    is also<GtkWindow>
  { $!gtk-win }

  multi method new (GtkWindowAncestry $gtk-window, :$ref = True) {
    return unless $gtk-window;

    my $o = self.bless( :$gtk-window );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    :$title  = 'GtkApplicationWindow',
    :$width  = 100,
    :$height = $width,
    :$size   = ($width, $height)
  ) {
    my $gtk-window = gtk_window_new();

    say "New-win: { $gtk-window // 'NO WINDOW!' }";
    return unless $gtk-window;

    my $o = self.bless( :$gtk-window );
    $o.set_size_request( |$size );
    $o.title = $title if $title;
    $o
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

  # Type: string
  method startup-id is rw  is g-property is also<startup_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'startup-id does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('startup-id', $gv);
      }
    );
  }

  # Type: boolean
  method resizable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resizable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resizable', $gv);
      }
    );
  }

  # Type: boolean
  method modal is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('modal', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('modal', $gv);
      }
    );
  }

  # Type: int
  method default-width is rw  is g-property is also<default_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('default-width', $gv);
      }
    );
  }

  # Type: int
  method default-height is rw  is g-property is also<default_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('default-height', $gv);
      }
    );
  }

  # Type: boolean
  method destroy-with-parent
    is rw
    is g-property
    is also<destroy_with_parent>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('destroy-with-parent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('destroy-with-parent', $gv);
      }
    );
  }

  # Type: boolean
  method hide-on-close is rw  is g-property is also<hide_on_close> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hide-on-close', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('hide-on-close', $gv);
      }
    );
  }

  # Type: boolean
  method mnemonics-visible is rw  is g-property is also<mnemonics_visible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mnemonics-visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('mnemonics-visible', $gv);
      }
    );
  }

  # Type: boolean
  method focus-visible is rw  is g-property is also<focus_visible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('focus-visible', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('focus-visible', $gv);
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

  # Type: GdkDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Display );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Display.getTypePair
        )
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: boolean
  method is-active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-active does not allow writing'
      }
    );
  }

  # Type: boolean
  method decorated is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('decorated', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('decorated', $gv);
      }
    );
  }

  # Type: boolean
  method deletable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('deletable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('deletable', $gv);
      }
    );
  }

  # Type: GTKWindow
  method transient-for ( :$raw = False )
    is rw
    is g-property
    is also<transient_for>
  {
    my $gv = GLib::Value.new( self.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transient-for', $gv);
        propReturnObject(
          $gv.object,
          $raw
          |self.getTypePair
        );
      },
      STORE => -> $, GtkWindow() $val is copy {
        $gv.object = $val;
        self.prop_set('transient-for', $gv);
      }
    );
  }

  # Type: boolean
  method maximized is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('maximized', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('maximized', $gv);
      }
    );
  }

  # Type: boolean
  method fullscreened is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fullscreened', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fullscreened', $gv);
      }
    );
  }

  # Type: GTKApplication
  method application ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GTK::Application').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('application', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GTK::Application').getTypePair
        );
      },
      STORE => -> $, GtkApplication() $val is copy {
        $gv.object = $val;
        self.prop_set('application', $gv);
      }
    );
  }

  method Activate-Default is also<Activate_Default> {
    self.connect($!gtk-win, 'Activate-Default');
  }

  method Activate-Focus is also<Activate_Focus> {
    self.connect($!gtk-win, 'Activate-Focus');
  }

  method Close-Request is also<Close_Request> {
    self.connect-ruint($!gtk-win, 'Close-Request');
  }

  method Enable-Debugging is also<Enable_Debugging> {
    self.connect-uint-ruint($!gtk-win, 'Enable-Debugging');
  }

  method Keys-Changed is also<Keys_Changed> {
    self.connect($!gtk-win, 'Keys-Changed');
  }

  # Type: GTKWidget
  method default-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property

    is also<default_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-widget', $gv);
        returnProperWidget(
           $gv.object,
          :$raw,
          :$proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('default-widget', $gv);
      }
    );
  }

  # Type: GTKWidget
  method focus-widget (
   :$raw           = False,
   :quick(:$fast)  = False,
   :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
    is also<focus_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('focus-widget', $gv);
        returnProperWidget(
           $gv.object,
          :$raw,
          :$proper
        );
      },
      STORE => -> $c, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('focus-widget', $gv);
      }
    );
  }

  # Type: GTKWidget
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
           :$raw,
           :$proper
         );
       },
       STORE => -> $, GtkWidget() $val is copy {
         $gv.object = $val;
         self.prop_set('child', $gv);
       }
     );
  }

  # Type: GTKWidget
  method titlebar (
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
        self.prop_get('titlebar', $gv);
        returnProperWidget(
           $gv.object,
          :$raw,
          :$proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('titlebar', $gv);
      }
    );
  }

  # Type: boolean
  method handle-menubar-accel
    is rw
    is g-property
    is also<handle_menubar_accel>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('handle-menubar-accel', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('handle-menubar-accel', $gv);
      }
    );
  }

  method close {
    gtk_window_close($!gtk-win);
  }

  method destroy {
    gtk_window_destroy($!gtk-win);
  }

  method fullscreen {
    gtk_window_fullscreen($!gtk-win);
  }

  method fullscreen_on_monitor (GdkMonitor() $monitor)
    is also<fullscreen-on-monitor>
  {
    gtk_window_fullscreen_on_monitor($!gtk-win, $monitor);
  }

  method get_application ( :$raw = False ) is also<get-application> {
    propReturnObject(
      gtk_window_get_application($!gtk-win),
      $raw,
      |GTK::Application.getTypePair
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
       gtk_window_get_child($!gtk-win),
      :$raw,
      :$proper
    );
  }

  method get_decorated is also<get-decorated> {
    so gtk_window_get_decorated($!gtk-win);
  }

  method get_default_icon_name
    is static
    is also<get-default-icon-name>
  {
    gtk_window_get_default_icon_name();
  }

  proto method get_default_size (|)
    is also<get-default-size>
  { * }

  multi method get_default_size {
    samewith($, $);
  }
  multi method get_default_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_window_get_default_size($!gtk-win, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_default_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-default-widget>
  {
    returnProperWidget(
       gtk_window_get_default_widget($!gtk-win),
      :$raw,
      :$proper
    );
  }

  method get_deletable is also<get-deletable> {
    so gtk_window_get_deletable($!gtk-win);
  }

  method get_destroy_with_parent is also<get-destroy-with-parent> {
    so gtk_window_get_destroy_with_parent($!gtk-win);
  }

  method get_focus (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-focus>
  {
    $(
      gtk_window_get_focus($!gtk-win),
      $raw,
      $proper
    );
  }

  method get_focus_visible is also<get-focus-visible> {
    so gtk_window_get_focus_visible($!gtk-win);
  }

  method get_group ( :$raw = False ) is also<get-group> {
    propReturnObject(
      gtk_window_get_group($!gtk-win),
      $raw,
      |GTK::WindowGroup.getTypePair
    );
  }

  method get_handle_menubar_accel is also<get-handle-menubar-accel> {
    so gtk_window_get_handle_menubar_accel($!gtk-win);
  }

  method get_hide_on_close is also<get-hide-on-close> {
    so gtk_window_get_hide_on_close($!gtk-win);
  }

  method get_icon_name is also<get-icon-name> {
    gtk_window_get_icon_name($!gtk-win);
  }

  method get_mnemonics_visible is also<get-mnemonics-visible> {
    so gtk_window_get_mnemonics_visible($!gtk-win);
  }

  method get_modal is also<get-modal> {
    so gtk_window_get_modal($!gtk-win);
  }

  method get_resizable is also<get-resizable> {
    so gtk_window_get_resizable($!gtk-win);
  }

  method get_title is also<get-title> {
    gtk_window_get_title($!gtk-win);
  }

  method get_titlebar (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-titlebar>
  {
    returnProperWidget(
       gtk_window_get_titlebar($!gtk-win),
      :$raw,
      :$proper
    );
  }

  method get_toplevels ( :$raw = False, :$raw-model, :$model = False )
    is static
    is also<get-toplevels>
  {
    my $t = gtk_window_get_toplevels();
    return $t if $raw-model;
    $t = GIO::ListModel.new($t);
    return $t if $model;
    $t.Array if $raw;
    $t.Array.map({ propReturnObject($_, False, |GTK::Window.getTypePair) });
  }

  method get_transient_for ( :$raw = False ) is also<get-transient-for> {
    returnProperObject(
      gtk_window_get_transient_for($!gtk-win),
      $raw,
      |GTK::Window.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_window_get_type, $n, $t );
  }

  method has_group (Str() $group) is also<has-group> {
    so gtk_window_has_group($!gtk-win, $group);
  }

  method is_active {
    so gtk_window_is_active($!gtk-win);
  }

  method is_fullscreen is also<is-fullscreen> {
    so gtk_window_is_fullscreen($!gtk-win);
  }

  method is_maximized is also<is-maximized> {
    so gtk_window_is_maximized($!gtk-win);
  }

  method list_toplevels is also<list-toplevels> {
    # cw: -XXX- Finish refinement!
    gtk_window_list_toplevels();
  }

  method maximize {
    gtk_window_maximize($!gtk-win);
  }

  method minimize {
    gtk_window_minimize($!gtk-win);
  }

  method present
    is also<
      show_all
      show-all
    >
  {
    gtk_window_present($!gtk-win);
  }

  method present_with_time (Int() $timestamp) is also<present-with-time> {
    my guint32 $t = $timestamp;

    gtk_window_present_with_time($!gtk-win, $t);
  }

  method set_application (GtkApplication() $application)
    is also<set-application>
  {
    gtk_window_set_application($!gtk-win, $application);
  }

  method set_auto_startup_notification
    is also<set-auto-startup-notification>
  {
    gtk_window_set_auto_startup_notification($!gtk-win);
  }

  method set_child (GtkWidget() $child)
    is also<
      set-child
      add
    >
  {
    gtk_window_set_child($!gtk-win, $child);
  }

  method set_decorated (Int() $setting) is also<set-decorated> {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_decorated($!gtk-win, $s);
  }

  method set_default_icon_name (Str() $name) is also<set-default-icon-name> {
    gtk_window_set_default_icon_name($name);
  }

  method set_default_size (Int() $width, Int() $height)
    is also<set-default-size>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_window_set_default_size($!gtk-win, $w, $h);
  }

  method set_default_widget (GtkWidget() $default_widget)
    is also<set-default-widget>
  {
    gtk_window_set_default_widget($!gtk-win, $default_widget);
  }

  method set_deletable (Int() $setting) is also<set-deletable> {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_deletable($!gtk-win, $s);
  }

  method set_destroy_with_parent (Int() $setting)
    is also<set-destroy-with-parent>
  {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_destroy_with_parent($!gtk-win, $s);
  }

  method set_display (GdkDisplay() $display) is also<set-display> {
    gtk_window_set_display($!gtk-win, $display);
  }

  method set_focus (GtkWidget() $focus) is also<set-focus> {
    gtk_window_set_focus($!gtk-win, $focus);
  }

  method set_focus_visible (Int() $setting) is also<set-focus-visible> {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_focus_visible($!gtk-win, $s);
  }

  method set_handle_menubar_accel (Int() $handle_menubar_accel)
    is also<set-handle-menubar-accel>
  {
    my gboolean $h = $handle_menubar_accel.so.Int;

    gtk_window_set_handle_menubar_accel($!gtk-win, $h);
  }

  method set_hide_on_close (Int() $setting) is also<set-hide-on-close> {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_hide_on_close($!gtk-win, $s);
  }

  method set_icon_name (Str() $name) is also<set-icon-name> {
    gtk_window_set_icon_name($!gtk-win, $name);
  }

  method set_interactive_debugging is also<set-interactive-debugging> {
    gtk_window_set_interactive_debugging($!gtk-win);
  }

  method set_mnemonics_visible (Int() $setting)
    is also<set-mnemonics-visible>
  {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_mnemonics_visible($!gtk-win, $s);
  }

  method set_modal (Int() $modal) is also<set-modal> {
    my gboolean $m = $modal.so.Int;

    gtk_window_set_modal($!gtk-win, $m);
  }

  method set_resizable (Int() $resizable) is also<set-resizable> {
    my gboolean $r = $resizable.so.Int;

    gtk_window_set_resizable($!gtk-win, $r);
  }

  method set_startup_id (Str() $startup_id) is also<set-startup-id> {
    gtk_window_set_startup_id($!gtk-win, $startup_id);
  }

  method set_title (Str() $title) is also<set-title> {
    gtk_window_set_title($!gtk-win, $title);
  }

  method set_titlebar (GtkWidget() $titlebar) is also<set-titlebar> {
    gtk_window_set_titlebar($!gtk-win, $titlebar);
  }

  method set_transient_for (GtkWindow() $parent) is also<set-transient-for> {
    gtk_window_set_transient_for($!gtk-win, $parent);
  }

  method unfullscreen {
    gtk_window_unfullscreen($!gtk-win);
  }

  method unmaximize {
    gtk_window_unmaximize($!gtk-win);
  }

  method unminimize {
    gtk_window_unminimize($!gtk-win);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Window;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Window;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

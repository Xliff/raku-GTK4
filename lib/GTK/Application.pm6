use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Application:ver<4>;
use GTK::Raw::Main:ver<4>;

use GIO::Application;
use GIO::MenuModel;
use GTK::ApplicationWindow;

use GLib::Roles::Implementor;
use GTK::Roles::Signals::Application:ver<4>;

our subset GtkApplicationAncestry is export of Mu
  where GtkApplication | GApplicationAncestry;

class GTK::Application:ver<4> is GIO::Application {
  also does GTK::Roles::Signals::Application;

  has GtkApplication $!gtk-app is implementor;

  has $.window handles<present>;
  #has $.init;

  submethod BUILD ( :$gtk-application ) {
    self.setGtkApplication($gtk-application) if $gtk-application;
    #$!init = Promise.new;
  }

  method setGtkApplication (GtkApplicationAncestry $_) {
    my $to-parent;

    $!gtk-app = do {
      when GtkApplication {
        $to-parent = cast(GApplication, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkApplication, $_);
      }
    }
    self.setGApplication($to-parent);
  }

  method GTK::Raw::Structs::GtkApplication
    is also<GtkApplcation>
  { $!gtk-app }

  multi method new (GtkApplicationAncestry $gtk-application, :$ref = True)
    is static
  {
    return unless $gtk-application;

    my $o = self.bless( :$gtk-application );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    :id(:$title) = 'org.genex.Application',
    :$flags      = 0,
    :$width      = 200,
    :$height     = $width
  )
    is static
  {
    my $o = ::?CLASS.new($title, $flags);
    $o.Activate.tap( -> *@a {
      say "Setting window...";
      $o.setWindow( GTK::ApplicationWindow.new($o) );
      $o.window.set-size-request($width, $height);
    });
    $o;
  }
  multi method new (Str() $id, Int() $flags = 0) is static {
    my GApplicationFlags $f = $flags;

    my $gtk-application = gtk_application_new($id, $f);

    $gtk-application ?? self.bless( :$gtk-application ) !! Nil;
  }

  method setWindow ($window) {
    $!window = $window;
  }

  # method wait-for-init {
  #   await $!init;
  # }

  # Type: boolean
  method register-session is rw  is g-property is also<register_session> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('register-session', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('register-session', $gv);
      }
    );
  }

  # Type: boolean
  method screensaver-active is rw  is g-property is also<screensaver_active> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('screensaver-active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'screensaver-active does not allow writing'
      }
    );
  }

  # Type: GMenuModel
  method menubar ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('menubar', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        );
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('menubar', $gv);
      }
    );
  }

  # Type: GTKWindow
  method active-window ( :$raw = False )
    is rw
    is g-property
    is also<active_window>
  {
    my $gv = GLib::Value.new( GTK::Window.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active-window', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Window.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'active-window does not allow writing'
      }
    );
  }

  method Query-End is also<Query_End> {
    self.connect($!gtk-app, 'query-end');
  }

  method Window-Added is also<Window_Added> {
    self.connect-window($!gtk-app, 'window-added');
  }

  method Window-Removed is also<Window_Removed> {
    self.connect-window($!gtk-app, 'window-removed');
  }

  method add_window (GtkWindow() $window) is also<add-window> {
    gtk_application_add_window($!gtk-app, $window);
  }

  method get_accels_for_action (Str() $detailed_action_name)
    is also<get-accels-for-action>
  {
    gtk_application_get_accels_for_action($!gtk-app, $detailed_action_name);
  }

  method get_actions_for_accel (Str() $accel) is also<get-actions-for-accel> {
    gtk_application_get_actions_for_accel($!gtk-app, $accel);
  }

  method get_active_window is also<get-active-window> {
    gtk_application_get_active_window($!gtk-app);
  }

  method get_menu_by_id (Str() $id) is also<get-menu-by-id> {
    gtk_application_get_menu_by_id($!gtk-app, $id);
  }

  method get_menubar is also<get-menubar> {
    gtk_application_get_menubar($!gtk-app);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_application_get_type, $n, $t );
  }

  method get_window_by_id (Int() $id) is also<get-window-by-id> {
    my guint $i = $id;

    gtk_application_get_window_by_id($!gtk-app, $i);
  }

  method get_windows is also<get-windows> {
    gtk_application_get_windows($!gtk-app);
  }

  method inhibit (GtkWindow() $window, Int() $flags, Str() $reason) {
    my GtkApplicationInhibitFlags $f = $flags;

    gtk_application_inhibit($!gtk-app, $window, $f, $reason);
  }

  method list_action_descriptions is also<list-action-descriptions> {
    gtk_application_list_action_descriptions($!gtk-app);
  }

  method remove_window (GtkWindow() $window) is also<remove-window> {
    gtk_application_remove_window($!gtk-app, $window);
  }

  proto method set_accels_for_action (|)
    is also<set-accels-for-action>
  { * }

  multi method set_accels_for_action (
    Str() $detailed_action_name,
          @accels
  ) {
    samewith(
      $detailed_action_name,
      ArrayToCArray(Str, @accels, :null)
    )
  }
  multi method set_accels_for_action (
    Str()       $detailed_action_name,
    CArray[Str] $accels
  ) {
    gtk_application_set_accels_for_action(
      $!gtk-app,
      $detailed_action_name,
      $accels
    );
  }

  method set_menubar (GMenuModel() $menubar) is also<set-menubar> {
    gtk_application_set_menubar($!gtk-app, $menubar);
  }

  method uninhibit (Int() $cookie) {
    my guint $c = $cookie;

    gtk_application_uninhibit($!gtk-app, $c);
  }

  method disable_setlocale is static is also<disable-setlocale> {
    gtk_disable_setlocale();
  }

  method get_default_language is static is also<get-default-language> {
    gtk_get_default_language();
  }

  method get_locale_direction is static is also<get-locale-direction> {
    gtk_get_locale_direction();
  }

  method init is static {
    gtk_init();
  }

  # method init_abi_check is static (
  #   gint   $num_checks,
  #   size_t $sizeof_GtkWindow,
  #   size_t $sizeof_GtkBox
  # ) {
  #   gtk_init_abi_check($num_checks, $sizeof_GtkWindow, $sizeof_GtkBox);
  # }
  #
  # method init_check is static {
  #   gtk_init_check();
  # }
  #
  # method init_check_abi_check is static (
  #   gint   $num_checks,
  #   size_t $sizeof_GtkWindow,
  #   size_t $sizeof_GtkBox
  # ) {
  #   gtk_init_check_abi_check($num_checks, $sizeof_GtkWindow, $sizeof_GtkBox);
  # }

  method is_initialized is static is also<is-initialized> {
    gtk_is_initialized();
  }

}

use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::StyleProvider;

our subset GtkSettingsAncestry is export of Mu
  where GtkSettings | GtkStyleProvider | GObject;

class GTK::Settings {
  also does GLib::Roles::Object;
  also does GTK::Roles::StyleProvider;

  has GtkSettings $!gtk-set is implementor;

  submethod BUILD ( :$gtk-settings ) {
    self.setGtkSettings($gtk-settings) if $gtk-settings
  }

  method setGtkSettings (GtkSettingsAncestry $_) {
    my $to-parent;

    $!gtk-set = do {
      when GtkSettings {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkStyleProvider {
        $!gsp      = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkSettings, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSettings, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkStyleProvider;
  }

  method GTK::Raw::Definitions::GtkSettings
    is also<GtkSettings>
  { $!gtk-set }

  multi method new (
    $gtk-settings where * ~~ GtkSettingsAncestry,

    :$ref = True
  ) {
    return unless $gtk-settings;

    my $o = self.bless( :$gtk-settings );
    $o.ref if $ref;
    $o;
  }

  method get_default
    is also<
      get-default
      default
    >
  {
    my $gtk-settings = gtk_settings_get_default();

    $gtk-settings ?? self.bless( :$gtk-settings ) !! Nil;
  }

  method get_for_display (GdkDisplay() $display) is also<get-for-display> {
    my $gtk-settings = gtk_settings_get_for_display($display);

    $gtk-settings ?? self.bless( :$gtk-settings ) !! Nil;
  }

  # Type: boolean
  method gtk-alternative-button-order
    is rw
    is g-property
    is also<gtk_alternative_button_order>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-alternative-button-order', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-alternative-button-order', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-alternative-sort-arrows
    is rw
    is g-property
    is also<gtk_alternative_sort_arrows>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-alternative-sort-arrows', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-alternative-sort-arrows', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-application-prefer-dark-theme
    is rw
    is g-property
    is also<gtk_application_prefer_dark_theme>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-application-prefer-dark-theme', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-application-prefer-dark-theme', $gv);
      }
    );
  }

  # Type: double
  method gtk-cursor-aspect-ratio
    is rw
    is g-property
    is also<gtk_cursor_aspect_ratio>
  {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-cursor-aspect-ratio', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('gtk-cursor-aspect-ratio', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-cursor-blink
    is rw
    is g-property
    is also<gtk_cursor_blink>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-cursor-blink', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-cursor-blink', $gv);
      }
    );
  }

  # Type: int
  method gtk-cursor-blink-time
    is rw
    is g-property
    is also<gtk_cursor_blink_time>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-cursor-blink-time', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-cursor-blink-time', $gv);
      }
    );
  }

  # Type: int
  method gtk-cursor-blink-timeout
    is rw
    is g-property
    is also<gtk_cursor_blink_timeout>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-cursor-blink-timeout', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-cursor-blink-timeout', $gv);
      }
    );
  }

  # Type: string
  method gtk-cursor-theme-name
    is rw
    is g-property
    is also<gtk_cursor_theme_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-cursor-theme-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-cursor-theme-name', $gv);
      }
    );
  }

  # Type: int
  method gtk-cursor-theme-size
    is rw
    is g-property
    is also<gtk_cursor_theme_size>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-cursor-theme-size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-cursor-theme-size', $gv);
      }
    );
  }

  # Type: string
  method gtk-decoration-layout
    is rw
    is g-property
    is also<gtk_decoration_layout>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-decoration-layout', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-decoration-layout', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-dialogs-use-header
    is rw
    is g-property
    is also<gtk_dialogs_use_header>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-dialogs-use-header', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-dialogs-use-header', $gv);
      }
    );
  }

  # Type: int
  method gtk-dnd-drag-threshold
    is rw
    is g-property
    is also<gtk_dnd_drag_threshold>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-dnd-drag-threshold', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-dnd-drag-threshold', $gv);
      }
    );
  }

  # Type: int
  method gtk-double-click-distance
    is rw
    is g-property
    is also<gtk_double_click_distance>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-double-click-distance', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-double-click-distance', $gv);
      }
    );
  }

  # Type: int
  method gtk-double-click-time
    is rw
    is g-property
    is also<gtk_double_click_time>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-double-click-time', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-double-click-time', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-enable-accels
    is rw
    is g-property
    is also<gtk_enable_accels>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-enable-accels', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-accels', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-enable-animations
    is rw
    is g-property
    is also<gtk_enable_animations>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-enable-animations', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-animations', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-enable-event-sounds
    is rw
    is g-property
    is also<gtk_enable_event_sounds>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-enable-event-sounds', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-event-sounds', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-enable-input-feedback-sounds
    is rw
    is g-property
    is also<gtk_enable_input_feedback_sounds>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get(
          'gtk-enable-input-feedback-sounds',
          $gv
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set(
          'gtk-enable-input-feedback-sounds',
          $gv
        );
      }
    );
  }

  # Type: boolean
  method gtk-enable-primary-paste
    is rw
    is g-property
    is also<gtk_enable_primary_paste>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-enable-primary-paste', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-primary-paste', $gv);
      }
    );
  }

  # Type: uint
  method gtk-entry-password-hint-timeout
    is rw
    is g-property
    is also<gtk_entry_password_hint_timeout>
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-entry-password-hint-timeout', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('gtk-entry-password-hint-timeout', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-entry-select-on-focus
    is rw
    is g-property
    is also<gtk_entry_select_on_focus>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-entry-select-on-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-entry-select-on-focus', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-error-bell
    is rw
    is g-property
    is also<gtk_error_bell>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-error-bell', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-error-bell', $gv);
      }
    );
  }

  # Type: string
  method gtk-font-name
    is rw
    is g-property
    is also<gtk_font_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-font-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-font-name', $gv);
      }
    );
  }

  # Type: uint
  method gtk-fontconfig-timestamp
    is rw
    is g-property
    is also<gtk_fontconfig_timestamp>
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-fontconfig-timestamp', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('gtk-fontconfig-timestamp', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-hint-font-metrics
    is rw
    is g-property
    is also<gtk_hint_font_metrics>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-hint-font-metrics', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-hint-font-metrics', $gv);
      }
    );
  }

  # Type: string
  method gtk-icon-theme-name
    is rw
    is g-property
    is also<gtk_icon_theme_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-icon-theme-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-icon-theme-name', $gv);
      }
    );
  }

  # Type: string
  method gtk-im-module
    is rw
    is g-property
    is also<gtk_im_module>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-im-module', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-im-module', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-keynav-use-caret
    is rw
    is g-property
    is also<gtk_keynav_use_caret>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-keynav-use-caret', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-keynav-use-caret', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-label-select-on-focus
    is rw
    is g-property
    is also<gtk_label_select_on_focus>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-label-select-on-focus', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-label-select-on-focus', $gv);
      }
    );
  }

  # Type: uint
  method gtk-long-press-time
    is rw
    is g-property
    is also<gtk_long_press_time>
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-long-press-time', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('gtk-long-press-time', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-overlay-scrolling
    is rw
    is g-property
    is also<gtk_overlay_scrolling>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-overlay-scrolling', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-overlay-scrolling', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-primary-button-warps-slider
    is rw
    is g-property
    is also<gtk_primary_button_warps_slider>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-primary-button-warps-slider', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-primary-button-warps-slider', $gv);
      }
    );
  }

  # Type: string
  method gtk-print-backends
    is rw
    is g-property
    is also<gtk_print_backends>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-print-backends', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-print-backends', $gv);
      }
    );
  }

  # Type: string
  method gtk-print-preview-command
    is rw
    is g-property
    is also<gtk_print_preview_command>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-print-preview-command', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-print-preview-command', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-recent-files-enabled
    is rw
    is g-property
    is also<gtk_recent_files_enabled>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-recent-files-enabled', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-recent-files-enabled', $gv);
      }
    );
  }

  # Type: int
  method gtk-recent-files-max-age
    is rw
    is g-property
    is also<gtk_recent_files_max_age>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-recent-files-max-age', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-recent-files-max-age', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-shell-shows-app-menu
    is rw
    is g-property
    is also<gtk_shell_shows_app_menu>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-shell-shows-app-menu', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-shell-shows-app-menu', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-shell-shows-desktop
    is rw
    is g-property
    is also<gtk_shell_shows_desktop>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-shell-shows-desktop', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-shell-shows-desktop', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-shell-shows-menubar
    is rw
    is g-property
    is also<gtk_shell_shows_menubar>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-shell-shows-menubar', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-shell-shows-menubar', $gv);
      }
    );
  }

  # Type: string
  method gtk-sound-theme-name
    is rw
    is g-property
    is also<gtk_sound_theme_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-sound-theme-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-sound-theme-name', $gv);
      }
    );
  }

  # Type: boolean
  method gtk-split-cursor
    is rw
    is g-property
    is also<gtk_split_cursor>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-split-cursor', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-split-cursor', $gv);
      }
    );
  }

  # Type: string
  method gtk-theme-name
    is rw
    is g-property
    is also<gtk_theme_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-theme-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-theme-name', $gv);
      }
    );
  }

  # Type: string
  method gtk-titlebar-double-click
    is rw
    is g-property
    is also<gtk_titlebar_double_click>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-titlebar-double-click', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-titlebar-double-click', $gv);
      }
    );
  }

  # Type: string
  method gtk-titlebar-middle-click
    is rw
    is g-property
    is also<gtk_titlebar_middle_click>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-titlebar-middle-click', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-titlebar-middle-click', $gv);
      }
    );
  }

  # Type: string
  method gtk-titlebar-right-click
    is rw
    is g-property
    is also<gtk_titlebar_right_click>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-titlebar-right-click', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-titlebar-right-click', $gv);
      }
    );
  }

  # Type: int
  method gtk-xft-antialias
    is rw
    is g-property
    is also<gtk_xft_antialias>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-xft-antialias', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-xft-antialias', $gv);
      }
    );
  }

  # Type: int
  method gtk-xft-dpi
    is rw
    is g-property
    is also<gtk_xft_dpi>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-xft-dpi', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-xft-dpi', $gv);
      }
    );
  }

  # Type: int
  method gtk-xft-hinting
    is rw
    is g-property
    is also<gtk_xft_hinting>
  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-xft-hinting', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-xft-hinting', $gv);
      }
    );
  }

  # Type: string
  method gtk-xft-hintstyle
    is rw
    is g-property
    is also<gtk_xft_hintstyle>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-xft-hintstyle', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-xft-hintstyle', $gv);
      }
    );
  }

  # Type: string
  method gtk-xft-rgba
    is rw
    is g-property
    is also<gtk_xft_rgba>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gtk-xft-rgba', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-xft-rgba', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_settings_get_type, $n, $t );
  }

  method reset_property (Str() $name) is also<reset-property> {
    gtk_settings_reset_property($!gtk-set, $name);
  }

}

### /usr/src/gtk4/gtk/gtksettings.h

sub gtk_settings_get_default
  returns GtkSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_settings_get_for_display (GdkDisplay $display)
  returns GtkSettings
  is      native(gtk4)
  is      export
{ * }

sub gtk_settings_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_settings_reset_property (
  GtkSettings $settings,
  Str         $name
)
  is      native(gtk4)
  is      export
{ * }

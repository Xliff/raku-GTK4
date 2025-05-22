use v6.c;

use GLib::Raw::Definitions;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Enums::Class;

our sub ALIGN is export {
  %(
    fill     => GTK_ALIGN_FILL,
    start    => GTK_ALIGN_START,
    end      => GTK_ALIGN_END,
    center   => GTK_ALIGN_CENTER,
    baseline => GTK_ALIGN_BASELINE
  ).Map
}

our sub BORDER is export {
  %(
    none   => GTK_BORDER_STYLE_NONE,
    hidden => GTK_BORDER_STYLE_HIDDEN,
    solid  => GTK_BORDER_STYLE_SOLID,
    inset  => GTK_BORDER_STYLE_INSET,
    outset => GTK_BORDER_STYLE_OUTSET,
    dotted => GTK_BORDER_STYLE_DOTTED,
    dashed => GTK_BORDER_STYLE_DASHED,
    double => GTK_BORDER_STYLE_DOUBLE,
    groove => GTK_BORDER_STYLE_GROOVE,
    ridge  => GTK_BORDER_STYLE_RIDGE
  ).Map;
}

our sub FLAGS is export {
  %(
    normal        => GTK_STATE_FLAG_NORMAL,
    active        => GTK_STATE_FLAG_ACTIVE,
    prelight      => GTK_STATE_FLAG_PRELIGHT,
    selected      => GTK_STATE_FLAG_SELECTED,
    insensitive   => GTK_STATE_FLAG_INSENSITIVE,
    inconsistent  => GTK_STATE_FLAG_INCONSISTENT,
    focused       => GTK_STATE_FLAG_FOCUSED,
    backdrop      => GTK_STATE_FLAG_BACKDROP,
    dir_ltr       => GTK_STATE_FLAG_DIR_LTR,
    dir_rtl       => GTK_STATE_FLAG_DIR_RTL,
    dir-ltr       => GTK_STATE_FLAG_DIR_LTR,
    dir-rtl       => GTK_STATE_FLAG_DIR_RTL,
    ltr           => GTK_STATE_FLAG_DIR_LTR,
    rtl           => GTK_STATE_FLAG_DIR_RTL,
    link          => GTK_STATE_FLAG_LINK,
    visited       => GTK_STATE_FLAG_VISITED,
    checked       => GTK_STATE_FLAG_CHECKED,
    drop-active   => GTK_STATE_FLAG_DROP_ACTIVE,
    drop_active   => GTK_STATE_FLAG_DROP_ACTIVE,
    visible       => GTK_STATE_FLAG_FOCUS_VISIBLE,
    within        => GTK_STATE_FLAG_FOCUS_WITHIN,
    focus_visible => GTK_STATE_FLAG_FOCUS_VISIBLE,
    focus_within  => GTK_STATE_FLAG_FOCUS_WITHIN,
    focus-visible => GTK_STATE_FLAG_FOCUS_VISIBLE,
    focus-within  => GTK_STATE_FLAG_FOCUS_WITHIN
  ).Map;
}

our sub POLICY is export {
  %(
    auto      => GTK_POLICY_AUTOMATIC,
    always    => GTK_POLICY_ALWAYS,
    automatic => GTK_POLICY_AUTOMATIC,
    never     => GTK_POLICY_NEVER,
    external  => GTK_POLICY_EXTERNAL
  ).Map
}

our sub POS is export {
  %(
    left   => GTK_POS_LEFT,
    right  => GTK_POS_RIGHT,
    top    => GTK_POS_TOP,
    bottom => GTK_POS_BOTTOM,
    l      => GTK_POS_LEFT,
    r      => GTK_POS_RIGHT,
    t      => GTK_POS_TOP,
    b      => GTK_POS_BOTTOM
  ).Map
}

our sub ICON is export {
  state $i = (
    class :: {
      method SIZE {
        %(
          inherit => GTK_ICON_SIZE_INHERIT,
          normal  => GTK_ICON_SIZE_NORMAL,
          large   => GTK_ICON_SIZE_LARGE
        ).Map
      }

      method LOOKUP {
        %(
          force_regular  => GTK_ICON_LOOKUP_FORCE_REGULAR,
          force-regular  => GTK_ICON_LOOKUP_FORCE_REGULAR,
          regular        => GTK_ICON_LOOKUP_FORCE_REGULAR,
          force_symbolic => GTK_ICON_LOOKUP_FORCE_SYMBOLIC,
          force-symbolic => GTK_ICON_LOOKUP_FORCE_SYMBOLIC,
          symbolic       => GTK_ICON_LOOKUP_FORCE_SYMBOLIC,
          preload        => GTK_ICON_LOOKUP_PRELOAD
        ).Map;
      }

      method THEME {
        %(
          not_found => GTK_ICON_THEME_NOT_FOUND,
          not-found => GTK_ICON_THEME_NOT_FOUND,
          failed    => GTK_ICON_THEME_FAILED
        ).Map
      }

      method VIEW {
        %(
          no_drop    => GTK_ICON_VIEW_NO_DROP,
          no-drop    => GTK_ICON_VIEW_NO_DROP,
          none       => GTK_ICON_VIEW_NO_DROP,
          drop_into  => GTK_ICON_VIEW_DROP_INTO,
          drop_left  => GTK_ICON_VIEW_DROP_LEFT,
          drop_right => GTK_ICON_VIEW_DROP_RIGHT,
          drop_above => GTK_ICON_VIEW_DROP_ABOVE,
          drop_below => GTK_ICON_VIEW_DROP_BELOW,
          drop-into  => GTK_ICON_VIEW_DROP_INTO,
          drop-left  => GTK_ICON_VIEW_DROP_LEFT,
          drop-right => GTK_ICON_VIEW_DROP_RIGHT,
          drop-above => GTK_ICON_VIEW_DROP_ABOVE,
          drop-below => GTK_ICON_VIEW_DROP_BELOW,
          into       => GTK_ICON_VIEW_DROP_INTO,
          left       => GTK_ICON_VIEW_DROP_LEFT,
          right      => GTK_ICON_VIEW_DROP_RIGHT,
          above      => GTK_ICON_VIEW_DROP_ABOVE,
          below      => GTK_ICON_VIEW_DROP_BELOW
        ).Map
      }
    }
  ).new;

  our sub STYLE is export {
    state $s = (
      class :: {

        method PRIORITY {
          %(
            fallback    => GTK_STYLE_PROVIDER_PRIORITY_FALLBACK,
            theme       => GTK_STYLE_PROVIDER_PRIORITY_THEME,
            settings    => GTK_STYLE_PROVIDER_PRIORITY_SETTINGS,
            application => GTK_STYLE_PROVIDER_PRIORITY_APPLICATION,
            user        => GTK_STYLE_PROVIDER_PRIORITY_USER
          ).Map
        }

        method PRINT {
          %(
            none        => GTK_STYLE_CONTEXT_PRINT_NONE,
            recurse     => GTK_STYLE_CONTEXT_PRINT_RECURSE,
            show_style  => GTK_STYLE_CONTEXT_PRINT_SHOW_STYLE,
            show_change => GTK_STYLE_CONTEXT_PRINT_SHOW_CHANGE,
            show-style  => GTK_STYLE_CONTEXT_PRINT_SHOW_STYLE,
            show-change => GTK_STYLE_CONTEXT_PRINT_SHOW_CHANGE,
            style       => GTK_STYLE_CONTEXT_PRINT_SHOW_STYLE,
            change      => GTK_STYLE_CONTEXT_PRINT_SHOW_CHANGE
          ).Map
        }

      }
    ).new

    $s
  }

);

  $i;
}

our sub ORDERING is export {
  %(
    smaller => GTK_ORDERING_SMALLER,
    equal   => GTK_ORDERING_EQUAL,
    larger  => GTK_ORDERING_LARGER
  ).Map;
}

our sub ORIENTATION is export {
  %(
    horizontal,
    h          => GTK_ORIENTATION_HORIZONTAL,
    vertical   => GTK_ORIENTATION_VERTICAL,
    v          => GTK_ORIENTATION_VERTICAL
  ).Map;
}

our sub REVEALER is export {
  %(
    none        => GTK_REVEALER_TRANSITION_TYPE_NONE,
    crossfade   => GTK_REVEALER_TRANSITION_TYPE_CROSSFADE,
    slide_right => GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT,
    slide_left  => GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT,
    slide_up    => GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP,
    slide_down  => GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN,
    swing_right => GTK_REVEALER_TRANSITION_TYPE_SWING_RIGHT,
    swing_left  => GTK_REVEALER_TRANSITION_TYPE_SWING_LEFT,
    swing_up    => GTK_REVEALER_TRANSITION_TYPE_SWING_UP,
    swing_down  => GTK_REVEALER_TRANSITION_TYPE_SWING_DOWN,
    slide-right => GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT,
    slide-left  => GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT,
    slide-up    => GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP,
    slide-down  => GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN,
    swing-right => GTK_REVEALER_TRANSITION_TYPE_SWING_RIGHT,
    swing-left  => GTK_REVEALER_TRANSITION_TYPE_SWING_LEFT,
    swing-up    => GTK_REVEALER_TRANSITION_TYPE_SWING_UP,
    swing-down  => GTK_REVEALER_TRANSITION_TYPE_SWING_DOWN
  ).Map
}

our sub RESPONSE is export {
  %(
    none         => GTK_RESPONSE_NONE,
    reject       => GTK_RESPONSE_REJECT,
    accept       => GTK_RESPONSE_ACCEPT,
    delete       => GTK_RESPONSE_DELETE_EVENT,
    delete_event => GTK_RESPONSE_DELETE_EVENT,
    delete-event => GTK_RESPONSE_DELETE_EVENT,
    ok           => GTK_RESPONSE_OK,
    cancel       => GTK_RESPONSE_CANCEL,
    close        => GTK_RESPONSE_CLOSE,
    yes          => GTK_RESPONSE_YES,
    no           => GTK_RESPONSE_NO,
    apply        => GTK_RESPONSE_APPLY,
    help         => GTK_RESPONSE_HELP
  ).Map;
}

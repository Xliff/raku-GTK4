use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Input::Context:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::Signals::Input::Context;

our subset GtkIMContextAncestry is export of Mu
  where GtkIMContext | GObject;

class GTK::Input::Context:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::Input::Context;

  has GtkIMContext $!gtk-ic is implementor;

  submethod BUILD ( :$gtk-input-context ) {
    self.setGtkIMContext($gtk-input-context) if $gtk-input-context
  }

  method setGtkIMContext (GtkIMContextAncestry $_) {
    my $to-parent;

    $!gtk-ic = do {
      when GtkIMContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkIMContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkIMContext
    is also<GtkIMContext>
  { $!gtk-ic }

  multi method new (
    $gtk-input-context where * ~~ GtkIMContextAncestry,

    :$ref = True
  ) {
    return unless $gtk-input-context;

    my $o = self.bless( :$gtk-input-context );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkInputHints
  method input-hints ( :$enum = True )
    is rw
    is g-property
    is also<input_hints>
  {
    my $gv = GLib::Value.new-enum( GtkInputHints );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-hints', $gv);
        my $v = $gv.enum;
        return $v unless $enum;
        GtkInputHintsEnum($v);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputHints) = $val;
        self.prop_set('input-hints', $gv);
      }
    );
  }

  # Type: GtkInputPurpose
  method input-purpose ( :$enum = True )
    is rw
    is g-property
    is also<input_purpose>
  {
    my $gv = GLib::Value.new-enum( GtkInputPurpose );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-purpose', $gv);
       my $v =  $gv.enum;
       return $v unless $enum;
       GtkInputPurposeEnum($v);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputPurpose) = $val;
        self.prop_set('input-purpose', $gv);
      }
    );
  }

  # Is originally:
  # GtkIMContext *context --> gboolean
  method Retrieve-Surrounding {
    self.connect-rbool($!gtk-ic, 'retrieve-surrounding');
  }

  # Is originally:
  # GtkIMContext *context,  int offset,  int n_chars --> gboolean
  method Delete-Surrounding {
    self.connect-delete-surrounding($!gtk-ic);
  }

  # Is originally:
  # GtkIMContext *context --> void
  method Preedit-Start {
    self.connect($!gtk-ic, 'preedit-start');
  }

  # Is originally:
  # GtkIMContext *context --> void
  method Preedit-End {
    self.connect($!gtk-ic, 'preedit-end');
  }

  # Is originally:
  # GtkIMContext *context --> void
  method Preedit-Changed {
    self.connect($!gtk-ic, 'preedit-changed');
  }

  # Is originally:
  # GtkIMContext *context,  char *str --> void
  method Commit {
    self.connect-str($!gtk-ic, 'commit');
  }

  method delete_surrounding (Int() $offset, Int() $n_chars)
    is also<delete-surrounding>
  {
    my gint ($o, $n);

    gtk_im_context_delete_surrounding($!gtk-ic, $o, $n);
  }

  method filter_key (
    Int()        $press,
    GdkSurface() $surface,
    GdkDevice()  $device,
    Int()        $time,
    Int()        $keycode,
    Int()        $state,
    Int()        $group
  )
    is also<filter-key>
  {
    my gboolean        $p = $press.so.Int;
    my guint32         $t = $time;
    my guint           $k = $keycode;
    my gint            $g = $group;
    my GdkModifierType $s = $state;

    gtk_im_context_filter_key(
      $!gtk-ic,
      $p,
      $surface,
      $device,
      $t,
      $k,
      $s,
      $g
    );
  }

  method filter_keypress (GdkEvent() $event) is also<filter-keypress> {
    gtk_im_context_filter_keypress($!gtk-ic, $event);
  }

  method focus_in is also<focus-in> {
    gtk_im_context_focus_in($!gtk-ic);
  }

  method focus_out is also<focus-out> {
    gtk_im_context_focus_out($!gtk-ic);
  }

  proto method get_preedit_string (|)
    is also<get-preedit-string>
  { * }

  multi method get_preedit_string {
    samewith( newCArray(Str), newCArray(PangoAttrList), $ );
  }
  multi method get_preedit_string (
    CArray[Str]                     $str,
    CArray[Pointer[PangoAttrList]]  $attrs,
                                    $cursor_pos is rw,
                                   :$raw               = False
  ) {
    my gint  $c = 0;

    gtk_im_context_get_preedit_string($!gtk-ic, $str, $attrs, $c);
    $cursor_pos = $c;

    (
      ppr($str),
      propReturnObject( ppr($attrs), $raw, Pango::AttrList.getTypePair ),
      $cursor_pos
    )
  }

  proto method get_surrounding (|)
    is also<get-surrounding>
  { * }

  multi method get_surrounding {
    samewith( newCArray(Str), $ );
  }
  multi method get_surrounding (
    CArray[Str]  $text,
                 $cursor_index is rw
  ) {
    my gint $c = 0;

    gtk_im_context_get_surrounding($!gtk-ic, $text, $c);
    $cursor_index = 0;
    ( ppr($text), $cursor_index );
  }

  proto method get_surrounding_with_selection (|)
    is also<get-surrounding-with-selection>
  { * }

  multi method get_surrounding_with_selection {
    samewith( newCArray(Str), $, $ );
  }
  multi method get_surrounding_with_selection (
    CArray[Str]  $text,
                 $cursor_index is rw,
                 $anchor_index is rw
  ) {
    my gint ($c, $a) = 0 xx 2;

    gtk_im_context_get_surrounding_with_selection($!gtk-ic, $text, $c, $a);
    ($cursor_index, $anchor_index) = ($c, $a);
    ( ppr($text), $cursor_index, $anchor_index );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_im_context_get_type, $n, $t );
  }

  method reset {
    gtk_im_context_reset($!gtk-ic);
  }

  method set_client_widget (GtkWidget() $widget) is also<set-client-widget> {
    gtk_im_context_set_client_widget($!gtk-ic, $widget);
  }

  method set_cursor_location (GdkRectangle() $area)
    is also<set-cursor-location>
  {
    gtk_im_context_set_cursor_location($!gtk-ic, $area);
  }

  method set_surrounding (Str() $text, Int() $len, Int() $cursor_index)
    is also<set-surrounding>
  {
    my gint ($l, $c) = ($len, $cursor_index);

    gtk_im_context_set_surrounding($!gtk-ic, $text, $l, $c);
  }

  method set_surrounding_with_selection (
    Str() $text,
    Int() $len,
    Int() $cursor_index,
    Int() $anchor_index
  )
    is also<set-surrounding-with-selection>
  {
    my gint ($l, $c, $a) = ($len, $cursor_index, $anchor_index);

    gtk_im_context_set_surrounding_with_selection(
      $!gtk-ic,
      $text,
      $l,
      $c,
      $a
    );
  }

  method set_use_preedit (Int() $use_preedit) is also<set-use-preedit> {
    my gboolean $u = $use_preedit.so.Int;

    gtk_im_context_set_use_preedit($!gtk-ic, $u);
  }

}

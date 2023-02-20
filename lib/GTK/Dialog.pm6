use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog:ver<4>;

use GTK::Window;

use GLib::Roles::Implementor;

our subset GtkDialogAncestry is export of Mu
  where GtkDialog | GtkWindowAncestry;

class GTK::Dialog:ver<4> is GTK::Window:ver<4> {
  has GtkDialog $!gtk-d is implementor;

  submethod BUILD ( :$gtk-dialog ) {
    self.setGtkDialog($gtk-dialog) if $gtk-dialog
  }

  method setGtkDialog (GtkDialogAncestry $_) {
    my $to-parent;

    $!gtk-d = do {
      when GtkDialog {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkDialog, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method GTK::Raw::Definitions::GtkDialog
    is also<GtkDialog>
  { $!gtk-d }

  multi method new ($gtk-dialog where * ~~ GtkDialogAncestry , :$ref = True) {
    return unless $gtk-dialog;

    my $o = self.bless( :$gtk-dialog );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-dialog = gtk_dialog_new();

    $gtk-dialog ?? self.bless( :$gtk-dialog ) !! Nil;
  }

  proto method new_with_buttons (|)
    is also<new-with-buttons>
  { * }

  multi method new_with_buttons (
                 @buttons where { .all ~~ Pair && .elems >= 1 },
    Int()       :$flags = GTK_DIALOG_DESTROY_WITH_PARENT
  ) {
    samewith(Str, GtkWindow, @buttons, :$flags);
  }
  multi method new_with_buttons (
    Str()        $title,
                 @buttons where { .all ~~ Pair && .elems >= 1 },
    Int()       :$flags = GTK_DIALOG_DESTROY_WITH_PARENT
  ) {
    samewith($title, GtkWindow, @buttons, :$flags);
  }
  multi method new_with_buttons (
    Str()        $title,
                *@buttons where { .none ~~ Pair && .elems % 2 == 0 },
    Int()       :$flags = GTK_DIALOG_DESTROY_WITH_PARENT
  ) {
     samewith(
       $title,
       @buttons.rotor(2).map({ Pair.new( |$_ ) }).cache,
       :$flags
     );
  }
  multi method new_with_buttons (
    Str()        $title,
    GtkWindow()  $parent,
                 @buttons where { .all ~~ Pair && .elems >= 1 },

    Int()       :$flags = GTK_DIALOG_DESTROY_WITH_PARENT
  ) {
    samewith($title, $parent, $flags, @buttons);
  }
  multi method new_with_buttons (
    Str()       $title,
    GtkWindow() $parent,
    Int()       $flags,
                @buttons where { .all ~~ Pair && .elems >= 1 }
  ) {
    my GtkDialogFlags $f = $flags;

    my $first_text     = @buttons.head.key;
    my $first_response = @buttons.head.value;

    my $gtk-dialog = gtk_dialog_new_with_button(
      $title,
      $parent,
      $f,
      $first_text,
      $first_response,
      Str
    );

    return Nil unless $gtk-dialog;
    my $o = self.bless( :$gtk-dialog );
    $o.add-buttons( @buttons.skip(1).cache );
    $o;
  }

  # Type: int
  method use-header-bar is rw  is g-property is also<use_header_bar> {
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

  method Close {
    self.connect($!gtk-d, 'close');
  }

  method Response {
    self.connect-int($!gtk-d, 'response');
  }

  method add_action_widget (GtkWidget() $child, Int() $response_id)
    is also<add-action-widget>
  {
    my gint $r = $response_id;

    @!children.push: $child;
    gtk_dialog_add_action_widget($!gtk-d, $child, $r);
  }

  method add_button (
    Str()  $button_text,
    Int()  $response_id,

          :r(:return(
            :allow_return(
              :allow-return(
                :allow_return_value(:$allow-return-value)
              )
            )
          )) = False,

          :$raw                    = False,
          :quick(:$fast)           = False,
          :slow(:$proper)          = $fast.not
  )
    is also<add-button>
  {
    my gint $r = $response_id;

    my $b = gtk_dialog_add_button($!gtk-d, $button_text, $r);
    @!children.push: $b;
    return Nil unless $allow-return-value;
    returnProperWidget($b, :$raw, :$proper);
  }

  method add_buttons (@buttons where @buttons.all ~~ Pair) {
    self.add_button( .key, .value ) for @buttons;
  }

  method get_content_area (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-content-area>
  {
    returnProperWidget(
      gtk_dialog_get_content_area($!gtk-d),
      :$raw,
      :$proper
    )
  }

  method get_header_bar (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-header-bar>
  {
    returnProperWidget(
      gtk_dialog_get_header_bar($!gtk-d),
      :$raw,
      :$proper
    );
  }

  method get_response_for_widget (GtkWidget() $widget)
    is also<get-response-for-widget>
  {
    gtk_dialog_get_response_for_widget($!gtk-d, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_dialog_get_type, $n, $t );
  }

  method get_widget_for_response (
    Int()  $response_id,
          :$raw           = False,
          :quick(:$fast)  = False,
          :slow(:$proper) = $fast.not

  )
    is also<get-widget-for-response>
  {
    my gint $r = $response_id;

    returnProperWidget(
      gtk_dialog_get_widget_for_response($!gtk-d, $r),
      :$raw,
      :$proper
    );
  }

  method response (Int() $response_id) {
    my gint $r = $response_id;

    gtk_dialog_response($!gtk-d, $r);
  }

  # cw: Backwards compat
  method run (
    :b(:block(:$blocking))  = False,
    :$enum                  = True,
    :enum_type(:$enum-type) = GtkResponseTypeEnum
  ) {
    self.show;
    return unless $blocking;

    my $p = Promise.new;
    self.Response.tap( -> *@a {
      $p.keep( @a[1] );
      self.hide;
    });
    await $p;
    my $r = $p.result;
    return unless $enum;
    $enum-type($r);
  }

  method set_default_response (Int() $response_id)
    is also<set-default-response>
  {
    my gint $r = $response_id;

    gtk_dialog_set_default_response($!gtk-d, $r);
  }

  method set_response_sensitive (Int() $response_id, Int() $setting)
    is also<set-response-sensitive>
  {
    my gint     $r = $response_id;
    my gboolean $s = $setting.so.Int;

    gtk_dialog_set_response_sensitive($!gtk-d, $r, $s);
  }

}

class GTK::Dialog::Error {
  also does GLib::Roles::StaticClass;

  method quark {
    gtk_dialog_error_quark();
  }
}


BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Dialog;
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
  my \O = GTK::Dialog;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

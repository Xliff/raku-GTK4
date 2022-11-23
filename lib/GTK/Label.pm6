use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Label:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Signals::Generic:ver<4>;

our subset GtkLabelAncestry is export of Mu
  where GtkLabel | GtkWidgetAncestry;

class GTK::Label:ver<4> is GTK::Widget {
  also does GTK::Roles::Signals::Generic;

  has GtkLabel $!gtk-l is implementor;

  submethod BUILD ( :$gtk-label ) {
    self.setGtkLabel($gtk-label) if $gtk-label
  }

  method setGtkLabel (GtkLabelAncestry $_) {
    my $to-parent;

    $!gtk-l = do {
      when GtkLabel {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkLabel, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkLabel
    is also<GtkLabel>
  { $!gtk-l }

  multi method new (GtkLabelAncestry $gtk-label, :$ref = True) {
    return unless $gtk-label;

    my $o = self.bless( :$gtk-label );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $label = Str) {
    my $gtk-label = gtk_label_new($label);

    $gtk-label ?? self.bless( :$gtk-label ) !! Nil;
  }

  method new_with_mnemonic (Str() $label = Str) is also<new-with-mnemonic> {
    my $gtk-label = gtk_label_new_with_mnemonic($label);

    $gtk-label ?? self.bless( :$gtk-label ) !! Nil;
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

  # Type: GTKAttrList
  method attributes is rw  is g-property {
    my $gv = GLib::Value.new( GTK::AttrList );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('attributes', $gv);
        $gv.GTKAttrList;
      },
      STORE => -> $,  $val is copy {
        $gv.GTKAttrList = $val;
        self.prop_set('attributes', $gv);
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

  # Type: GTKJustification
  method justify ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkJustification) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('justify', $gv);
        my $j = $gv.valueFromEnum(GtkJustification);
        return $j unless $enum;
        GtkJustificationEnum($j);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkJustification) = $val;
        self.prop_set('justify', $gv);
      }
    );
  }

  # Type: float
  method xalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: float
  method yalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  # Type: boolean
  method wrap is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('wrap', $gv);
      }
    );
  }

  # Type: GTKWrapMode
  method wrap-mode ( :$enum = True ) is rw  is g-property is also<wrap_mode> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkWrapMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-mode', $gv);
        my $w = $gv.valueFromEnum(GtkWrapMode);
        return $w unless $enum;
        GtkWrapModeEnum($w);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkWrapMode) = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  # Type: GTKNaturalWrapMode
  method natural-wrap-mode ( :$enum = True )
    is rw
    is g-property
    is also<natural_wrap_mode>
  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkNaturalWrapMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-wrap-mode', $gv);
        my $nwm = $gv.valueFromEnum(GtkNaturalWrapMode);
        return $nwm unless $enum;
        GtkNaturalWrapModeEnum($nwm);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkNaturalWrapMode) = $val;
        self.prop_set('natural-wrap-mode', $gv);
      }
    );
  }

  # Type: boolean
  method selectable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selectable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('selectable', $gv);
      }
    );
  }

  # Type: uint
  method mnemonic-keyval is rw  is g-property is also<mnemonic_keyval> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mnemonic-keyval', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'mnemonic-keyval does not allow writing'
      }
    );
  }

  # Type: GTKWidget
  method mnemonic-widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property

    is also<mnemonic_widget>
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mnemonic-widget', $gv);
        returnProperWidget(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('mnemonic-widget', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method ellipsize ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(PangoEllipsizeMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ellipsize', $gv);
        my $e = $gv.typeFromEnum(PangoEllipsizeMode);
        return $e unless $enum;
        PangoEllipsizeModeEnum( $gv.valueFromEnum(PangoEllipsizeMode) );
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoEllipsizeMode) = $val;
        self.prop_set('ellipsize', $gv);
      }
    );
  }

  # Type: int
  method width-chars is rw  is g-property is also<width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width-chars', $gv);
      }
    );
  }

  # Type: boolean
  method single-line-mode is rw  is g-property is also<single_line_mode> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('single-line-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('single-line-mode', $gv);
      }
    );
  }

  # Type: int
  method max-width-chars is rw  is g-property is also<max_width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-chars', $gv);
      }
    );
  }

  # Type: int
  method lines is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('lines', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('lines', $gv);
      }
    );
  }

  # Type: GTKMenuModel
  method extra-menu ( :$raw = False ) is rw  is g-property is also<extra_menu> {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('extra-menu', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        )
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('extra-menu', $gv);
      }
    );
  }

  # Type: GTKTabArray
  method tabs (:$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::Tabs.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tabs', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |Pango::Tabs.getTypePair
        )
      },
      STORE => -> $, PangoTabArray() $val is copy {
        $gv.pointer = $val;
        self.prop_set('tabs', $gv);
      }
    );
  }

  method Activate-Current-Link is also<Activate_Current_Link> {
    self.connect($!gtk-l, 'activate-current-link');
  }

  method Activate-Link is also<Activate_Link> {
    self.connect-str-rbool($!gtk-l, 'activate-link');
  }

  method Copy-Clipboard is also<Copy_Clipboard> {
    self.connect($!gtk-l, 'copy-clipboard');
  }

  method Move-Cursor is also<Move_Cursor> {
    self.connect-move-cursor($!gtk-l, 'move-cursor');
  }

  method get_attributes ( :$raw = False ) is also<get-attributes> {
    propReturnObject(
      gtk_label_get_attributes($!gtk-l),
      $raw,
      |Pango::AttrList.getTypePair
    );
  }

  method get_current_uri is also<get-current-uri> {
    gtk_label_get_current_uri($!gtk-l);
  }

  method get_ellipsize ( :$enum = True ) is also<get-ellipsize> {
    my $e = gtk_label_get_ellipsize($!gtk-l);
    return $e unless $enum;
    PangoEllipsizeModeEnum($e);
  }

  method get_extra_menu ( :$raw = False ) is also<get-extra-menu> {
    propReturnObject(
      gtk_label_get_extra_menu($!gtk-l),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_justify ( :$enum = True ) is also<get-justify> {
    my $j = gtk_label_get_justify($!gtk-l);
    return $j unless $enum;
    GtkJustificationEnum($j);
  }

  method get_label is also<get-label> {
    gtk_label_get_label($!gtk-l);
  }

  method get_layout ( :$raw = False )  is also<get-layout> {
    propReturnObject(
      gtk_label_get_layout($!gtk-l),
      $raw,
      |Pango::Layout.getTypePair
    );
  }

  proto method get_layout_offsets (|)
    is also<get-layout-offsets>
  { * }

  multi method get_layout_offsets {
    samewith($, $);
  }
  multi method get_layout_offsets ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;

    gtk_label_get_layout_offsets($!gtk-l, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_lines is also<get-lines> {
    gtk_label_get_lines($!gtk-l);
  }

  method get_max_width_chars is also<get-max-width-chars> {
    gtk_label_get_max_width_chars($!gtk-l);
  }

  method get_mnemonic_keyval is also<get-mnemonic-keyval> {
    gtk_label_get_mnemonic_keyval($!gtk-l);
  }

  method get_mnemonic_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-mnemonic-widget>
  {
    returnProperWidget(
      gtk_label_get_mnemonic_widget($!gtk-l),
      $raw,
      $proper
    );
  }

  method get_natural_wrap_mode ( :$enum  = True ) is also<get-natural-wrap-mode> {
    my $nwm = gtk_label_get_natural_wrap_mode($!gtk-l);
    return $nwm unless $enum;
    PangoWrapModeEnum($nwm);
  }

  method get_selectable is also<get-selectable> {
    so gtk_label_get_selectable($!gtk-l);
  }

  proto method get_selection_bounds (|)
    is also<get-selection-bounds>
  { * }

  multi method get_selection_bounds {
    samewith($, $);
  }
  multi method get_selection_bounds ($start is rw, $end is rw) {
    my gint ($s, $e) = 0 xx 2;

    gtk_label_get_selection_bounds($!gtk-l, $s, $e);
    ($start, $end) = ($s, $e);
  }

  method get_single_line_mode is also<get-single-line-mode> {
    so gtk_label_get_single_line_mode($!gtk-l);
  }

  method get_tabs (:$raw = False ) is also<get-tabs> {
    propReturnObject(
      gtk_label_get_tabs($!gtk-l),
      $raw,
      |Pango::Tabs.getTypePair
    )
  }

  method get_text is also<get-text> {
    gtk_label_get_text($!gtk-l);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_label_get_type, $n, $t );
  }

  method get_use_markup is also<get-use-markup> {
    so gtk_label_get_use_markup($!gtk-l);
  }

  method get_use_underline is also<get-use-underline> {
    so gtk_label_get_use_underline($!gtk-l);
  }

  method get_width_chars is also<get-width-chars> {
    gtk_label_get_width_chars($!gtk-l);
  }

  method get_wrap  is also<get-wrap> {
    so gtk_label_get_wrap($!gtk-l);
  }

  method get_wrap_mode ( :$enum = True ) is also<get-wrap-mode> {
    my $w = gtk_label_get_wrap_mode($!gtk-l);
    return $w unless $enum;
    PangoWrapModeEnum($w);
  }

  method get_xalign is also<get-xalign> {
    gtk_label_get_xalign($!gtk-l);
  }

  method get_yalign is also<get-yalign> {
    gtk_label_get_yalign($!gtk-l);
  }

  method select_region (Int() $start_offset, Int() $end_offset)
    is also<select-region>
  {
    my gint ($s, $e) = ($start_offset, $end_offset);

    gtk_label_select_region($!gtk-l, $s, $e);
  }

  method set_attributes (PangoAttrList() $attrs) is also<set-attributes> {
    gtk_label_set_attributes($!gtk-l, $attrs);
  }

  method set_ellipsize (Int() $mode) is also<set-ellipsize> {
    my PangoEllipsizeMode $m = $mode;

    gtk_label_set_ellipsize($!gtk-l, $m);
  }

  method set_extra_menu (GMenuModel() $model) is also<set-extra-menu> {
    gtk_label_set_extra_menu($!gtk-l, $model);
  }

  method set_justify (Int() $jtype) is also<set-justify> {
    my GtkJustification $j = $jtype;

    gtk_label_set_justify($!gtk-l, $j);
  }

  method set_label (Str() $str) is also<set-label> {
    gtk_label_set_label($!gtk-l, $str);
  }

  method set_lines (Int() $lines) is also<set-lines> {
    my gint $l = $lines;

    gtk_label_set_lines($!gtk-l, $lines);
  }

  method set_markup (Str() $str) is also<set-markup> {
    gtk_label_set_markup($!gtk-l, $str);
  }

  method set_markup_with_mnemonic (Str() $str)
    is also<set-markup-with-mnemonic>
  {
    gtk_label_set_markup_with_mnemonic($!gtk-l, $str);
  }

  method set_max_width_chars (Int() $n_chars) is also<set-max-width-chars> {
    my gint $n = $n_chars;

    gtk_label_set_max_width_chars($!gtk-l, $n);
  }

  method set_mnemonic_widget (GtkWidget() $widget)
    is also<set-mnemonic-widget>
  {
    gtk_label_set_mnemonic_widget($!gtk-l, $widget);
  }

  method set_natural_wrap_mode (Int() $wrap_mode)
    is also<set-natural-wrap-mode>
  {
    my GtkNaturalWrapMode $w = $wrap_mode;

    gtk_label_set_natural_wrap_mode($!gtk-l, $w);
  }

  method set_selectable (Int() $setting) is also<set-selectable> {
    my gboolean $s = $setting.so.Int;

    gtk_label_set_selectable($!gtk-l, $s);
  }

  method set_single_line_mode (Int() $single_line_mode)
    is also<set-single-line-mode>
  {
    my gboolean $s = $single_line_mode.so.Int;

    gtk_label_set_single_line_mode($!gtk-l, $s);
  }

  method set_tabs (PangoTabArray() $tabs) is also<set-tabs> {
    gtk_label_set_tabs($!gtk-l, $tabs);
  }

  method set_text (Str() $str) is also<set-text> {
    gtk_label_set_text($!gtk-l, $str);
  }

  method set_text_with_mnemonic (Str() $str)
    is also<set-text-with-mnemonic>
  {
    gtk_label_set_text_with_mnemonic($!gtk-l, $str);
  }

  method set_use_markup (Int() $setting) is also<set-use-markup> {
    my gboolean $s = $setting;

    gtk_label_set_use_markup($!gtk-l, $s);
  }

  method set_use_underline (Int() $setting) is also<set-use-underline> {
    my gboolean $s = $setting.so.Int;

    gtk_label_set_use_underline($!gtk-l, $s);
  }

  method set_width_chars (Int() $n_chars) is also<set-width-chars> {
    my gint $n = $n_chars;

    gtk_label_set_width_chars($!gtk-l, $n);
  }

  method set_wrap (Int() $wrap) is also<set-wrap> {
    my gboolean $w = $wrap.so.Int;

    gtk_label_set_wrap($!gtk-l, $w);
  }

  method set_wrap_mode (Int() $wrap_mode) is also<set-wrap-mode> {
    my PangoWrapMode $w = $wrap_mode;

    gtk_label_set_wrap_mode($!gtk-l, $w);
  }

  method set_xalign (Num() $xalign) is also<set-xalign> {
    my gfloat $x = $xalign;

    gtk_label_set_xalign($!gtk-l, $x);
  }

  method set_yalign (Num() $yalign) is also<set-yalign> {
    my gfloat $y = $yalign;

    gtk_label_set_yalign($!gtk-l, $y);
  }

}

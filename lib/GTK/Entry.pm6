use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Entry:ver<4>;

use GTK::Widget:ver<4>;
use GTK::Entry::Buffer:ver<4>;

use GLib::Roles::Implementor;

our subset GtkEntryAncestry is export of Mu
  where GtkEntry | GtkWidgetAncestry;

class GTK::Entry:ver<4> is GTK::Widget:ver<4> {
  has GtkEntry $!gtk-e is implementor;

  submethod BUILD ( :$gtk-entry ) {
    self.setGtkEntry($gtk-entry) if $gtk-entry
  }

  method setGtkEntry (GtkEntryAncestry $_) {
    my $to-parent;

    $!gtk-e = do {
      when GtkEntry {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkEntry, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkEntry
    is also<GtkEntry>
  { $!gtk-e }

  multi method new (GtkEntryAncestry $gtk-entry, :$ref = True) {
    return unless $gtk-entry;

    my $o = self.bless( :$gtk-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-entry = gtk_entry_new();

    $gtk-entry ?? self.bless( :$gtk-entry ) !! Nil;
  }

  method new_with_buffer (GtkEntryBuffer() $buffer) is also<new-with-buffer> {
    my $gtk-entry = gtk_entry_new_with_buffer($!gtk-e, $buffer);

    $gtk-entry ?? self.bless( :$gtk-entry ) !! Nil;
  }

  # Type: GTKEntryBuffer
  method buffer ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Entry::Buffer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('buffer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Entry::Buffer.getTypePair
        )
      },
      STORE => -> $, GtkEntryBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: int
  method max-length is rw  is g-property is also<max_length> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-length', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-length', $gv);
      }
    );
  }

  # Type: boolean
  method visibility is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visibility', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visibility', $gv);
      }
    );
  }

  # Type: boolean
  method has-frame is rw  is g-property is also<has_frame> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-frame', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-frame', $gv);
      }
    );
  }

  # Type: GTK
  method invisible-char is rw  is g-property is also<invisible_char> {
    my $gv = GLib::Value.new( GTK );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('invisible-char', $gv);
        $gv.GTK;
      },
      STORE => -> $,  $val is copy {
        $gv.GTK = $val;
        self.prop_set('invisible-char', $gv);
      }
    );
  }

  # Type: boolean
  method activates-default is rw  is g-property is also<activates_default> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activates-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activates-default', $gv);
      }
    );
  }

  # Type: int
  method scroll-offset is rw  is g-property is also<scroll_offset> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scroll-offset', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scroll-offset does not allow writing'
      }
    );
  }

  # Type: boolean
  method truncate-multiline is rw  is g-property is also<truncate_multiline> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('truncate-multiline', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('truncate-multiline', $gv);
      }
    );
  }

  # Type: boolean
  method overwrite-mode is rw  is g-property is also<overwrite_mode> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('overwrite-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('overwrite-mode', $gv);
      }
    );
  }

  # Type: uint
  method text-length is rw  is g-property is also<text_length> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-length', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'text-length does not allow writing'
      }
    );
  }

  # Type: boolean
  method invisible-char-set is rw  is g-property is also<invisible_char_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('invisible-char-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invisible-char-set', $gv);
      }
    );
  }

  # Type: double
  method progress-fraction is rw  is g-property is also<progress_fraction> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('progress-fraction', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('progress-fraction', $gv);
      }
    );
  }

  # Type: double
  method progress-pulse-step is rw  is g-property is also<progress_pulse_step> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('progress-pulse-step', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('progress-pulse-step', $gv);
      }
    );
  }

  # Type: string
  method placeholder-text is rw  is g-property is also<placeholder_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('placeholder-text', $gv);
      }
    );
  }

  # Type: GdkPaintable
  method primary-icon-paintable ( :$raw = False ) is rw  is g-property is also<primary_icon_paintable> {
    my $gv = GLib::Value.new( GDK::Paintable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-paintable', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Paintable.getTypePair
        )
      },
      STORE => -> $, GdkPaintable() $val is copy {
        $gv.object = $val;
        self.prop_set('primary-icon-paintable', $gv);
      }
    );
  }

  # Type: GTKPaintable
  method secondary-icon-paintable ( :$raw = False ) is rw  is g-property is also<secondary_icon_paintable> {
    my $gv = GLib::Value.new( GTK::Paintable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-paintable', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Paintable.getTypePair
        )
      },
      STORE => -> $, GdkPaintable() $val is copy {
        $gv.object = $val;
        self.prop_set('secondary-icon-paintable', $gv);
      }
    );
  }

  # Type: string
  method primary-icon-name is rw  is g-property is also<primary_icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-name', $gv);
      }
    );
  }

  # Type: string
  method secondary-icon-name is rw  is g-property is also<secondary_icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-name', $gv);
      }
    );
  }

  # Type: GIcon
  method primary-icon-gicon ( :$raw = False ) is rw is g-property is also<primary_icon_gicon> {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-gicon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
        );
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('primary-icon-gicon', $gv);
      }
    );
  }

  # Type: GIcon
  method secondary-icon-gicon ( :$raw = False ) is rw  is g-property is also<secondary_icon_gicon> {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-gicon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
        );
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('secondary-icon-gicon', $gv);
      }
    );
  }

  # Type: GTKImageType
  method primary-icon-storage-type ( :$enum = True ) is rw  is g-property is also<primary_icon_storage_type> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkImageType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-storage-type', $gv);
        my $t = $gv.valueFromEnum(GtkImageType);
        return $t unless $enum;
        GtkImageTypeEnum($t);
      },
      STORE => -> $,  $val is copy {
        warn 'primary-icon-storage-type does not allow writing'
      }
    );
  }

  # Type: GTKImageType
  method secondary-icon-storage-type ( :$enum = True ) is rw  is g-property is also<secondary_icon_storage_type> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkImageType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-storage-type', $gv);
        my $t = $gv.valueFromEnum(GtkImageType);
        return $t unless $enum;
        GtkImageTypeEnum($t);
      },
      STORE => -> $,  $val is copy {
        warn 'secondary-icon-storage-type does not allow writing'
      }
    );
  }

  # Type: boolean
  method primary-icon-activatable is rw  is g-property is also<primary_icon_activatable> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-activatable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('primary-icon-activatable', $gv);
      }
    );
  }

  # Type: boolean
  method secondary-icon-activatable is rw  is g-property is also<secondary_icon_activatable> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-activatable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('secondary-icon-activatable', $gv);
      }
    );
  }

  # Type: boolean
  method primary-icon-sensitive is rw  is g-property is also<primary_icon_sensitive> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('primary-icon-sensitive', $gv);
      }
    );
  }

  # Type: boolean
  method secondary-icon-sensitive is rw  is g-property is also<secondary_icon_sensitive> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('secondary-icon-sensitive', $gv);
      }
    );
  }

  # Type: string
  method primary-icon-tooltip-text is rw  is g-property is also<primary_icon_tooltip_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-tooltip-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-tooltip-text', $gv);
      }
    );
  }

  # Type: string
  method secondary-icon-tooltip-text is rw  is g-property is also<secondary_icon_tooltip_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-tooltip-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-tooltip-text', $gv);
      }
    );
  }

  # Type: string
  method primary-icon-tooltip-markup is rw  is g-property is also<primary_icon_tooltip_markup> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('primary-icon-tooltip-markup', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('primary-icon-tooltip-markup', $gv);
      }
    );
  }

  # Type: string
  method secondary-icon-tooltip-markup is rw  is g-property is also<secondary_icon_tooltip_markup> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-tooltip-markup', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-tooltip-markup', $gv);
      }
    );
  }

  # Type: string
  method im-module is rw  is g-property is also<im_module> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('im-module', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('im-module', $gv);
      }
    );
  }

  # Type: GTKEntryCompletion
  method completion ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::EntryCompletion.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('completion', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::EntryCompletion.getTypePair
        )
      },
      STORE => -> $, GtkEntryCompletion() $val is copy {
        $gv.object = $val;
        self.prop_set('completion', $gv);
      }
    );
  }

  # Type: GTKInputPurpose
  method input-purpose ( :$enum = True ) is rw  is g-property is also<input_purpose> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkInputPurpose) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-purpose', $gv);
        my $p = $gv.valueFromEnum(GtkInputPurpose);
        return $p unless $enum;
        GtkInputPurposeEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputPurpose) = $val;
        self.prop_set('input-purpose', $gv);
      }
    );
  }

  # Type: GTKInputHints
  method input-hints ( :set(:$flags) = True ) is rw  is g-property is also<input_hints> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkInputHints) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-hints', $gv);
        my $f = $gv.valueFromEnum(GtkInputHints);
        return $f unless $flags;
        getFlags(GtkInputHintsEnum, $f);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkInputHints) = $val;
        self.prop_set('input-hints', $gv);
      }
    );
  }

  # Type: PangoAttrList
  method attributes ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::AttrList.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('attributes', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |Pango::AttrList.getTypePair
        )
      },
      STORE => -> $, PangoAttrList() $val is copy {
        $gv.pointer = $val;
        self.prop_set('attributes', $gv);
      }
    );
  }

  # Type: PangoTabArray
  method tabs ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::Tabs.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tabs', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Pango::Tabs.getTypePair
        );
      },
      STORE => -> $, PangoTabArray() $val is copy {
        $gv.pointer = $val;
        self.prop_set('tabs', $gv);
      }
    );
  }

  # Type: boolean
  method show-emoji-icon is rw  is g-property is also<show_emoji_icon> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-emoji-icon', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-emoji-icon', $gv);
      }
    );
  }

  # Type: GMenuModel
  method extra-menu ( :$raw = False ) is rw  is g-property is also<extra_menu> {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('extra-menu', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::MenuModel.getTypePair
        );
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('extra-menu', $gv);
      }
    );
  }

  # Type: boolean
  method enable-emoji-completion is rw  is g-property is also<enable_emoji_completion> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-emoji-completion', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-emoji-completion', $gv);
      }
    );
  }

  method text is rw {
    Proxy.new:
      FETCH => -> $     { self.get_buffer.get_text    },
      STORE => -> $, \v { self.get_buffer.set_text(v) }
  }

  method Activate {
    self.connect($!gtk-e, 'activate');
  }

  method Icon-Press is also<Icon_Press> {
    self.connect-uint($!gtk-e, 'icon-press');
  }

  method Icon-Release is also<Icon_Release> {
    self.connect-uint($!gtk-e, 'icon-release');
  }

  method get_activates_default is also<get-activates-default> {
    so gtk_entry_get_activates_default($!gtk-e);
  }

  method get_alignment is also<get-alignment> {
    gtk_entry_get_alignment($!gtk-e);
  }

  method get_attributes ( :$raw = False ) is also<get-attributes> {
    propReturnObject(
      gtk_entry_get_attributes($!gtk-e),
      $raw,
      |Pango::AttrList.getTypePair
    );
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_entry_get_buffer($!gtk-e),
      $raw,
      |GTK::Entry::Buffer.getTypePair
    );
  }

  method get_completion ( :$raw = False ) is also<get-completion> {
    propReturnObject(
      gtk_entry_get_completion($!gtk-e),
      $raw,
      |GTK::EntryCompletion.getTypePair
    );
  }

  method get_current_icon_drag_source is also<get-current-icon-drag-source> {
    gtk_entry_get_current_icon_drag_source($!gtk-e);
  }

  method get_extra_menu ( :$raw = False ) is also<get-extra-menu> {
    propReturnObject(
      gtk_entry_get_extra_menu($!gtk-e),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_has_frame is also<get-has-frame> {
    so gtk_entry_get_has_frame($!gtk-e);
  }

  method get_icon_activatable (Int() $icon_pos) is also<get-icon-activatable> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_get_icon_activatable($!gtk-e, $i);
  }

  method get_icon_area (Int() $icon_pos, GdkRectangle() $icon_area) is also<get-icon-area> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_get_icon_area($!gtk-e, $icon_pos, $icon_area);
  }

  method get_icon_at_pos (Int() $x, Int() $y) is also<get-icon-at-pos> {
    my gint ($xx, $yy) = ($x, $y);

    gtk_entry_get_icon_at_pos($!gtk-e, $xx, $yy);
  }

  method get_icon_gicon (Int() $icon_pos, :$raw = False) is also<get-icon-gicon> {
    my GtkEntryIconPosition $i = $icon_pos;

    propReturnObject(
      gtk_entry_get_icon_gicon($!gtk-e, $icon_pos),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name (Int() $icon_pos) is also<get-icon-name> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_get_icon_name($!gtk-e, $icon_pos);
  }

  method get_icon_paintable (Int() $icon_pos, :$raw = False) is also<get-icon-paintable> {
    my GtkEntryIconPosition $i = $icon_pos;

    propReturnObject(
      gtk_entry_get_icon_paintable($!gtk-e, $icon_pos),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method get_icon_sensitive (Int() $icon_pos) is also<get-icon-sensitive> {
    my GtkEntryIconPosition $i = $icon_pos;

    so gtk_entry_get_icon_sensitive($!gtk-e, $icon_pos);
  }

  method get_icon_storage_type (Int() $icon_pos, :$enum = True) is also<get-icon-storage-type> {
    my GtkEntryIconPosition $i = $icon_pos;

    my $t = gtk_entry_get_icon_storage_type($!gtk-e, $icon_pos);
    return $t unless $enum;
    GtkImageTypeEnum($t);
  }

  method get_icon_tooltip_markup (Int() $icon_pos) is also<get-icon-tooltip-markup> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_get_icon_tooltip_markup($!gtk-e, $icon_pos);
  }

  method get_icon_tooltip_text (Int() $icon_pos) is also<get-icon-tooltip-text> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_get_icon_tooltip_text($!gtk-e, $icon_pos);
  }

  method get_input_hints ( :set(:$flags) = True ) is also<get-input-hints> {
    my $f = gtk_entry_get_input_hints($!gtk-e);
    return $f unless $flags;
    getFlags(GtkInputHintsEnum, $f);
  }

  method get_input_purpose ( :$enum = True ) is also<get-input-purpose> {
    my $p = gtk_entry_get_input_purpose($!gtk-e);
    return $p unless $enum;
    GtkInputPurposeEnum($p);
  }

  method get_invisible_char is also<get-invisible-char> {
    gtk_entry_get_invisible_char($!gtk-e);
  }

  method get_max_length is also<get-max-length> {
    gtk_entry_get_max_length($!gtk-e);
  }

  method get_overwrite_mode is also<get-overwrite-mode> {
    so gtk_entry_get_overwrite_mode($!gtk-e);
  }

  method get_placeholder_text is also<get-placeholder-text> {
    gtk_entry_get_placeholder_text($!gtk-e);
  }

  method get_progress_fraction is also<get-progress-fraction> {
    gtk_entry_get_progress_fraction($!gtk-e);
  }

  method get_progress_pulse_step is also<get-progress-pulse-step> {
    gtk_entry_get_progress_pulse_step($!gtk-e);
  }

  method get_tabs ( :$raw = False ) is also<get-tabs> {
    propReturnObject(
      gtk_entry_get_tabs($!gtk-e),
      $raw,
      |Pango::Tabs.getTypePair
    );
  }

  method get_text_length is also<get-text-length> {
    gtk_entry_get_text_length($!gtk-e);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_entry_get_type, $n, $t );
  }

  method get_visibility is also<get-visibility> {
    so gtk_entry_get_visibility($!gtk-e);
  }

  method grab_focus_without_selecting is also<grab-focus-without-selecting> {
    gtk_entry_grab_focus_without_selecting($!gtk-e);
  }

  method progress_pulse is also<progress-pulse> {
    gtk_entry_progress_pulse($!gtk-e);
  }

  method reset_im_context is also<reset-im-context> {
    gtk_entry_reset_im_context($!gtk-e);
  }

  method set_activates_default (Int() $setting) is also<set-activates-default> {
    my gboolean $s = $setting.so.Int;

    gtk_entry_set_activates_default($!gtk-e, $s);
  }

  method set_alignment (Num() $xalign) is also<set-alignment> {
    my gfloat $x = $xalign;

    gtk_entry_set_alignment($!gtk-e, $x);
  }

  method set_attributes (PangoAttrList() $attrs) is also<set-attributes> {
    gtk_entry_set_attributes($!gtk-e, $attrs);
  }

  method set_buffer (GtkEntryBuffer() $buffer) is also<set-buffer> {
    gtk_entry_set_buffer($!gtk-e, $buffer);
  }

  method set_completion (GtkEntryCompletion() $completion) is also<set-completion> {
    gtk_entry_set_completion($!gtk-e, $completion);
  }

  method set_extra_menu (GMenuModel() $model) is also<set-extra-menu> {
    gtk_entry_set_extra_menu($!gtk-e, $model);
  }

  method set_has_frame (Int() $setting) is also<set-has-frame> {
    my gboolean $s = $setting.so.Int;

    gtk_entry_set_has_frame($!gtk-e, $s);
  }

  method set_icon_activatable (Int() $icon_pos, Int() $activatable) is also<set-icon-activatable> {
    my GtkEntryIconPosition $i = $icon_pos;
    my gboolean             $a = $activatable;

    gtk_entry_set_icon_activatable($!gtk-e, $i, $a);
  }

  method set_icon_drag_source (
    Int()                $icon_pos,
    GdkContentProvider() $provider,
    Int()                $actions
  )
    is also<set-icon-drag-source>
  {
    my GtkEntryIconPosition $i = $icon_pos;
    my GdkDragAction        $a = $actions;

    gtk_entry_set_icon_drag_source($!gtk-e, $i, $provider, $a);
  }

  method set_icon_from_gicon (Int() $icon_pos, GIcon() $icon) is also<set-icon-from-gicon> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_set_icon_from_gicon($!gtk-e, $i, $icon);
  }

  method set_icon_from_icon_name (Int() $icon_pos, Str() $icon_name) is also<set-icon-from-icon-name> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_set_icon_from_icon_name($!gtk-e, $i, $icon_name);
  }

  method set_icon_from_paintable (
    Int()          $icon_pos,
    GdkPaintable() $paintable
  )
    is also<set-icon-from-paintable>
  {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_set_icon_from_paintable($!gtk-e, $i, $paintable);
  }

  method set_icon_sensitive (Int() $icon_pos, Int() $sensitive) is also<set-icon-sensitive> {
    my GtkEntryIconPosition $i = $icon_pos;
    my gboolean             $s = $sensitive.so.Int;

    gtk_entry_set_icon_sensitive($!gtk-e, $i, $s);
  }

  method set_icon_tooltip_markup (
    Int() $icon_pos,
    Str                  $tooltip
  )
    is also<set-icon-tooltip-markup>
  {
    my GtkEntryIconPosition $i = $icon_pos;
    gtk_entry_set_icon_tooltip_markup($!gtk-e, $i, $tooltip);
  }

  method set_icon_tooltip_text (Int() $icon_pos, Str() $tooltip) is also<set-icon-tooltip-text> {
    my GtkEntryIconPosition $i = $icon_pos;

    gtk_entry_set_icon_tooltip_text($!gtk-e, $i, $tooltip);
  }

  method set_input_hints (Int() $hints) is also<set-input-hints> {
    my GtkInputHints $h = $hints;

    gtk_entry_set_input_hints($!gtk-e, $h);
  }

  method set_input_purpose (Int() $purpose) is also<set-input-purpose> {
    my GtkInputPurpose $p = $purpose;

    gtk_entry_set_input_purpose($!gtk-e, $p);
  }

  method set_invisible_char (Int() $ch) is also<set-invisible-char> {
    my gunichar $c = $ch;

    gtk_entry_set_invisible_char($!gtk-e, $c);
  }

  method set_max_length (Int() $max) is also<set-max-length> {
    my gint     $m = $max;

    gtk_entry_set_max_length($!gtk-e, $m);
  }

  method set_overwrite_mode (Int() $overwrite) is also<set-overwrite-mode> {
    my gboolean $o = $overwrite.so.Int;

    gtk_entry_set_overwrite_mode($!gtk-e, $o);
  }

  method set_placeholder_text (Str() $text) is also<set-placeholder-text> {
    gtk_entry_set_placeholder_text($!gtk-e, $text);
  }

  method set_progress_fraction (Num() $fraction) is also<set-progress-fraction> {
    my gdouble $f = $fraction;

    gtk_entry_set_progress_fraction($!gtk-e, $f);
  }

  method set_progress_pulse_step (Num() $fraction) is also<set-progress-pulse-step> {
    my gdouble $f = $fraction;

    gtk_entry_set_progress_pulse_step($!gtk-e, $f);
  }

  method set_tabs (PangoTabArray() $tabs) is also<set-tabs> {
    gtk_entry_set_tabs($!gtk-e, $tabs);
  }

  method set_visibility (Int() $visible) is also<set-visibility> {
    my gboolean $v = $visible.so.Int;

    gtk_entry_set_visibility($!gtk-e, $v);
  }

  method unset_invisible_char is also<unset-invisible-char> {
    gtk_entry_unset_invisible_char($!gtk-e);
  }

}

INIT {
  my \O = GTK::Entry;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

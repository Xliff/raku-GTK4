use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::ComboBox:ver<4>;

use GTK::Tree::Iter:ver<4>;
use GTK::Widget:ver<4>;

use GTK::Roles::Cell::Layout:ver<4>;
use GTK::Roles::Cell::Editable:ver<4>;
use GTK::Roles::Signals::ComboBox:ver<4>;
use GTK::Roles::Tree::Model:ver<4>;

our subset GtkComboBoxAncestry is export of Mu
  where GtkComboBox | GtkCellLayout | GtkCellEditable | GtkWidgetAncestry;

class GTK::ComboBox:ver<4>
  is GTK::Widget
  is DEPRECATED(GtkDropDown)
{
  also does GTK::Roles::Cell::Editable;
  also does GTK::Roles::Cell::Layout;
  also does GTK::Roles::Signals::ComboBox;

  has GtkComboBox $!gcb is implementor;

  submethod BUILD ( :$gtk-combo-box ) {
    self.setGtkComboBox($gtk-combo-box) if $gtk-combo-box
  }

  method setGtkComboBox (GtkComboBoxAncestry $_) {
    my $to-parent;

    $!gcb = do {
      when GtkComboBox {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkCellEditable {
        $!gce      = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkComboBox, $_);
      }

      when GtkCellLayout {
        $!gcl      = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkComboBox, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkComboBox, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkCellLayout;
    self.roleInit-GtkCellEditable;
  }

  method GTK::Raw::Definitions::GtkComboBox
    is also<GtkComboBox>
  { $!gcb }

  multi method new (GtkComboBoxAncestry $gtk-combo-box, :$ref = True) {
    return unless $gtk-combo-box;

    my $o = self.bless( :$gtk-combo-box );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-combo-box = gtk_combo_box_new();

    $gtk-combo-box ?? self.bless( :$gtk-combo-box ) !! Nil;
  }

  method new_with_entry is also<new-with-entry> {
    my $gtk-combo-box = gtk_combo_box_new_with_entry();

    $gtk-combo-box ?? self.bless( :$gtk-combo-box ) !! Nil;
  }

  method new_with_model (GtkTreeModel() $model) is also<new-with-model> {
    my $gtk-combo-box = gtk_combo_box_new_with_model($model);

    $gtk-combo-box ?? self.bless( :$gtk-combo-box ) !! Nil;
  }

  method new_with_model_and_entry (GtkTreeModel() $model)
    is also<new-with-model-and-entry>
  {
    my $gtk-combo-box = gtk_combo_box_new_with_model_and_entry($model);

    $gtk-combo-box ?? self.bless( :$gtk-combo-box ) !! Nil;
  }

  # Type: int
  method active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: string
  method active-id is rw  is g-property is also<active_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('active-id', $gv);
      }
    );
  }

  # Type: GtkSensitivityType
  method button-sensitivity ( :$enum = True ) is rw  is g-property is also<button_sensitivity> {
    my $gv = GLib::Value.new-enum( GtkSensitivityType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('button-sensitivity', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSensitivityTypeEnum($t);
      },
      STORE => -> $,  $val is copy {
        $gv.value-from-enum(GtkSensitivityType) = $val;
        self.prop_set('button-sensitivity', $gv);
      }
    );
  }

  # Type: GtkWidget
  method child is rw  is g-property {
    my $gv = GLib::Value.new( GtkWidget );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child', $gv);
        $gv.GtkWidget;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkWidget = $val;
        self.prop_set('child', $gv);
      }
    );
  }

  # Type: int
  method entry-text-column is rw  is g-property is also<entry_text_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('entry-text-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('entry-text-column', $gv);
      }
    );
  }

  # Type: boolean
  method has-entry is rw  is g-property is also<has_entry> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-entry', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-entry', $gv);
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

  # Type: int
  method id-column is rw  is g-property is also<id_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('id-column', $gv);
      }
    );
  }

  # Type: GtkTreeModel
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GtkTreeModel );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Tree::Model.getTypePair
        );
      },
      STORE => -> $, GtkTreeModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: boolean
  method popup-fixed-width is rw  is g-property is also<popup_fixed_width> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('popup-fixed-width', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('popup-fixed-width', $gv);
      }
    );
  }

  # Type: boolean
  method popup-shown is rw  is g-property is also<popup_shown> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('popup-shown', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'popup-shown does not allow writing'
      }
    );
  }

  # Is originally:
  # GtkComboBox, gpointer --> void
  method Activate {
    self.connect($!gcb, 'activate');
  }

  # Is originally:
  # GtkComboBox, gpointer --> void
  method Changed {
    self.connect($!gcb, 'changed');
  }

  # Is originally:
  #
  method Format-Entry-Text is also<Format_Entry_Text> {
    self.connect-format-entry-text($!gcb);
  }

  # Is originally:
  # GtkComboBox, *GtkScrollType, gpointer --> void
  method Move-Active is also<Move_Active> {
    self.connect-move-active($!gcb);
  }

  # Is originally:
  # GtkComboBox, gpointer --> gboolean
  method Popdown {
    self.connect($!gcb, 'popdown');
  }

  # Is originally:
  # GtkComboBox, gpointer --> void
  method Popup {
    self.connect($!gcb, 'popup');
  }

  method get_active is also<get-active> {
    gtk_combo_box_get_active($!gcb);
  }

  method get_active_id is also<get-active-id> {
    gtk_combo_box_get_active_id($!gcb);
  }

  method get_active_iter (GtkTreeIter() $iter, :$raw = False)
    is also<get-active-iter>
  {
    propReturnObject(
      gtk_combo_box_get_active_iter($!gcb, $iter),
      $raw,
      |GTK::Tree::Iter.getTypePair
    );
  }

  method get_button_sensitivity is also<get-button-sensitivity> {
    gtk_combo_box_get_button_sensitivity($!gcb);
  }

  method get_child is also<get-child> {
    gtk_combo_box_get_child($!gcb);
  }

  method get_entry_text_column is also<get-entry-text-column> {
    gtk_combo_box_get_entry_text_column($!gcb);
  }

  method get_has_entry is also<get-has-entry> {
    so gtk_combo_box_get_has_entry($!gcb);
  }

  method get_id_column is also<get-id-column> {
    gtk_combo_box_get_id_column($!gcb);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_combo_box_get_model($!gcb),
      $raw,
      |GTK::Tree::Model.getTypePair
    );
  }

  method get_popup_fixed_width is also<get-popup-fixed-width> {
    gtk_combo_box_get_popup_fixed_width($!gcb);
  }

  method get_row_separator_func ( :$raw = False )
    is also<get-row-separator-func>
  {
    my $f = gtk_combo_box_get_row_separator_func($!gcb);
    return $f if $raw;

    # cw: Hopefully converts a function pointer to a callable!
    cast(
      :(GtkTreeModel, GtkTreeIter, gpointer --> gboolean),
      $f
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_combo_box_get_type, $n, $t );
  }

  method popdown {
    gtk_combo_box_popdown($!gcb);
  }

  method popup {
    gtk_combo_box_popup($!gcb);
  }

  method popup_for_device (GdkDevice() $device) is also<popup-for-device> {
    gtk_combo_box_popup_for_device($!gcb, $device);
  }

  method set_active (Int() $index) is also<set-active> {
    my gint $i = $index;

    gtk_combo_box_set_active($!gcb, $i);
  }

  method set_active_id (Str() $active_id) is also<set-active-id> {
    gtk_combo_box_set_active_id($!gcb, $active_id);
  }

  method set_active_iter (GtkTreeIter() $iter) is also<set-active-iter> {
    gtk_combo_box_set_active_iter($!gcb, $iter);
  }

  method set_button_sensitivity (Int() $sensitivity)
    is also<set-button-sensitivity>
  {
    my GtkSensitivityType $s = $sensitivity;

    gtk_combo_box_set_button_sensitivity($!gcb, $s);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gtk_combo_box_set_child($!gcb, $child);
  }

  method set_entry_text_column (Int() $text_column)
    is also<set-entry-text-column>
  {
    my gint $t = $text_column;

    gtk_combo_box_set_entry_text_column($!gcb, $t);
  }

  method set_id_column (Int() $id_column) is also<set-id-column> {
    my gint $i = $id_column;

    gtk_combo_box_set_id_column($!gcb, $i);
  }

  method set_model (GtkTreeModel() $model) is also<set-model> {
    gtk_combo_box_set_model($!gcb, $model);
  }

  method set_popup_fixed_width (Int() $fixed)
    is also<set-popup-fixed-width>
  {
    my gboolean $f = $fixed.so.Int;

    gtk_combo_box_set_popup_fixed_width($!gcb, $f);
  }

  method set_row_separator_func (
             &func,
    gpointer $data,
             &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-row-separator-func>
  {
    gtk_combo_box_set_row_separator_func(&func, $data, &destroy);
  }

}

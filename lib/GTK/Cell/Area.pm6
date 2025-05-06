use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Area:ver<4>;

use GLib::GList;
use GLib::Value;
use GTK::Cell::Renderer:ver<4>;
use GTK::Cell::Area::Context:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkCellAreaAncestry is export of Mu
  where GtkCellArea | GObject;

class GTK::Cell::Area {
  also does GLib::Roles::Object;

  has GtkCellArea $!gtk-ca is implementor;

  submethod BUILD ( :$gtk-cell-area ) {
    self.setGtkCellArea($gtk-cell-area) if $gtk-cell-area
  }

  method setGtkCellArea (GtkCellAreaAncestry $_) {
    my $to-parent;

    $!gtk-ca = do {
      when GtkCellArea {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellArea, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkCellArea
    is also<GtkCellArea>
  { $!gtk-ca }

  method new (
    $gtk-cell-area where * ~~ GtkCellAreaAncestry,

    :$ref = True
  ) {
    return unless $gtk-cell-area;

    my $o = self.bless( :$gtk-cell-area );
    $o.ref if $ref;
    $o;
  }

  method activate (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    GdkRectangle()       $cell_area,
    Int()                $flags,
    Int()                $edit_only
  ) {
    my GtkCellRendererState $f = $flags;
    my gboolean             $e = $edit_only;

    gtk_cell_area_activate($!gtk-ca, $context, $widget, $cell_area, $f, $e);
  }

  method activate_cell (
    GtkWidget()       $widget,
    GtkCellRenderer() $renderer,
    GdkEvent()        $event,
    GdkRectangle()    $cell_area,
    Int()             $flags
  )
    is also<activate-cell>
  {
    my GtkCellRendererState $f = $flags;

    gtk_cell_area_activate_cell(
      $!gtk-ca,
      $widget,
      $renderer,
      $event,
      $cell_area,
      $f
    );
  }

  method add (GtkCellRenderer() $renderer) {
    gtk_cell_area_add($!gtk-ca, $renderer);
  }

  method add_with_properties (
    GtkCellRenderer()  $renderer,
                      :$signed    = True
                      :$double    = True
                      *%a
  ) {
    is also<add-with-properties>
  {
    $.add($renderer);
    $.cell_set_property($renderer, .key, .value, :$signed, :$double)
      for %a.pairs;
  }

  method add_focus_sibling (
    GtkCellRenderer() $renderer,
    GtkCellRenderer() $sibling
  )
    is also<add-focus-sibling>
  {
    gtk_cell_area_add_focus_sibling($!gtk-ca, $renderer, $sibling);
  }

  # method add_with_properties (
  #   GtkCellRenderer() $renderer,
  #   Str()             $first_prop_name
  # )
  #   is also<add-with-properties>
  # {
  #   gtk_cell_area_add_with_properties($!gtk-ca, $renderer, $first_prop_name);
  # }

  method apply_attributes (
    GtkTreeModel() $tree_model,
    GtkTreeIter()  $iter,
    Int()          $is_expander,
    Int()          $is_expanded
  )
    is also<apply-attributes>
  {
    my ($i, $e) = ($is_expander, $is_expanded).map( *.so.Int );

    gtk_cell_area_apply_attributes($!gtk-ca, $tree_model, $iter, $i, $e);
  }

  method attribute_connect (
    GtkCellRenderer() $renderer,
    Str()             $attribute,
    Int()             $column
  )
    is also<attribute-connect>
  {
    my gint $c = $column;

    gtk_cell_area_attribute_connect($!gtk-ca, $renderer, $attribute, $c);
  }

  method attribute_disconnect (
    GtkCellRenderer() $renderer,
    Str()             $attribute
  )
    is also<attribute-disconnect>
  {
    gtk_cell_area_attribute_disconnect($!gtk-ca, $renderer, $attribute);
  }

  method attribute_get_column (
    GtkCellRenderer() $renderer,
    Str()             $attribute
  )
    is also<attribute-get-column>
  {
    gtk_cell_area_attribute_get_column($!gtk-ca, $renderer, $attribute);
  }

  proto method cell_get_property (|)
    is also<cell-get-property>
  { * }

  multi method cell_get_property ($renderer, $property_name) {
    my $v = GValue.new;

    samewith($renderer, $property_name, $v);
    # cw: Could take the extra step here and resolve the type to a name and
    #     then to an object type.
    #     This is something for a later version.
    $v.value;
  }
  multi method cell_get_property (
    GtkCellRenderer() $renderer,
    Str()             $property_name,
    GValue()          $value
  ) {
    gtk_cell_area_cell_get_property($!gtk-ca, $renderer, $property_name, $value);
  }

  multi method cell_set_property (
    GtkCellRenderer()  $renderer,
    Str()              $property_name,
                       $value,
                      :$signed         = False,
                      :$double         = True
  )
    is also<cell-set-property>
  {
    my $v = valueToGValue($value);

    gtk_cell_area_cell_set_property($!gtk-ca, $renderer, $property_name, $v);
  }

  method copy_context (GtkCellAreaContext() $context) is also<copy-context> {
    gtk_cell_area_copy_context($!gtk-ca, $context);
  }

  method create_context ( :$raw = False ) is also<create-context> {
    propReturnObject(
      gtk_cell_area_create_context($!gtk-ca),
      $raw,
      |GTK::Cell::Area::Context.getTypePair
    );
  }

  method event (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    GdkEvent()           $event,
    GdkRectangle()       $cell_area,
    Int()                $flags
  ) {
    my GtkCellRendererState $f = $flags;

    gtk_cell_area_event($!gtk-ca, $context, $widget, $event, $cell_area, $f);
  }

  method focus (Int() $direction) {
    my GtkDirectionType $d = $direction;

    gtk_cell_area_focus($!gtk-ca, $d);
  }

  method foreach (&callback, gpointer $callback_data = gpointer) {
    gtk_cell_area_foreach($!gtk-ca, &callback, $callback_data);
  }

  method foreach_alloc (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    GdkRectangle()       $cell_area,
    GdkRectangle()       $background_area,
                         &callback,
    gpointer             $callback_data    = gpointer
  )
    is also<foreach-alloc>
  {
    gtk_cell_area_foreach_alloc(
      $!gtk-ca,
      $context,
      $widget,
      $cell_area,
      $background_area,
      &callback,
      $callback_data
    );
  }

  method get_cell_allocation (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    GtkCellRenderer()    $renderer,
    GdkRectangle()       $cell_area,
    GdkRectangle()       $allocation
  )
    is also<get-cell-allocation>
  {
    gtk_cell_area_get_cell_allocation(
      $!gtk-ca,
      $context,
      $widget,
      $renderer,
      $cell_area,
      $allocation
    );
  }

  method get_cell_at_position (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    GdkRectangle()       $cell_area,
    Int()                $x,
    Int()                $y,
    GdkRectangle()       $alloc_area
  )
    is also<get-cell-at-position>
  {
    my gint ($xx, $yy) = ($x, $y);

    gtk_cell_area_get_cell_at_position(
      $!gtk-ca,
      $context,
      $widget,
      $cell_area,
      $xx,
      $yy,
      $alloc_area
    );
  }

  method get_current_path_string is also<get-current-path-string> {
    gtk_cell_area_get_current_path_string($!gtk-ca);
  }

  proto method get_edit_widget (|)
    is also<get-edit-widget>
  { * }

  multi method get_edit_widget ( :$editable is required where *.so ) {
    propReturnObject(
      samewith( :raw ),
      False,
      |GTK::Cell::Editable.getTypePair
    );
  }
  multi method get_edit_widget ( :$raw = False ) {
    gtk_cell_area_get_edit_widget($!gtk-ca);
  }

  method get_edited_cell ( :$raw = False ) is also<get-edited-cell> {
    propReturnObject(
      gtk_cell_area_get_edited_cell($!gtk-ca),
      $raw,
      |GTK::Cell::Renderer.getTypePair
    );
  }

  method get_focus_cell ( :$raw = False ) is also<get-focus-cell> {
    propReturnObject(
      gtk_cell_area_get_focus_cell($!gtk-ca),
      $raw,
      |GTK::Cell::Renderer.getTypePair
    );
  }

  method get_focus_from_sibling (GtkCellRenderer() $renderer, :$raw = False)
    is also<get-focus-from-sibling>
  {
    propReturnObject(
      gtk_cell_area_get_focus_from_sibling($!gtk-ca, $renderer),
      $raw,
      |GTK::Cell::Renderer.getTypePair
    );
  }

  method get_focus_siblings (
    GtkCellRenderer()  $renderer,
                      :$raw            = False,
                      :gslist(:$glist) = False
  )
    is also<get-focus-siblings>
  {
    returnGList(
      gtk_cell_area_get_focus_siblings($!gtk-ca, $renderer),
      $raw,
      $glist,
      |GTK::Cell::Renderer.getTypePair
    );
  }

  proto method get_preferred_height (|)
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height ($context, $widget) {
    samewith($context, $widget, $, $);
  }
  multi method get_preferred_height (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
                         $minimum_height is rw,
                         $natural_height is rw
  ) {
    my gint ($w, $m, $n) = (0, 0);

    gtk_cell_area_get_preferred_height($!gtk-ca, $context, $widget, $m, $n);
    ($minimum_height, $natural_height) = ($m, $n);
  }

  proto method get_preferred_height_for_width (|)
    is also<get-preferred-height-for-width>
  { * }

  multi method get_preferred_height_for_width ($context, $widget, $width) {
    samewith($context, $widget, $width, $, $)
  }
  multi method get_preferred_height_for_width (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    Int()                $width,
                         $minimum_height is rw,
                         $natural_height is rw
  ) {
    my gint ($w, $m, $n) = ($width, 0, 0);

    gtk_cell_area_get_preferred_height_for_width(
      $!gtk-ca,
      $context,
      $widget,
      $w,
      $m,
      $n
    );
    ($minimum_height, $natural_height) = ($m, $n);
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width ($context, $widget) {
    samewith($, $);
  }
  multi method get_preferred_width (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
                         $minimum_width is rw,
                         $natural_width is rw
  ) {
    my gint ($m, $n) = (0, 0);

    gtk_cell_area_get_preferred_width($!gtk-ca, $context, $widget, $m, $n);
    ($minimum_width, $natural_width) = ($m, $n);
  }

  proto method get_preferred_width_for_height (|)
    is also<get-preferred-width-for-height>
  { * }

  multi method get_preferred_width_for_height ($context, $widget, $height) {
    samewith($context, $widget, $height, $, $);
  }
  multi method get_preferred_width_for_height (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    Int()                $height,
                         $minimum_width is rw,
                         $natural_width is rw
  ) {
    my gint ($h, $m, $n) = ($height, 0, 0);

    gtk_cell_area_get_preferred_width_for_height(
      $!gtk-ca,
      $context,
      $widget,
      $h,
      $m,
      $n
    );

    ($minimum_width, $natural_width) = ($m, $n);
  }

  method get_request_mode ( :$enum = True ) is also<get-request-mode> {
    my $m = gtk_cell_area_get_request_mode($!gtk-ca);
    return $m unless $enum;
    GtkSizeRequestModeEnum($m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_area_get_type, $n, $t );
  }

  method has_renderer (GtkCellRenderer() $renderer) is also<has-renderer> {
    so gtk_cell_area_has_renderer($!gtk-ca, $renderer);
  }

  proto method inner_cell_area (|)
    is also<inner-cell-area>
  { * }

  multi method inner_cell_area ($widget, $cell_area, :$raw = False) {
    samewith($widget, $cell_area, GdkRectangle.new);
  }
  multi method inner_cell_area (
    GtkWidget()     $widget,
    GdkRectangle()  $cell_area,
    GdkRectangle()  $inner_area,
                   :$raw         = False
  ) {
    gtk_cell_area_inner_cell_area($!gtk-ca, $widget, $cell_area, $inner_area);

    propReturnObject($inner_area, $raw, |GDK::Rectange.getTypePair)
  }

  method is_activatable is also<is-activatable> {
    so gtk_cell_area_is_activatable($!gtk-ca);
  }

  method is_focus_sibling (
    GtkCellRenderer() $renderer,
    GtkCellRenderer() $sibling
  )
    is also<is-focus-sibling>
  {
    so gtk_cell_area_is_focus_sibling($!gtk-ca, $renderer, $sibling);
  }

  method remove (GtkCellRenderer() $renderer) {
    gtk_cell_area_remove($!gtk-ca, $renderer);
  }

  method remove_focus_sibling (
    GtkCellRenderer() $renderer,
    GtkCellRenderer() $sibling
  )
    is also<remove-focus-sibling>
  {
    gtk_cell_area_remove_focus_sibling($!gtk-ca, $renderer, $sibling);
  }

  proto method request_renderer (|)
    is also<request-renderer>
  { * }

  multi method request_renderer ($renderer, $orientation, $widget, $fs) {
    samewith($renderer, $orientation, $widget, $fs, $, $);
  }
  multi method request_renderer (
    GtkCellRenderer() $renderer,
    Int()             $orientation,
    GtkWidget()       $widget,
    Int()             $for_size,
                      $minimum_size is rw,
                      $natural_size is rw
  ) {
    my GtkOrientation  $o          =  $orientation;
    my gint           ($f, $m, $n) = ($for_size, 0, 0);

    gtk_cell_area_request_renderer(
      $!gtk-ca,
      $renderer,
      $o,
      $widget,
      $f,
      $m,
      $n
    );

    ($minimum_size, $natural_size) = ($m, $n);
  }

  method set_focus_cell (GtkCellRenderer() $renderer) is also<set-focus-cell> {
    gtk_cell_area_set_focus_cell($!gtk-ca, $renderer);
  }

  method snapshot (
    GtkCellAreaContext() $context,
    GtkWidget()          $widget,
    GtkSnapshot()        $snapshot,
    GdkRectangle()       $background_area,
    GdkRectangle()       $cell_area,
    Int()                $flags,
    Int()                $paint_focus
  ) {
    my GtkCellRendererState $f = $flags;
    my gboolean             $p = $paint_focus.so.Int;

    gtk_cell_area_snapshot(
      $!gtk-ca,
      $context,
      $widget,
      $snapshot,
      $background_area,
      $cell_area,
      $f,
      $p
    );
  }

  method stop_editing (Int() $canceled) is also<stop-editing> {
    my gboolean $c = $canceled;

    gtk_cell_area_stop_editing($!gtk-ca, $c);
  }

}

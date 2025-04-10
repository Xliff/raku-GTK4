use v6.c;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::Layout:ver<4>;

use GLib::GList;

# use GTK::Cell::Area:ver<4>;

use GLib::Roles::Implementor;
# use GTK::Roles::Cell::Renderer:ver<4>;

role GTK::Roles::Cell::Layout {
  has GtkCellLayout $!gcl is implementor;

  method GTK::Raw::Definitions::GtkCellLayout { $!gcl }
  method GtkCellLayout                        { $!gcl }

  method roleInit-GtkCellLayout {
    return if $!gcl;

    my \i = findProperImplementor(self.^attributes);
    $!gcl = cast( GtkCellLayout, i.get_value(self) );
  }

  method add_attribute (
    GtkCellRenderer() $cell,
    Str()             $attribute,
    Int()             $column
  ) {
    my gint $c = $column;

    gtk_cell_layout_add_attribute($!gcl, $cell, $attribute, $c);
  }

  method clear {
    gtk_cell_layout_clear($!gcl);
  }

  method clear_attributes (GtkCellRenderer() $cell) {
    gtk_cell_layout_clear_attributes($!gcl, $cell);
  }

  method get_area ( :$raw = False ) {
    propReturnObject(
      gtk_cell_layout_get_area($!gcl),
      $raw,
      |GTK::Cell::Area.getTypePair
    );
  }

  method get_cells ( :$raw = False, :gslist(:$glist) = False ) {
    returnGList(
      gtk_cell_layout_get_cells($!gcl),
      $raw,
      $glist,
      |GTK::Cell::Renderer.getTypePair
    );
  }

  method gtkcelllayout_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_layout_get_type, $n, $t );
  }

  method pack_end (GtkCellRenderer() $cell, Int() $expand) {
    my gboolean $e = $expand.so.Int;

    gtk_cell_layout_pack_end($!gcl, $cell, $e);
  }

  method pack_start (GtkCellRenderer() $cell, Int() $expand) {
    my gboolean $e = $expand.so.Int;

    gtk_cell_layout_pack_start($!gcl, $cell, $e);
  }

  method reorder (GtkCellRenderer() $cell, Int() $position) {
    my gint $p = $position;

    gtk_cell_layout_reorder($!gcl, $cell, $p);
  }

  method set_attributes (GtkCellRenderer() $cell) {
    gtk_cell_layout_set_attributes($!gcl, $cell);
  }

  method set_cell_data_func (
    GtkCellRenderer()  $cell,
                       &func,
    gpointer           $func_data,
                       &destroy,
                      :$raw         = False

  ) {
    my &myFunc = &func;
    &myFunc = SUB {
      my @a = $*A;

      @a[0] = GTK::Cell::Layout.new(   @a[0] );
      @a[1] = GTK::Cell::Renderer.new( @a[1] );
      @a[2] = GTK::Tree::Model.new(    @a[2] );
      @a[3] = GTK::Tree::Iter.new(     @a[3] );

      &func( |@a );
    }

    gtk_cell_layout_set_cell_data_func(
      $!gcl,
      $cell,
      &myFunc,
      $func_data,
      &destroy
    );
  }

}

our subset GtkCellLayoutAncestry is export of Mu
  where GtkCellLayout | GObject;

use Method::Also;

class GTK::Cell::Layout:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Cell::Layout;

  submethod BUILD ( :$gtk-cell-layout ) {
    self.setGtkCellLayout($gtk-cell-layout) if $gtk-cell-layout
  }

  method setGtkCellLayout (GtkCellLayoutAncestry $_) {
    my $to-parent;

    $!gcl = do {
      when GtkCellLayout {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellLayout, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
    GtkCellLayoutAncestry $gtk-cell-layout,

    :$ref = True
  ) {
    return unless $gtk-cell-layout;

    my $o = self.bless( :$gtk-cell-layout );
    $o.ref if $ref;
    $o;
  }

}

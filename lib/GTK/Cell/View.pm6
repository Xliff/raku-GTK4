use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Cell::View:ver<4>;

use GTK::Cell::Area:ver<4>;
use GTK::Cell::Area::Context:ver<4>;
use GTK::Tree::Path:ver<4>;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Orientable:ver<4>;
use GTK::Roles::Tree::Model:ver<4>;

our subset GtkCellViewAncestry is export of Mu
  where GtkCellView | GtkOrientable | GtkWidgetAncestry;

class GTK::Cell::View:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Orientable;

  has GtkCellView $!gtk-cv is implementor;

  submethod BUILD ( :$gtk-cell-view ) {
    self.setGtkCellView($gtk-cell-view) if $gtk-cell-view
  }

  method setGtkCellView (GtkCellViewAncestry $_) {
    my $to-parent;

    $!gtk-cv = do {
      when GtkCellView {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkOrientable {
        $!gtk-o    = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkCellView, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkCellView, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkOrientable;
  }

  method GTK::Raw::Definitions::GtkCellView
    is also<GtkCellView>
  { $!gtk-cv }

  multi method new (
    $gtk-cell-view where * ~~ GtkCellViewAncestry,

    :$ref = True
  ) {
    return unless $gtk-cell-view;

    my $o = self.bless( :$gtk-cell-view );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-cell-area = gtk_cell_view_new();

    my $o = $gtk-cell-area ?? self.bless( :$gtk-cell-area ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_context (
    GtkCellArea()         $area,
    GtkCellAreaContext()  $context,
                         *%a
  )
    is also<new-with-context>
  {
    my $gtk-cell-area = gtk_cell_view_new_with_context($area, $context);

    my $o = $gtk-cell-area ?? self.bless( :$gtk-cell-area ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_markup (Str() $markup, *%a) is also<new-with-markup> {
    my $gtk-cell-area = gtk_cell_view_new_with_markup($markup);

    my $o = $gtk-cell-area ?? self.bless( :$gtk-cell-area ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_text (Str() $text, *%a) is also<new-with-text> {
    my $gtk-cell-area = gtk_cell_view_new_with_text($text);

    my $o = $gtk-cell-area ?? self.bless( :$gtk-cell-area ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_texture (GdkTexture() $texture, *%a)
    is also<new-with-texture>
  {
    my $gtk-cell-area = gtk_cell_view_new_with_texture($texture);

    my $o = $gtk-cell-area ?? self.bless( :$gtk-cell-area ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkCellArea
  method cell-area ( :$raw = False ) is rw  is g-property is also<cell_area> {
    my $gv = GLib::Value.new( GTK::Cell::Area.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cell-area', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Cell::Area.getTypePair
        );
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.object = $val;
        self.prop_set('cell-area', $gv);
      }
    );
  }

  # Type: GtkCellAreaContext
  method cell-area-context ( :$raw = False )
    is rw
    is g-property
    is also<cell_area_context>
  {
    my $gv = GLib::Value.new( GTK::Cell::Area::Context.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cell-area-context', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Cell::Area::Context.getTypePair
        );
      },
      STORE => -> $, GtkCellAreaContext() $val is copy {
        $gv.object = $val;
        self.prop_set('cell-area-context', $gv);
      }
    );
  }

  # Type: boolean
  method draw-sensitive is rw  is g-property is also<draw_sensitive> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('draw-sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('draw-sensitive', $gv);
      }
    );
  }

  # Type: boolean
  method fit-model is rw  is g-property is also<fit_model> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fit-model', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fit-model', $gv);
      }
    );
  }

  # Type: GtkTreeModel
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Tree::Model.get_type );
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

  method get_displayed_row ( :$raw = False ) is also<get-displayed-row> {
    propReturnObject(
      gtk_cell_view_get_displayed_row($!gtk-cv),
      $raw,
      |GTK::Tree::Path.getTypePair
    );
  }

  method get_draw_sensitive is also<get-draw-sensitive> {
    so gtk_cell_view_get_draw_sensitive($!gtk-cv);
  }

  method get_fit_model is also<get-fit-model> {
    so gtk_cell_view_get_fit_model($!gtk-cv);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_cell_view_get_model($!gtk-cv),
      $raw,
      |GTK::Tree::Model.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_view_get_type, $n, $t );
  }

  method set_displayed_row (GtkTreePath() $path) is also<set-displayed-row> {
    gtk_cell_view_set_displayed_row($!gtk-cv, $path);
  }

  method set_draw_sensitive (Int() $draw_sensitive)
    is also<set-draw-sensitive>
  {
    my gboolean $d = $draw_sensitive.so.Int;

    gtk_cell_view_set_draw_sensitive($!gtk-cv, $d);
  }

  method set_fit_model (Int() $fit_model) is also<set-fit-model> {
    my gboolean $f = $fit_model.so.Int;

    gtk_cell_view_set_fit_model($!gtk-cv, $f);
  }

  method set_model (GtkTreeModel() $model) is also<set-model> {
    gtk_cell_view_set_model($!gtk-cv, $model);
  }

}

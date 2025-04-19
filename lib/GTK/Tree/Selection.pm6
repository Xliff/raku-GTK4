use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Tree::Selection:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkTreeSelectionAncestry is export of Mu
  where GtkTreeSelection | GObject;

class GTK::Tree::Selection {
  also does GLib::Roles::Object;

  has GtkTreeSelection $!gts is implementor;

  submethod BUILD ( :$gtk-tree-sel ) {
    self.setGtkTreeSelection($gtk-tree-sel) if $gtk-tree-sel
  }

  method setGtkTreeSelection (GtkTreeSelectionAncestry $_) {
    my $to-parent;

    $!gts = do {
      when GtkTreeSelection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTreeSelection, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkTreeSelection
    is also<GtkTreeSelection>
  { $!gts }

  multi method new (
    $gtk-tree-sel where * ~~ GtkTreeSelectionAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-sel;

    my $o = self.bless( :$gtk-tree-sel );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkSelectionMode
  method mode ( :$enum = True ) is rw  is also<from_charset> {
    my GLib::Value $gv .= new( GLib::Value.from-enum(GtkSelectionMode) );
    Proxy.new(
      FETCH => -> $ {
        $gv = self.prop_get('mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkSelectionModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.value-from-enum(GtkSelectionMode) = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  method Changed {
    self.connect($!gts, 'changed');
  }

  method count_selected_rows is also<count-selected-rows> {
    gtk_tree_selection_count_selected_rows($!gts);
  }

  method get_mode ( :$enum = True ) is also<get-mode> {
    my $m = gtk_tree_selection_get_mode($!gts);
    return $m unless $enum;
    GtkSelectionModeEnum($m);
  }

  method get_select_function ( :$raw = False ) is also<get-select-function> {
    my $f = gtk_tree_selection_get_select_function($!gts);
    return $f if $raw;

    cast(
      :(
        GtkTreeSelection,
        GtkTreeModel,
        GtkTreePath,
        gboolean,
        gpointer --> gboolean
      ),
      $f
    );
  }

  proto method get_selected (|)
    is also<get-selected>
  { * }

  multi method get_selected ( :$raw = False ) {
    samewith(
       newCArray(GtkTreeIter),
       GtkTreeIter.new,
      :$raw
    );
  }
  multi method get_selected (
    CArray[GtkTreeModel]  $model,
    GtkTreeIter()         $iter,
                         :$raw    = False
  ) {
    my ($mo, $io);

    gtk_tree_selection_get_selected($!gts, $model, $iter);

    return ($model, $iter) if $raw;

    (
      CArrayToArray($model).map({ GTK::Tree::Model.new($_) }),
      GTK::Tree::Iter.new($iter)
    );
  }

  proto method get_selected_rows (|)
    is also<get-selected-rows>
  { * }

  multi method get_selected_rows ( :$raw = False ) {
    samewith( newCArray(GtkTreeModel), :$raw );
  }
  multi method get_selected_rows (CArray[GtkTreeModel] $model, :$raw = False) {
    gtk_tree_selection_get_selected_rows($!gts, $model);

    return $model if $raw;

    CArrayToArray($model).map({ GTK::Tree::Model.new($_) });
  }

  method get_tree_view ( :$raw = False ) is also<get-tree-view> {
    propReturnObject(
      gtk_tree_selection_get_tree_view($!gts),
      $raw,
      |::('GTK::Tree::View').getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_selection_get_type, $n, $t );
  }

  method get_user_data is also<get-user-data> {
    gtk_tree_selection_get_user_data($!gts);
  }

  method iter_is_selected (GtkTreeIter() $iter) is also<iter-is-selected> {
    gtk_tree_selection_iter_is_selected($!gts, $iter);
  }

  method path_is_selected (GtkTreePath() $path) is also<path-is-selected> {
    gtk_tree_selection_path_is_selected($!gts, $path);
  }

  method select_all is also<select-all> {
    gtk_tree_selection_select_all($!gts);
  }

  method select_iter (GtkTreeIter() $iter) is also<select-iter> {
    gtk_tree_selection_select_iter($!gts, $iter);
  }

  method select_path (GtkTreePath() $path) is also<select-path> {
    gtk_tree_selection_select_path($!gts, $path);
  }

  method select_range (GtkTreePath() $start_path,GtkTreePath() $end_path)
    is also<select-range>
  {
    gtk_tree_selection_select_range($!gts, $start_path, $end_path);
  }

  method selected_foreach (&func, gpointer $data  = gpointer, :$raw = False)
    is also<selected-foreach>
  {
    my &myFunc = &func;

    unless $raw {
      &myFunc = SUB {
        $*A[0] = GTK::Tree::Model.new( $*A[0] );
        $*A[1] = GTK::Tree::Path.new(  $*A[1] );
        $*A[2] = GTK::Tree::Iter.new(  $*A[2] );

        &func( |$*A );
      }
    }

    gtk_tree_selection_selected_foreach($!gts, &myFunc, $data);
  }

  method set_mode (Int() $type) is also<set-mode> {
    my GtkSelectionMode $t = $type;

    gtk_tree_selection_set_mode($!gts, $type);
  }

  proto method set_select_function (|)
    is also<set-select-function>
  { * }

  multi method set_select_function (
    &func,
    $data    = gpointer,
    &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    samewith( cast(gpointer, &func), $data, &destroy );
  }
  multi method set_select_function (
    gpointer $func,
    gpointer $data    = gpointer,
             &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gtk_tree_selection_set_select_function($!gts, $func, $data, &destroy);
  }

  method unselect_all is also<unselect-all> {
    gtk_tree_selection_unselect_all($!gts);
  }

  method unselect_iter (GtkTreeIter() $iter) is also<unselect-iter> {
    gtk_tree_selection_unselect_iter($!gts, $iter);
  }

  method unselect_path (GtkTreePath() $path) is also<unselect-path> {
    gtk_tree_selection_unselect_path($!gts, $path);
  }

  method unselect_range (GtkTreePath() $start_path, GtkTreePath() $end_path)
    is also<unselect-range>
  {
    gtk_tree_selection_unselect_range($!gts, $start_path, $end_path);
  }

}

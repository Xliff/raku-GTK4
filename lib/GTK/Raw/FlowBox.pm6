use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::FlowBox:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gtk/gtkflowbox.h

sub gtk_flow_box_append (
  GtkFlowBox $self,
  GtkWidget  $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_bind_model (
  GtkFlowBox $box,
  GListModel $model,
             &create_widget_func (GObject, gpointer --> GtkWidget),
  gpointer   $user_data,
             &user_data_free_func (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_changed (GtkFlowBoxChild $child)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_get_child (GtkFlowBoxChild $self)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_get_index (GtkFlowBoxChild $child)
  returns gint
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_is_selected (GtkFlowBoxChild $child)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_new
  returns GtkFlowBoxChild
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_child_set_child (
  GtkFlowBoxChild $self,
  GtkWidget       $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_activate_on_single_click (GtkFlowBox $box)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_child_at_index (
  GtkFlowBox $box,
  gint       $idx
)
  returns GtkFlowBoxChild
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_child_at_pos (
  GtkFlowBox $box,
  gint       $x,
  gint       $y
)
  returns GtkFlowBoxChild
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_column_spacing (GtkFlowBox $box)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_homogeneous (GtkFlowBox $box)
  returns uint32
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_max_children_per_line (GtkFlowBox $box)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_min_children_per_line (GtkFlowBox $box)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_row_spacing (GtkFlowBox $box)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_selected_children (GtkFlowBox $box)
  returns GList
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_selection_mode (GtkFlowBox $box)
  returns GtkSelectionMode
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_insert (
  GtkFlowBox $box,
  GtkWidget  $widget,
  gint       $position
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_invalidate_filter (GtkFlowBox $box)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_invalidate_sort (GtkFlowBox $box)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_new
  returns GtkFlowBox
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_prepend (
  GtkFlowBox $self,
  GtkWidget  $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_remove (
  GtkFlowBox $box,
  GtkWidget  $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_select_all (GtkFlowBox $box)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_select_child (
  GtkFlowBox      $box,
  GtkFlowBoxChild $child
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_selected_foreach (
  GtkFlowBox            $box,
                        &func (GtkFlowBox, GtkFlowBoxChild, gpointer),
  gpointer              $data
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_activate_on_single_click (
  GtkFlowBox $box,
  gboolean   $single
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_column_spacing (
  GtkFlowBox $box,
  guint      $spacing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_filter_func (
  GtkFlowBox           $box,
                       &filter_func (GtkFlowBoxChild, gpointer --> gboolean),
  gpointer             $user_data,
                       &destroy (gpointer)
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_hadjustment (
  GtkFlowBox    $box,
  GtkAdjustment $adjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_homogeneous (
  GtkFlowBox $box,
  gboolean   $homogeneous
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_max_children_per_line (
  GtkFlowBox $box,
  guint      $n_children
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_min_children_per_line (
  GtkFlowBox $box,
  guint      $n_children
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_row_spacing (
  GtkFlowBox $box,
  guint      $spacing
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_selection_mode (
  GtkFlowBox       $box,
  GtkSelectionMode $mode
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_sort_func (
  GtkFlowBox         $box,
                     &sort_func (
                       GtkFlowBoxChild,
                       GtkFlowBoxChild,
                       gpointer
                       --> gint
                     ),
  gpointer           $user_data,
  GDestroyNotify     $destroy
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_set_vadjustment (
  GtkFlowBox    $box,
  GtkAdjustment $adjustment
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_unselect_all (GtkFlowBox $box)
  is      native(gtk4)
  is      export
{ * }

sub gtk_flow_box_unselect_child (
  GtkFlowBox      $box,
  GtkFlowBoxChild $child
)
  is      native(gtk4)
  is      export
{ * }

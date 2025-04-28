

### /usr/src/gtk4/gtk/gtksizerequest.h

sub gtk_distribute_natural_allocation (
  gint             $extra_space,
  guint            $n_requested_sizes,
  GtkRequestedSize $sizes
) 
  returns gint
  is      native(gtk4)
  is      export
{ * }


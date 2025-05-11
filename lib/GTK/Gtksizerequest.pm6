

  method gtk_distribute_natural_allocation (
    guint            $n_requested_sizes,
    GtkRequestedSize $sizes
  ) {
    gtk_distribute_natural_allocation($!gtk-sr, $n_requested_sizes, $sizes);
  }

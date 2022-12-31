  method gtk_tree_row_reference_copy {
    gtk_tree_row_reference_copy($!gtk-tm);
  }

  method gtk_tree_row_reference_deleted (
    GObject     $proxy,
    GtkTreePath $path
  ) {
    gtk_tree_row_reference_deleted($!gtk-tm, $path);
  }

  method gtk_tree_row_reference_free {
    gtk_tree_row_reference_free($!gtk-tm);
  }

  method gtk_tree_row_reference_get_model {
    gtk_tree_row_reference_get_model($!gtk-tm);
  }

  method gtk_tree_row_reference_get_path {
    gtk_tree_row_reference_get_path($!gtk-tm);
  }

  method gtk_tree_row_reference_get_type {
    gtk_tree_row_reference_get_type();
  }

  method gtk_tree_row_reference_inserted (
    GObject     $proxy,
    GtkTreePath $path
  ) {
    gtk_tree_row_reference_inserted($!gtk-tm, $path);
  }

  method gtk_tree_row_reference_new (
    GtkTreeModel $model,
    GtkTreePath  $path
  ) {
    gtk_tree_row_reference_new($!gtk-tm, $path);
  }

  method gtk_tree_row_reference_new_proxy (
    GObject      $proxy,
    GtkTreeModel $model,
    GtkTreePath  $path
  ) {
    gtk_tree_row_reference_new_proxy($!gtk-tm, $model, $path);
  }

  method gtk_tree_row_reference_reordered (
    GObject     $proxy,
    GtkTreePath $path,
    GtkTreeIter $iter,
    gint        $new_order is rw
  ) {
    gtk_tree_row_reference_reordered($!gtk-tm, $path, $iter, $new_order);
  }

  method gtk_tree_row_reference_valid {
    gtk_tree_row_reference_valid($!gtk-tm);
  }

  method complete {
    gtk_entry_completion_complete($!gtk-ec);
  }

  method compute_prefix (
    Str                $key
  ) {
    gtk_entry_completion_compute_prefix($!gtk-ec, $key);
  }

  method get_completion_prefix {
    gtk_entry_completion_get_completion_prefix($!gtk-ec);
  }

  method get_entry {
    gtk_entry_completion_get_entry($!gtk-ec);
  }

  method get_inline_completion {
    gtk_entry_completion_get_inline_completion($!gtk-ec);
  }

  method get_inline_selection {
    gtk_entry_completion_get_inline_selection($!gtk-ec);
  }

  method get_minimum_key_length {
    gtk_entry_completion_get_minimum_key_length($!gtk-ec);
  }

  method get_model {
    gtk_entry_completion_get_model($!gtk-ec);
  }

  method get_popup_completion {
    gtk_entry_completion_get_popup_completion($!gtk-ec);
  }

  method get_popup_set_width {
    gtk_entry_completion_get_popup_set_width($!gtk-ec);
  }

  method get_popup_single_match {
    gtk_entry_completion_get_popup_single_match($!gtk-ec);
  }

  method get_text_column {
    gtk_entry_completion_get_text_column($!gtk-ec);
  }

  method get_type {
    gtk_entry_completion_get_type();
  }

  method insert_prefix {
    gtk_entry_completion_insert_prefix($!gtk-ec);
  }

  method new {
    gtk_entry_completion_new();
  }

  method new_with_area (

  ) {
    gtk_entry_completion_new_with_area($!gtk-ec, $area);
  }

  method set_inline_completion (
    GtkEntryCompletion $completion,
    gboolean           $inline_completion
  ) {
    gtk_entry_completion_set_inline_completion($!gtk-ec, $inline_completion);
  }

  method set_inline_selection (
    GtkEntryCompletion $completion,
    gboolean           $inline_selection
  ) {
    gtk_entry_completion_set_inline_selection($!gtk-ec, $inline_selection);
  }

  method set_match_func (
    GtkEntryCompletion          $completion,
    GtkEntryCompletionMatchFunc $func,
    gpointer                    $func_data,
    GDestroyNotify              $func_notify
  ) {
    gtk_entry_completion_set_match_func($!gtk-ec, $func, $func_data, $func_notify);
  }

  method set_minimum_key_length (
    GtkEntryCompletion $completion,
    gint               $length
  ) {
    gtk_entry_completion_set_minimum_key_length($!gtk-ec, $length);
  }

  method set_model (
    GtkEntryCompletion $completion,
    GtkTreeModel       $model
  ) {
    gtk_entry_completion_set_model($!gtk-ec, $model);
  }

  method set_popup_completion (
    GtkEntryCompletion $completion,
    gboolean           $popup_completion
  ) {
    gtk_entry_completion_set_popup_completion($!gtk-ec, $popup_completion);
  }

  method set_popup_set_width (
    GtkEntryCompletion $completion,
    gboolean           $popup_set_width
  ) {
    gtk_entry_completion_set_popup_set_width($!gtk-ec, $popup_set_width);
  }

  method set_popup_single_match (
    GtkEntryCompletion $completion,
    gboolean           $popup_single_match
  ) {
    gtk_entry_completion_set_popup_single_match($!gtk-ec, $popup_single_match);
  }

  method set_text_column (
    GtkEntryCompletion $completion,
    gint               $column
  ) {
    gtk_entry_completion_set_text_column($!gtk-ec, $column);
  }

Loading: /usr/src/gtk4-4.8.1+ds/gtk/gtkentrycompletion.c
# Type: GTKTreeModel
method model is rw  is g-property {
  my $gv = GLib::Value.new( GTKTreeModel );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('model', $gv);
      $gv.GTKTreeModel;
    },
    STORE => -> $,  $val is copy {
      $gv.GTKTreeModel = $val;
      self.prop_set('model', $gv);
    }
  );
}

# Type: int
method minimum-key-length is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_INT );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('minimum-key-length', $gv);
      $gv.int;
    },
    STORE => -> $, Int() $val is copy {
      $gv.int = $val;
      self.prop_set('minimum-key-length', $gv);
    }
  );
}

# Type: int
method text-column is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_INT );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('text-column', $gv);
      $gv.int;
    },
    STORE => -> $, Int() $val is copy {
      $gv.int = $val;
      self.prop_set('text-column', $gv);
    }
  );
}

# Type: boolean
method inline-completion is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('inline-completion', $gv);
      $gv.boolean;
    },
    STORE => -> $, Int() $val is copy {
      $gv.boolean = $val;
      self.prop_set('inline-completion', $gv);
    }
  );
}

# Type: boolean
method popup-completion is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('popup-completion', $gv);
      $gv.boolean;
    },
    STORE => -> $, Int() $val is copy {
      $gv.boolean = $val;
      self.prop_set('popup-completion', $gv);
    }
  );
}

# Type: boolean
method popup-set-width is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('popup-set-width', $gv);
      $gv.boolean;
    },
    STORE => -> $, Int() $val is copy {
      $gv.boolean = $val;
      self.prop_set('popup-set-width', $gv);
    }
  );
}

# Type: boolean
method popup-single-match is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('popup-single-match', $gv);
      $gv.boolean;
    },
    STORE => -> $, Int() $val is copy {
      $gv.boolean = $val;
      self.prop_set('popup-single-match', $gv);
    }
  );
}

# Type: boolean
method inline-selection is rw  is g-property {
  my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('inline-selection', $gv);
      $gv.boolean;
    },
    STORE => -> $, Int() $val is copy {
      $gv.boolean = $val;
      self.prop_set('inline-selection', $gv);
    }
  );
}

# Type: GTKCellArea
method cell-area is rw  is g-property {
  my $gv = GLib::Value.new( GTKCellArea );
  Proxy.new(
    FETCH => sub ($) {
      self.prop_get('cell-area', $gv);
      $gv.GTKCellArea;
    },
    STORE => -> $,  $val is copy {
      $gv.GTKCellArea = $val;
      self.prop_set('cell-area', $gv);
    }
  );
}

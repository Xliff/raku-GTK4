use v6.c;

use GTK::Raw::Types:ver<4>;

role GTK::Roles::Cell::Editable {
  has GtkCellEditable $!gce is implementor;

  method GTK::Raw::Definitions::GtkCellEditable { $!gce }
  method GtkCellEditable                        { $!gce }

  method roleInit-GtkCellEditable {
    return if $!gce;

    my \i = findProperImplementor(self.^attributes);
    $!gce = cast( GtkCellEditable, i.get_value(self) );
  }

  method editing_done {
    gtk_cell_editable_editing_done($!gce);
  }

  method gtkcelleditable_get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &gtk_cell_editable_get_type, $n, $t );
  }

  method remove_widget {
    gtk_cell_editable_remove_widget($!gce);
  }

  method start_editing (GdkEvent() $event) {
    gtk_cell_editable_start_editing($!gce, $event);
  }

}

our subset GtkCellEditableAncestry is export of Mu
  where GtkCellEditable | GObject;

use Method::Also;

class GTK::Cell::Editable:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Cell::Editable;

  submethod BUILD ( :$gtk-cell-editable ) {
    self.setGtkCellEditable($gtk-cell-editable) if $gtk-cell-editable
  }

  method setGtkCellEditable (GtkCellEditableAncestry $_) {
    my $to-parent;

    $!gce = do {
      when GtkCellEditable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCellEditable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
    GtkCellEditableAncestry $gtk-cell-editable,

    :$ref = True
  ) {
    return unless $gtk-cell-editable;

    my $o = self.bless( :$gtk-cell-editable );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gtkcelleditable_get_type;
  }

}

### /usr/src/gtk4/gtk/deprecated/gtkcelleditable.h

sub gtk_cell_editable_editing_done (GtkCellEditable $cell_editable)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_editable_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_editable_remove_widget (GtkCellEditable $cell_editable)
  is      native(gtk4)
  is      export
{ * }

sub gtk_cell_editable_start_editing (
  GtkCellEditable $cell_editable,
  GdkEvent        $event
)
  is      native(gtk4)
  is      export
{ * }

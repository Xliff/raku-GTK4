use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GTK::Roles::SelectionModel:ver<4>;

our subset GtkNoSelectionAncestry is export of Mu
  where GtkNoSelection | GtkSelectionModel | GObject;

class GTK::NoSelection {
  also does GLib::Roles::Object;
  also does GTK::Roles::SelectionModel;

  has GtkNoSelection $!gtk-no-s is implementor;

  submethod BUILD ( :$gtk-no-selection ) {
    self.setGtkNoSelection($gtk-no-selection) if $gtk-no-selection
  }

  method setGtkNoSelection (GtkNoSelectionAncestry $_) {
    my $to-parent;

    $!gtk-no-s = do {
      when GtkNoSelection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkSelectionModel {
        $to-parent = cast(GObject, $_);
        $!gtk-sm   = $_;
        cast(GtkNoSelection, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkNoSelection, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkSelectionModel;
  }

  method GTK::Raw::Definitions::GtkNoSelection
    is also<GtkNoSelection>
  { $!gtk-no-s }

  multi method new (
     $gtk-no-selection where * ~~ GtkNoSelectionAncestry,

    :$ref = True
  ) {
    return unless $gtk-no-selection;

    my $o = self.bless( :$gtk-no-selection );
    $o.ref if $ref;
    $o;
  }
  multi method new (GListModel() $model) {
    my $gtk-no-selection = gtk_no_selection_new($model);

    $gtk-no-selection ?? self.bless( :$gtk-no-selection ) !! Nil;
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gtk_no_selection_get_model($!gtk-no-s),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method set_model (GListModel() $model) is also<set-model> {
    gtk_no_selection_set_model($!gtk-no-s, $model);
  }

}

### /usr/src/gtk4/gtk/gtknoselection.h

sub gtk_no_selection_get_model (GtkNoSelection $self)
  returns GListModel
  is      native(gtk4)
  is      export
{ * }

sub gtk_no_selection_new (GListModel $model)
  returns GtkNoSelection
  is      native(gtk4)
  is      export
{ * }

sub gtk_no_selection_set_model (
  GtkNoSelection $self,
  GListModel     $model
)
  is      native(gtk4)
  is      export
{ * }

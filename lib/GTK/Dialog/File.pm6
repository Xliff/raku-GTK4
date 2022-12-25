use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog::File:ver<4>;

use GLib::Roles::Object;

our subset GtkFileDialogAncestry is export of Mu
  where GtkFileDialog | GObject;

class GTK::Dialog::File {
  also does GLib::Roles::Object;

  has GtkFileDialog $!gtk-d-f is implementor;

  submethod BUILD ( :$gtk-file-dialog ) {
    self.setGtkFileDialog($gtk-file-dialog) if $gtk-file-dialog
  }

  method setGtkFileDialog (GtkFileDialogAncestry $_) {
    my $to-parent;

    $!gtk-d-f = do {
      when GtkFileDialog {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkFileDialog, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkFileDialog
    is also<GtkFileDialog>
  { $!gtk-d-f }

  multi method new (
    $gtk-file-dialog where * ~~ GtkFileDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-file-dialog;

    my $o = self.bless( :$gtk-file-dialog );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-file-dialog = gtk_file_dialog_new();

    $gtk-file-dialog ?? self.bless( :$gtk-file-dialog ) !! Nil;
  }

  # Type: GtkFileFilter
  method current-filter is rw  is g-property is also<current_filter> {
    my $gv = GLib::Value.new( GtkFileFilter );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('current-filter', $gv);
        $gv.GtkFileFilter;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkFileFilter = $val;
        self.prop_set('current-filter', $gv);
      }
    );
  }

  # Type: GtkFile
  method current-folder is rw  is g-property is also<current_folder> {
    my $gv = GLib::Value.new( GIO::GFile.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('current-folder', $gv);
        $gv.GtkFile;
      },
      STORE => -> $,  $val is copy {
        $gv.GtkFile = $val;
        self.prop_set('current-folder', $gv);
      }
    );
  }

  # Type: GtkListModel
  method filters ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('filters', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        );
      },
      STORE => -> $, GListModel() $val is copy {
        $gv.object = $val;
        self.prop_set('filters', $gv);
      }
    );
  }

  # Type: boolean
  method modal is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('modal', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('modal', $gv);
      }
    );
  }

  # Type: GtkListModel
  method shortcut-folders ( :$raw = False ) is rw  is g-property is also<shortcut_folders> {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shortcut-folders', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        )
      },
      STORE => -> $, GListModel() $val is copy {
        $gv.GtkListModel = $val;
        self.prop_set('shortcut-folders', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method get_current_filter ( :$raw = False ) is also<get-current-filter> {
    propReturnObject(
      gtk_file_dialog_get_current_filter($!gtk-d-f),
      $raw,
      |GTK::Filter::File.getTypePair
    );
  }

  method get_current_folder is also<get-current-folder> {
    gtk_file_dialog_get_current_folder($!gtk-d-f);
  }

  method get_filters ( :$raw = False ) is also<get-filters> {
    propReturnObject(
      gtk_file_dialog_get_filters($!gtk-d-f),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_modal is also<get-modal> {
    so gtk_file_dialog_get_modal($!gtk-d-f);
  }

  method get_shortcut_folders (:$raw = False) is also<get-shortcut-folders> {
    propReturnObject(
      gtk_file_dialog_get_shortcut_folders($!gtk-d-f),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_title is also<get-title> {
    gtk_file_dialog_get_title($!gtk-d-f);
  }

  multi method open (
                        &callback      = Callable,
    gpointer            $user_data     = gpointer,
    GtkWindow           :$parent       = GtkWindow,
    GCancellable        :$cancellable  = GCancellable,
    GFile               :$current_file = GFile
  ) {
    samewith($parent, $current_file, $cancellable, &callback, $user_data);
  }
  multi method open (
    GtkWindow()         $parent,
    GFile()             $current_file,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data      = gpointer
  ) {
    gtk_file_dialog_open(
      $!gtk-d-f,
      $parent,
      $current_file,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method open_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$raw      = False
  )
    is also<open-finish>
  {
    clear_error;
    my $f = gtk_file_dialog_open_finish($!gtk-d-f, $result, $error);
    set_error($error);
    propReturnObject($f, $raw, |GIO::File.getTypePair)
  }

  proto method open_multiple (|)
    is also<open-multiple>
  { * }

  multi method open_multiple (
                        &callback     = Callable,
    GtkWindow()         $parent       = GtkWindow,
    GCancellable()      $cancellable  = GCancellable,
    gpointer            $user_data    = gpointer
  ) {
    samewith($parent, $cancellable, &callback, $user_data);
  }
  multi method open_multiple (
    GtkWindow()         $parent,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data    = gpointer
  ) {
    gtk_file_dialog_open_multiple(
      $!gtk-d-f,
      $parent,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method open_multiple_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$raw      = False
  )
    is also<open-multiple-finish>
  {
    clear_error
    my $l = gtk_file_dialog_open_multiple_finish($!gtk-d-f, $result, $error);
    set_error($error);
    propReturnObject($l, $raw, |GIO::ListModel.getTypePair);
  }

  multi method save (
                   &callback,
    GtkWindow()    :$parent       = GtkWindow,
    GFile()        :$current_file = GFile,
    Str()          :$current_name = Str,
    GCancellable() :$cancellable  = GCancellable,
    gpointer       :$user_data    = gpointer
  ) {
    samewith(
      $parent,
      $current_file,
      $current_name,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method save (
    GtkWindow()    $parent,
    GFile()        $current_file,
    Str()          $current_name,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data     = gpointer
  ) {
    gtk_file_dialog_save(
      $!gtk-d-f,
      $parent,
      $current_file,
      $current_name,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method save_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<save-finish>
  {
    clear_error;
    my $f = gtk_file_dialog_save_finish($!gtk-d-f, $result, $error);
    set_error($error);
    propReturnObject($f, $raw, |GIO::File.getTypePair);
  }

  proto method select_folder (|)
    is also<select-folder>
  { * }

  multi method select_folder (
                    &callback       = Callable,
    gpointer        $user_data      = gpointer,
    GtkWindow      :$parent         = GtkWindow,
    GFile          :$current_folder = GFile,
    GCancellable   :$cancellable    = GCancellable
  ) {
    samewith($parent, $current_folder, $cancellable, &callback, $user_data);
  }
  multi method select_folder (
    GtkWindow()    $parent,
    GFile()        $current_folder,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    gtk_file_dialog_select_folder(
      $!gtk-d-f,
      $parent,
      $current_folder,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method select_folder_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<select-folder-finish>
  {
    clear_error;
    my $f = gtk_file_dialog_select_folder_finish($!gtk-d-f, $result, $error);
    set_error($error);
    propReturnObject($f, $raw, |GIO::File.getTypePair)
  }

  proto method select_multiple_folders (|)
    is also<select-multiple-folders>
  { * }

  multi method select_multiple_folders (
    GtkWindow      $parent      = GtkWindow,
    GCancellable   $cancellable = GCancellable
  ) {
    samewith($parent, $cancellable, Callable, gpointer)
  }
  multi method select_multiple_folders (
                    &callback     = Callable,
    gpointer        $user_data    = gpointer,
    GtkWindow      :$parent      = GtkWindow,
    GCancellable   :$cancellable = GCancellable
  ) {
    samewith($parent, $cancellable, &callback, $user_data);
  }
  multi method select_multiple_folders (
    GtkWindow()    $parent,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    gtk_file_dialog_select_multiple_folders(
      $!gtk-d-f,
      $parent,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method select_multiple_folders_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<select-multiple-folders-finish>
  {
    clear_error;
    my $f = gtk_file_dialog_select_multiple_folders_finish(
      $!gtk-d-f,
      $result,
      $error
    );
    set_error($error);
    propReturnObject($f, $raw, |GIO::ListModel.getTypePair);
  }

  method set_current_filter (GtkFileFilter() $filter) is also<set-current-filter> {
    gtk_file_dialog_set_current_filter($!gtk-d-f, $filter);
  }

  method set_current_folder (GFile() $folder) is also<set-current-folder> {
    gtk_file_dialog_set_current_folder($!gtk-d-f, $folder);
  }

  method set_filters (GListModel() $filters) is also<set-filters> {
    gtk_file_dialog_set_filters($!gtk-d-f, $filters);
  }

  method set_modal (Int() $modal) is also<set-modal> {
    my gboolean $m = $modal.so.Int;

    gtk_file_dialog_set_modal($!gtk-d-f, $m);
  }

  method set_shortcut_folders (GListModel() $shortcut_folders) is also<set-shortcut-folders> {
    gtk_file_dialog_set_shortcut_folders($!gtk-d-f, $shortcut_folders);
  }

  method set_title (Str() $title) is also<set-title> {
    gtk_file_dialog_set_title($!gtk-d-f, $title);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Dialog::File;
  my \P = O.getTypePair;
  given "widget-types.json".IO.open( :rw ) {
    .lock;
    %widgets = from-json( .slurp );
    %widgets{ P.head.^shortname } = P.tail.^name;
    .seek(0, SeekFromBeginning);
    .spurt: to-json(%widgets);
    .close;
  }
}

INIT {
  my \O = GTK::Dialog::File;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

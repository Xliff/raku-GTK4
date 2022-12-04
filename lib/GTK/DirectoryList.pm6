use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::DirectoryList:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::GFile;
use GIO::Roles::ListModel;

our subset GtkDirectoryListAncestry is export of Mu
  where GtkDirectoryList | GListModel | GObject;

class GTK::DirectoryList {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has GtkDirectoryList $!gtk-dl is implementor;

  submethod BUILD ( :$gtk-dir-list ) {
    self.setGtkDirectoryList($gtk-dir-list) if $gtk-dir-list
  }

  method setGtkDirectoryList (GtkDirectoryListAncestry $_) {
    my $to-parent;

    $!gtk-dl = do {
      when GtkDirectoryList {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $!lm = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkDirectoryList, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkDirectoryList, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel
  }

  method GTK::Raw::Definitions::GtkDirectoryList
    is also<GtkDirectoryList>
  { $!gtk-dl }

  multi method new (
     $gtk-dir-list where * ~~ GtkDirectoryListAncestry,

    :$ref = True
  ) {
    return unless $gtk-dir-list;

    my $o = self.bless( :$gtk-dir-list );
    $o.ref if $ref;
    $o;
  }
  multi method new (GFile() $file) {
    my $gtk-dir-list = gtk_directory_list_new($file);

    $gtk-dir-list ?? self.bless( :$gtk-dir-list ) !! Nil;
  }

  # Type: string
  method attributes is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('attributes', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('attributes', $gv);
      }
    );
  }

  # Type: GtkError
  method error is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Error.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('error', $gv);
        cast(GError, $gv.pointer);
      },
      STORE => -> $,  $val is copy {
        warn 'error does not allow writing'
      }
    );
  }

  # Type: GtkFile
  method file ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::File.getTypePair
        );
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: int
  method io-priority is rw  is g-property is also<io_priority> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('io-priority', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('io-priority', $gv);
      }
    );
  }

  # Type: GtkFileInfo
  method item-type ( :$raw = False )
    is rw
    is g-property
    is also<item_type>
  {
    my $gv = GLib::Value.new( GLib::FileInfo.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item-type', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::FileInfo.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'item-type does not allow writing'
      }
    );
  }

  # Type: boolean
  method loading is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('loading', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'loading does not allow writing'
      }
    );
  }

  # Type: boolean
  method monitored is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('monitored', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('monitored', $gv);
      }
    );
  }

  # Type: uint
  method n-items is rw  is g-property is also<n_items> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-items', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-items does not allow writing'
      }
    );
  }


  method get_attributes is also<get-attributes> {
    gtk_directory_list_get_attributes($!gtk-dl);
  }

  method get_error is also<get-error> {
    gtk_directory_list_get_error($!gtk-dl);
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      gtk_directory_list_get_file($!gtk-dl),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_io_priority is also<get-io-priority> {
    gtk_directory_list_get_io_priority($!gtk-dl);
  }

  method get_monitored is also<get-monitored> {
    so gtk_directory_list_get_monitored($!gtk-dl);
  }

  method is_loading is also<is-loading> {
    so gtk_directory_list_is_loading($!gtk-dl);
  }

  method set_attributes (Str() $attributes) is also<set-attributes> {
    gtk_directory_list_set_attributes($!gtk-dl, $attributes);
  }

  method set_file (GFile() $file) is also<set-file> {
    gtk_directory_list_set_file($!gtk-dl, $file);
  }

  method set_io_priority (Int() $io_priority) is also<set-io-priority> {
    my gint $i = $io_priority;

    gtk_directory_list_set_io_priority($!gtk-dl, $i);
  }

  method set_monitored (Int() $monitored) is also<set-monitored> {
    my gboolean $m = $monitored.so.Int;

    gtk_directory_list_set_monitored($!gtk-dl, $m);
  }

}

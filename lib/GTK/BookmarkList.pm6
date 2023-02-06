use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::BookmarkList:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset GtkBookmarkListAncestry is export of Mu
  where GtkBookmarkList | GListModel | GObject;

class GTK::BookmarkList {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has GtkBookmarkList $!gtk-bl is implementor;

  submethod BUILD ( :$gtk-bookmark-list ) {
    self.setGtkBookmarkList($gtk-bookmark-list) if $gtk-bookmark-list
  }

  method setGtkBookmarkList (GtkBookmarkListAncestry $_) {
    my $to-parent;

    $!gtk-bl = do {
      when GtkBookmarkList {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $!lm = $_;
        $to-parent = cast(GObject, $_);
        cast(GtkBookmarkList, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkBookmarkList, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkBookmarkList
    is also<GtkBookmarkList>
  { $!gtk-bl }

  multi method new (
     $gtk-bookmark-list where * ~~ GtkBookmarkListAncestry,

    :$ref = True
  ) {
    return unless $gtk-bookmark-list;

    my $o = self.bless( :$gtk-bookmark-list );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $filename, Str() $attributes) {
    my $gtk-bookmark-list = gtk_bookmark_list_new($filename, $attributes);

    $gtk-bookmark-list ?? self.bless( :$gtk-bookmark-list ) !! Nil;
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

  # Type: string
  method filename is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('filename', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('filename', $gv);
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

  # Type: GFileInfo
  method item-type ( :$raw = False ) is rw  is g-property is also<item_type> {
    my $gv = GLib::Value.new( GIO::FileInfo.get_type );
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
    gtk_bookmark_list_get_attributes($!gtk-bl);
  }

  method get_filename is also<get-filename> {
    gtk_bookmark_list_get_filename($!gtk-bl);
  }

  method get_io_priority is also<get-io-priority> {
    gtk_bookmark_list_get_io_priority($!gtk-bl);
  }

  method is_loading is also<is-loading> {
    so gtk_bookmark_list_is_loading($!gtk-bl);
  }

  method set_attributes (Str() $attributes) is also<set-attributes> {
    gtk_bookmark_list_set_attributes($!gtk-bl, $attributes);
  }

  method set_io_priority (Int() $io_priority) is also<set-io-priority> {
    my gint $i = $io_priority;

    gtk_bookmark_list_set_io_priority($!gtk-bl, $i);
  }

}

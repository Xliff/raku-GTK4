use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog::Font:ver<4>;

use Pango::FontMap;
use Pango::Language;
use GTK::Filter:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GTK::Dialog::Font:ver<4> {
  also does GLib::Roles::Object;

  has GtkFontDialog $!gtk-fd is implementor;

  method new {
    my $gtk-font-dialog = gtk_font_dialog_new();

    $gtk-font-dialog ?? self.bless( :$gtk-font-dialog ) !! Nil;
  }

  method filter is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_filter    },
      STORE => -> $, \v { self.set_filter(v) }
  }

  method font_map is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_font_map    },
      STORE => -> $, \v { self.set_font_map(v) }
  }

  method language is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_language    },
      STORE => -> $, \v { self.set_language(v) }
  }

  method modal is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_modal    },
      STORE => -> $, \v { self.set_modal(v) }
  }

  method title is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_title    },
      STORE => -> $, \v { self.set_title(v) }
  }

  proto method choose_face (|)
  { * }

  multi method choose_face (
                     &callback      = Callable,
    gpointer         $user_data     = gpointer,
    GtkWindow()     :$parent        = GtkWindow,
    PangoFontFace() :$initial_value = PangoFontFace,
    GCancellable()  :$cancellable   = GCancellable
  ) {
    samewith(
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      &callback ?? $user_data !! gpointer
    );
  }
  multi method choose_face (
    GtkWindow()     $parent,
    PangoFontFace() $initial_value,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data       = gpointer
  ) {
    gtk_font_dialog_choose_face(
      $!gtk-fd,
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method choose_face_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = gtk_font_dialog_choose_face_finish($!gtk-fd, $result, $error);
    set_error($error);
    $rv;
  }

  proto method choose_family (|)
  { * }

  multi method choose_family (
                       &callback      = Callable,
    gpointer           $user_data     = gpointer,
    GtkWindow()       :$parent        = GtkWindow,
    PangoFontFamily() :$initial_value = PangoFontFamily,
    GCancellable()    :$cancellable   = GCancellable
  ) {
    samewith(
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method choose_family (
    GtkWindow()       $parent,
    PangoFontFamily() $initial_value,
    GCancellable()    $cancellable,
                      &callback,
    gpointer          $user_data       = gpointer
  ) {
    gtk_font_dialog_choose_family(
      $!gtk-fd,
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      &callback ?? $user_data !! gpointer
    );
  }

  method choose_family_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = gtk_font_dialog_choose_family_finish($!gtk-fd, $result, $error);
    set_error($error);
    $rv;
  }

  proto method choose_font (|)
  { * }

  multi method choose_font (
                            &callback       = Callable,
    gpointer                $user_data      = gpointer,
    GtkWindow()            :$parent         = GtkWindow,
    PangoFontDescription() :$initial_value  = PangoFontDescription,
    GCancellable()         :$cancellable    = GCancellable
  ) {
    samewith(
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method choose_font (
    GtkWindow()            $parent,
    PangoFontDescription() $initial_value,
    GCancellable()         $cancellable,
                           &callback,
    gpointer               $user_data       = gpointer
  ) {
    gtk_font_dialog_choose_font(
      $!gtk-fd,
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method choose_font_and_features (|)
  { * }

  multi method choose_font_and_features (
                            &callback      = Callable,
    gpointer                $user_data     = gpointer,
    GtkWindow()            :$parent        = GtkWindow,
    PangoFontDescription() :$initial_value = PangoFontDescription,
    GCancellable()         :$cancellable   = GCancellable
  ) {
    samewith(
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method choose_font_and_features (
    GtkWindow()            $parent,
    PangoFontDescription() $initial_value,
    GCancellable()         $cancellable,
                           &callback,
    gpointer               $user_data      = gpointer
  ) {
    gtk_font_dialog_choose_font_and_features(
      $!gtk-fd,
      $parent,
      $initial_value,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method choose_font_and_features_finish (|)
  { * }

  multi method choose_font_and_features_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  ) {
    return-with-all(
      samewith(
         $result,
         newCArray(PangoFontDescription),
         newCArray(Str),
         newCArray(PangoLanguage),
         $error,
        :all,
        :$raw
      )
    );
  }
  multi method choose_font_and_features_finish (
    GAsyncResult()                $result,
    CArray[PangoFontDescription]  $font_desc,
    CArray[Str]                   $font_features,
    CArray[PangoLanguage]         $language,
    CArray[Pointer[GError]]       $error          = gerror,
                                 :$raw            = False,
                                 :$all            = False
  ) {
    clear_error;
    my $rv = gtk_font_dialog_choose_font_and_features_finish(
      $!gtk-fd,
      $result,
      $font_desc,
      $font_features,
      $language,
      $error
    );
    set_error($error);

    $all.not
      ?? $rv
      !! (
        $rv,
        propReturnObject(
          ppr($font_desc),
          $raw,
          |Pango::FontDescription.getTypePair
        ),
        $raw ?? $font_features !! CArrayToArray($font_features),
        propReturnObject(
          ppr($language),
          $raw,
          |Pango::Language.getTypePair
        )
      )
  }

  method choose_font_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = gtk_font_dialog_choose_font_finish($!gtk-fd, $result, $error);
    set_error($error);
    $rv;
  }

  method get_filter ( :$raw = False ) {
    propReturnObject(
      gtk_font_dialog_get_filter($!gtk-fd),
      $raw,
      |GTK::Filter.getTypePair
    );
  }

  method get_font_map ( :$raw = False ) {
    propReturnObject(
      gtk_font_dialog_get_font_map($!gtk-fd),
      $raw,
      |Pango::FontMap.getTypePair
    );
  }

  method get_language ( :$raw = False ) {
    propReturnObject(
      gtk_font_dialog_get_language($!gtk-fd),
      $raw,
      |Pango::Language.getTypePair
    );
  }

  method get_modal {
    so gtk_font_dialog_get_modal($!gtk-fd);
  }

  method get_title {
    gtk_font_dialog_get_title($!gtk-fd);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_font_dialog_get_type, $n, $t );
  }

  method set_filter (GtkFilter() $filter) {
    gtk_font_dialog_set_filter($!gtk-fd, $filter);
  }

  method set_font_map (PangoFontMap() $fontmap) {
    gtk_font_dialog_set_font_map($!gtk-fd, $fontmap);
  }

  method set_language (PangoLanguage() $language) {
    gtk_font_dialog_set_language($!gtk-fd, $language);
  }

  method set_modal (Int() $modal) {
    my gboolean $m = $modal.so.Int;

    gtk_font_dialog_set_modal($!gtk-fd, $m);
  }

  method set_title (Str() $title) {
    gtk_font_dialog_set_title($!gtk-fd, $title);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::Dialog::Font;
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
  my \O = GTK::Dialog::Font;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

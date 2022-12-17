use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;
use GTK::Roles::Editable;

our subset GtkSearchEntryAncestry is export of Mu
  where GtkSearchEntry | GtkEditable | GtkWidgetAncestry;

class GTK::SearchEntry:ver<4> is GTK::Widget:ver<4> {
  also does GTK::Roles::Editable;
  
  has GtkSearchEntry $!gtk-se is implementor;

  submethod BUILD ( :$gtk-search-entry ) {
    self.setGtkSearchEntry($gtk-search-entry) if $gtk-search-entry
  }

  method setGtkSearchEntry (GtkSearchEntryAncestry $_) {
    my $to-parent;

    $!gtk-se = do {
      when GtkSearchEntry {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      when GtkEditable {
        $!gtk-e = $_;
        $to-parent = cast(GtkWidget, $_);
        cast(GtkSearchEntry, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSearchEntry, $_);
      }
    }
    self.setGtkWidget($to-parent);
    self.roleInit-GtkEditable;
  }

  method GTK::Raw::Definitions::GtkSearchEntry
    is also<GtkSearchEntry>
  { $!gtk-se }

  multi method new (
    $gtk-search-entry where * ~~ GtkSearchEntryAncestry,

    :$ref = True
  ) {
    return unless $gtk-search-entry;

    my $o = self.bless( :$gtk-search-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-search-entry = gtk_search_entry_new();

    $gtk-search-entry ?? self.bless( :$gtk-search-entry ) !! Nil;
  }

  # Type: boolean
  method activates-default is rw  is g-property is also<activates_default> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('activates-default', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activates-default', $gv);
      }
    );
  }

  # Type: string
  method placeholder-text is rw  is g-property is also<placeholder_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('placeholder-text', $gv);
      }
    );
  }

  # Type: uint
  method search-delay is rw  is g-property is also<search_delay> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-delay', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('search-delay', $gv);
      }
    );
  }

  method Activate {
    self.connect($!gtk-se, 'activate');
  }

  method Next-Match is also<Next_Match> {
    self.connect($!gtk-se, 'next-match');
  }

  method Previous-Match is also<Previous_Match> {
    self.connect($!gtk-se, 'previous-match');
  }

  method Search-Changed is also<Search_Changed> {
    self.connect($!gtk-se, 'search-changed');
  }

  method Search-Started is also<Search_Started> {
    self.connect($!gtk-se, 'search-started');
  }

  method Stop-Search is also<Stop_Search> {
    self.connect($!gtk-se, 'stop-search');
  }

  method get_key_capture_widget (
    :$raw = False,
    :quick(:$fast) = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-key-capture-widget>
  {
    returnProperWidget(
      gtk_search_entry_get_key_capture_widget($!gtk-se),
      $raw,
      $proper
    );
  }

  method get_search_delay is also<get-search-delay> {
    gtk_search_entry_get_search_delay($!gtk-se);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_search_entry_get_type, $n, $t );
  }

  method set_key_capture_widget (GtkWidget() $widget) is also<set-key-capture-widget> {
    gtk_search_entry_set_key_capture_widget($!gtk-se, $widget);
  }

  method set_search_delay (Int() $delay) is also<set-search-delay> {
    my guint $d = $delay;

    gtk_search_entry_set_search_delay($!gtk-se, $d);
  }

}

INIT {
  my \O = GTK::SearchEntry;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}


### /usr/src/gtk4/gtk/gtksearchentry.h

sub gtk_search_entry_get_key_capture_widget (GtkSearchEntry $entry)
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_entry_get_search_delay (GtkSearchEntry $entry)
  returns guint
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_entry_get_type
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_entry_new
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_entry_set_key_capture_widget (
  GtkSearchEntry $entry,
  GtkWidget      $widget
)
  is      native(gtk4)
  is      export
{ * }

sub gtk_search_entry_set_search_delay (
  GtkSearchEntry $entry,
  guint          $delay
)
  is      native(gtk4)
  is      export
{ * }

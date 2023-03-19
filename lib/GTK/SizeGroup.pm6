use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::SizeGroup:ver<4>;

use GLib::GSList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSizeGroupAncestry is export of Mu
  where GtkSizeGroup | GtkBuildable | GObject;

class GTK::SizeGroup:ver<4> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Buildable;

  has GtkSizeGroup $!gtk-sg is implementor;

  submethod BUILD ( :$gtk-size-group ) {
    self.setGtkSizeGroup($gtk-size-group) if $gtk-size-group
  }

  method setGtkSizeGroup (GtkSizeGroupAncestry $_) {
    my $to-parent;

    $!gtk-sg = do {
      when GtkSizeGroup {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkBuildable {
        $to-parent = cast(GObject, $_);
        $gtk-b     = $_;
        cast(GtkSizeGroup, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkSizeGroup, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkBuildable;
  }

  method GTK::Raw::Definitions::GtkSizeGroup
    is also<GtkSizeGroup>
  { $!gtk-sg }

  multi method new (GtkSizeGroupAncestry $gtk-size-group, :$ref = True) {
    return unless $gtk-size-group;

    my $o = self.bless( :$gtk-size-group );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $mode, *%a) {
    my GtkSizeGroupMode $m = $mode;

    my $gtk-size-group = gtk_size_group_new($m);

    my $o = $gtk-size-group ?? self.bless( :$gtk-size-group ) !! Nil;
    $o.setAtributes(%a);
    $o;
  }

  # Type: GTKSizeGroupMode
  method mode ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkSizeGroupMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkSizeGroupModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSizeGroupMode) = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  method add_widget (GtkWidget() $widget)
    is also<
      add-widget
      add
    >
  {
    #self.addBuildableChild($widget)
    gtk_size_group_add_widget($!gtk-sg, $widget);
  }

  method get_mode ( :$enum = True ) is also<get-mode> {
    my $m = gtk_size_group_get_mode($!gtk-sg);
    return $m unless $enum;
    GtkSizeGroupModeEnum($m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_size_group_get_type, $n, $t );
  }

  method get_widgets (
    :$raw           = False,
    :$glist         = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-widgets>
  {
    my $wl = gtk_size_group_get_widgets($!gtk-sg),
    return $raw && $glist;
    $wl = returnGSList($wl, $raw, $glist);
    return $wl if $glist;
    $wl.map({ returnProperWidget($_, $raw, $proper) });
  }

  method remove_widget (GtkWidget() $widget)
    is also<
      remove-widget
      remove
    >
  {
    #self.removeBuildableChild($widget);
    gtk_size_group_remove_widget($!gtk-sg, $widget);
  }

  method set_mode (Int() $mode) is also<set-mode> {
    my GtkSizeGroupMode $m = $mode;

    gtk_size_group_set_mode($!gtk-sg, $m);
  }

}

BEGIN {
  use JSON::Fast;

  my %widgets;
  my \O = GTK::SizeGroup;
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
  my \O = GTK::SizeGroup;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Buildable:ver<4>;

use GLib::Array;

use GTK::Roles::Implementor;
use GTK::Roles::Object;

role GTK::Roles::Buildable:ver<4> {
  has GtkBuildable $!gtk-b is implementor;

  method roleInit-GtkBuildable is also<roleInit_GtkBuildable> {
    return if $!gtk-b;

    my \i = findProperImplementor(self.^attributes);
    $!gtk-b = cast( GtkBuildable, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkBuildable
  { $!gtk-b }
  method GtkBuildable
  { $!gtk-b }

  method get_buildable_id
    is also<
      get-buildable-id
      buildable_id
      buildable-id
    >
  {
    gtk_buildable_get_buildable_id($!gtk-b);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_buildable_get_type, $n, $t );
  }

}

our subset GtkBuildableAncestry is export of Mu
  where GtkBuildable | GObject;

class GTK::Buildable {
  also does GLib::Roles::Object;
  also does GLib::Roles::Buildable;

  submethod BUILD ( :$gtk-buildable ) {
    self.setGtkBuildable($gtk-buildable) if $gtk-buildable
  }

  method setGtkBuildable (GtkBuildableAncestry $_) {
    my $to-parent;

    $!gtk-b = do {
      when GtkBuildable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkBuildable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GtkBuildableAncestry $gtk-buildable, :$ref = True) {
    return unless $gtk-buildable;

    my $o = self.bless( :$gtk-buildable );
    $o.ref if $ref;
    $o;
  }

}


our subset GtkBuildableParseContextAncestry is export of Mu
  where GtkBuildableParseContext | GObject;

class GTK::Buildable::ParseContext {
  has GtkBuildableParseContext $!gtk-b-pc is implementor;

  submethod BUILD ( :$gtk-buildable ) {
    self.setGtkBuildableParseContext($gtk-buildable) if $gtk-buildable
  }

  method setGtkBuildableParseContext (GtkBuildableParseContextAncestry $_) {
    my $to-parent;

    $!gtk-b-pc = do {
      when GtkBuildableParseContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkBuildableParseContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  submethod BUILD ( :$gtk-buildable-context ) {
    $!gtk-b-pc = $gtk-buildable-context if $gtk-builable-context;
  }

  method GTK::Raw::Definitions::GtkParseContext
    is also<GtkParseContext>
  { $!gtk-pc }

  method get_element is also<get-element> {
    gtk_buildable_parse_context_get_element($!gtk-b);
  }

  method get_element_stack ( :$raw = False, :$array = True )
    is also<get-element-stack>
  {
    my $sa = gtk_buildable_parse_context_get_element_stack($!gtk-b);
    return $sa if $raw;
    $sa = GLib::Array::String.new($sa);
    return $sa unless $array;
    $sa.Array;
  }

  method get_position ($line_number is rw, $char_number is rw)
    is also<get-position>
    my gint ($l, $c) = 0 xx 2;

    gtk_buildable_parse_context_get_position($!gtk-b, $l, $c);
  }

  method parse_context_pop is also<parse-context-pop> {
    gtk_buildable_parse_context_pop($!gtk-b);
  }

  method parse_context_push (
    GtkBuildableParser()       $parser,
    gpointer                   $user_data
  )
    is also<parse-context-push>
  {
    gtk_buildable_parse_context_push($!gtk-b, $parser, $user_data);
  }

}

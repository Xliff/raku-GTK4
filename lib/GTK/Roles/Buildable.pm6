use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Buildable:ver<4>;

use GLib::Array;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GTK::Roles::Buildable:ver<4> {
  has GtkBuildable $!gtk-b is implementor;

  has @!children;

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

  method toBuilderString ($i = 0) {
    my $children = '';
    if +@!children {
      $children = "\n" ~ @!children.map({
        next unless $_;
        .toBuilderString($i++)
      }).join("\n").&indent($i.succ * 2);
    }

    my @properties = gather for self.listProperties {
      my $p = self."$_"();
      return unless $p;
      take [~](
        $p ~~ Str ?? "<property name=\"{ $_ }\" translatable=\"yes\">"
                  !! "<property name=\"{ $_ }\">",
        "{ $p }</property>"
      );
    }

    my $intro = '';
    $intro = q«<?xml version="1.0" encoding="UTF-8"?>\n<interface>» unless $i;

    my $outtro = '';
    $outtro = "\n</interface>";

    qq:to/OBJECT/;
      { $intro
      }<object class="{ self.getClass.name }">
        { @properties.join("\n").&indent($i.succ * 2) }{
          $children }
      </object>{
      $outtro }
      OBJECT
  }

  method addBuildableChild (GTK::Widget $child) {
    @!children.push: $child;
  }

  method indexOfBuildableChild (GTK::Widget $child) {
    @!children.first( +* == +$child, :k );
  }

  method removeBuildableChild (GTK::Widget $child) {
    @!children.splice( self.indexOfBuildableChild($child), 1 );
  }

  method insertBuildableChild (GTK::Widget $child, Int() $pos) {
    @!children.splice($pos, 1, $child);
  }

  method prependBuildableChild (GTK::Widget $child) {
    @!children.unshift($child);
  }

  method reorderBuildableChild (GTK::Widget $child, Int() $pos) {
    self.insertBuildableChild(self.removeBuildableChild($child), $pos);
  }

}

our subset GtkBuildableAncestry is export of Mu
  where GtkBuildable | GObject;

class GTK::Buildable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Buildable;

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

class GTK::Buildable::ParseContext {
  has GtkBuildableParseContext $!gtk-b-pc is implementor;

  submethod BUILD ( :$gtk-buildable-context ) {
    $!gtk-b-pc = $gtk-buildable-context if $gtk-buildable-context;
  }

  method GTK::Raw::Definitions::GtkParseContext
    is also<GtkParseContext>
  { $!gtk-b-pc }

  multi method new (
    GtkBuildableParseContext  $gtk-buildable-context,
                             :$ref                    = True
   ) {
    return unless $gtk-buildable-context;

    my $o = self.bless( :$gtk-buildable-context );
    $o.ref if $ref;
    $o;
  }

  method get_element is also<get-element> {
    gtk_buildable_parse_context_get_element($!gtk-b-pc);
  }

  method get_element_stack ( :$raw = False, :$array = True )
    is also<get-element-stack>
  {
    my $sa = gtk_buildable_parse_context_get_element_stack($!gtk-b-pc);
    return $sa if $raw;
    $sa = GLib::Array::String.new($sa);
    return $sa unless $array;
    $sa.Array;
  }

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position {
    samewith($, $);
  }
  multi method get_position ($line_number is rw, $char_number is rw) {
    my gint ($l, $c) = 0 xx 2;

    gtk_buildable_parse_context_get_position($!gtk-b-pc, $l, $c);
    ($line_number, $char_number) = ($l, $c);
  }

  method parse_context_pop is also<parse-context-pop> {
    gtk_buildable_parse_context_pop($!gtk-b-pc);
  }

  method parse_context_push (
    GtkBuildableParser()       $parser,
    gpointer                   $user_data
  )
    is also<parse-context-push>
  {
    gtk_buildable_parse_context_push($!gtk-b-pc, $parser, $user_data);
  }

}

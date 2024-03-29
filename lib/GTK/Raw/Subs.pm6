use v6.c;

use NativeCall;

use GLib::Raw::Subs;
use GLib::Raw::Object;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Subs:ver<4>;

our %widget-types is export;

multi sub returnProperWidget (
   $object,
  :$raw           = False,
  :quick(:$fast)  = False,
  :slow(:$proper) = $fast.not,
  :$base          = GLib::Object;
)
  is export
{
  say "1 - Obj: { $object // 'NONE' }, Raw: { $raw }, Proper: { $proper }";
  return Nil unless $object.defined;

  my $o = ($object ~~ GObject) ?? $object !! cast(GObject, $object);

  if $proper {
    if %widget-types{ $o.g_type_instance.g_class.g_type } -> $ot {
      return propReturnObject( $o, $raw, |$ot<pair> );
    }
  }
  propReturnObject($o, $raw, $base.getTypePair);
}

multi sub returnProperWidget ($object, $raw, $proper) is export {
  say "0 - Obj: { $object // 'NONE' }, Raw: { $raw }, Proper: { $proper }";
  returnProperWidget($object, :$raw, :$proper)
}

sub invoke-vfunc ($pointer, &ROUTINE, *@args) is export {
  # cw: This routine takes the function pointer $pointer,
  #     casts it to a callable matching &ROUTINE.signature
  #     and invokes said callable with the arguments in @args
}

sub setGStrV ( $val is copy, $routine = callframe(2).code.name ) is export {
  $val .= Array if $val.^can('Array');
  $val = ArrayToCArray(Str, $val) if $val ~~ Array;
  X::GLib::InvalidArgument.new(
    message => "Invalid argument of type { $val.^name } passed to {
                $routine }!"
  ).throw unless $val ~~ CArray[Str];
  $val;
}

proto sub getPodSection (|)
  is export
{ * }

multi sub getPodSection ($pod, *@sections) {
  samewith($pod, @sections);
}
multi sub getPodSection ($pod, @sections) {
  my %sections;
  for $pod.grep( *.name eq @sections.any ).Array {
    # This may not always be true. Keep up with POD spec!
    %sections{ .name } //= $_.contents.map( *.contents[0] ).join("\n");
  }
  |%sections{ @sections }
}

# cw: Probably better in GLib
sub takeIntOrArray ($v is copy, $routine-name, :$size = 2, :$type = Int)
  is export
{
  $v .= Int         if $v.^can('Int')   && $v !~~ Cool;
  $v  = $v xx $size if $v ~~ Int;
  $v .= Array       if $v.^can('Array') && ($v ~~ Seq || $v !~~ Cool);

  X::GLib::UnknownType.new(
    message => "Value is of incorrect type. Contains ({
      $v.map( *.^name ).sort.unique.join(', ') }) and must be {
      $type.^name }"
  ).throw unless $v.all ~~ $type;

  X::GLib::InvalidSize.new(
    message => "Value passed to .{ $routine-name } must be Int-compatible or {
                '' } Array-compatible with only { $size } -elements!"
  ).throw unless $v.elems == $size;
  $v;
}

sub resolveGdkActions (
  :$ask,
  :$copy,
  :$link,
  :$move,
  :$all
)
  is export
{
  my $actions = 0;
  $actions +|= GDK_ACTION_ASK  if $ask  || $all;
  $actions +|= GDK_ACTION_COPY if $copy || $all;
  $actions +|= GDK_ACTION_LINK if $link || $all;
  $actions +|= GDK_ACTION_MOVE if $move || $all;
  $actions;
}

sub hop (@a, Int() $num, Int() :$skip = 0, :$partial) is export {
  die 'Cannot skip more than the number you are hopping!' if $skip >= $num;
  return @a if $num == 1;
  @a.rotor($num, :$partial).map({
    my $a = $_;
    $a .= skip($skip) if $skip;
    $a.head
  });
}

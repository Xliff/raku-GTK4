use v6.c;

use GLib::Raw::Subs;
use GLib::Raw::Object;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Subs:ver<4>;

our %widget-types is export;

sub returnProperWidget (
   $object,
  :$raw                   = False,
  :quick(:$fast)          = False,
  :slow(:$proper)         = $fast.not
)
  is export
{
  my $o = ($object ~~ GObject) ?? $object !! cast(GObject, $object);

  if $proper {
    if %widget-types{ $o.g_type_instance.g_class.g_type } -> $ot {
      return propReturnObject( $o, $raw, |$ot<pair> );
    }
  }
  propReturnObject(
     $o,
     $raw,
    |%widget-types<GTK::Widget><pair>
  );
}

sub invoke-vfunc ($pointer, &ROUTINE, *@args) is export {
  # cw: This routine takes the function pointer $pointer,
  #     casts it to a callable matching &ROUTINE.signature
  #     and invokes said callable with the arguments in @args
}

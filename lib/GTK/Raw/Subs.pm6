use v6.c;

use GLib::Raw::Subs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Subs:ver<4>;

our has %widget-types is export;

sub returnProperWidget (
   $object,
  :$raw                   = False,
  :quick(:$fast)          = False,
  :slow(:$proper)         = $fast.not
)
  is export
{
  my $o = $o ~~ $GObject ?? $o !! cast(GObject, $o);
  unless $proper {
    if %widget-types{ $object.g_type_instance.g_class.g_type } -> $ot {
      return returnProperObject(
        $raw,
        |%widget-types{$ot}<pair>
      );
    }
  }
  returnProperObject(
    $raw.
    |GTK::Widget.getTypePair
  );
}

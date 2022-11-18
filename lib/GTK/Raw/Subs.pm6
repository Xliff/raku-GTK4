use v6.c;

use GLib::Raw::Subs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;

unit package GTK::Raw::Subs:ver<4>;

our has %widget-types is export;

sub returnProperWidget(
  :quick(:$fast)  = False,
  :$raw           = False,
  :slow(:$proper) = $fast.not
) {
  # ...
}

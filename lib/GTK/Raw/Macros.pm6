use v6.c;

use experimental :macros;

use GLib::Raw::Macros;

unit package GTK::Raw::Macros:ver<4>;

macro WIDGET-TYPE-RESOLVER (\T) is export {
  TYPE-RESOLVER(T, 'widget-types.json');
}

use v6.c;

unit package GTK::Raw::Exports:ver<4>;

our @gtk4-exports is export;

BEGIN {
  @gtk4-exports = <
    GTK::Raw::Definitions
    GTK::Raw::Enums
    GTK::Raw::Structs
    GTK::Raw::Subs
  >;
}

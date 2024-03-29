use v6.c;

use GTK::Button::Check;

# cw: When using smartmatching, do NOT use GTK::CheckButton.
#     All GTK::CheckButtons are GTK::Button::Check. The converse
#     is NOT true.

class GTK::CheckButton:ver<4> is GTK::Button::Check:ver<4> {
  # cw: TIMTWODI
  #
  # has GTK::Button::Check $!gtk-check-button-alias is built handles(*);
  #
  # submethod BUILD ( :$!gtk-check-button-alias ) { }
  #
  # proto method new (|) {
  #   my $gtk-check-button-alias = {*};
  #
  #   $gtk-check-button-alias ?? self.bless( :$gtk-check-button-alias ) !! Nil;
  # }
}

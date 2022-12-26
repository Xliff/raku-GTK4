use v6.c;

use GTK::Button::Toggle;

class GTK::ToggleButton:ver<4> is GTK::Button::Toggle:ver<4> {
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

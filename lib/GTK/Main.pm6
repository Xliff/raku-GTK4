use v6.c;

use GTK::Raw::Main:ver<4>;

class GTK::Main {

  method init {
    gtk_init;
  }

}

INIT GTK::Main.init;

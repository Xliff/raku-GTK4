use GTK::Raw::Types;

class GTK::Enums::Position:ver<4> {

  method get_type {
    state ($n, $t);

    sub gtk_position_type_get_type
      returns GType
      is      native(gtk4)
    { * }

    unstable_get_type( self.^name, &gtk_position_type_get_type, $n, $t );
  }

}

class GTK::Enums::TextWindowType:ver<4> {

  method get_type {
    state ($n, $t);

    sub gtk_text_window_type_get_type
      returns GType
      is      native(gtk4)
    { * }

    unstable_get_type( self.^name, &gtk_text_window_type_get_type, $n, $t );
  }

}

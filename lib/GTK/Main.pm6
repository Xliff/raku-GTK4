use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Main:ver<4>;

use Pango::Language;

class GTK::Main:ver<4> {

  method init {
    gtk_init;
  }

  method disable_setlocale is also<disable-setlocale> {
    gtk_disable_setlocale
  }

  method get_default_language ( :$raw = True )
    is also<
      get-default-language
      default_language
      default-language
    >
  {
    propReturnObject(
      gtk_get_default_language,
      $raw,
      |Pango::Language.getTypePair
    );
  }

  method get_locale_direction ( :$enum = True )
    is also<
      get-locale-direction
      locale_direction
      locale-direction
    >
  {
    my $d = gtk_get_locale_direction;
    return $d unless $enum;
    GtkTextDirectionEnum($d);
  }

  method init_check is also<init-check> {
    gtk_init_check
  }

  method is_initialized is also<is-initialized> {
    gtk_is_initialized
  }

}

use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Dialog::About:ver<4>;

use GTK::Window:ver<4>;

use GLib::Roles::Implementor;
use GDK::Roles::Paintable;

our subset GtkAboutDialogAncestry is export of Mu
  where GtkAboutDialog | GtkWindowAncestry;

class GTK::Dialog::About:ver<4> is GTK::Window:ver<4> {
  has GtkAboutDialog $!gtk-d-a is implementor;

  submethod BUILD ( $gtk-about-dialog ) {
    self.setGtkAboutDialog($gtk-about-dialog) if $gtk-about-dialog
  }

  method setGtkAboutDialog (GtkAboutDialogAncestry $_) {
    my $to-parent;

    $!gtk-d-a = do {
      when GtkAboutDialog {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAboutDialog, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method GTK::Raw::Definitions::GtkAboutDialog
    is also<GtkAboutDialog>
  { $!gtk-d-a }

  multi method new (
    $gtk-about-dialog where * ~~ GtkAboutDialogAncestry,

    :$ref = True
  ) {
    return unless $gtk-about-dialog;

    my $o = self.bless( :$gtk-about-dialog );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-about-dialog = gtk_about_dialog_new();

    $gtk-about-dialog ?? self.bless( :$gtk-about-dialog ) !! Nil;
  }

  # Type: GtkStrv
  method artists ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('artists', $gv);
        my $sa = cast(CArray[Str], $gv.boxed);
        return $sa if $raw;
        CArrayToArray($sa);
      },
      STORE => -> $,  $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('artists', $gv);
      }
    );
  }

  # Type: GtkStrv
  method authors ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('authors', $gv);
        my $sa = cast(CArray[Str], $gv.boxed);
        return $sa if $raw;
        CArrayToArray($sa);
      },
      STORE => -> $,  $val is copy {
        $gv.boxed = setGStrV($val);
        self.prop_set('authors', $gv);
      }
    );
  }

  # Type: string
  method comments is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('comments', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('comments', $gv);
      }
    );
  }

  # Type: string
  method copyright is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('copyright', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('copyright', $gv);
      }
    );
  }

  # Type: GtkStrv
  method documenters ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('documenters', $gv);
        my $sa = cast(CArray[Str], $gv.boxed);
        return $sa if $raw;
        CArrayToArray($sa);
      },
      STORE => -> $, $val is copy {
        $val .= Array if $val.^can('Array');
        $val = ArrayToCArray(Str, $val) if $val ~~ Array;
        X::GLib::InvalidArgument.new(
          message => "Invalid argument of type { $val.^name } passed to {
                      &?ROUTINE.name }!"
        ).throw unless $val ~~ CArray[Str];
        $gv.boxed = $val;
        self.prop_set('documenters', $gv);
      }
    );
  }

  # Type: string
  method license is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('license', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('license', $gv);
      }
    );
  }

  # Type: GtkLicense
  method license-type ( :$enum = True )
    is rw
    is g-property
    is also<license_type>
  {
    my $gv = GLib::Value.new-enum( GtkLicense );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('license-type', $gv);
        my $l = $gv.enum;
        return $l unless $enum;
        GtkLicenseEnum($l);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkLicense) = $val;
        self.prop_set('license-type', $gv);
      }
    );
  }

  # Type: GtkPaintable
  method logo ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Paintable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('logo', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Paintable.getTypePair
        );
      },
      STORE => -> $, GdkPaintable() $val is copy {
        $gv.object = $val;
        self.prop_set('logo', $gv);
      }
    );
  }

  # Type: string
  method logo-icon-name is rw  is g-property is also<logo_icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('logo-icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('logo-icon-name', $gv);
      }
    );
  }

  # Type: string
  method program-name is rw  is g-property is also<program_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('program-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('program-name', $gv);
      }
    );
  }

  # Type: string
  method system-information is rw  is g-property is also<system_information> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('system-information', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('system-information', $gv);
      }
    );
  }

  # Type: string
  method translator-credits is rw  is g-property is also<translator_credits> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('translator-credits', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('translator-credits', $gv);
      }
    );
  }

  # Type: string
  method version is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('version', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('version', $gv);
      }
    );
  }

  # Type: string
  method website is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('website', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('website', $gv);
      }
    );
  }

  # Type: string
  method website-label is rw  is g-property is also<website_label> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('website-label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('website-label', $gv);
      }
    );
  }

  # Type: boolean
  method wrap-license is rw  is g-property is also<wrap_license> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-license', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('wrap-license', $gv);
      }
    );
  }

  method Activate-Link {
    self.connect-string($!gtk-d-a, 'activate-link');
  }

  proto method add_credit_section (|)
    is also<add-credit-section>
  { * }

  multi method add_credit_section (Str() $section_name, @people) {
    samewith( $section_name, ArrayToCArray(Str, @people, :null) );
  }
  multi method add_credit_section (
    Str()          $section_name,
    CArray[Str]    $people
  ) {
    gtk_about_dialog_add_credit_section($!gtk-d-a, $section_name, $people);
  }

  method get_artists is also<get-artists> {
    CArrayToArray( gtk_about_dialog_get_artists($!gtk-d-a) );
  }

  method get_authors is also<get-authors> {
    CArrayToArray( gtk_about_dialog_get_authors($!gtk-d-a) )
  }

  method get_comments is also<get-comments> {
    gtk_about_dialog_get_comments($!gtk-d-a);
  }

  method get_copyright is also<get-copyright> {
    gtk_about_dialog_get_copyright($!gtk-d-a);
  }

  method get_documenters is also<get-documenters> {
    CArrayToArray( gtk_about_dialog_get_documenters($!gtk-d-a) )
  }

  method get_license is also<get-license> {
    gtk_about_dialog_get_license($!gtk-d-a);
  }

  method get_license_type is also<get-license-type> {
    gtk_about_dialog_get_license_type($!gtk-d-a);
  }

  method get_logo ( :$raw = False ) is also<get-logo> {
    propReturnObject(
      gtk_about_dialog_get_logo($!gtk-d-a),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method get_logo_icon_name is also<get-logo-icon-name> {
    gtk_about_dialog_get_logo_icon_name($!gtk-d-a);
  }

  method get_program_name is also<get-program-name> {
    gtk_about_dialog_get_program_name($!gtk-d-a);
  }

  method get_system_information is also<get-system-information> {
    gtk_about_dialog_get_system_information($!gtk-d-a);
  }

  method get_translator_credits is also<get-translator-credits> {
    gtk_about_dialog_get_translator_credits($!gtk-d-a);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_about_dialog_get_type, $n, $t );
  }

  method get_version ( :$version = True, :$parts = False )
    is also<get-version>
  {
    my $v = gtk_about_dialog_get_version($!gtk-d-a);
    return $v unless $version;
    if $v ~~ / 'v' $<maj>=\d+ '.' $<min>=\d+ [ '.' $<mic>=\d+ ] / {
      return $parts ?? |$/<maj min mic>.map( *.Str ).cache
                    !! Version.new($v);
    }
    $v;
  }

  method get_website is also<get-website> {
    gtk_about_dialog_get_website($!gtk-d-a);
  }

  method get_website_label is also<get-website-label> {
    gtk_about_dialog_get_website_label($!gtk-d-a);
  }

  method get_wrap_license is also<get-wrap-license> {
    gtk_about_dialog_get_wrap_license($!gtk-d-a);
  }

  # method gtk_show_about_dialog (Str       $first_property_name) {
  #   gtk_show_about_dialog($!gtk-d-a, $first_property_name);
  # }

  proto method set_artists (|)
    is also<set-artists>
  { * }

  multi method set_artists (@artists) {
    samewith( ArrayToCArray(Str, @artists, :null) );
  }
  multi method set_artists (CArray[Str] $artists) {
    gtk_about_dialog_set_artists($!gtk-d-a, $artists);
  }

  proto method set_authors (|)
    is also<set-authors>
  { * }
  multi method set_authors (@authors) {
    samewith( ArrayToCArray(Str, @authors, :null) );
  }
  multi method set_authors (CArray[Str] $authors) {
    gtk_about_dialog_set_authors($!gtk-d-a, $authors);
  }

  method set_comments (Str() $comments) is also<set-comments> {
    gtk_about_dialog_set_comments($!gtk-d-a, $comments);
  }

  method set_copyright (Str() $copyright) is also<set-copyright> {
    gtk_about_dialog_set_copyright($!gtk-d-a, $copyright);
  }

  proto method set_documenters (|)
    is also<set-documenters>
  { * }

  multi method set_documenters (@documenters) {
    samewith( ArrayToCArray(Str, @documenters, :null) );
  }
  multi method set_documenters (CArray[Str] $documenters) {
    gtk_about_dialog_set_documenters($!gtk-d-a, $documenters);
  }

  method set_license (Str() $license) is also<set-license> {
    gtk_about_dialog_set_license($!gtk-d-a, $license);
  }

  method set_license_type (Int() $license_type) is also<set-license-type> {
    my GtkLicense $l = $license_type;

    gtk_about_dialog_set_license_type($!gtk-d-a, $l);
  }

  method set_logo (GdkPaintable() $logo) is also<set-logo> {
    gtk_about_dialog_set_logo($!gtk-d-a, $logo);
  }

  method set_logo_icon_name (Str() $icon_name) is also<set-logo-icon-name> {
    gtk_about_dialog_set_logo_icon_name($!gtk-d-a, $icon_name);
  }

  method set_program_name (Str() $name) is also<set-program-name> {
    gtk_about_dialog_set_program_name($!gtk-d-a, $name);
  }

  method set_system_information (Str() $system_information)
    is also<set-system-information>
  {
    gtk_about_dialog_set_system_information($!gtk-d-a, $system_information);
  }

  method set_translator_credits (Str() $translator_credits)
    is also<set-translator-credits>
  {
    gtk_about_dialog_set_translator_credits($!gtk-d-a, $translator_credits);
  }

  method set_version (Str() $version) is also<set-version> {
    gtk_about_dialog_set_version($!gtk-d-a, $version);
  }

  method set_website (Str() $website) is also<set-website> {
    gtk_about_dialog_set_website($!gtk-d-a, $website);
  }

  method set_website_label (Str() $website_label) is also<set-website-label> {
    gtk_about_dialog_set_website_label($!gtk-d-a, $website_label);
  }

  method set_wrap_license (Int() $wrap_license) is also<set-wrap-license> {
    my gboolean $w = $wrap_license.so.Int;

    gtk_about_dialog_set_wrap_license($!gtk-d-a, $w);
  }

}

# BEGIN {
#   use JSON::Fast;
#
#   my %widgets;
#   my \O = GTK::Dialog::About;
#
# }

INIT {
  my \O = GTK::Dialog::About;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}

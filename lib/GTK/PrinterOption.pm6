use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::PrinterOption:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkPrinterOptionAncestry is export of Mu
  where GtkPrinterOption | GObject;

class GTK::PrinterOption:ver<4> {
  also does GLib::Roles::Object;

  has GtkPrinterOption $!gtk-po is implementor;

  submethod BUILD ( :$gtk-printer-option ) {
    self.setGtkPrinterOption($gtk-printer-option) if $gtk-printer-option;
  }

  method setGtkPrinterOption (GtkPrinterOptionAncestry $_) {
    my $to-parent;

    $!gtk-po = do {
      when GtkPrinterOption {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrinterOption, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrinterOption
    is also<GtkPrinterOption>
  { $!gtk-po }

  multi method new (
     $gtk-printer-option where * ~~ GtkPrinterOptionAncestry,

    :$ref = True
  ) {
    return unless $gtk-printer-option ;

    my $o = self.bless( :$gtk-printer-option );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, Str() $display_text, Int() $type) {
    my GtkPrinterOptionType $t = $type;

    my $gtk-printer-option = gtk_printer_option_new($name, $display_text, $t);

    $gtk-printer-option ?? self.bless( :$gtk-printer-option ) !! Nil;
  }

  method allocate_choices (Int() $num) is also<allocate-choices> {
    my gint $n = $num;

    gtk_printer_option_allocate_choices($!gtk-po, $n);
  }

  proto method choices_from_array (|)
    is also<choices-from-array>
  { * }

  multi method choices_from_array (@choices, @choices-display) {
    warn '@choices and @choices-display have different sizes!'
      unless +@choices == +@choices-display;

    samewith(
      min( +@choices, +@choices-display ),
      ArrayToCArray(Str, @choices),
      ArrayToCArray(Str, @choices-display)
    );
  }
  multi method choices_from_array (
    Int()       $num_choices,
    CArray[Str] $choices,
    CArray[Str] $choices_display
  ) {
    my gint $n = $num_choices;

    gtk_printer_option_choices_from_array(
      $!gtk-po,
      $num_choices,
      $choices,
      $choices_display
    );
  }

  method clear_has_conflict is also<clear-has-conflict> {
    gtk_printer_option_clear_has_conflict($!gtk-po);
  }

  method get_activates_default is also<get-activates-default> {
    so gtk_printer_option_get_activates_default($!gtk-po);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_printer_option_get_type, $n, $t );
  }

  method has_choice (Str() $choice) is also<has-choice> {
    so gtk_printer_option_has_choice($!gtk-po, $choice);
  }

  method set (Str() $value) {
    gtk_printer_option_set($!gtk-po, $value);
  }

  method set_activates_default (Int() $activates)
    is also<set-activates-default>
  {
    my gboolean $a = $activates.so.Int;

    gtk_printer_option_set_activates_default($!gtk-po, $a);
  }

  method set_boolean (Int() $value) is also<set-boolean> {
    my gboolean $v = $value.so.Int;

    gtk_printer_option_set_boolean($!gtk-po, $v);
  }

  method set_has_conflict (Int() $has_conflict) is also<set-has-conflict> {
    my gboolean $h = $has_conflict.so.Int;

    gtk_printer_option_set_has_conflict($!gtk-po, $h);
  }

}

use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<4>;
use GTK::Raw::Printer::Option::Set:ver<4>;

use GLib::GList;
use GTK::Printer::Option:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkPrinterOptionSetAncestry is export of Mu
  where GtkPrinterOptionSet | GObject;

class GTK::Printer::Option::Set:ver<4> {
  also does GLib::Roles::Object;

  has GtkPrinterOptionSet $!gtk-pos is implementor;

  submethod BUILD ( :$gtk-printer-option-set ) {
    self.setGtkPrinterOptionSet($gtk-printer-option-set)
      if $gtk-printer-option-set
  }

  method setGtkPrinterOptionSet (GtkPrinterOptionSetAncestry $_) {
    my $to-parent;

    $!gtk-pos = do {
      when GtkPrinterOptionSet {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrinterOptionSet, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrinterOptionSet
    is also<GtkPrinterOptionSet>
  { $!gtk-pos }

  multi method new (
     $gtk-printer-option-set where * ~~ GtkPrinterOptionSetAncestry,

    :$ref = True
  ) {
    return unless $gtk-printer-option-set;

    my $o = self.bless( :$gtk-printer-option-set );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-printer-option-set = gtk_printer_option_set_new();

    $gtk-printer-option-set ?? self.bless( :$gtk-printer-option-set ) !! Nil;
  }

  method add (GtkPrinterOption() $option) {
    gtk_printer_option_set_add($!gtk-pos, $option);
  }

  method clear_conflicts is also<clear-conflicts> {
    gtk_printer_option_set_clear_conflicts($!gtk-pos);
  }

  method foreach (&func, gpointer $user_data = gpointer) {
    gtk_printer_option_set_foreach($!gtk-pos, &func, $user_data);
  }

  method foreach_in_group (
    Str()    $group,
             &func,
    gpointer $user_data = gpointer
  )
    is also<foreach-in-group>
  {
    gtk_printer_option_set_foreach_in_group(
      $!gtk-pos,
      $group,
      &func,
      $user_data
    );
  }

  method get_groups ( :$raw = False, :$glist = False ) is also<get-groups> {
    returnGList(
      gtk_printer_option_set_get_groups($!gtk-pos),
      $raw,
      $glist,
      |GTK::Printer::Option.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_printer_option_set_get_type, $n, $t );
  }

  method lookup (Str() $name) {
    gtk_printer_option_set_lookup($!gtk-pos, $name);
  }

  method remove (GtkPrinterOption() $option) {
    gtk_printer_option_set_remove($!gtk-pos, $option);
  }

}

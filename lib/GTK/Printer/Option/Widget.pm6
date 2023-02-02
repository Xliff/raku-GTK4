use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Printer::Option::Widget:ver<4>;

use GTK::Box:ver<4>;

our subset GtkPrinterOptionWidgetAncestry is export of Mu
  where GtkPrinterOptionWidget | GtkBoxAncestry;

class GTK::Printer::Option::Widget:ver<4> is GTK::Box:ver<4> {
  has GtkPrinterOptionWidget $!gtk-pow is implementor;

  submethod BUILD ( :$gtk-printer-option-widget ) {
    self.setGtkPrinterOptionWidget($gtk-printer-option-widget)
      if $gtk-printer-option-widget
  }

  method setGtkPrinterOptionWidget (GtkPrinterOptionWidgetAncestry $_) {
    my $to-parent;

    $!gtk-pow = do {
      when GtkPrinterOptionWidget {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrinterOptionWidget, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrinterOptionWidget
  { $!gtk-pow }

  multi method new (
     $gtk-printer-option-widget where * ~~ GtkPrinterOptionWidgetAncestry,

    :$ref = True
  ) {
    return unless $gtk-printer-option-widget;

    my $o = self.bless( :$gtk-printer-option-widget );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkPrinterOption() $options = GtkPrinterOption) {
    my $gtk-printer-option-widget = gtk_printer_option_widget_new($options);

    $gtk-printer-option-widget ?? self.bless( :$gtk-printer-option-widget )
                               !! Nil;
  }

  # Type: string
  method id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: GtkPrinterOption
  method source ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Printer::Option.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('source', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::Printer::Option.getTypePair
        );
      },
      STORE => -> $, GtkPrinterOption() $val is copy {
        $gv.object = $val;
        self.prop_set('source', $gv);
      }
    );
  }

  # Type: string
  method string is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('string', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('string', $gv);
      }
    );
  }

  # Is originally:
  # GtkPrinterOptionWidget *widget, gpointer --> void
  method Changed {
    self.connect($!gtk-pow, 'changed');
  }

  method get_external_label (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-external-label>
  {
    returnProperWidget(
      gtk_printer_option_widget_get_external_label($!gtk-pow),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_printer_option_widget_get_type,
      $n,
      $t
    );
  }

  method get_value is also<get-value> {
    gtk_printer_option_widget_get_value($!gtk-pow);
  }

  method has_external_label is also<has-external-label> {
    so gtk_printer_option_widget_has_external_label($!gtk-pow);
  }

  method set_source (GtkPrinterOption() $source) is also<set-source> {
    gtk_printer_option_widget_set_source($!gtk-pow, $source);
  }

}

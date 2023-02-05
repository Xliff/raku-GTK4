use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Printer:ver<4>;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkPrinterAncestry is export of Mu
  where GtkPrinter | GObject;

class GTK::Printer:ver<4> {
  also does GLib::Roles::Object;

  has GtkPrinter $!p is implementor;

  submethod BUILD ( :$gtk-printer ) {
    self.setGtkPrinter($gtk-printer) if $gtk-printer
  }

  method setGtkPrinter (GtkPrinterAncestry $_) {
    my $to-parent;

    $!p = do {
      when GtkPrinter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrinter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrinter
    is also<GtkPrinter>
  { $!p }

  multi method new (
    $gtk-printer where * ~~ GtkPrinterAncestry,

    :$ref = True
  ) {
    return unless $gtk-printer;

    my $o = self.bless( :$gtk-printer );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, GtkPrintBackend() $backend, Int() $virtual) {
    my gboolean $v = $virtual.so.Int;

    my $gtk-printer = gtk_printer_new($name, $backend, $v);

    $gtk-printer ?? self.bless( :$gtk-printer ) !! Nil;
  }

  # Type: boolean
  method accepting-jobs is rw  is g-property is also<accepting_jobs> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accepting-jobs', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'accepting-jobs does not allow writing'
      }
    );
  }

  # Type: boolean
  method accepts-pdf is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accepts-pdf', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accepts-pdf', $gv);
      }
    );
  }

  # Type: boolean
  method accepts-ps is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accepts-ps', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accepts-ps', $gv);
      }
    );
  }

  # Type: GtkPrintBackend
  method backend is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('backend', $gv);
        cast(GtkPrintBackend, $gv.pointer);
      },
      STORE => -> $, GtkPrintBackend() $val is copy {
        $gv.pointer = $val;
        self.prop_set('backend', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'icon-name does not allow writing'
      }
    );
  }

  # Type: boolean
  method is-virtual is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-virtual', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-virtual', $gv);
      }
    );
  }

  # Type: int
  method job-count is rw  is g-property is also<job_count> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('job-count', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'job-count does not allow writing'
      }
    );
  }

  # Type: string
  method location is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('location', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'location does not allow writing'
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: boolean
  method paused is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('paused', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'paused does not allow writing'
      }
    );
  }

  # Type: string
  method state-message is rw  is g-property is also<state_message> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state-message', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'state-message does not allow writing'
      }
    );
  }

  method Details-Acquired is also<Details_Acquired> {
    self.connect-bool($!p, 'details-acquired');
  }

  method accepts_pdf {
    so gtk_printer_accepts_pdf($!p);
  }

  method accepts_ps {
    so gtk_printer_accepts_ps($!p);
  }

  method compare (GtkPrinter() $b) {
    so gtk_printer_compare($!p, $b);
  }

  method get_backend is also<get-backend> {
    gtk_printer_get_backend($!p);
  }

  method get_capabilities ( :set(:$flags) = True ) is also<get-capabilities> {
    my $f = gtk_printer_get_capabilities($!p);
    return $f unless $flags;
    getFlags(GtkPrintCapabilitiesEnum, $f);
  }

  method get_default_page_size is also<get-default-page-size> {
    gtk_printer_get_default_page_size($!p);
  }

  method get_description is also<get-description> {
    gtk_printer_get_description($!p);
  }

  proto method get_hard_margins (|)
    is also<get-hard-margins>
  { * }

  multi method get_hard_margins {
    samewith($, $, $, $);
  }
  multi method get_hard_margins (
    $top    is rw,
    $bottom is rw,
    $left   is rw,
    $right  is rw
  ) {
    my gdouble ($t, $b, $l, $r) = 0e0 xx 4;

    gtk_printer_get_hard_margins($!p, $t, $b, $l, $r);
    ($top, $bottom, $left, $right) = ($t, $b, $l, $r);
  }

  proto method get_hard_margins_for_paper_size (|)
    is also<get-hard-margins-for-paper-size>
  { * }

  multi method get_hard_margins_for_paper_size (Int() $paper_size) {
    samewith($paper_size, $, $, $, $);
  }
  multi method get_hard_margins_for_paper_size (
    Int() $paper_size,
          $top         is rw,
          $bottom      is rw,
          $left        is rw,
          $right       is rw
  ) {
    my GtkPaperSize  $ps             = $paper_size;
    my gdouble      ($t, $b, $l, $r) = 0e0 xx 4;

    gtk_printer_get_hard_margins_for_paper_size($!p, $ps, $t, $b, $l, $r);
    ($top, $bottom, $left, $right) = ($t, $b, $l, $r);
  }

  method get_icon_name is also<get-icon-name> {
    gtk_printer_get_icon_name($!p);
  }

  method get_job_count is also<get-job-count> {
    gtk_printer_get_job_count($!p);
  }

  method get_location is also<get-location> {
    gtk_printer_get_location($!p);
  }

  method get_name is also<get-name> {
    gtk_printer_get_name($!p);
  }

  method get_state_message is also<get-state-message> {
    gtk_printer_get_state_message($!p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_printer_get_type, $n, $t );
  }

  multi method enumerate_printers (
              &func,
    gpointer  $data    = gpointer,
              &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>,
             :$wait    = False
  ) {
    samewith(&func, $data, $wait, &destroy)
  }
  multi method enumerate_printers (
             &func,
    gpointer $data,
             &destroy,
    Int()    $wait
  )
    is also<gtk-enumerate-printers>
    is static
  {
    my gboolean $w = $wait.so.Int;

    gtk_enumerate_printers(&func, $data, &destroy, $w);
  }

  method has_details is also<has-details> {
    so gtk_printer_has_details($!p);
  }

  method is_accepting_jobs is also<is-accepting-jobs> {
    so gtk_printer_is_accepting_jobs($!p);
  }

  method is_active is also<is-active> {
    so gtk_printer_is_active($!p);
  }

  method is_default is also<is-default> {
    so gtk_printer_is_default($!p);
  }

  method is_paused is also<is-paused> {
    so gtk_printer_is_paused($!p);
  }

  method is_virtual {
    so gtk_printer_is_virtual($!p);
  }

  method list_papers ( :$raw = False, :$glist = False ) is also<list-papers> {
    returnGList(
      gtk_printer_list_papers($!p),
      $raw,
      $glist,
      |GTK::Page::Setup.getTypePair
    );
  }

  method request_details is also<request-details> {
    gtk_printer_request_details($!p);
  }
}

class GTK::Print::Capabilities {
  also does GLib::Roles::StaticClass;

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_capabilities_get_type, $n, $t );
  }

}

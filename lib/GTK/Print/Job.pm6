use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Print::Job:ver<4>;

use Cairo;
#use GTK::Printer:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkPrintJobAncestry is export of Mu
  where GtkPrintJob | GObject;

class GTK::Print::Job {
  also does GLib::Roles::Object;

  has GtkPrintJob $!gtk-pj is implementor;

  submethod BUILD ( :$gtk-print-job ) {
    self.setGtkPrintJob($gtk-print-job)
      if $gtk-print-job
  }

  method setGtkPrintJob (GtkPrintJobAncestry $_) {
    my $to-parent;

    $!gtk-pj = do {
      when GtkPrintJob {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPrintJob, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkPrintJob
    is also<GtkPrintJob>
  { $!gtk-pj }

  multi method new ($gtk-print-job where * ~~ GtkPrintJobAncestry , :$ref = True) {
    return unless $gtk-print-job;

    my $o = self.bless( :$gtk-print-job );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GtkPrinter()       $printer,
    GtkPrintSettings() $settings,
    Int()              $page_setup
  ) {
    my GtkPageSetup $p = $page_setup;

    my $gtk-print-job = gtk_print_job_new($printer, $settings, $page_setup);

    $gtk-print-job ?? self.bless( :$gtk-print-job ) !! Nil;
  }

  method collate is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_collate    },
      STORE => -> $, \v { self.set_collate(v) }
  }

  method n_up is rw is g-accessor is also<n-up> {
    Proxy.new:
      FETCH => -> $     { self.get_n_up    },
      STORE => -> $, \v { self.set_n_up(v) }
  }

  method n_up_layout is rw is g-accessor is also<n-up-layout> {
    Proxy.new:
      FETCH => -> $     { self.get_n_up_layout    },
      STORE => -> $, \v { self.set_n_up_layout(v) }
  }

  method num_copies is rw is g-accessor is also<num-copies> {
    Proxy.new:
      FETCH => -> $     { self.get_num_copies    },
      STORE => -> $, \v { self.set_num_copies(v) }
  }

  method page_ranges is rw is g-accessor is also<page-ranges> {
    Proxy.new:
      FETCH => -> $     { self.get_page_ranges    },
      STORE => -> $, \v { self.set_page_ranges(v) }
  }

  method page_set is rw is g-accessor is also<page-set> {
    Proxy.new:
      FETCH => -> $     { self.get_page_set    },
      STORE => -> $, \v { self.set_page_set(v) }
  }

  method pages is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_pages    },
      STORE => -> $, \v { self.set_pages(v) }
  }

  method reverse is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_reverse    },
      STORE => -> $, \v { self.set_reverse(v) }
  }

  method rotate is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_rotate    },
      STORE => -> $, \v { self.set_rotate(v) }
  }

  method scale is rw is g-accessor {
    Proxy.new:
      FETCH => -> $     { self.get_scale    },
      STORE => -> $, \v { self.set_scale(v) }
  }

  method track_print_status is rw is g-accessor is also<track-print-status> {
    Proxy.new:
      FETCH => -> $     { self.get_track_print_status    },
      STORE => -> $, \v { self.set_track_print_status(v) }
  }

  method get_collate is also<get-collate> {
    so gtk_print_job_get_collate($!gtk-pj);
  }

  method get_n_up is also<get-n-up> {
    gtk_print_job_get_n_up($!gtk-pj);
  }

  method get_n_up_layout ( :$enum = True ) is also<get-n-up-layout> {
    my $l = gtk_print_job_get_n_up_layout($!gtk-pj);
    return $l unless $enum;
    GtkNumberUpLayoutEnum($l);
  }

  method get_num_copies is also<get-num-copies> {
    gtk_print_job_get_num_copies($!gtk-pj);
  }

  method get_page_ranges ($n_ranges is rw, :$raw = True)
    is also<get-page-ranges>
  {
    my gint $n = 0;

    my $prb = gtk_print_job_get_page_ranges($!gtk-pj, $n)
      but GLib::Roles::TypedBuffer[GtkPageRange];
    $n_ranges = $n;
    return $prb if $raw;
    $prb.Array;
  }

  method get_page_set ( :$enum = True ) is also<get-page-set> {
    my $s = gtk_print_job_get_page_set($!gtk-pj);
    return $s unless $enum;
    GtkPageSetEnum($s);
  }

  method get_pages ( :$enum = True ) is also<get-pages> {
    my $p = gtk_print_job_get_pages($!gtk-pj);
    return $p unless $enum;
    GtkPrintPagesEnum($p);
  }

  method get_printer ( :$raw = False ) is also<get-printer> {
    propReturnObject(
      gtk_print_job_get_printer($!gtk-pj),
      $raw,
      |GTK::Printer.getTypePair
    );
  }

  method get_reverse is also<get-reverse> {
    so gtk_print_job_get_reverse($!gtk-pj);
  }

  method get_rotate is also<get-rotate> {
    so gtk_print_job_get_rotate($!gtk-pj);
  }

  method get_scale is also<get-scale> {
    gtk_print_job_get_scale($!gtk-pj);
  }

  method get_settings ( :$raw = False ) is also<get-settings> {
    propReturnObject(
      gtk_print_job_get_settings($!gtk-pj),
      $raw,
      |GTK::Print::Settings.getTypePair
    );
  }

  method get_status ( :$enum = True ) is also<get-status> {
    my $s = gtk_print_job_get_status($!gtk-pj);
    return $s unless $enum;
    GtkPrintStatus($s);
  }

  method get_surface (CArray[Pointer[GError]] $error = gerror, :$raw = False)
    is also<get-surface>
  {
    clear_error;
    my $s = propReturnObject(
      gtk_print_job_get_surface($!gtk-pj, $error),
      $raw,
      Cairo::cairo_surface_t,
      Cairo::Surface
    );
    set_error($error);
    $s;
  }

  method get_title is also<get-title> {
    gtk_print_job_get_title($!gtk-pj);
  }

  method get_track_print_status is also<get-track-print-status> {
    so gtk_print_job_get_track_print_status($!gtk-pj);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_print_job_get_type, $n, $t );
  }

  method send (
             &callback,
    gpointer $user_data = gpointer,
             &dnotify   = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gtk_print_job_send($!gtk-pj, &callback, $user_data, &dnotify);
  }

  method set_collate (Int() $collate) is also<set-collate> {
    my gboolean $c = $collate.so.Int;

    gtk_print_job_set_collate($!gtk-pj, $c);
  }

  method set_n_up (Int() $n_up) is also<set-n-up> {
    my guint $n = $n_up;

    gtk_print_job_set_n_up($!gtk-pj, $n);
  }

  method set_n_up_layout (Int() $layout) is also<set-n-up-layout> {
    my GtkNumberUpLayout $l = $layout;

    gtk_print_job_set_n_up_layout($!gtk-pj, $l);
  }

  method set_num_copies (Int() $num_copies) is also<set-num-copies> {
    my gint $n = $num_copies;

    gtk_print_job_set_num_copies($!gtk-pj, $n);
  }

  proto method set_page_ranges (|)
    is also<set-page-ranges>
  { * }

  multi method set_page_ranges (@ranges) {
    samewith(
      GLib::Roles::TypedBuffer[GtkPageRange].new(@ranges).p,
      @ranges.elems
    );
  }
  multi method set_page_ranges (Pointer $ranges, Int() $n_ranges) {
    my gint $n = $n_ranges;

    gtk_print_job_set_page_ranges($!gtk-pj, $ranges, $n);
  }

  method set_page_set (Int() $page_set) is also<set-page-set> {
    my GtkPageSet $p = $page_set;

    gtk_print_job_set_page_set($!gtk-pj, $p);
  }

  method set_pages (Int() $pages) is also<set-pages> {
    my GtkPrintPages $p = $pages;

    gtk_print_job_set_pages($!gtk-pj, $p);
  }

  method set_reverse (Int() $reverse) is also<set-reverse> {
    my gboolean $r = $reverse.so.Int;

    gtk_print_job_set_reverse($!gtk-pj, $r);
  }

  method set_rotate (Int() $rotate) is also<set-rotate> {
    my gboolean $r = $rotate.so.Int;

    gtk_print_job_set_rotate($!gtk-pj, $r);
  }

  method set_scale (Num() $scale) is also<set-scale> {
    my gdouble $s = $scale;

    gtk_print_job_set_scale($!gtk-pj, $s);
  }

  method set_source_fd (
    Int()                   $fd,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-source-fd>
  {
    my gint $f = $fd;

    clear_error;
    gtk_print_job_set_source_fd($!gtk-pj, $f, $error);
    set_error($error);
  }

  method set_source_file (
    Str                     $filename,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<set-source-file>
  {
    clear_error;
    gtk_print_job_set_source_file($!gtk-pj, $filename, $error);
    set_error($error);
  }

  method set_track_print_status (Int() $track_status)
    is also<set-track-print-status>
  {
    my gboolean $t = $track_status.so.Int;

    gtk_print_job_set_track_print_status($!gtk-pj, $t);
  }

}

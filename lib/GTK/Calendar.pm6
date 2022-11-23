use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::Calendar:ver<4>;

use GLib::DateTime;
use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkCalendarAncestry is export of Mu
  where GtkCalendar | GtkWidgetAncestry;

class GTK::Calendar:ver<4> is GTK::Widget:ver<4> {
  has GtkCalendar $!gtk-cal is implementor;

  submethod BUILD ( :$gtk-calendar ) {
    self.setGtkCalendar($gtk-calendar) if $gtk-calendar
  }

  method setGtkCalendar (GtkCalendarAncestry $_) {
    my $to-parent;

    $!gtk-cal = do {
      when GtkCalendar {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCalendar, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method GTK::Raw::Definitions::GtkCalendar
    is also<GtkCalendar>
  { $!gtk-cal }

  multi method new (GtkCalendarAncestry $gtk-calendar, :$ref = True) {
    return unless $gtk-calendar;

    my $o = self.bless( :$gtk-calendar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-calendar = gtk_calendar_new();

    $gtk-calendar ?? self.bless( :$gtk-calendar ) !! Nil;
  }

  # Type: int
  method year is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('year', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('year', $gv);
      }
    );
  }

  # Type: int
  method month is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('month', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('month', $gv);
      }
    );
  }

  # Type: int
  method day is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('day', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('day', $gv);
      }
    );
  }

  # Type: boolean
  method show-heading is rw  is g-property is also<show_heading> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-heading', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-heading', $gv);
      }
    );
  }

  # Type: boolean
  method show-day-names is rw  is g-property is also<show_day_names> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-day-names', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-day-names', $gv);
      }
    );
  }

  # Type: boolean
  method show-week-numbers is rw  is g-property is also<show_week_numbers> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-week-numbers', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-week-numbers', $gv);
      }
    );
}

  method Day-Selected is also<Day_Selected> {
    self.connect($!gtk-cal, 'day-selected');
  }

  method Next-Month is also<Next_Month> {
    self.connect($!gtk-cal, 'next-month');
  }

  method Next-Year is also<Next_Year> {
    self.connect($!gtk-cal, 'next-year');
  }

  method Prev-Month is also<Prev_Month> {
    self.connect($!gtk-cal, 'prev-month');
  }

  method Prev-Year is also<Prev_Year> {
    self.connect($!gtk-cal, 'prev-year');
  }

  method clear_marks is also<clear-marks> {
    gtk_calendar_clear_marks($!gtk-cal);
  }

  method get_date ( :$raw = False ) is also<get-date> {
    propReturnObject(
      gtk_calendar_get_date($!gtk-cal),
      $raw,
      |GLib::DateTime.getTypePair
    );
  }

  method get_day_is_marked (Int() $day) is also<get-day-is-marked> {
    my guint $d = $day;

    so gtk_calendar_get_day_is_marked($!gtk-cal, $d);
  }

  method get_show_day_names is also<get-show-day-names> {
    so gtk_calendar_get_show_day_names($!gtk-cal);
  }

  method get_show_heading is also<get-show-heading> {
    so gtk_calendar_get_show_heading($!gtk-cal);
  }

  method get_show_week_numbers is also<get-show-week-numbers> {
    so gtk_calendar_get_show_week_numbers($!gtk-cal);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_calendar_get_type, $n, $t );
  }

  method mark_day (Int() $day) is also<mark-day> {
    my guint $d = $day;

    gtk_calendar_mark_day($!gtk-cal, $d);
  }

  method select_day (GDateTime() $date) is also<select-day> {
    gtk_calendar_select_day($!gtk-cal, $date);
  }

  method set_show_day_names (Int() $value) is also<set-show-day-names> {
    my gboolean $v = $value;

    gtk_calendar_set_show_day_names($!gtk-cal, $v);
  }

  method set_show_heading (Int() $value) is also<set-show-heading> {
    my gboolean $v = $value.so.Int;

    gtk_calendar_set_show_heading($!gtk-cal, $value);
  }

  method set_show_week_numbers (Int() $value) is also<set-show-week-numbers> {
    my gboolean $v = $value.so.Int;

    gtk_calendar_set_show_week_numbers($!gtk-cal, $value);
  }

  method unmark_day (Int() $day) is also<unmark-day> {
    my guint $d = $day;

    gtk_calendar_unmark_day($!gtk-cal, $d);
  }

}

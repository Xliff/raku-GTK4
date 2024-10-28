use v6.c;

use GTK::Raw::Types;

use GLib::Value;
use GTK::Expression;

use Test;

sub test-value {
  my $expr  = GTK::Expression::Constant.new-for-value( gv_int(22) );
  my $val = GLib::Value.new( GTK::Expression.get_type);
  $val.take-expression($expr);
  ok $val.GValue.g-type == GTK::Expression.get_type;
}

sub MAIN {
  test-value;
}

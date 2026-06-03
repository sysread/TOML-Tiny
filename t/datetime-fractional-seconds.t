use strict;
use warnings;

use Test2::V0;
use TOML::Tiny qw(from_toml);

#-------------------------------------------------------------------------------
# parse_datetime normalized fractional seconds with a float multiplication
# ($frac * 1_000_000_000), which is both lossy and can overflow the 9-digit
# field: ".999999999999999999" rounds to 1_000_000_000 and renders as a bogus
# 10-digit ".1000000000". Normalize by string truncate/pad to nanosecond
# precision instead -- faithful, and never produces an out-of-range fraction.
#
# The default inflate_datetime returns the normalized string, so we assert on
# the parsed value directly.
#-------------------------------------------------------------------------------

sub frac {
  my $input = shift;
  my ($data, $err) = from_toml("t = 1985-04-12T23:20:50${input}Z");
  die "parse failed for '$input': $err" if $err;
  my $v = $data->{t};
  $v =~ /(\.\d+)Z$/ or die "no fractional seconds in '$v'";
  return $1;
}

# Existing behavior: pad shorter fractions out to 9 digits (nanoseconds).
is(frac('.52'),        '.520000000', 'short fraction is zero-padded to 9 digits');
is(frac('.123456789'), '.123456789', 'exactly 9 fractional digits is preserved');
is(frac('.000000001'), '.000000001', 'leading-zero nanoseconds preserved');

# Excess precision is truncated to 9 digits, never rounded or overflowed.
is(frac('.123456789999'),       '.123456789', 'over-precise fraction truncated to 9 digits');
is(frac('.999999999999999999'), '.999999999', 'all-nines fraction truncates, does not overflow to 10 digits');
is(frac('.1234567890000000000000000000001'),
                                 '.123456789', 'absurdly long fraction handled without float error');

done_testing;

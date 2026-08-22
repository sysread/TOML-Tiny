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

# Returns the normalized fractional-seconds portion of a parsed datetime. The
# offset defaults to "Z"; pass a numeric offset (e.g. "+05:30") to exercise the
# substitution's offset-reattachment ($2) branch. The match is anchored on the
# offset, so it also asserts that the offset survives normalization intact.
sub frac {
  my ($input, $offset) = @_;
  $offset //= 'Z';
  my ($data, $err) = from_toml("t = 1985-04-12T23:20:50${input}${offset}");
  die "parse failed for '$input$offset': $err" if $err;
  my $v = $data->{t};
  my $quoted = quotemeta $offset;
  $v =~ /(\.\d+)$quoted$/ or die "no fractional seconds with offset '$offset' in '$v'";
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

# Numeric offsets exercise the $2 reattachment branch: the rewritten fraction
# and the multi-character offset must both survive, with no digit bleed between.
is(frac('.52', '+05:30'),        '.520000000', 'short fraction padded with a positive numeric offset');
is(frac('.52', '-08:00'),        '.520000000', 'short fraction padded with a negative numeric offset');
is(frac('.999999999999999999', '+05:30'),
                                 '.999999999', 'over-precise fraction truncates cleanly with a numeric offset');

done_testing;

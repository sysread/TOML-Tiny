use strict;
use warnings;

use Test2::V0;

#-------------------------------------------------------------------------------
# Regression guard for transient memory amplification on a huge single dotted
# key (a.a.a.....a = 1).
#
# The parser bounds key-path depth, but only AFTER the tokenizer's unbounded
# $Key match has run. Matching a $DottedKey with hundreds of thousands of
# segments makes Perl's regex engine allocate engine state proportional to the
# number of segments -- ~325 MB of transient RSS for a ~1 MB input -- before
# any depth check fires. A ~400x input-to-RSS amplification is a cheap
# memory-exhaustion vector.
#
# The tokenizer must reject an over-limit dotted key BEFORE that match, keeping
# peak RSS growth small. We measure peak RSS via /proc, so the test is
# Linux-only; it is also resource-sensitive, so gate it on AUTHOR_TESTING (CI
# sets it).
#
# Each case carries its own 'max_mb' ceiling, chosen to sit between the
# pre-fix peak and the post-fix peak so the assertion is a real regression
# guard rather than a threshold so loose it can never fail. Measured pre-fix
# (origin/master, unbounded $Key) vs post-fix peaks:
#
#   context        pre-fix   post-fix   ceiling
#   bare key        392 MB     ~0 MB     50 MB
#   inline table     74 MB     ~0 MB     30 MB
#   table header      5 MB     ~0 MB     30 MB
#
# The bare-key and inline-table contexts both exceed their ceilings on the
# unbounded code, so those two assertions genuinely fail without the fix. The
# table-header context never exhibited the large amplification: its leading
# '[' is consumed as an inline-array open before the key match would run, so
# the unbounded $Key never matched the whole key there (pre-fix peak was only
# ~5 MB). Its memory assertion is therefore a forward-looking ceiling, not a
# reproduction of the bug; its primary guarantee is that the over-limit input
# is still rejected with bounded memory.
#-------------------------------------------------------------------------------

BEGIN {
  plan skip_all => 'resource-sensitive; set AUTHOR_TESTING=1 to run'
    unless $ENV{AUTHOR_TESTING};
}

plan skip_all => 'requires Linux /proc/self/status for RSS measurement'
  unless -r '/proc/self/status';

use TOML::Tiny qw(from_toml);

sub peak_rss_kb {
  open my $fh, '<', '/proc/self/status' or return undef;
  while (my $line = <$fh>) {
    return $1 if $line =~ /^VmHWM:\s+(\d+)/;
  }
  return undef;
}

# A 500k-segment dotted key, in each context where the tokenizer matches a key.
# Each source is built as a single ~1 MB string (no large transient list) so the
# only large allocation under test is whatever the parser does. 'depth_msg'
# marks contexts that also produce a clean depth error (the table header gives a
# generic error because its leading '[' is consumed as an inline array before
# the bounded key fails -- memory, the security property, is what this guards).
my $segs = 'a.' x 500_000;
my @cases = (
  { name => 'bare dotted key', depth_msg => 1, max_mb => 50, src => "$segs" . "a = 1" },
  { name => 'inline table key', depth_msg => 1, max_mb => 30, src => "k = { ${segs}a = 1 }" },
  { name => 'table header',     depth_msg => 0, max_mb => 30, src => "[${segs}a]\nz = 1\n" },
);

for my $case (@cases) {
  my $before = peak_rss_kb();
  my ($data, $err) = from_toml($case->{src});
  my $after  = peak_rss_kb();
  my $delta_mb = ($after - $before) / 1024;

  note(sprintf '%s: peak RSS growth %.0f MB (ceiling %d MB)', $case->{name}, $delta_mb, $case->{max_mb});

  ok($err, "$case->{name}: over-limit dotted key is rejected");
  like($err, qr/depth/i, "$case->{name}: rejection mentions depth")
    if $case->{depth_msg};
  ok($delta_mb < $case->{max_mb},
    sprintf('%s: peak memory stays bounded (%.0f MB < %d MB)', $case->{name}, $delta_mb, $case->{max_mb}));
}

done_testing;

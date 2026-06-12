use strict;
use warnings;

use Test2::V0;
use TOML::Tiny::Tokenizer;

#-------------------------------------------------------------------------------
# Regression guard for a quadratic-tokenizer CPU-exhaustion vector.
#
# Parsing a single long line (e.g. one big flat inline array) must scale
# roughly LINEARLY in the number of tokens. A subtle bug in the end-of-line
# match -- an optional comment group in front of the line terminator -- caused
# the regex engine to forward-scan to end-of-string on every token, making a
# single long line O(n^2) and turning a ~1-2 MB document into minutes of CPU.
#
# Absolute wall-clock budgets flake on loaded CI (see t/max-depth.t), so we
# assert on the machine-independent SCALING RATIO instead: quadrupling the
# input should roughly quadruple the work (linear), not multiply it by ~16
# (quadratic). The bug measured ~6x+ here and climbs without bound; linear is
# ~4x, so a threshold of 5.0 sits well above linear-with-noise and well below
# the regression.
#
# We measure CPU time (times()), not wall-clock: the work is CPU-bound, so the
# quadratic shows up identically in CPU time, but CPU time is immune to
# descheduling under the parallel (prove -j4) CI run. Still timing-sensitive,
# so gate on AUTHOR_TESTING.
#-------------------------------------------------------------------------------

BEGIN {
  plan skip_all => 'timing-sensitive; set AUTHOR_TESTING=1 to run'
    unless $ENV{AUTHOR_TESTING};
}

# Drive the tokenizer directly: it is where the quadratic lived, and isolating
# it from the parser gives a cleaner scaling signal. Returns user CPU seconds.
sub tokenize_cpu {
  my $n   = shift;
  my $src = 'k = [' . join(',', (1) x $n) . ']';
  my $tok = TOML::Tiny::Tokenizer->new(source => $src);
  my @t0  = times;
  my $count = 0;
  while (my $token = $tok->next_token) { ++$count }
  my @t1  = times;
  # ~2 tokens per element (value + comma; the last element has no comma) plus
  # the surrounding key/=/[ ]/EOF -- i.e. ~2n+2. The >= 2*$n guard is therefore
  # conservative and just confirms we tokenized the whole line.
  die "tokenized $count tokens, expected ~" . (2 * $n) . "\n"
    unless $count >= 2 * $n;
  return $t1[0] - $t0[0];
}

# The ratio is only meaningful if the baseline is well above the times()
# resolution -- otherwise a near-zero denominator turns measurement noise into a
# spurious failure. Rather than SKIP the real assertion on fast machines (which
# would leave the regression unguarded exactly where the parser is fastest), we
# grow the baseline input until it clears a measurable floor, then assert. Fast
# hardware just runs a bigger input; the ratio check always runs.
#
# Growth only happens when tokenization is FAST, i.e. when the quadratic is
# absent, so enlarging $n here can never mask the bug -- and the cap is a
# backstop in case times() reports implausibly low on some platform.
#
# Clearing the floor needs roughly an 18x speedup over a baseline machine, so a
# 16x cap (100k -> 1.6M) suffices in practice while bounding the worst case: the
# dominant allocation is the 4x measurement (4 * 1.6M = 6.4M elements, a ~12 MB
# source string), and its runtime stays in seconds rather than minutes.
my $NOISE_FLOOR = 0.05;       # seconds of CPU; ~5x a typical times() tick
my $MAX_N       = 1_600_000;  # 16x growth cap; worst-case 4x run is ~6.4M tokens

my $n  = 100_000;
my $t1 = tokenize_cpu($n);
while ($t1 < $NOISE_FLOOR && $n < $MAX_N) {
  $n *= 2;
  $t1 = tokenize_cpu($n);
}

my $t4 = tokenize_cpu($n * 4);

note(sprintf 'tokenize %8d tokens: %.3fs CPU', $n,     $t1);
note(sprintf 'tokenize %8d tokens: %.3fs CPU', $n * 4, $t4);

my $ratio = $t4 / $t1;
note(sprintf 'growth for 4x input: %.2fx (linear ~4x, quadratic ~16x)', $ratio);

ok($ratio < 5.0,
  sprintf('single-line tokenization scales sub-quadratically (%.2fx < 5.0x)', $ratio));

done_testing;

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
  # 2 tokens per element (value + comma) plus the surrounding key/=/[ ]/EOF.
  die "tokenized $count tokens, expected ~" . (2 * $n) . "\n"
    unless $count >= 2 * $n;
  return $t1[0] - $t0[0];
}

my $n  = 100_000;
my $t1 = tokenize_cpu($n);
my $t4 = tokenize_cpu($n * 4);
my $ratio = $t4 / ($t1 || 1e-9);

note(sprintf 'tokenize %7d tokens: %.3fs CPU', $n,     $t1);
note(sprintf 'tokenize %7d tokens: %.3fs CPU', $n * 4, $t4);
note(sprintf 'growth for 4x input: %.2fx (linear ~4x, quadratic ~16x)', $ratio);

ok($ratio < 5.0,
  sprintf('single-line tokenization scales sub-quadratically (%.2fx < 5.0x)', $ratio));

done_testing;

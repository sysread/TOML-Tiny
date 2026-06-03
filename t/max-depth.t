use strict;
use warnings;

use Test2::V0;
use TOML::Tiny qw(from_toml);

# Build a TOML document whose value for key "k" nests $depth containers deep.
#   kind 'array': k = [[[ ... ]]]
#   kind 'table': k = {a={a={ ... =1 }}}
sub nested {
  my ($depth, $kind) = @_;
  if ($kind eq 'array') {
    return 'k = ' . ('[' x $depth) . (']' x $depth);
  }
  return 'k = ' . ('{a=' x $depth) . '1' . ('}' x $depth);
}

subtest 'within default depth parses' => sub {
  for my $kind (qw(array table)) {
    my ($data, $err) = from_toml(nested(100, $kind));
    ok !$err, "$kind nested 100 deep parses without error"
      or diag $err;
    ok defined $data, "$kind returns data";
  }
};

subtest 'exceeding default depth is rejected' => sub {
  for my $kind (qw(array table)) {
    my ($data, $err) = from_toml(nested(5000, $kind));
    ok $err, "$kind nested 5000 deep is rejected";
    like $err, qr/depth/i, "$kind error mentions depth";
  }
};

subtest 'configurable max_depth' => sub {
  for my $kind (qw(array table)) {
    my ($ok_data, $ok_err) = from_toml(nested(10, $kind), max_depth => 16);
    ok !$ok_err, "$kind nested 10 deep accepted under max_depth => 16"
      or diag $ok_err;

    my ($bad_data, $bad_err) = from_toml(nested(32, $kind), max_depth => 16);
    ok $bad_err, "$kind nested 32 deep rejected under max_depth => 16";
  }
};

subtest 'deeply nested input is rejected quickly and cheaply' => sub {
  # Without a guard, this drives the process to multi-GB RSS and tens of
  # seconds of CPU. With the guard it must fail fast.
  my $src = nested(1_000_000, 'array');
  my $t0  = time;
  my ($data, $err) = from_toml($src);
  my $elapsed = time - $t0;
  ok $err, 'pathologically nested input is rejected';
  ok $elapsed < 5, "rejected promptly (took ${elapsed}s)";
};

done_testing;

use Test2::V0;
use TOML::Tiny::Grammar;

my $re = qr{ ((?&Float)) $TOML }x;

my @valid = qw(
  +1.0
  3.1415
  -0.01
  5e+22
  1e06
  -2E-2
  6.626e-34
  224_617.445_991_228
  inf
  +inf
  -inf
  nan
  +nan
  -nan
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

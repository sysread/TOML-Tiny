use Test2::V0;
use TOML::Tiny;

my $re = qr{ ((?&Integer)) $TOML::Tiny::GRAMMAR_V5 }x;

my @valid = qw(
  +99
  42
  0
  -17
  1_000
  5_349_221
  1_2_3_4_5
  0xDEADBEEF
  0xdeadbeef
  0xdead_beef
  0o01234567
  0o755
  0b110101101
);

like($_, $re, $_) for @valid;

done_testing;

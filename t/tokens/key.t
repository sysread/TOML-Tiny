use Test2::V0;
use TOML::Tiny;

my $re = qr{ ((?&Key)) $TOML::Tiny::GRAMMAR_V5 }x;

my @valid = qw(
  key
  bare_key
  bare-key
  1234
  "127.0.0.1"
  "character encoding"
  "ʎǝʞ"
  'key2'
  'quoted "value"'
  physical.color
  physical.shape
  site."google.com"
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

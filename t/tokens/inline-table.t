use Test2::V0;
use TOML::Tiny::Grammar;

my $re = qr{ ((?&InlineTable)) $TOML }x;

my @valid = (
  q|{ first = "Tom", last = "Preston-Werner" }|,
  q|{ x = 1, y = 2 }|,
  q|{ type.name = "pug" }|,
  q|{ x = 1 }|,
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

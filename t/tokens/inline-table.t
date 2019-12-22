use Test2::V0;
use TOML::Tiny;

my $re = qr{ ((?&InlineTable)) $TOML::Tiny::GRAMMAR_V5 }x;

my @valid = (
  q|{ first = "Tom", last = "Preston-Werner" }|,
  q|{ x = 1, y = 2 }|,
  q|{ type.name = "pug" }|,
  q|{
    x = 1
  }|,
  q|{
    x = 1,
  }|,
  q|{
    x = 1,
    y = 2
  }|,
  q|{
    x = 1,
    y = 2,
  }|
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

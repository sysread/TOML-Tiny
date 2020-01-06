use Test2::V0;
use TOML::Tiny::Grammar;

my $re = qr{ ((?&ArrayOfTables)) $TOML }x;

my @valid = (
  qq{[[foo]]\n},

  qq{[[foo]]
bar = 1234},

  qq{[[foo]]
bar = 1234
baz = 5678},

  qq{[[foo]]
bar = 1234
[[baz]]
bat = 5678},

  qq{[[foo]]
bar = 1234
[baz]
bat = 5678},
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

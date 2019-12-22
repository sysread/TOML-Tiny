use Test2::V0;
use TOML::Tiny;

my $re = qr{ (?&Table) $TOML::Tiny::GRAMMAR_V5 }x;

my @valid = (
  qq{[foo]\n},

  qq{[foo]
bar = 1234},

  qq{[foo]
bar = 1234
baz = 5678},

  qq{[foo]
bar = 1234
[baz]
bat = 5678},
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

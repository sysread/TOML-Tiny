use Test2::V0;
use TOML::Tiny::Grammar;

my $re = qr{ ((?&Array)) $TOML }x;

my @valid = (
  q{[ 1, 2, 3 ]},
  q{[ "red", "yellow", "green" ]},
  q{[ [ 1, 2 ], [3, 4, 5] ]},
  q{[ [ 1, 2 ], ["a", "b", "c"] ]},
  q{[ "all", 'strings', """are the same""", '''type''' ]},
  q{[ 0.1, 0.2, 0.5, 1, 2, 5 ]},
  q{[ "Foo Bar <foo@example.com>", { name = "Baz Qux", email = "bazqux@example.com", url = "https://example.com/bazqux" } ]},
  q{[ 1, 2, 3 ]},
  q{[ 1, 2, ]},
  q{[
    1,
    2,
  ]},
  q{[
    1,
    2
  ]},
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

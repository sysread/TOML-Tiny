use Test2::V0;
use TOML::Tiny::Grammar;

my $re = qr{ ((?&KeyValuePair)) $TOML }x;

my @valid = (
  q{foo= "bar"},
  q{foo ="bar"},
  q{foo="bar"},
  q{foo = "bar"},
  q{foo = 1234},
  q{foo = 12.34},
  q{foo = true},
  q{foo = [1,2,3]},
  q{foo = [1, 2, 3]},
  q{foo = [ 1, 2, 3 ]},
);

ok($_ =~ /$re/, $_) for @valid;

done_testing;

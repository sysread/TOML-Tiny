# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'people' => [
                             {
                               'first_name' => 'Bruce',
                               'last_name' => 'Springsteen'
                             },
                             {
                               'last_name' => 'Clapton',
                               'first_name' => 'Eric'
                             },
                             {
                               'last_name' => 'Seger',
                               'first_name' => 'Bob'
                             }
                           ]
             };


my $actual = from_toml(q{people = [{first_name = "Bruce", last_name = "Springsteen"},
          {first_name = "Eric", last_name = "Clapton"},
          {first_name = "Bob", last_name = "Seger"}]
});

is($actual, $expected1, 'inline-table-array - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'inline-table-array - to_toml') or do{
  diag "ERROR: $@" if $@;

  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'GENERATED TOML:';
  diag to_toml($actual);

  diag '';
  diag 'REPARSED FROM GENERATED TOML:';
  diag Dumper(scalar from_toml(to_toml($actual)));
};

done_testing;
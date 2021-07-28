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
               'Section' => {
                              'M' => 'latin letter M',
                              'name' => 'different section!!',
                              "\x{39c}" => 'greek capital letter MU',
                              "\x{3bc}" => 'greek small letter mu'
                            },
               'sectioN' => 'NN',
               'section' => {
                              'NAME' => 'upper',
                              'Name' => 'capitalized',
                              'name' => 'lower'
                            }
             };


my $actual = from_toml(q|sectioN = "NN"

[section]
name = "lower"
NAME = "upper"
Name = "capitalized"

[Section]
name = "different section!!"
"μ" = "greek small letter mu"
"Μ" = "greek capital letter MU"
M = "latin letter M"

|);

is($actual, $expected1, 'key/case-sensitive - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'key/case-sensitive - to_toml') or do{
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
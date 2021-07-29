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

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'key/case-sensitive - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'key/case-sensitive - to_toml') or do{
  diag "ERROR: $error" if $error;

  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'REGENERATED TOML:';
  diag Dumper($regenerated);

  diag '';
  diag 'REPARSED FROM REGENERATED TOML:';
  diag Dumper($reparsed);
};

done_testing;
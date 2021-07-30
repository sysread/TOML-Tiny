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
               'nzdt' => '1987-07-05T17:45:56+13:00',
               'nzst' => '1987-07-05T17:45:56+12:00',
               'pdt' => '1987-07-05T17:45:56-05:00',
               'utc' => '1987-07-05T17:45:56Z'
             };


my $actual = from_toml(q|utc  = 1987-07-05T17:45:56Z
pdt  = 1987-07-05T17:45:56-05:00
nzst = 1987-07-05T17:45:56+12:00
nzdt = 1987-07-05T17:45:56+13:00  # DST
|);

is($actual, $expected1, 'datetime/timezone - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'datetime/timezone - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'datetime/timezone - to_toml') or do{
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
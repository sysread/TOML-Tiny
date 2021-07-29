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
               'albums' => [
                             {
                               'name' => 'Born to Run',
                               'songs' => [
                                            {
                                              'name' => 'Jungleland'
                                            },
                                            {
                                              'name' => 'Meeting Across the River'
                                            }
                                          ]
                             },
                             {
                               'name' => 'Born in the USA',
                               'songs' => [
                                            {
                                              'name' => 'Glory Days'
                                            },
                                            {
                                              'name' => 'Dancing in the Dark'
                                            }
                                          ]
                             }
                           ]
             };


my $actual = from_toml(q|[[albums]]
name = "Born to Run"

  [[albums.songs]]
  name = "Jungleland"

  [[albums.songs]]
  name = "Meeting Across the River"

[[albums]]
name = "Born in the USA"
  
  [[albums.songs]]
  name = "Glory Days"

  [[albums.songs]]
  name = "Dancing in the Dark"
|);

is($actual, $expected1, 'table/array-nest - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

is($error, U, 'table/array-nest - to_toml - no errors');

is($reparsed, $expected1, 'table/array-nest - to_toml') or do{
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
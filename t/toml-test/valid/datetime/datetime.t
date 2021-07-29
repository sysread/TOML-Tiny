# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Test2::Require::Module 'DateTime';
use Test2::Require::Module 'DateTime::Format::RFC3339';
use DateTime;
use DateTime::Format::RFC3339;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'lower' => bless( {
                                   '_file' => '(eval 373)',
                                   '_lines' => [
                                                 13
                                               ],
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1987-07-05T17:45:00Z');
                                                 my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                 $exp->set_time_zone('UTC');
                                                 $got->set_time_zone('UTC');
                                                 return 'DateTime'->compare($got, $exp) == 0;
                                             },
                                   'name' => '<Custom Code>',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'space' => bless( {
                                   '_file' => '(eval 374)',
                                   '_lines' => [
                                                 13
                                               ],
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1987-07-05T17:45:00Z');
                                                 my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                 $exp->set_time_zone('UTC');
                                                 $got->set_time_zone('UTC');
                                                 return 'DateTime'->compare($got, $exp) == 0;
                                             },
                                   'name' => '<Custom Code>',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|space = 1987-07-05 17:45:00Z
lower = 1987-07-05t17:45:00z
|);

is($actual, $expected1, 'datetime/datetime - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

is($error, U, 'datetime/datetime - to_toml - no errors');

is($reparsed, $expected1, 'datetime/datetime - to_toml') or do{
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
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
               'local' => bless( {
                                   '_file' => '(eval 376)',
                                   '_lines' => [
                                                 13
                                               ],
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1987-07-05T17:45:00');
                                                 my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                 $exp->set_time_zone('UTC');
                                                 $got->set_time_zone('UTC');
                                                 return 'DateTime'->compare($got, $exp) == 0;
                                             },
                                   'name' => '<Custom Code>',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'milli' => bless( {
                                   '_file' => '(eval 377)',
                                   '_lines' => [
                                                 13
                                               ],
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1977-12-21T10:32:00.555');
                                                 my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                 $exp->set_time_zone('UTC');
                                                 $got->set_time_zone('UTC');
                                                 return 'DateTime'->compare($got, $exp) == 0;
                                             },
                                   'name' => '<Custom Code>',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'space' => bless( {
                                   '_file' => '(eval 375)',
                                   '_lines' => [
                                                 13
                                               ],
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1987-07-05T17:45:00');
                                                 my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                 $exp->set_time_zone('UTC');
                                                 $got->set_time_zone('UTC');
                                                 return 'DateTime'->compare($got, $exp) == 0;
                                             },
                                   'name' => '<Custom Code>',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|local = 1987-07-05T17:45:00
milli = 1977-12-21T10:32:00.555
space = 1987-07-05 17:45:00
|);

is($actual, $expected1, 'datetime/local - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'datetime/local - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'datetime/local - to_toml') or do{
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